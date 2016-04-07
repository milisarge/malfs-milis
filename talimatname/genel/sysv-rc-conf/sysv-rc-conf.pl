#!/usr/bin/perl -w
# This program is distributed under the terms of the GNU General Public License
# 
#    This file is part of sysv-rc-conf.
#
#    sysv-rc-conf is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    sysv-rc-conf is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with sysv-rc-conf; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# Copyright 2004 Joe Oppegaard <joe@pidone.org>
#
use strict;
use Getopt::Long qw(:config no_ignore_case);

use Curses;
use Curses::UI;

use constant {
    BOTTOM_LAB_HEIGHT   => 2,
    BOTTOM_WIN_HEIGHT   => 4,
    DEFAULT_K_PRI       => 80,
    DEFAULT_S_PRI       => 20,
    LABEL_WIDTH         => 10,
    LIST_SN_LENGTH      => 12,
    LIST_SN_PAD         => 1,
    MAX_ROWS            => 8,
    TOP_LABEL_HEIGHT    => 2,
};

my $VERSION = "0.98";

my %opts = (
    cache_dir   => "/var/lib/sysv-rc-conf",
    order       => 'a',
    priority    => '',
    root        => '/',
    show        => '',
    verbose     => '',
    chkcfg_levels => '2345', # default runlevels to affect if not specified
    chkcfg_list   => undef,
    chkcfg_sn     => '',
    chkcfg_state  => '',
);

GetOptions("cache=s"	=> \$opts{cache_dir},
           "level=s"    => \$opts{chkcfg_levels},
           "list:s"     => \$opts{chkcfg_list},
	   "order=s"	=> \$opts{order},
	   "priority"	=> \$opts{priority},
	   "root=s"	=> \$opts{root},
	   "show=s"	=> \$opts{show},
	   "verbose=s"	=> \$opts{verbose},
           "Version"    => sub { print STDERR "$0 $VERSION\n"; exit; },
	  );

my $runlevel_cmd = '/sbin/runlevel';

$opts{verbose} ||= "/dev/null";
open VERBOSE, "> $opts{verbose}" or die "Can't open $opts{verbose} : $!";

my $etc_rc = $opts{root} . "/etc/rc.d/rc";
my $initd = $opts{root} . "/etc/init.d";

my @rls = qw/ 1 2 3 4 5 7 8 9 0 6 S /;

check_args();
setup_cache_env();

my @show_rls = split //, $opts{show};

# Page index
my $current_screen = 0;

# Page screens
my @s = ();

# All the runlevel information
my %runlevels = runlevel_status();

list_output(%runlevels) if defined $opts{chkcfg_list};
chkconfig_emulation();

my $cui = new Curses::UI( -clear_on_exit    => 0, 
			  -color_support    => 1,
			  -default_colors   => 1,
			) or die "Can't create base Curses::UI object";

create_bottom_box();

# Get the service names for each screen
my @snames_per_screen = split_services();

create_main_window();

my %box_pos = (x => '00', y => '00');

$cui->set_binding( \&toggle_help,    "h" );
$cui->set_binding( \&revert_changes, "r") ;
$cui->set_binding( sub { exit },  "q" );

$cui->set_binding( \&next_page, "\cN" );
$cui->set_binding( \&prev_page, "\cP" );

$s[$current_screen]->focus();

$cui->mainloop();

#--- rc access and modification subs ---#
sub update_link
{
    my ($sn, $rl, $sk, $pri) = @_;

    if (defined $sn && defined $rl && defined $sk && defined $pri) {
        if (-e "$etc_rc$rl.d/$sk$pri$sn") {
            # The symlink we are trying to make already exists
            return 'exists';
        }
    }

    opendir (RL, "$etc_rc$rl.d") or die "$0: opendir $etc_rc$rl.d : $!";

    foreach (grep { /[SK]\d\d$sn/i } readdir(RL)) {
	verbose("rm $etc_rc$rl.d/$_");
	unlink "$etc_rc$rl.d/$_"
	    or die "Can't unlink $etc_rc$rl.d/$_ : $!";
    }

    # If in priority mode and are completely deleting the link, $sk will
    # be empty.
    return 1 if $sk eq '';

    $pri = get_pri_cache($sn, $rl, $sk) unless $pri;

    unless ($pri =~ /^\d\d$/) { die "Priority isn't two numbers: $pri" }
    unless ($sk  =~ /^[SK]$/) { die "You have to use S or K to start a link" }

    verbose("symlink $initd/$sn $etc_rc$rl.d/$sk$pri$sn");
    # unlike ln relative symlinks are relative to the target file, not the cwd
    symlink "../init.d/$sn", "$etc_rc$rl.d/$sk$pri$sn"
        or die "Can't symlink $etc_rc$rl.d/$sk$pri$sn to ../init.d/$sn : $!\n";
}

