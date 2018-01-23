

Milis İşletim Sistemi (Milis Linux)

Milis işletim sistemi,lfs esaslarını temel alarak yerli bağımsız bir dağıtım olmak üzere yola çıkmıştır.
Milis işletim sistemi kendine özgü mps paket yöneticisi kullanmaktadır.
Mps paket yöneticisi performansı ve sorunsuz paket derleme-kurup-kaldırma-güncellemeyi hedeflemektedir.
Bash betik dilinde yazılmıştır,bu sayede direk linux komutlarıyla paket sistemi daha etkileşimli bir şekilde yönetilmektedir.
Milis işletim sisteminin paketleri bir lzma algoritması olan lzip yöntemiyle sıkıştırılmaktadır.Uzantı olarak mps.lz şeklindedirler.
Milis sisteminde ayrıca talimatnameye dayalı derleme sistemi kullanılmaktadır.
Her paket için bir talimat dosyası vardır,bu talimat dosyası bir paketin nasıl derlenip nasıl paket haline getirileceğini yazar.
Talimat dosyaları da bash betik dilindedir.Talimatlar mps tarafından kullanılarak paket üretimi sağlanmaktadır.
Milis işletim sistemi son güncel sürümleri dikkate alarak paket üretmektedir,yalnız sürekli güncellikten ziyade kararlı güncellik benimsenmektedir.
Milis başta ülkemizin işletim sistemi ihtiyaçlarını dikkate almayı hedeflemektedir.
Genel felsefe olarak ülkemizdeki bilgisayar kullanıcıları için linuxu kolaylaştırıp 
Milis işletim sisteminin sorunsuz bir işletim sistemi olmasını sağlamayı ve yazılımsal olarak dışa bağımlı olmaktan kurtarmayı esas alır. 
Milis'in ana hedefi ülkemizde her bilgisayarda(resmi,işyerleri,ev kullanıcıları) bağımsız yazılım ve bileşkenlerinin kullanımını sağlamaktır.
Kısaca Milis Linux,sanal dünyanın getirisi olarak hakkımız olan kaybettiğimiz bilim ve ilerlemenin yeniden yakalanması için Milisçe bir çalışmadır. 
Ayrıca her türlü katkıda bulunmak isteyenler için bulunmaz bir Türkçe açık kaynak projesidir.


Milis Anasayfa : http://milislinux.org

İletişim:

iletisim@milislinux.org

milisarge@gmail.com 

irc.freenode.net #milisarge


Sunucu desteği için Oyakder'e ve Lucas Sköldqvist'e teşekkür ederiz. 

MPS (Milis Paket Sistemi)

Mps Milis işletim sisteminin kendine özgü sıfırdan bash betik dilinde yazılmış paket yöneticisidir.
Mps ile talimatnamedeki talimatları kullanarak paket üretebilir,paket kurabilir kaldırabilir ve güncelleyebilirsiniz.

