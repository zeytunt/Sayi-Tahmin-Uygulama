//
//  ViewController.swift
//  Sayı tahmin uygulaması
//
//  Created by zeytun on 17.10.2024.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var txtTahminEdilecekSayi: UITextField!
    @IBOutlet weak var imgKaydet: UIImageView!
    @IBOutlet weak var btnKaydet: UIButton!
    @IBOutlet weak var btnDene: UIButton!
    @IBOutlet weak var txtTahminSayisi: UITextField!
    @IBOutlet weak var imgTahmin: UIImageView!
    @IBOutlet weak var imgDene: UIImageView!
    @IBOutlet weak var lblSonuc: UILabel!
    @IBOutlet weak var imgYildiz1: UIImageView!
    @IBOutlet weak var imgYildiz2: UIImageView!
    @IBOutlet weak var imgYildiz3: UIImageView!
    @IBOutlet weak var imgYildiz4: UIImageView!
    @IBOutlet weak var imgYildiz5: UIImageView!
   
    // ekrandaki 5 tane yıldızı dizi halinde tutar
    var yildizlar : [UIImageView] = [UIImageView]()
    
    // kullanıcının kullanması gereken max deneme sayısı
    var maxDenemeSayisi : Int = 5
    // kullanıcı kaç tane deneme yaptı
    var denemeSayisi : Int = 0
    // tahmin edilmesi gereken sayi
    var hedefSayi : Int = -1
    var oyunBasarili : Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        yildizlar = [imgYildiz1 , imgYildiz2 , imgYildiz3 , imgYildiz4 , imgYildiz5]
        
        imgKaydet.isHidden = true // isHidden bu görsel gizlensin mi anlamına gelir. - KULLANICI İŞLEM YAPMADAN ÖNCE GİZLENMESİNİ SAĞLAR.
        imgDene.isHidden = true
        btnDene.isEnabled = false // ilk başta tahmin edilecek sayı girilmeden çalışmayacaktır. / Çalışmamasını sağlar.
        txtTahminEdilecekSayi.isSecureTextEntry = true // tahmin edilecek sayı girilirken şifreli gözükür , sayı açık bir şekilde gözükmez.
        lblSonuc.text = ""
        
    }

    @IBAction func btnKaydetClicked(_ sender: UIButton) {
        
        imgKaydet.isHidden = false
        
        if let t = Int(txtTahminEdilecekSayi.text!){
            hedefSayi = t
            btnDene.isEnabled = true
            txtTahminEdilecekSayi.isEnabled = false
            btnKaydet.isEnabled = false
            imgKaydet.image = UIImage(named: "onay")
            
        }else{
            imgKaydet.image = UIImage(named: "hata")
            
        }
        
        
    }
    
    @IBAction func btnDeneClicked(_ sender: UIButton) {
    
        if oyunBasarili == true || denemeSayisi > maxDenemeSayisi{
            return
        }
        imgDene.isHidden = false
        
        if let girilenSayi = Int(txtTahminSayisi.text!){
            denemeSayisi += 1
            yildizlar[denemeSayisi  - 1].image = UIImage(named: "beyazYildiz")
            imgDene.isHidden = false
            
            if girilenSayi > hedefSayi {
                
                imgDene.image = UIImage(named: "asagi")
                txtTahminSayisi.backgroundColor = UIColor.red
                
            }else if girilenSayi < hedefSayi {
                
                imgDene.image = UIImage(named: "yukari")
                txtTahminSayisi.backgroundColor = UIColor.red
                
            }else{
                // oyuncu başarılı bir şekilde tahmin ettiğinde bu alan çalışır!!!!!
                
                imgDene.image = UIImage(named: "tamam")
                txtTahminSayisi.backgroundColor = UIColor.green
                btnKaydet.isEnabled = true
                btnDene.isEnabled = false
                lblSonuc.text = "DOĞRU TAHMİN !!"
                txtTahminEdilecekSayi.backgroundColor = UIColor.green
                txtTahminEdilecekSayi.isSecureTextEntry = false
                oyunBasarili = true
                
                // UIAlertController metodu bildirim göstermemizi sağlar. alertAction ise o bildirimin altına buton koymamızı sağlar.AlerAction butonuna tıklamadan
                // ekrandaki diğer alanlar çalışmaz. Son olarak alertController.addAction diyerek alertAction'ı eklemeyi unutma!
                
                
                let alertController = UIAlertController(title: "BAŞARILI", message: "Tebrikler oyunu kazandınız.", preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                
                let playAgainAction = UIAlertAction(title: "Yeniden Oyna", style: UIAlertAction.Style.default ,handler: nil)
                
                alertController.addAction(alertAction)
                alertController.addAction(playAgainAction)
                
                present(alertController , animated: true)
                
                return
        }
            
        }else{
            // oyuncu oyunda başarısız olduğunda bu alan çalışır!!!!!
            
            imgDene.image = UIImage(named: "hata")

        }
        
        // deneme sayisi max deneme sayısını geçince veya eşit olunca başarısız olunacaktır.!!!!!
        
        if denemeSayisi == maxDenemeSayisi{
            btnDene.isEnabled = false
            imgDene.image = UIImage(named: "hata")
            lblSonuc.text = "OYUN BAŞARISIZ \n Arkadaşın \(hedefSayi) sayısını girmişti"
            txtTahminEdilecekSayi.isSecureTextEntry = false
            
        
            let basarisizAlert = UIAlertController(title: "BAŞARISIZ", message: "Oyunu kazanamadınız.Tahmin hakkınız bitti.Tahmin etmen gereken sayı : \(hedefSayi)", preferredStyle: UIAlertController.Style.alert)
            
            let basarisizAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
            
            let playAgainAction = UIAlertAction(title: "Yeniden Oyna", style: UIAlertAction.Style.default ,handler: nil)
            
            basarisizAlert.addAction(basarisizAction)
            basarisizAlert.addAction(playAgainAction)
            
            
            present(basarisizAlert, animated: true, completion: nil)
            
            return
        }
        
    }
    
    
}