sub usage
{
    print STDERR <<USAGE;
sysv-rc-conf command line usage:  
        
        sysv-rc-conf --list [service name]
        sysv-rc-conf [--level <runlevels>] <service name> <on|off>
USAGE
}

sub chkconfig_emulation
{
    $opts{chkcfg_sn}    = $ARGV[0] if defined $ARGV[0];
    $opts{chkcfg_state} = $ARGV[1] if defined $ARGV[1];
    
    if ($opts{chkcfg_sn} && not $opts{chkcfg_state}) {
        # Check to see if service is configured to run in current rl
        # exit true if it is, false if not.
        # See chkconfig(8) 
        my $current_rl = current_runlevel();
        if (exists $runlevels{$opts{chkcfg_sn}}{$current_rl}) {
            if ($runlevels{$opts{chkcfg_sn}}{$current_rl} =~ /^S/) {
                # Service is configured to start, exit true
                exit 0;
            }
        }
        exit 1;
    }

    if ($opts{chkcfg_sn} && $opts{chkcfg_state}) {
        my $sk = '';
        if ($opts{chkcfg_state} =~ /^on$/i) {
            $sk = 'S';
        }
        elsif ($opts{chkcfg_state} =~ /^off$/i) {
            $sk = 'K';
        }
        else {
            usage();
        }

        foreach (split //, $opts{chkcfg_levels}) {
            update_link($opts{chkcfg_sn}, $_, $sk, undef);
        }

        exit 0;
    }

    # Program isn't being called like chkconfig, so return to normal
    # operation.
    return 1;
}

sub list_output
{
    my (%runlevels) = @_;

    # There was an argument to --list
    my $opt_sn = $opts{chkcfg_list};
    foreach my $sn (sort keys %runlevels) {
        my $output = substr $sn, 0, LIST_SN_LENGTH;
        $output .= " " until length $output >= LIST_SN_LENGTH + LIST_SN_PAD;

        foreach my $rl (sort keys %{$runlevels{$sn}}) {
            $output .= "$rl:";
            if ($runlevels{$sn}{$rl} =~ /^[Ss]/) {
                $output .= "on";
            }
            else {
                $output .= "off";
            }
            $output .= "\t";
        }
        chop($output);
        $output .= "\n";
        if ($opt_sn) {
            print $output if $sn eq $opt_sn;
        }
        else {
            print $output;
        }
    }

    exit 0;
}
            
sub revert_changes
{
    # Lookup table
    my %cache = ();
    foreach my $scr (@s) {
        for (my $i = 0; $i < max_services() ; $i++) {
            for (my $j = 0; $j <= $#show_rls; $j++) {
                my $obj = $scr->getobj(zero_pad($i).zero_pad($j));
                my $ud = $obj->userdata();

                $cache{ $ud->{sn} }{ $ud->{runlevel} } = $obj;
            }
        }
    }
    
    foreach my $sn (keys %runlevels) {
        foreach my $rl (keys %{$runlevels{$sn}}) {
            $runlevels{$sn}{$rl} =~ /^([SK])(\d\d)$/;
            my ($sk, $pri) = ($1, $2);

            next if update_link($sn, $rl, $sk, $pri) eq 'exists';

            if (exists($cache{$sn}{$rl})) {
                my $box = $cache{$sn}{$rl};
                if ($opts{priority}) { 
                    # Reset the text
                    $box->text($sk.$pri);
                    $box->draw(1);
                }
                else {
                    # Simple layout, just toggle the box.
                    $box->toggle();
                    $box->draw(1);
                }
            }
            

        }
    }

    $cui->dialog("Symlinks restored to original state!");
}

sub start_service
{
    my ($widget) = @_;
    my $ud = $widget->userdata();

    st_service($ud->{sn}, 'start');
}

sub stop_service
{
    my ($widget) = @_;
    my $ud = $widget->userdata();

    st_service($ud->{sn}, 'stop');
}

sub st_service
{
    my ($sn, $st) = @_;

    my $output = `$initd/$sn $st`;

    verbose("$initd/$sn $st : $output");
    $cui->dialog("Results of $initd/$sn $st :\n" . $output);
}

