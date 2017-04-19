# bütün kurallar temizlenir
servis iptables clear

# değişkenler ayarlanır
SUID=$(id -u squid)
agarayuz=wlp3s0

# 80 ve 443 çıkışları squid e tahsis edilir.80 ve 443 çıkışları squid in ilgili portlarına yönlendirilir.
iptables -t nat -A OUTPUT -p tcp -m multiport --dports 80,443 -m owner --uid-owner 90 -j ACCEPT
iptables -t nat -A OUTPUT -p tcp --dport 80 -m owner ! --uid-owner 90 -j REDIRECT --to-port 3128
iptables -t nat -A OUTPUT -p tcp --dport 443 -m owner ! --uid-owner 90 -j REDIRECT --to-port 3130
iptables -A OUTPUT -o $agarayuz -p tcp -m multiport --dports 1024:65535 -m state --state NEW -j ACCEPT
