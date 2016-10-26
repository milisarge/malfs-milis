

##Milis İşletim Sistemi
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


Milis Anasayfa : http://milis.gungre.ch

####İletişim:

milisarge@gmail.com 

irc.freenode.net #milisarge


Sunucu desteği için Lucas Sköldqvist dostumuza teşekkür ederiz. 

###MPS (Milis Paket Sistemi)

Mps Milis işletim sisteminin kendine özgü sıfırdan bash betik dilinde yazılmış paket yöneticisidir.
Mps ile talimatnamedeki talimatları kullanarak paket üretebilir,paket kurabilir kaldırabilir ve güncelleyebilirsiniz.

```
mps guncelle                İkili paket veritabanını ve sistemi günceller.

mps kur paket_adi           Depodan yazılım paketi kurar.

mps kur paket_adi.mps.lz    Dosyadan yazılım paketi kurar.

mps sil paket_adi           Paket siler.

mps ara paket_adi           Paket arar.


API Parametreler

mps -G                      İkili paket veritabanini gunceller.

mps -GG                     Git sunucusundan talimatname ve sistem günceller.

mps -kur paket_ismi         İlgili paketi bağimlılıklarıyla ağdan çekip kurar.

mps -s paket_ismi           İlgili paketi kaldırır.

mps -k paket_ismi           Yereldeki paketi bagimliliksiz kurar.

mps -kl                     Kurulu paket listesini verir.

mps -kk paket_ismi          İlgili paketin kurulu olma durumunu verir.

mps -d paket_ismi           İlgili paketin talimat dosyasına göre bağımlıksız derler,paketler.

mps -derle paket_ismi       İlgili paketin talimat dosyasına göre bağımlıklarıyla derler,paketler.
```

