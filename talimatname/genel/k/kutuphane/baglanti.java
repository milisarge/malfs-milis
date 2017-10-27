
package kutuphane.otomasyonu;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import java.util.Date;

public  class baglanti 
{
//--------------------------------------------------------------------------//    
     //----------------------------------------------------------//
public Connection con = null; // Bağlantı nesnesi
//public String url = "jdbc:mysql://localhost:3307/kutuphane?useUnicode=true&amp;amp;characterEncoding=utf8"; // Veritabanı adresi
//public String userName = "root"; // Veritabanı kullanıcı adı
public String driver = "com.mysql.jdbc.Driver";
//public String password = "Şifre girilecek"; // Veritabanı şifresi
public ResultSet result; // Yapılan sorgu sonucunda döndürülen değerlerin tutulacağı nesnedir.
public Statement statement; // Veri tabanına gönderilen sorgu ifadesi nesnesidir. 
public PreparedStatement pst=null;
public Date simdikiZaman;//Şimdiki zamanı aldık
public DateFormat df = new SimpleDateFormat("yyyy-M-dd hh:mm:ss");//zamanı formatladık.
public DefaultTableModel model = new DefaultTableModel();//Model oluşturuyoruz
public DefaultTableModel tm = new DefaultTableModel();//Model oluşturuyoruz
public int sayac_grti=0;
//--------------------/*df.format(simdikiZaman);*/-------------------------------//
//------------------------------------------------------------------------------//
public String ekle_mesaj="Kayıt işleminiz tamamlanmıştır.";
public String sil_mesaj="Silme işleminiz tamamlanmıştır.";
public String güncelle_mesaj="Güncelleme işleminiz tamamlanmıştır.";
public String genel_mesaj="Ebubekir Bastama Kütüphane Otomasyonu";
public String k_girisi_hata="Lütfen Kullanıcıbilgilerinizi kontrol ediniz.";
public String Verivar="Eklemek istediğiniz kitap elimizde bulunmaktadır.";
public String baglantıerro="Bağlantı Başarısız";
public String text_kntrl="Lütfen gerekliyeri boş bırakmayınız.";
public String text_kntrl_1="Lütfen Öğrenciyi ve Teslim edeceğiniz kitabı seçiniz";
public String hat="Hata";
public String kitap_yok="Aradığınız kitap kütüphanemizde bulunmamaktadır.";
public  ArrayList<String> list = new ArrayList<String>();
//------------------------------------------------------------------------------//
public String kitap_verigetirme="SELECT id,ktp_brkt_nmr,ktp_ismi,ktp_adedi,ktp_ktgr,ktp_raf_nmr, ktp_yzr_ismi , ktp_kayit_tarih FROM kitaplar";
public String ogrenci_verigetirme="SELECT * FROM ogr";
public String kitap_kategori_verigetirme="select * from ktp_ktgr";
public String yetkili_verigetirme="select * from yetkili";
//------------------------------------------------------------------------------//
public String []dgr_ogrenci={"No", "Öğrenci Tc No", "Öğrenci Adı", "öğrenci Soyadı", "Sınıfı", "Telefon Numarası", "Tarih"};
public String []dgr_kitap={"No","Barkot Numarası","Kitap İsmi","Kitap Adedi","Kitap Kategorisi","Kitap Raf No","Yazar İsmi","Tarih"}; 
public String []dgr_kitap_kategorisi={"No","Kategori İsmi","Tarih"};
public String []dgr_yetkili={"No","Yetkili İsmi", "Yetkili Soyadı", "Yetkili Ünvanı", "Yetkili Şifresi","Tarih"};
public String []k_girisi_par={"ytkl_ism","ytkl_sf"};
public String []ktp_odunc={"Öğrenci Numarası","Kitap Barkot Numarası","Kayıt Tarihi"};
public String []ktp_ekleme={"ktp_brkt_nmr_,ktp_ismi_,ktp_adedi_,ktp_ktgr_,ktp_raf_nmr_,ktp_yzr_ismi_,ktp_kayit_tarih_"};
public String []ktp_guncelle={"ktp_brkt_nmr_,ktp_ismi_,ktp_adedi_,ktp_ktgr_,ktp_raf_nmr_,ktp_yzr_ismi_,ktp_kayit_tarih_"};
//-----------------------------------------------------------------//
//--------------------------------------------------------------------------//
public void oku() throws FileNotFoundException, IOException
{   
try{
  
FileReader fileReader = new FileReader("/etc/kutup.conf");
String line;
BufferedReader br = new BufferedReader(fileReader);      
while ((line = br.readLine()) != null) {         
list.add(line);
}  
br.close();
}
catch(Exception ex)
{
  JOptionPane.showMessageDialog(null, ex.getMessage() ,hat, 1);
}
    
}
public void baglanti()
{
try
     {
         oku();
         Class.forName(driver);
          con=DriverManager.getConnection(list.get(0).toString(),list.get(1).toString(),list.get(2).toString());
          statement=(Statement)con.createStatement();
          if (con != null){}
          else{JOptionPane.showMessageDialog(null,baglantıerro);}         
     }
     catch(Exception e)
     {
         JOptionPane.showMessageDialog(null, e.getMessage() ,hat, 1);
     }
}

public void veri_ekle(String sqlcumle,String a[])
{
  try       
  {   
      baglanti(); 
    CallableStatement calstat=con.prepareCall("{call'"+sqlcumle+"'(?,?,?,?,?,?)}");
    calstat.setString("ktp_brkt_nmr_",a[0]);
    JOptionPane.showMessageDialog(null,"hata1");
    calstat.setString(ktp_ekleme[1],a[1]);
    calstat.setString(ktp_ekleme[2],a[2]);
    calstat.setString(ktp_ekleme[3],a[3]);
    calstat.setString(ktp_ekleme[4],a[4]);
    calstat.setString(ktp_ekleme[5],a[5]);
    calstat.setString(ktp_ekleme[6],a[6]);
    JOptionPane.showMessageDialog(null,"hata1");
    ResultSet rdr= calstat.executeQuery();
    while(rdr.next())
          {
             
              if ("1".equals(rdr.getObject(1).toString()))
              {
                 JOptionPane.showMessageDialog(null,ekle_mesaj,genel_mesaj,2);  
              }
              else
              {
                 JOptionPane.showMessageDialog(null,Verivar,genel_mesaj,2);
              }
          }
    con.close();
    calstat.close();
  }
  catch(SQLException e )
  {
      JOptionPane.showMessageDialog(null, e.getMessage() ,"Hata", 1);
  }   
}

public void veri_sil(String sqlcumle,String a[]) throws SQLException
{
 try       
  {     
     baglanti(); 
    CallableStatement calstat=con.prepareCall("{call '"+sqlcumle+"'(?,?,?)}");
    calstat.setString(ktp_ekleme[0],a[0]);
    ResultSet rdr= calstat.executeQuery();
    while(rdr.next())
          {
             
              if ("1".equals(rdr.getObject(1).toString()))
              {
                 JOptionPane.showMessageDialog(null,ekle_mesaj,genel_mesaj,2);  
              }
              else
              {
                 JOptionPane.showMessageDialog(null,Verivar,genel_mesaj,2);
              }
          }
    con.close();
    calstat.close();
  }
  catch(Exception e)
  {
      JOptionPane.showMessageDialog(null, e.getMessage() ,"Hata", 1);
  }    
}

public void veri_guncelle(String sqlcumle,String a[]) throws SQLException
{
   try       
  {     
     baglanti(); 
    CallableStatement calstat=con.prepareCall("{call '"+sqlcumle+"'(?,?,?)}");
    calstat.setString(ktp_guncelle[0],a[0]);
    calstat.setString(ktp_guncelle[1],a[1]);
    calstat.setString(ktp_guncelle[2],a[2]);
    calstat.setString(ktp_guncelle[3],a[3]);
    calstat.setString(ktp_guncelle[4],a[4]);
    calstat.setString(ktp_guncelle[5],a[5]);
    calstat.setString(ktp_guncelle[6],a[6]);
    ResultSet rdr= calstat.executeQuery();
    while(rdr.next())
          {
             
              if ("1".equals(rdr.getObject(1).toString()))
              {
                 JOptionPane.showMessageDialog(null,ekle_mesaj,genel_mesaj,2);  
              }
              else
              {
                 JOptionPane.showMessageDialog(null,Verivar,genel_mesaj,2);
              }
          }
    con.close();
    calstat.close();
  }
  catch(Exception e)
  {
      JOptionPane.showMessageDialog(null, e.getMessage() ,"Hata", 1);
  }   
}
public void gtr(String sqlcumle,javax.swing.JTable tablo,int kolon_sayisi,String[] dgr) 
{
   try 
   {        
        baglanti();
        try (ResultSet rs = statement.executeQuery(sqlcumle))//Veritabanındaki tabloya bağlandık
        { 
            int colcount = rs.getMetaData().getColumnCount();//Veritabanındaki tabloda kaç tane sütun var?           
            for(int i = 1;i<=colcount;i++)
              tm.addColumn(tm);//Tabloya sütun ekliyoruz veritabanımızdaki sütun ismiyle aynı olacak şekilde
            while(rs.next())
                {
                    Object[] row = new Object[colcount];
                    for(int i=1;i<=colcount;i++)
                    row[i-1] = rs.getObject(i);
                    tm.addRow(row);
                }
            tablo.setModel(tm);
             for (int i = 0; i < kolon_sayisi; i++)
            {
              tablo.getColumnModel().getColumn(i).setHeaderValue(dgr[i]); 
            }
        }
        con.close();
    } catch (Exception e)
    {
       JOptionPane.showMessageDialog(null, e.getMessage() ,"Hata", 1);
    }
}
public void ktgr_sil(String sqlcumle,String a[])
{
  try       
  {     
     baglanti(); 
    CallableStatement calstat=con.prepareCall("{call '"+sqlcumle+"'(?,?,?)}");
//    calstat.setString(ktgr_ekle[0],a[0]);
    ResultSet rdr= calstat.executeQuery();
    while(rdr.next())
          {             
              if ("1".equals(rdr.getObject(1).toString()))
              {
                 JOptionPane.showMessageDialog(null,ekle_mesaj,genel_mesaj,2);  
              }
              else
              {
                 JOptionPane.showMessageDialog(null,Verivar,genel_mesaj,2);
              }
          }
    con.close();
    calstat.close();
  }
  catch(Exception e)
  {
      JOptionPane.showMessageDialog(null, e.getMessage() ,"Hata", 1);
  }   
}
public void rapor(String sqlcumle,javax.swing.JTable tablo,int kolon_sayisi,String[] dgr) 
{
   try 
   {        
        baglanti();
        try (ResultSet rs = statement.executeQuery(sqlcumle))//Veritabanındaki tabloya bağlandık
        { 
            int colcount = rs.getMetaData().getColumnCount();//Veritabanındaki tabloda kaç tane sütun var?           
            for(int i = 1;i<=colcount;i++)
              tm.addColumn(tm);//Tabloya sütun ekliyoruz veritabanımızdaki sütun ismiyle aynı olacak şekilde
            while(rs.next())
                {
                    Object[] row = new Object[colcount];
                    for(int i=1;i<=colcount;i++)
                    row[i-1] = rs.getObject(i);
                    tm.addRow(row);
                }
            tablo.setModel(tm);
             for (int i = 0; i < kolon_sayisi; i++)
            {
              tablo.getColumnModel().getColumn(i).setHeaderValue(dgr[i]); 
            }
        }
        con.close();
    } catch (Exception e)
    {
       JOptionPane.showMessageDialog(null, e.getMessage() ,"Hata", 1);
    }
}
}

