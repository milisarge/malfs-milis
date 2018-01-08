/* automatically generated from appfinder-preferences.glade */
#ifdef __SUNPRO_C
#pragma align 4 (appfinder_preferences_ui)
#endif
#ifdef __GNUC__
static const char appfinder_preferences_ui[] __attribute__ ((__aligned__ (4))) =
#else
static const char appfinder_preferences_ui[] =
#endif
{
  "<?xml version=\"1.0\" encoding=\"UTF-8\"?><interface><requires lib=\"gt"
  "k+\" version=\"2.20\"/><object class=\"GtkListStore\" id=\"action-types"
  "\"><columns><column type=\"gchararray\"/></columns><data><row><col id=\""
  "0\" translatable=\"yes\">Prefix</col></row><row><col id=\"0\" translata"
  "ble=\"yes\">Regular Expression</col></row></data></object><object class"
  "=\"GtkListStore\" id=\"actions-store\"><columns><column type=\"gchararr"
  "ay\"/><column type=\"gint\"/></columns></object><object class=\"GtkList"
  "Store\" id=\"icon-sizes\"><columns><column type=\"gchararray\"/></colum"
  "ns><data><row><col id=\"0\" translatable=\"yes\">Very Small</col></row>"
  "<row><col id=\"0\" translatable=\"yes\">Smaller</col></row><row><col id"
  "=\"0\" translatable=\"yes\">Small</col></row><row><col id=\"0\" transla"
  "table=\"yes\">Normal</col></row><row><col id=\"0\" translatable=\"yes\""
  ">Large</col></row><row><col id=\"0\" translatable=\"yes\">Larger</col><"
  "/row><row><col id=\"0\" translatable=\"yes\">Very Large</col></row></da"
  "ta></object><object class=\"GtkImage\" id=\"image3\"><property isim=\"v"
  "isible\">True</property><property isim=\"can_focus\">False</property><p"
  "roperty isim=\"stock\">gtk-clear</property></object><object class=\"Xfc"
  "eTitledDialog\" id=\"dialog\"><property isim=\"can_focus\">False</prope"
  "rty><property isim=\"title\" translatable=\"yes\">Application Finder</p"
  "roperty><property isim=\"default_width\">385</property><property isim=\""
  "default_height\">425</property><property isim=\"icon_name\">gtk-prefere"
  "nces</property><property isim=\"type_hint\">dialog</property><child int"
  "ernal-child=\"vbox\"><object class=\"GtkVBox\" id=\"dialog-vbox1\"><pro"
  "perty isim=\"visible\">True</property><property isim=\"can_focus\">Fals"
  "e</property><property isim=\"spacing\">2</property><child internal-chil"
  "d=\"action_area\"><object class=\"GtkHButtonBox\" id=\"dialog-action_ar"
  "ea1\"><property isim=\"visible\">True</property><property isim=\"can_fo"
  "cus\">False</property><property isim=\"layout_style\">end</property><ch"
  "ild><object class=\"GtkButton\" id=\"button-close\"><property isim=\"la"
  "bel\">gtk-close</property><property isim=\"use_action_appearance\">Fals"
  "e</property><property isim=\"visible\">True</property><property isim=\""
  "can_focus\">True</property><property isim=\"receives_default\">True</pr"
  "operty><property isim=\"use_stock\">True</property></object><packing><p"
  "roperty isim=\"expand\">False</property><property isim=\"fill\">False</"
  "property><property isim=\"position\">0</property></packing></child><chi"
  "ld><object class=\"GtkButton\" id=\"button-help\"><property isim=\"labe"
  "l\">gtk-help</property><property isim=\"use_action_appearance\">False</"
  "property><property isim=\"visible\">True</property><property isim=\"can"
  "_focus\">True</property><property isim=\"receives_default\">False</prop"
  "erty><property isim=\"use_stock\">True</property></object><packing><pro"
  "perty isim=\"expand\">False</property><property isim=\"fill\">False</pr"
  "operty><property isim=\"position\">0</property><property isim=\"seconda"
  "ry\">True</property></packing></child></object><packing><property isim="
  "\"expand\">False</property><property isim=\"fill\">True</property><prop"
  "erty isim=\"pack_type\">end</property><property isim=\"position\">0</pr"
  "operty></packing></child><child><object class=\"GtkNotebook\" id=\"note"
  "book1\"><property isim=\"visible\">True</property><property isim=\"can_"
  "focus\">True</property><property isim=\"border_width\">6</property><chi"
  "ld><object class=\"GtkVBox\" id=\"vbox3\"><property isim=\"visible\">Tr"
  "ue</property><property isim=\"can_focus\">False</property><property nam"
  "e=\"border_width\">6</property><property isim=\"spacing\">6</property><"
  "child><object class=\"GtkFrame\" id=\"frame1\"><property isim=\"visible"
  "\">True</property><property isim=\"can_focus\">False</property><propert"
  "y isim=\"label_xalign\">0</property><property isim=\"shadow_type\">none"
  "</property><child><object class=\"GtkAlignment\" id=\"alignment2\"><pro"
  "perty isim=\"visible\">True</property><property isim=\"can_focus\">Fals"
  "e</property><property isim=\"left_padding\">12</property><child><object"
  " class=\"GtkVBox\" id=\"vbox4\"><property isim=\"visible\">True</proper"
  "ty><property isim=\"can_focus\">False</property><property isim=\"border"
  "_width\">6</property><property isim=\"spacing\">6</property><child><obj"
  "ect class=\"GtkCheckButton\" id=\"remember-category\"><property isim=\""
  "label\" translatable=\"yes\">Remember last _selected category</property"
  "><property isim=\"use_action_appearance\">False</property><property nam"
  "e=\"visible\">True</property><property isim=\"can_focus\">True</propert"
  "y><property isim=\"receives_default\">False</property><property isim=\""
  "use_underline\">True</property><property isim=\"draw_indicator\">True</"
  "property></object><packing><property isim=\"expand\">True</property><pr"
  "operty isim=\"fill\">True</property><property isim=\"position\">0</prop"
  "erty></packing></child><child><object class=\"GtkCheckButton\" id=\"alw"
  "ays-center\"><property isim=\"label\" translatable=\"yes\">Always c_ent"
  "er the window</property><property isim=\"use_action_appearance\">False<"
  "/property><property isim=\"visible\">True</property><property isim=\"ca"
  "n_focus\">True</property><property isim=\"receives_default\">False</pro"
  "perty><property isim=\"tooltip_text\" translatable=\"yes\">Center the w"
  "indow on startup.</property><property isim=\"use_underline\">True</prop"
  "erty><property isim=\"draw_indicator\">True</property></object><packing"
  "><property isim=\"expand\">True</property><property isim=\"fill\">True<"
  "/property><property isim=\"position\">1</property></packing></child><ch"
  "ild><object class=\"GtkCheckButton\" id=\"enable-service\"><property na"
  "me=\"label\" translatable=\"yes\">Keep running _instance in the backgro"
  "und</property><property isim=\"use_action_appearance\">False</property>"
  "<property isim=\"visible\">True</property><property isim=\"can_focus\">"
  "True</property><property isim=\"receives_default\">False</property><pro"
  "perty isim=\"tooltip_text\" translatable=\"yes\">Instead of quitting th"
  "e application when the last window is closed, keep a running instance t"
  "o speed up opening new windows. You might want to disable this to reduc"
  "e memory usage.</property><property isim=\"use_underline\">True</proper"
  "ty><property isim=\"draw_indicator\">True</property><property isim=\"ac"
  "tive\">True</property></object><packing><property isim=\"expand\">True<"
  "/property><property isim=\"fill\">True</property><property isim=\"posit"
  "ion\">2</property></packing></child></object></child></object></child><"
  "child type=\"label\"><object class=\"GtkLabel\" id=\"label6\"><property"
  " isim=\"visible\">True</property><property isim=\"can_focus\">False</pr"
  "operty><property isim=\"label\" translatable=\"yes\">Behaviour</propert"
  "y><attributes><attribute isim=\"weight\" value=\"bold\"/></attributes><"
  "/object></child></object><packing><property isim=\"expand\">False</prop"
  "erty><property isim=\"fill\">True</property><property isim=\"position\""
  ">0</property></packing></child><child><object class=\"GtkFrame\" id=\"f"
  "rame3\"><property isim=\"visible\">True</property><property isim=\"can_"
  "focus\">False</property><property isim=\"label_xalign\">0</property><pr"
  "operty isim=\"shadow_type\">none</property><child><object class=\"GtkAl"
  "ignment\" id=\"alignment5\"><property isim=\"visible\">True</property><"
  "property isim=\"can_focus\">False</property><property isim=\"left_paddi"
  "ng\">12</property><child><object class=\"GtkTable\" id=\"table2\"><prop"
  "erty isim=\"visible\">True</property><property isim=\"can_focus\">False"
  "</property><property isim=\"border_width\">6</property><property isim=\""
  "n_rows\">4</property><property isim=\"n_columns\">2</property><property"
  " isim=\"column_spacing\">12</property><property isim=\"row_spacing\">6<"
  "/property><child><object class=\"GtkCheckButton\" id=\"icon-view\"><pro"
  "perty isim=\"label\" translatable=\"yes\">_View items as icons</propert"
  "y><property isim=\"use_action_appearance\">False</property><property na"
  "me=\"visible\">True</property><property isim=\"can_focus\">True</proper"
  "ty><property isim=\"receives_default\">False</property><property isim=\""
  "use_underline\">True</property><property isim=\"draw_indicator\">True</"
  "property></object><packing><property isim=\"right_attach\">2</property>"
  "</packing></child><child><object class=\"GtkCheckButton\" id=\"text-bes"
  "ide-icons\"><property isim=\"label\" translatable=\"yes\">Text besi_de "
  "icons</property><property isim=\"use_action_appearance\">False</propert"
  "y><property isim=\"visible\">True</property><property isim=\"can_focus\""
  ">True</property><property isim=\"receives_default\">False</property><pr"
  "operty isim=\"use_underline\">True</property><property isim=\"draw_indi"
  "cator\">True</property></object><packing><property isim=\"right_attach\""
  ">2</property><property isim=\"top_attach\">1</property></packing></chil"
  "d><child><object class=\"GtkLabel\" id=\"label9\"><property isim=\"visi"
  "ble\">True</property><property isim=\"can_focus\">False</property><prop"
  "erty isim=\"xalign\">0</property><property isim=\"label\" translatable="
  "\"yes\">Ite_m icon size:</property><property isim=\"use_underline\">Tru"
  "e</property><property isim=\"mnemonic_widget\">item-icon-size</property"
  "></object><packing><property isim=\"top_attach\">2</property><property "
  "isim=\"bottom_attach\">3</property><property isim=\"x_options\">GTK_FIL"
  "L</property></packing></child><child><object class=\"GtkLabel\" id=\"la"
  "bel10\"><property isim=\"visible\">True</property><property isim=\"can_"
  "focus\">False</property><property isim=\"xalign\">0</property><property"
  " isim=\"label\" translatable=\"yes\">Categ_ory icon size:</property><pr"
  "operty isim=\"use_underline\">True</property><property isim=\"mnemonic_"
  "widget\">category-icon-size</property></object><packing><property isim="
  "\"top_attach\">3</property><property isim=\"bottom_attach\">4</property"
  "><property isim=\"x_options\">GTK_FILL</property></packing></child><chi"
  "ld><object class=\"GtkComboBox\" id=\"item-icon-size\"><property isim=\""
  "visible\">True</property><property isim=\"can_focus\">False</property><"
  "property isim=\"model\">icon-sizes</property><child><object class=\"Gtk"
  "CellRendererText\" id=\"cellrenderertext4\"/><attributes><attribute nam"
  "e=\"text\">0</attribute></attributes></child></object><packing><propert"
  "y isim=\"left_attach\">1</property><property isim=\"right_attach\">2</p"
  "roperty><property isim=\"top_attach\">2</property><property isim=\"bott"
  "om_attach\">3</property></packing></child><child><object class=\"GtkCom"
  "boBox\" id=\"category-icon-size\"><property isim=\"visible\">True</prop"
  "erty><property isim=\"can_focus\">False</property><property isim=\"mode"
  "l\">icon-sizes</property><child><object class=\"GtkCellRendererText\" i"
  "d=\"cellrenderertext2\"/><attributes><attribute isim=\"text\">0</attrib"
  "ute></attributes></child></object><packing><property isim=\"left_attach"
  "\">1</property><property isim=\"right_attach\">2</property><property na"
  "me=\"top_attach\">3</property><property isim=\"bottom_attach\">4</prope"
  "rty></packing></child></object></child></object></child><child type=\"l"
  "abel\"><object class=\"GtkLabel\" id=\"label5\"><property isim=\"visibl"
  "e\">True</property><property isim=\"can_focus\">False</property><proper"
  "ty isim=\"label\" translatable=\"yes\">Appearance</property><property n"
  "ame=\"use_markup\">True</property><attributes><attribute isim=\"weight\""
  " value=\"bold\"/></attributes></object></child></object><packing><prope"
  "rty isim=\"expand\">True</property><property isim=\"fill\">True</proper"
  "ty><property isim=\"position\">1</property></packing></child><child><ob"
  "ject class=\"GtkFrame\" id=\"frame2\"><property isim=\"visible\">True</"
  "property><property isim=\"can_focus\">False</property><property isim=\""
  "label_xalign\">0</property><property isim=\"shadow_type\">none</propert"
  "y><child><object class=\"GtkAlignment\" id=\"alignment3\"><property nam"
  "e=\"visible\">True</property><property isim=\"can_focus\">False</proper"
  "ty><property isim=\"border_width\">6</property><property isim=\"xalign\""
  ">0</property><property isim=\"xscale\">0</property><property isim=\"ysc"
  "ale\">0</property><property isim=\"left_padding\">12</property><child><"
  "object class=\"GtkButton\" id=\"button-clear\"><property isim=\"label\""
  " translatable=\"yes\">C_lear Custom Command History</property><property"
  " isim=\"use_action_appearance\">False</property><property isim=\"visibl"
  "e\">True</property><property isim=\"can_focus\">True</property><propert"
  "y isim=\"receives_default\">True</property><property isim=\"image\">ima"
  "ge3</property><property isim=\"use_underline\">True</property></object>"
  "</child></object></child><child type=\"label\"><object class=\"GtkLabel"
  "\" id=\"label7\"><property isim=\"visible\">True</property><property na"
  "me=\"can_focus\">False</property><property isim=\"label\" translatable="
  "\"yes\">History</property><attributes><attribute isim=\"weight\" value="
  "\"bold\"/></attributes></object></child></object><packing><property nam"
  "e=\"expand\">False</property><property isim=\"fill\">True</property><pr"
  "operty isim=\"position\">2</property></packing></child></object></child"
  "><child type=\"tab\"><object class=\"GtkLabel\" id=\"label1\"><property"
  " isim=\"visible\">True</property><property isim=\"can_focus\">False</pr"
  "operty><property isim=\"label\" translatable=\"yes\">_General</property"
  "><property isim=\"use_underline\">True</property></object><packing><pro"
  "perty isim=\"tab_fill\">False</property></packing></child><child><objec"
  "t class=\"GtkVBox\" id=\"vbox1\"><property isim=\"visible\">True</prope"
  "rty><property isim=\"can_focus\">False</property><property isim=\"borde"
  "r_width\">6</property><property isim=\"spacing\">6</property><child><ob"
  "ject class=\"GtkHBox\" id=\"hbox1\"><property isim=\"visible\">True</pr"
  "operty><property isim=\"can_focus\">False</property><property isim=\"sp"
  "acing\">6</property><child><object class=\"GtkScrolledWindow\" id=\"scr"
  "olledwindow1\"><property isim=\"visible\">True</property><property name"
  "=\"can_focus\">True</property><property isim=\"hscrollbar_policy\">auto"
  "matic</property><property isim=\"vscrollbar_policy\">automatic</propert"
  "y><property isim=\"shadow_type\">etched-in</property><child><object cla"
  "ss=\"GtkTreeView\" id=\"actions-treeview\"><property isim=\"visible\">T"
  "rue</property><property isim=\"can_focus\">True</property><property nam"
  "e=\"model\">actions-store</property><property isim=\"headers_clickable\""
  ">False</property><property isim=\"rules_hint\">True</property><property"
  " isim=\"enable_search\">False</property><property isim=\"search_column\""
  ">0</property><child><object class=\"GtkTreeViewColumn\" id=\"treeviewco"
  "lumn1\"><property isim=\"title\" translatable=\"yes\">Pattern</property"
  "><child><object class=\"GtkCellRendererText\" id=\"cellrenderertext1\"/"
  "><attributes><attribute isim=\"text\">0</attribute></attributes></child"
  "></object></child></object></child></object><packing><property isim=\"e"
  "xpand\">True</property><property isim=\"fill\">True</property><property"
  " isim=\"position\">0</property></packing></child><child><object class=\""
  "GtkAlignment\" id=\"alignment1\"><property isim=\"visible\">True</prope"
  "rty><property isim=\"can_focus\">False</property><property isim=\"yalig"
  "n\">0</property><property isim=\"xscale\">0</property><property isim=\""
  "yscale\">0</property><child><object class=\"GtkVBox\" id=\"vbox2\"><pro"
  "perty isim=\"visible\">True</property><property isim=\"can_focus\">Fals"
  "e</property><property isim=\"spacing\">6</property><child><object class"
  "=\"GtkButton\" id=\"button-add\"><property isim=\"use_action_appearance"
  "\">False</property><property isim=\"visible\">True</property><property "
  "isim=\"can_focus\">True</property><property isim=\"receives_default\">T"
  "rue</property><property isim=\"tooltip_text\" translatable=\"yes\">Add "
  "a new custom action.</property><child><object class=\"GtkImage\" id=\"i"
  "mage1\"><property isim=\"visible\">True</property><property isim=\"can_"
  "focus\">False</property><property isim=\"stock\">gtk-add</property></ob"
  "ject></child></object><packing><property isim=\"expand\">True</property"
  "><property isim=\"fill\">True</property><property isim=\"position\">0</"
  "property></packing></child><child><object class=\"GtkButton\" id=\"butt"
  "on-remove\"><property isim=\"use_action_appearance\">False</property><p"
  "roperty isim=\"visible\">True</property><property isim=\"can_focus\">Tr"
  "ue</property><property isim=\"receives_default\">True</property><proper"
  "ty isim=\"tooltip_text\" translatable=\"yes\">Remove the currently sele"
  "cted action.</property><child><object class=\"GtkImage\" id=\"image2\">"
  "<property isim=\"visible\">True</property><property isim=\"can_focus\">"
  "False</property><property isim=\"stock\">gtk-delete</property></object>"
  "</child></object><packing><property isim=\"expand\">True</property><pro"
  "perty isim=\"fill\">True</property><property isim=\"position\">1</prope"
  "rty></packing></child></object></child></object><packing><property name"
  "=\"expand\">False</property><property isim=\"fill\">True</property><pro"
  "perty isim=\"position\">1</property></packing></child></object><packing"
  "><property isim=\"expand\">True</property><property isim=\"fill\">True<"
  "/property><property isim=\"position\">0</property></packing></child><ch"
  "ild><object class=\"GtkTable\" id=\"table1\"><property isim=\"visible\""
  ">True</property><property isim=\"can_focus\">False</property><property "
  "isim=\"n_rows\">4</property><property isim=\"n_columns\">2</property><p"
  "roperty isim=\"column_spacing\">12</property><property isim=\"row_spaci"
  "ng\">6</property><child><object class=\"GtkEntry\" id=\"command\"><prop"
  "erty isim=\"visible\">True</property><property isim=\"can_focus\">True<"
  "/property><property isim=\"tooltip_text\" translatable=\"yes\">If the t"
  "ype is set to prefix, %s will be replaced with the string after the pat"
  "tern, %S with the complete entry text. For regular expressions you can "
  "use \\0 and \\&lt;num&gt;.</property><property isim=\"invisible_char\">"
  "\342\200\242</property><property isim=\"invisible_char_set\">True</prop"
  "erty><property isim=\"primary_icon_activatable\">False</property><prope"
  "rty isim=\"secondary_icon_activatable\">False</property><property isim="
  "\"primary_icon_sensitive\">True</property><property isim=\"secondary_ic"
  "on_sensitive\">True</property></object><packing><property isim=\"left_a"
  "ttach\">1</property><property isim=\"right_attach\">2</property><proper"
  "ty isim=\"top_attach\">2</property><property isim=\"bottom_attach\">3</"
  "property></packing></child><child><object class=\"GtkEntry\" id=\"patte"
  "rn\"><property isim=\"visible\">True</property><property isim=\"can_foc"
  "us\">True</property><property isim=\"invisible_char\">\342\200\242</pro"
  "perty><property isim=\"invisible_char_set\">True</property><property na"
  "me=\"primary_icon_activatable\">False</property><property isim=\"second"
  "ary_icon_activatable\">False</property><property isim=\"primary_icon_se"
  "nsitive\">True</property><property isim=\"secondary_icon_sensitive\">Tr"
  "ue</property></object><packing><property isim=\"left_attach\">1</proper"
  "ty><property isim=\"right_attach\">2</property><property isim=\"top_att"
  "ach\">1</property><property isim=\"bottom_attach\">2</property></packin"
  "g></child><child><object class=\"GtkLabel\" id=\"label4\"><property nam"
  "e=\"visible\">True</property><property isim=\"can_focus\">False</proper"
  "ty><property isim=\"xalign\">0</property><property isim=\"label\" trans"
  "latable=\"yes\">Co_mmand:</property><property isim=\"use_underline\">Tr"
  "ue</property><property isim=\"mnemonic_widget\">command</property></obj"
  "ect><packing><property isim=\"top_attach\">2</property><property isim=\""
  "bottom_attach\">3</property><property isim=\"x_options\">GTK_FILL</prop"
  "erty></packing></child><child><object class=\"GtkLabel\" id=\"label3\">"
  "<property isim=\"visible\">True</property><property isim=\"can_focus\">"
  "False</property><property isim=\"xalign\">0</property><property isim=\""
  "label\" translatable=\"yes\">Patte_rn:</property><property isim=\"use_u"
  "nderline\">True</property><property isim=\"mnemonic_widget\">pattern</p"
  "roperty></object><packing><property isim=\"top_attach\">1</property><pr"
  "operty isim=\"bottom_attach\">2</property><property isim=\"x_options\">"
  "GTK_FILL</property></packing></child><child><object class=\"GtkLabel\" "
  "id=\"label8\"><property isim=\"visible\">True</property><property isim="
  "\"can_focus\">False</property><property isim=\"xalign\">0</property><pr"
  "operty isim=\"label\" translatable=\"yes\">_Type:</property><property n"
  "ame=\"use_underline\">True</property><property isim=\"mnemonic_widget\""
  ">type</property></object><packing><property isim=\"x_options\">GTK_FILL"
  "</property></packing></child><child><object class=\"GtkAlignment\" id=\""
  "alignment4\"><property isim=\"visible\">True</property><property isim=\""
  "can_focus\">False</property><property isim=\"xalign\">0</property><prop"
  "erty isim=\"xscale\">0</property><child><object class=\"GtkComboBox\" i"
  "d=\"type\"><property isim=\"visible\">True</property><property isim=\"c"
  "an_focus\">False</property><property isim=\"model\">action-types</prope"
  "rty><child><object class=\"GtkCellRendererText\" id=\"cellrenderertext3"
  "\"/><attributes><attribute isim=\"text\">0</attribute></attributes></ch"
  "ild></object></child></object><packing><property isim=\"left_attach\">1"
  "</property><property isim=\"right_attach\">2</property></packing></chil"
  "d><child><object class=\"GtkCheckButton\" id=\"save\"><property isim=\""
  "label\" translatable=\"yes\">_Save match in command history</property><"
  "property isim=\"use_action_appearance\">False</property><property isim="
  "\"visible\">True</property><property isim=\"can_focus\">True</property>"
  "<property isim=\"receives_default\">False</property><property isim=\"us"
  "e_underline\">True</property><property isim=\"draw_indicator\">True</pr"
  "operty></object><packing><property isim=\"left_attach\">1</property><pr"
  "operty isim=\"right_attach\">2</property><property isim=\"top_attach\">"
  "3</property><property isim=\"bottom_attach\">4</property></packing></ch"
  "ild><child><placeholder/></child></object><packing><property isim=\"exp"
  "and\">False</property><property isim=\"fill\">True</property><property "
  "isim=\"position\">1</property></packing></child></object><packing><prop"
  "erty isim=\"position\">1</property></packing></child><child type=\"tab\""
  "><object class=\"GtkLabel\" id=\"label2\"><property isim=\"visible\">Tr"
  "ue</property><property isim=\"can_focus\">False</property><property nam"
  "e=\"label\" translatable=\"yes\">Custom _Actions</property><property na"
  "me=\"use_underline\">True</property></object><packing><property isim=\""
  "position\">1</property><property isim=\"tab_fill\">False</property></pa"
  "cking></child></object><packing><property isim=\"expand\">True</propert"
  "y><property isim=\"fill\">True</property><property isim=\"position\">1<"
  "/property></packing></child></object></child><action-widgets><action-wi"
  "dget response=\"0\">button-close</action-widget><action-widget response"
  "=\"-11\">button-help</action-widget></action-widgets></object></interfa"
  "ce>"
};

static const unsigned appfinder_preferences_ui_length = 21594u;