sub get_pri_cache
{
    my ($sn, $rl, $sk) = @_;
    # See if we can get an exact match from the cache, if not try to match
    # the S or K except in a different run level, if there still is not a match
    # get the opposite of S or K on another runlevel, if still no match return
    # the default.

    open CACHE, "< $opts{cache_dir}/services" 
        or die "Can't open $opts{cache_dir}/services : $!";

    chomp (my @cache = <CACHE>);
    close CACHE;

    # Try an exact cache match
    foreach (@cache) {
        # $arg_rl $arg_sk $arg_pri $arg_sn
        next unless /^$rl\s+$sk\s+(\d\d)\s+$sn$/;
        verbose("Got exact cache match for priority: $_");
	    return $1;
    }

    # Try an $sk match, except on any runlevel
    foreach (@cache) {
        next unless /^[\dsS]\s+$sk\s+(\d\d)\s+$sn$/;
        verbose("Got differing runlevel cache for priority: $_");
        return $1;
    }

    # Ok, try to match on any runlevel with either S or K
    foreach (@cache) {
        next unless /^[\dsS]\s+([SK])\s+(\d\d)\s+$sn$/;
        verbose("Returning difference of 100 and $2: $_");
        # Sequence numbers are usually defined as stop = 100 - start
        # So that means that start = 100 - stop
        # Above we would have returned if $sk eq $1 so we know that $1 is
        # the opposite of $sk. So return 100 - $2.
        return zero_pad(100 - $2);
    }

    verbose("No cache found, returning default");
    return DEFAULT_S_PRI if $sk eq 'S';
    return DEFAULT_K_PRI if $sk eq 'K';
}

sub pri_box_changed
{
    my ($widget) = @_;

    my $ud = $widget->userdata();
    my $new_link = $widget->get();

    if ($new_link eq $ud->{last_good_text}) {
	# Text didn't actually change, just moved out of the box
	return 1;
    }

    if ($new_link =~ /^([KS])(\d\d)$/ or $new_link =~ /^$/) {
	my ($sk, $pri) = ('', '');
	if (defined $1 and defined $2) {
	    $sk  = $1;
	    $pri = $2;
	}

	update_link($ud->{sn}, $ud->{runlevel}, $sk, $pri);

	$ud->{last_good_text} = $new_link;
    }
    else {
	$cui->error("Incorrect format: $new_link\n" .
		    "The correct format is a K or S followed by two digits!\n" .
		    "Returning field back to original state."
		   );

	# Set the text in the box back to whatever the last good text was.
	$widget->{-text} = $ud->{last_good_text};
    }
}

sub simple_box_changed
{
    my ($box) = @_;
    my $userdata = $box->userdata();

    $userdata->{changed}++;

    if ($box->get()) {
	update_link($userdata->{sn}, $userdata->{runlevel}, 'S', undef) 
    } 
    else {
	update_link($userdata->{sn}, $userdata->{runlevel}, 'K', undef)
    }
}

sub runlevel_status 
{
    my %runlevels = ();

    opendir (INITD, $initd) or die "$0: opendir $initd : $!";
    while ( defined(my $service = readdir INITD) ) {
	next if $service =~ /\.sh$/; # see the debian policy manual
	next if $service =~ /^\.+$/; # ignore . and ..
	next unless -x "$initd/$service"; # ignore stuff like README
	$runlevels{$service} = { };
    }
    closedir INITD or die "$0: closedir $initd : $!";

    # While 7-9 usually aren't used, init supports it.
    foreach my $rl (@rls) {
	unless (opendir(DIR, "$etc_rc$rl.d")) {
	    next if $rl =~ /^[789S]$/;
	    die "$0: opendir $etc_rc$rl.d : $!";
	}
	while ( defined(my $file = readdir DIR) ) {
	    $file = "$etc_rc$rl.d/$file"; # Add the pathname to the file
	    next unless -l $file;
	    next if $file =~ /\.sh$/;
	    next unless $file =~ /([SK])(\d\d)(.+)$/;
	    my ($sk, $pri, $sn) = ($1, $2, $3);
	    $runlevels{$sn}{$rl} = $sk.$pri;
	}
	closedir DIR or die "$0: closedir $etc_rc$rl.d : $!";
    }

    update_cache(\%runlevels);
    return %runlevels;
}

sub setup_cache_env
{
    unless (-e $opts{cache_dir}) {
        verbose("Creating non-existant cache directory: $opts{cache_dir}");
        mkdir $opts{cache_dir} or die "Can't create $opts{cache_dir} : $!";
    }

    unless (-e "$opts{cache_dir}/services") {
        # Later we need to open the file with +< which can't create a new file
        # so we'll emulate touch.
        verbose("Touching $opts{cache_dir}/services");
        open CACHE, "> $opts{cache_dir}/services"
            or die "Can't touch $opts{cache_dir}/services : $!";
        close CACHE;
    }
}

