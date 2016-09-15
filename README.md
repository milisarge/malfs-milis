

####Milis İşletim Sistemine hoş geldiniz.

Milis işletim sistemi,lfs esaslarını temel alarak yerli bağımsız bir dağıtım olmak üzere yola çıkmıştır.
Milis işletim sistemi kendine özgü mps paket yöneticisi kullanmaktadır.
Mps paket yöneticisi performansı ve sorunsuz paket derleme-kurup-kaldırma-güncellemeyi hedeflemektedir.
Bash betik dilinde yazılmıştır,bu sayede direk linux komutlarıyla paket sistemi daha etkileşimli bir şekilde yönetilmektedir.
Milis işletim sisteminin paketleri bir lzma algoritması olan lzip yöntemiyle sıkıştırılmaktadır.Uzantı olarak mps.lz şeklindedirler.
Milis sisteminde ayrıca talimatnameye dayalı derleme sistemi kullanılmaktadır.
Her paket için bir talimat dosyası vardır,bu talimat dosyası bir paketin nasıl derlenip nasıl paket haline getireleciğini yazar.
Talimat dosyaları da bash betik dilindedir.Talimatlar mps tarafından kullanılarak paket üretimi sağlanmaktadır.
Milis işletim sistemi son güncel sürümleri dikkate alarak paket üretmektedir,yalnız sürekli güncellikten ziyade kararlı güncellik benimsenmektedir.
Milis başta ülkemizin işletim sistemi ihtiyaçlarını dikkate almayı hedeflemektedir.
Genel felsefe olarak ülkemizdeki bilgisayar kullanıcıları için linuxu kolaylaştırıp 
Milis işletim sisteminin sorunsuz bir işletim sistemi olmasını sağlamayı ve yazılımsal olarak dışa bağımlı olmaktan kurtarmayı esas alır. 
Milis'in ana hedefi ülkemizde her bilgisayarda(resmi,işyerleri,ev kullanıcıları) bağımsız yazılım ve bileşkenlerinin kullanımını sağlamaktır.
Kısaca Milis,sanal dünyanın getirisi olarak hakkımız olan kaybettiğimiz bilim ve ilerlemenin yeniden yakalanması için Milisçe bir çalışmadır. 
Ayrıca her türlü katkıda bulunmak isteyenler için bulunmaz bir türkçe açık kaynak projesidir.


milis anasayfa : http://milis.gungre.ch

iletişim: milisarge@gmail.com irc.freenode.net #milisarge

Sunucu desteği için Lucas Sköldqvist dostumuza teşekkür ederiz. 

###MPS (Milis Paket Sistemi)

Mps Milis işletim sisteminin kendine özgü sıfırdan bash betik dilinde yazılmış paket yöneticisidir.
Mps ile talimatnamedeki talimatları kullanarak paket üretebilir,paket kurabilir kaldırabilir ve güncelleyebilirsiniz.

```
mps -G					ikili paket veritabanini gunceller

mps -Ggit				git sunucusundan talimatname ve sistem gunceller

mps -kur   paket_ismi	ilgili paketi bagimliliklariyla agdan cekip kurar

mps -s     paket_ismi	ilgili paketi kaldirir

mps -k     paket_ismi	yereldeki paketi bagimliliksiz kurar

mps -g     paket_ismi	paketi günceller

mps -go    paket_ismi	paketi bağımlılıklarıyla günceller

mps -kl					kurulu paket listesini verir

mps -kk    paket_ismi	ilgili paketin kurulu olma durumunu verir

mps -d     paket_ismi	ilgili paketin talimat dosyasına göre sadece derler,paketler

mps -derle paket_ismi	ilgili paketin talimat dosyasına göre bagimliliklariyla beraber derler,paketler ve kurar.
```