```
Milis_Paket_Sistemi_Yardim                                                                           
--------------------------                                                                           
mps    -i            paketismi           sadece paketi indirir,paket kurulmaz.   
mps    -ik           paketismi           ilgili paketi indirir ve kurar.         
mps    -ikz|yekur    paketismi           ilgili indirip tekrardan kurar,kurulu olmasına bakılmaz. 
mps    -k            paketismi..mps.lz   yerel dizindeki paketi kurar.           
mps    sil|-s        paketismi           ilgili paketi onaylı kaldırır.          
mps    zorsil|-sz    paketismi           ilgili paketi onaysız kaldırır.         
mps    gsil          paketismi           ilgili paketi güvenli(ters bağımlılıklarına da bakarak) kaldırır. 
mps    -S            paketismi           ilgili paketi altbağımlılıklarını da sorarak kaldırır. 
mps    -Sz           paketismi           ilgili paketi altbağımlılıklarını da sormadan sırayla kaldırır. 
mps    ara           aranan              paket isimleri ve açıklamalarında anahtar kelime arar. 
mps    bul           aranan              talimat dosyaları içinde anahtar kelimeyi arar. 
mps    -d            paketisimi          sadece paketi bağımlıksız derler.Genelde bağımlılığı olmayan paketler için kullanılır. 
mps    -zd           paketismi           Pake kurulu olsa bile derleme yapılır.Bağımlıksız derleme için kullanılır. 
mps    odkp          paketismi           bir paketi bağımlılık zinciri çıkarıp gereklileri önce kurar gerekli olanları derler,paketler ve kurar. 
mps    god           paketismi           mps guncelle && mps odkp paketismi.     
mps    -derlist      liste               verilen liste dosyasındaki paketleri derler.Alt alta yazılı olmalıdır. 
mps    derle         paketismi           paketismi için bağımlılık zinciri çıkarıp gerekli tüm paketleri derler,paketler ve kurar. 
mps    kurul         liste               verilen liste dosyasındaki paketleri kurar.Alt alta yazılı olmalıdır. 
mps    gkur          paketismi           git-paketvt günceller ve yerelde mps.lz varsa yereldekini yoksa sunucudan paketi indirip kurar. 
mps    kur           paketismi           yerelde mps.lz varsa yereldekini yoksa sunucudan paketi indirip kurar. 
mps    kaynak        paketismi           ilgili paketin kaynak kodunu indirir.   
mps    serkur        paketismi           ilgili paketin servisini kurar          
mps    sersil        paketismi           ilgili paketin servisini siler          
mps    serkon        paketismi           servislerin değişmemezlik kontrolünü yapar. 
mps    kurkos        paketismi           ilgili paketin kurulumdan sonraki çalışması gereken betiğini çalıştırır. 
mps    koskur        paketismi           ilgili paketin kurulumdan önceki çalışması gereken betiğini çalıştırır. 
mps    silkos        paketismi           ilgili paketin silindikten sonraki çalışması gereken betiğini çalıştırır. 
mps    kossil        paketismi           ilgili paketin silindikten önceki çalışması gereken betiğini çalıştırır. 
mps    -kdl          paketismi           ilgili paketin sistemdeki kurulmuş olması gereken dosyalarını gösterir. 
mps    -kkp          paketismi           ilgili paketin çalışması için eksik olan dosyaları tespit eder. 
mps    kirma         paketismi           ilgili paketin sistemde kırdığı paketler tespit edilir. 
mps    -kks          .                   sistemde kurulu tüm paketlerin kırık kontrolünü yapar.Eksik dosyaları tespit eder. 
mps    -sk           paketismi           bir paketin güncel sürüm numarasını denetler. 
mps    -dk           paketismi           bir paketin güncel devir numarasını denetler. 
mps    liste         .                   sistemde kurulu olan paket listesini verir. 
mps    dliste        .                   sistemde kurulu olan ama talimatnamede yer almayan paket listesini verir. 
mps    paketler      grup_ismi           paket deposundaki paket listesini verir.(grup_ismi verilmezse tüm paketler) 
mps    gruplar       .                   paket deposundaki paket grup listesini verir. 
mps    -dly          paketismi           ilgili paketin genel ve tüm bağımlılık listesini verir,oluşturur. 
mps    -kly          paketismi           ilgili paketin ve kurulması gereken altgereklerini verir,oluştur. 
mps    -ykp          paketismi           ilgili paketin kurulmak istenirse,kurulacak yeni paketleri listeler. 
mps    sunucular     .                   paket sunucularını verir.               
mps    -bb           paketismi           ilgili paketin gereklerinin durumunu listeler. 
mps    -tb           talimatismi         ilgili talimata gerek duyan(ters-gerekler) talimatları listeler. 
mps    pka           paketismi           ilgili paketin depo-gitdepo uyumluluğunu kontrol eder. 
mps    pda           paketdepo           paketlerin olduğu dizindeki paketlerin depo-gitdepo uyumluluğunu kontrol eder. 
mps    tbilgi        paketismi           ilgili paketin talimat bilgilerini verir. 
mps    talimat       paketismi           ilgili paketin talimatını yazdırır.     
mps    -b            paketismi           ilgili paketin kurulum bilgilerini verir. 
mps    bilgi         paketismi           ilgili paketin talimat ve kurulum bilgilerini verir. 
mps    -to           talimat_ismi        ilgili talimat ismine göre talimat şablonu oluşturur. 
mps    log           yyyy-aa-gg          mps.log verisi çekmek için (ör: mps log 2017-01-01 silindi) 
mps    guncelle      .                   paket veritabanı ve git güncellemesi-talimatname bilgilerini günceller. 
mps    -GG           .                   git güncellemelerini ve talimatname bilgilerini günceller. 
mps    -G            .                   paket veritabanı bilgilerini günceller. 
mps    tespit        .                   tüm sistemin güncellemesi için güncellenecek paket listesini gösterir. 
mps    gun           .                   güncellenmesi gereken ve depoya yeni eklenen paketleri gösterir. 
mps    yukselt       .                   tüm sistemin güncellemesini gerçekleştirir. 
mps    -g            paketismi           ilgili paketi tekil günceller.          
mps    -kk           paketismi           ilgili paketin kurulu olma durumunu gösterir. 
mps    -suko         .                   sunucuların erişim kontrolünü yapar.    
mps    -pot          .                   talimatı olup ta paketi henüz depoda yer almayan talimatları listeler. 
mps    depsil        .                   depo/paketler altındaki paket önbelleğini temizler. 
mps    etksil        .                   /var/lib/pkg/etkilenen altındaki kurtarılmış paket önbelleğini temizler. 
mps    link          url_adres           verilen url adresindeki talimatı ektalimatname/topluluk altına indirir. 
mps    ti            url_adres           verilen url adresindeki talimatı talimatname/genel altına indirir. 
mps    -hp           aranan              ilgili aranan ifadenin hangi paketlerde olabileceğini listeler. 
mps    tgs           talimat             ilgili talimatın kaynak kodunun yeni sürümü olup olmadığını kontrol eder. 
mps    -tro          .                   tarihçe noktası oluşturur.              
mps    -trot         .                   temel tarihçe noktası oluşturur.        
mps    -try          tarihce_nokta       tarihçe noktasına göre paketleri yükler-siler. 
mps    -trl          .                   tarihçe noktalarını listeler.           
mps    tdc           talimat_dosyası     ilgili talimat dosyasının Türkçe değişken çevrimini yapar. 
mps    dos           .                   derleme ortamını sıfırlar.temel tarihçeye geri döner. 
mps    itest         islev_ismi          mps içindeki işlevlerin testi için kullanılmaktadır. 
mps    -v            .                   mps sürüm bilgisini gösterir.
```