sub update_cache
{
    my ($runlevels) = @_;

    open CACHE, "+< $opts{cache_dir}/services"
        or die "Can't open $opts{cache_dir}/services for rw access : $!";

    # Check to see if this service & rl already exists somewhere in this file
    # and update the line if so.
    my %touched = ();
    while (<CACHE>) {
        chomp;
        next unless /^([\dSs])\s+([SK])\s+(\d\d)\s+([^\s]+)$/;

        my ($rl, $sk, $pri, $sn) = ($1, $2, $3, $4);

        if (exists $runlevels->{$sn}{$rl}) {
            $runlevels->{$sn}{$rl} =~ /^([SK])(\d\d)$/;
            $touched{$sn}{$rl} = 1;

            my ($n_sk, $n_pri) = ($1, $2);
            next if $sk eq $n_sk && $pri eq $n_pri;

            s/^.+$/$rl $n_sk $n_pri $sn/;
        }
    }

    foreach my $sn (sort keys %{$runlevels}) {
        foreach my $rl (sort keys %{$runlevels->{$sn}}) {
            unless (exists $touched{$sn}{$rl}) {
                $runlevels->{$sn}{$rl} =~ /^([SK])(\d\d)$/;
                print CACHE "$rl $1 $2 $sn\n";
            }
        }
    }

    close CACHE or die "Can't close $opts{cache_dir}/services : $!";
}

#--- Misc subs ---#
sub check_args
{
    $opts{show} ||= get_default_show();

    unless ($opts{show} =~ /^[S0-9]*$/) {
	die "$0: --show must match [S0-9]\n";
    }

    if (length($opts{show}) > MAX_ROWS) {
	die "$0: can only show ". MAX_ROWS . "rows at a time\n";
    }

    return 1;
}

sub current_runlevel
{
    if (-e $runlevel_cmd) {
        my $rl_out = `$runlevel_cmd`;
        $rl_out = 1 if $rl_out =~ /unknown/;
        $rl_out =~ /^\S\s?([Ss\d])?$/ or
            die "Unknown return from $runlevel_cmd : $rl_out";
        return $1;
    }
    else {
        return 1;
    }
}


sub split_services
{
    # Figure out how many services can fit on the screen, then make
    # as many screens as needed to fit all the services.
    my @screens = ();

    my @services = ();

    my %o_opts = ();
    $o_opts{p} = 1 if $opts{order} =~ /p/;
    $o_opts{n} = 1 if $opts{order} =~ /n/;
    $o_opts{a} = 1 unless exists $o_opts{p};

    if ($opts{order} =~ /([Ss\d])/) {
        $o_opts{rl} = $1;
    }
    else {
        # If the --order option didn't set a runlevel to sort by, then
        # use the current runlevel (from the output of /sbin/runlevel) or
        # sort by runlevel 1 if the runlevel command doesn't exsist on this
        # system.
        $o_opts{rl} = current_runlevel();
    }
    
    # Process the opts we just set.
    if (exists $o_opts{a}) {
        if (exists $o_opts{n}) {
            # Include the priority num on an alpha sort
            foreach my $sn (sort keys %runlevels) {
                next unless exists $runlevels{$sn}{$o_opts{rl}};
                next unless $runlevels{$sn}{$o_opts{rl}} =~ /^[SK](\d\d)$/;
                push @services, $1.$sn;
            }
        }
        else {
            # Standard alpha sort
            @services = sort keys %runlevels;
        }
    }
    elsif (exists $o_opts{p}) {
        # Sort by priority at runlevel specified or current runlevel

        my @tmp_order = ( [ ], [ ] ); # S is 0 and K is 1
        foreach my $sn (keys %runlevels) {
            next unless exists $runlevels{$sn}{$o_opts{rl}};
            next unless $runlevels{$sn}{$o_opts{rl}} =~ /^([SK])(\d\d)$/;
            
            if    ($1 eq 'S') { push @{$tmp_order[0]}, $2.$sn }
            elsif ($1 eq 'K') { push @{$tmp_order[1]}, $2.$sn }
        }

        foreach (0, 1) {
            foreach my $ddsn (sort @{$tmp_order[$_]}) {
                $ddsn =~ /^(\d\d)(.+)$/;
                if (exists $o_opts{n}) {
                    # Include the priority num on a pri sort
                    push @services, $1.$2;
                }
                else {
                    push @services, $2;
                }
            }
        }
    }

    {
        # We could be missing some services if they didn't have a link in the
        # runlevel we were sorting by. This happens in all circumstances except
        # the default of just 'a' being set.
        my %seen = ();
        foreach (@services) {
            next unless $_ =~ /^(\d\d)?(.+)$/;
            $seen{$2} = 1;
        }

        foreach (sort keys %runlevels) {
            unless (exists $seen{$_}) {
                push(@services, $_);
            }
        }
    }
    
    my $per_screen = max_services();

    my $i = 0;
    do {
        $screens[$i] = [ splice(@services, 0, $per_screen) ];
        $i++;
    } while @services;

    return @screens;
}

sub max_services
{
    my $tmp_screen = $cui->add(
	undef, 'Window',
	-title	    => "N/A",
	-border	    => 1,
	-padtop	    => 1,
	-padbottom  => 4,
	-ipad	    => 1,
    );

    my $ms = $tmp_screen->canvasheight() - TOP_LABEL_HEIGHT;
    undef $tmp_screen; # Make sure the memory is cleaned up.

    return $ms;
}

sub get_default_show
{
    my $show = '';
    foreach (@rls) {
	if (-e "$etc_rc$_.d") {
	    $show .= $_;
	}
    }
    return $show;
}

sub zero_pad { sprintf('%.2u', $_[0]); }

sub verbose { print VERBOSE $_[0]."\n" if $opts{verbose}; }


#--- Screen layout subs ---#
sub create_main_window
{
    create_help_window();
    
    my $i = 0;
    foreach my $services (@snames_per_screen) {

	# First create the main window all of this page of services goes in
	my $id = "window_$i";
	my $screen = $cui->add(
	    $id, 'Window',
	    -title	    => 
"SysV Runlevel Config   -: stop service  =/+: start service  h: help  q: quit",
	    -border	    => 1,
	    -padtop	    => 1,
	    -padbottom      => 4,
	    -ipad	    => 1,
	);

        # Can't set these globally (on $cui) or else it overrides the
        # keybindings on all other objects
        $screen->set_binding( \&move_up,    KEY_UP(),    );
        $screen->set_binding( \&move_down,  KEY_DOWN(),  );
        $screen->set_binding( \&move_left,  KEY_LEFT(),  );
        $screen->set_binding( \&move_right, KEY_RIGHT(), );

	create_top_label($screen);

	my $left_label = '';
	for (my $i = 0; $i < scalar(@$services); $i++) {
	    $left_label .= $services->[$i] . "\n";
	    if ($services->[$i] =~ /^\d\d(.+)$/) {
		# If the labels had numbers, we don't need them anymore. 
		$services->[$i] = $1;
	    }
	}

	my $row = TOP_LABEL_HEIGHT;

	$screen->add(
	    undef, 'Label',
	    -text   => $left_label,
	    -y	    => $row,
	    -width  => LABEL_WIDTH,
	    -height => last_x() + 1,
	);

	foreach my $sn (@$services) {
	    if   ($opts{priority}) { draw_priority_layout($screen, $sn, $row) }
	    else             { draw_simple_layout($screen, $sn, $row)   }

	    $row++;
	}	

	$s[$i] = $screen;

	$i++;
    }
}

sub create_help_window
{
    my $help_text = <<EOF;
Quick key reference:

  Arrow keys: Move around
  CTRL-n:     Next Page
  CTRL-p:     Previous Page
  r:          Restore all symlinks back to original state
  -:          Stop service
  = or +:     Start service
  h:          Toggle help on / off
  q:          Quit

  Checkbox Layout:
    Space:      Toggle service on / off

  Priority Layout:
    Backspace:  Delete text behind cursor
    CTRL-d:     Delete text in front of cursor
    CTRL-f:     Move cursor forward through text
    CTRL-b:     Move cursor backwards through text

  See the man page for information on how the system uses the init 
  script links, how to get new version of the program, how to submit 
  bug reports, etc.  

  sysv-rc-conf is released under the GNU GPL.
  Version: $VERSION

  (c) 2004 Joe Oppegaard <joe\@pidone.org>
EOF

    my $hw = $cui->add(
        'help_window', 'Window',
        -title	    => 
"SysV Runlevel Config   -: stop service  =/+: start service  h: help  q: quit",
        -border	    => 1,
        -padtop	    => 1,
        -padbottom  => 4,
        -ipad	    => 1,
        -userdata   => 0,
    );

    $hw->add(
        'help_tv', 'TextViewer',
        -text       => $help_text,
        -title      => 'sysv-rc-conf help',
        -vscrollbar => 1,
    );

}

sub draw_simple_layout
{
    my ($screen, $sn, $row) = @_;

    for (my $i = 0, my $right_n = 12; $i <= $#show_rls; $i++, $right_n += 8) {
	my $on_or_off = 0;
	# We only want to show S\d\d services as selected. 
	$on_or_off = 1 if exists $runlevels{$sn}{$show_rls[$i]} 
		          &&     $runlevels{$sn}{$show_rls[$i]} =~ /^S\d\d$/;

        my $box = $screen->add(
            zero_pad($row-2).zero_pad($i), 'Checkbox',
            -label      => '',
            -checked    => $on_or_off,
            -border     => 0,
            -x          => $right_n,
            -y          => $row,
            -width      => 5,
            #-height     => 1,
	    -userdata	=> { id		=> zero_pad($row-2).zero_pad($i),
			     sn		=> $sn,
			     changed	=> 0,
			     runlevel	=> $show_rls[$i],
			   },
            -onchange   => \&simple_box_changed,
            -onfocus    => \&got_focus,
        );

	$box->set_binding( \&start_service, "=", "+" );
	$box->set_binding( \&stop_service,  "-" );
    }
}

sub draw_priority_layout
{
    my ($screen, $sn, $row) = @_;

    for (my $i = 0, my $right_n = 11; $i <= $#show_rls; $i++, $right_n += 8) {
	my $text = exists $runlevels{$sn}{$show_rls[$i]}
		    ? $runlevels{$sn}{$show_rls[$i]}
		    : '';
	my $box = $screen->add(
	    zero_pad($row-2).zero_pad($i), 'TextEntry',
	    -sbborder   => 1,
	    -x		=> $right_n,
	    -y		=> $row,
	    -width	=> 6,
	    -maxlength  => 3,
	    -regexp	=> '/^[skSK\d]*$/',
	    -toupper	=> 1,
	    -showoverflow => 0,
	    -text	=> $text,
	    -userdata	=> { id		=> zero_pad($row-2).zero_pad($i),
			     sn		=> $sn,
			     changed	=> 0,
			     runlevel	=> $show_rls[$i],
			     last_good_text => $text,
			   },
	    -onblur	=> \&pri_box_changed,
	    -onfocus	=> \&got_focus,
	);

	$box->set_binding( \&start_service, "=", "+" );
	$box->set_binding( \&stop_service,  "-" );
    }
}

sub create_top_label
{
    my ($window) = @_;

    my @label_rls = @show_rls;

    my $text = 'service      ' . shift @label_rls;
    foreach (@label_rls) { $text .= "       $_" };
    $text .= "\n";
    $text .= "-" x 76;

    $window->add(
	undef, 'Label',
	-text	=> $text,
	-y	=> 0,
	-x	=> 0,
	-height	=> TOP_LABEL_HEIGHT,
	-textalignment	=> 'left',
    );
}

sub create_bottom_box
{
    my $cmd_text = '';

    if ($opts{priority}) {
	$cmd_text = 
"Editing:     Backspace: bs     ^d: delete      ^b: backward      ^f: forward";
    }
    else {
	$cmd_text = 
"                       space: toggle service on / off                      ",
    }
    
    my $exp_window = $cui->add(
	'exp_window', 'Window',
	-border    => 1,
	-y	   => -1,
	-height	   => BOTTOM_WIN_HEIGHT,
        -ipadleft  => 1,
        -ipadright => 1,
    );
    $exp_window->add(undef, 'Label', 
	-y	=> 0,
	-width	=> -1,
	-height => BOTTOM_LAB_HEIGHT,
	-text => 
"Use the arrow keys or mouse to move around.      ^n: next pg     ^p: prev pg\n$cmd_text",
    );
}

sub toggle_help
{
    my $hw = $cui->getobj('help_window');
    my $hw_data = $hw->userdata();

    if ($hw_data == 0) {
        $hw->userdata($cui->getfocusobj);
        $hw->focus();
    }
    else {
        # The help window is up, so turn it off by focusing the last
        # object that was focused on before we pulled up the help window
        $hw_data->focus();
        $hw->userdata(0);
    }
}

#--- Movement subs ---#
sub next_page
{
    $current_screen++;
    $current_screen = 0 if $current_screen > last_screen();
    verbose("Going to screen $current_screen");
    _move_focus(00, $box_pos{y});
}

sub prev_page
{
    $current_screen--;
    $current_screen = last_screen() if $current_screen < 0;
    verbose("Going to screen $current_screen");
    $box_pos{x} = last_x();
    _move_focus($box_pos{x}, $box_pos{y});
}

sub got_focus
{
    my $widget = shift;
    # Is there a better way to figure out my own id besides putting it
    # in userdata on creation and fetching it?
    my $userdata = $widget->userdata();
    my $id = $userdata->{id};

    $id =~ /^(\d\d)(\d\d)$/;

    $box_pos{x} = $1;
    $box_pos{y} = $2;
}

sub move_left
{
    return if $box_pos{y} eq '00';
    _move_focus($box_pos{x}, $box_pos{y} - 1);
}

sub move_right
{
    return if $box_pos{y} == scalar(@show_rls)-1;
    _move_focus($box_pos{x}, $box_pos{y} + 1);
}

sub move_up
{
    #return if $box_pos{x} eq '00';
    return prev_page() if $box_pos{x} eq '00';
    _move_focus($box_pos{x} - 1, $box_pos{y});
}

sub move_down
{
    # Index starts at 00, so we need one less then the max services that
    # are on the screen.
    return next_page() if $box_pos{x} == last_x();
    _move_focus($box_pos{x} + 1, $box_pos{y});
}

sub _move_focus
{
    $box_pos{x} = $_[0];
    $box_pos{y} = $_[1];
    my $box = $s[$current_screen]->getobj(zero_pad($_[0]).zero_pad($_[1]));
    $box->focus();
}

sub last_x { return scalar(@{$snames_per_screen[$current_screen]})-1; }

sub first_screen { return 0 }

sub last_screen  { return scalar(@s)-1 }

=pod 

=head1 NAME

B<sysv-rc-conf> - Run-level configuration for SysV like init script links

=head1 SYNOPSIS

B<sysv-rc-conf> [ I<options> ]

B<sysv-rc-conf> [ --level I<levels> ] I<service> E<lt>I<on|off>E<gt>

=head1 DESCRIPTION

B<sysv-rc-conf> gives an easy to use interface for managing
C</etc/rc{runlevel}.d/> symlinks. The interface comes in two different
flavors, one that simply allows turning services on or off and another that
allows for more fine tuned management of the symlinks. It's a replacement for
programs like B<ntsysv(8)> or B<rcconf(8)>.

B<sysv-rc-conf> can also be used at the command line when the desired changes
to the symlinks are already known. The syntax is borrowed from B<chkconfig(8)>.

=head1 GENERAL OPTIONS

=over

=item B<-c> DIRECTORY, B<--cache=>DIRECTORY

The directory where the priority numbers, old runlevel configuration, etc. 
should be stored. This defaults to C</var/lib/sysv-rc-conf>. See the FILES
section below.

=item B<-r> DIRECTORY, B<--root=>DIRECTORY

The root directory to use. This defaults to C</>. This comes in handy if the
root file system is mounted somewhere else, such as when using a rescue disk.

=item B<-v> FILE, B<--verbose=>FILE

Print verbose information to C<FILE>

=item B<-V>, B<--Version>

Print version information to STDOUT and exit

=back

=head1 GUI RELATED OPTIONS

=over

=item B<-o> [ see description ], B<--order=>[ see description ]

Allows various sorting orders and ways to display the rows. The argument can be
made up of any of the following:

=over

=item B<a>

Sort the rows B<a>lphabetically. This is the default if the B<-o> option isn't
specified.

=item B<n>

Show the priority numbers along with the name of the service.

=item B<p>

Sorts by the B<p>riority numbers.

=item B<level>

I<level> can be any runlevel, 0-9 or S. This controls which runlevel the
priority numbers are sorted at. It only makes sense to use this in conjuntion
with B<p>. If omitted the priority numbers are sorted by the current runlevel
the system is in.

=back

=item B<-p>, B<--priority>

Alternate layout. Instead of just showing a checkbox, the priority of the
service and the S or K are allowed to be edited. This is for more fine tuned
control then the default layout allows.

=item B<-s> I<levels>, B<--show=>I<levels>

Which runlevels to show. This defaults to up to 8 of the runlevels available
on the system. Usually this means it will show 1, 2, 3, 4, 5, 0, 6, and S.
The syntax calls for the runlevels to be allruntogether. For instance, to
show runlevels 3, 4, and 5 the syntax would be C<--show=345>. Also see 
B<--order>.

=back

=head1 CLI RELATED OPTIONS

=over

=item B<--level> I<levels>

The runlevels this operation will affect. I<levels> can be any number from
0-9 or S. For example, B<--level 135> will affect runlevels 1, 3, and 5.
If B<--level> is not set, the default is to affect runlevels 2, 3, 4, and 5.
This option is only used for the command line interface, see the section
below labled USING THE CLI for more information. 

=item B<--list> [I<name>]

This option will list all of the services and if they are stopped or started
when entering each runlevel. If I<name> is specified, only the information
for that service is displayed.

=back

=head1 USING THE GUI

=head2 Using the Default layout

The default (simple) layout shows in a grid fashion all of the services that
are in C<init.d> and which runlevels they are turned on at. For example, where
the C<ssh> row and C<3> column intersect, if there is a checkbox there that
means the service will be turned on when entering runlevel 3. If there is no
checkbox it can mean that either there are no links to the service in that
specific runlevel, or that the service is turned off when entering that 
runlevel. If more configuration detail is needed, see the next paragraph and
the B<--priority> option.

=head2 Using the Priority layout

The priority (advanced) layout also uses a grid fashion, but instead of
checkboxes there are text boxes that can have a few different values. If the
text box is blank, that means there isn't a symlink in that runlevel for that
service. This means that when changing into that runlevel that the service
will not be started or stopped, which is significant. If the text box starts
with the letter K that means that the service will be stopped when entering
that runlevel. If the text box starts with the letter S that means the service
will be started when entering that runlevel. The two digits following is the 
order in which the services are started. That means that C<S08iptables> would
start before C<S20ssh>. For more information see your system documentation.

=head2 Controls

To move around use the arrow keys, or if the terminal support it, the mouse.
Typically there is more then one page of services (unless the terminal screen
is large), to move between the pages use CTRL-n or CTRL-p, or simply arrow key
down or up at the bottom or top of the screen, respectively. The bottom of the
screen also shows these movement commands for quick reference. To restore the
symlinks back to their original state before the B<sysv-rc-conf> was run,
press the B<r> key.  The B<h> key will display a quick reference help screen. 

=head2 Default layout

When using the default layout use the space bar to toggle the service on / off.

=head2 Priority layout

The priority layout uses the default movement keys. In order to edit the fields
you can use CTRL-d to delete the character in front of the cursor or backspace
to backspace. Use CTRL-b or CTRL-f to move the cursor backwards or forwards 
within the field. Note that only S, K, or any digit is allowed to be entered
into the field.

=head2 Starting / Stopping Services

To start a service, press the C<+> or C<=> key.
To stop  a service, press the C<-> key.

This will call C</etc/init.d/service start> or C</etc/init.d/service stop>.

=head1 USING THE CLI

If the desired modifications to the symlinks are known and only one quick
change is needed, then you can use a CLI interface to B<sysv-rc-conf>.
Examples:

  # sysv-rc-conf --level 35 ssh off
  # sysv-rc-conf atd on

The first example will turn ssh off on levels 3 and 5. The second example
turns atd on for runlevels 2, 3, 4, and 5.

=head1 FILES

B<Note:> Feel free to skip this section

B<sysv-rc-conf> stores a cache of all the symlink information from 
C</etc/rc{runlevel}.d/> in C</var/lib/sysv-rc-conf/services> (See the --cache
option to change the location of this file). It uses this cache to make an
intelligent decision on what priority number to give the K or S link when they
are changed in the simple layout. This cache is updated/created everytime the
program is launched.  The format of the file is as follows:

  RUNLEVEL S|K PRIORITY SERVICE

Here's a few examples:

  2 K 74 ntpd
  2 K 50 xinetd
  3 S 08 iptables
  3 S 80 sendmail

B<sysv-rc-conf> will first see if it can get an exact match from the cache.
For example, if the symlink for C<cron> in runlevel 3 is S89cron and you 
uncheck it, B<sysv-rc-conf> will first see if there is an entry in the cache
that looks like C<3 K nn cron>, if so it will use nn for the priority number.

If there wasn't a match, B<sysv-rc-conf> will then see if there is another S or
K (whichever you're switching to, so in this example, K) entry on a different
runlevel - so an entry like C<i K nn cron>, where i is any runlevel. If found,
the link will use nn. 

If there still wasn't a match, B<sysv-rc-conf> will look for the opposite of S
or K in any run level, and use 100 - that priority. So in our example,
C<i S nn cron>. If nn is 20, then it will use 80 (100 - 20), since that is
typically the way that the priority numbers are used.

If there still isn't a match, the default priority of 20 for S links is used,
and the default priority of 80 for K links is used.

=head1 COMPATIBILITY

B<sysv-rc-conf> should work on any Unix like system that manages services 
when changing runlevels by using symlinks in C</etc/rc{runlevel}.d/>. Refer
to your system documentation to see if that's the case (usually there's a 
C</etc/init.d/README>).

=head1 CAVEATS

B<sysv-rc-conf> only manages the symlinks in the C<rc{runlevel}.d>
directories. It's possible that pacakages may have other ways of being
disabled or enabled. 

Because Curses takes over the screen sometimes error messages won't be
seen on the terminal. If you run across any weird problems try redirecting
STDERR to a file when you execute the program. 

For example:
  # sysv-rc-conf 2E<gt> err.out

=head1 REPORTING BUGS

Report bugs to Joe Oppegaard E<lt>joe@pidone.orgE<gt>

=head1 SEE ALSO

B<init(8)>, B<runlevel(8)>, B<chkconfig(8)>, C</etc/init.d/README>

  www: http://sysv-rc-conf.sourceforge.net
  ftp: ftp://ftp.pidone.org/sysv-rc-conf

=head1 AUTHOR

Joe Oppegaard E<lt>joe@pidone.orgE<gt>
