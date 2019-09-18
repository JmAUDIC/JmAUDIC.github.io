import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams, ToastController } from 'ionic-angular';
import { User } from "../../models/user";
import { AngularFireAuth } from "angularfire2/auth";

@IonicPage({
  name: 'tosignup',
  defaultHistory:['AccueilPage']
})
@Component({
  selector: 'page-signup',
  templateUrl: 'signup.html',
})
export class SignupPage {

  user = {} as User;

  constructor(private afAuth:AngularFireAuth,private toast: ToastController,
     public navCtrl: NavController, public navParams: NavParams) {
  }

  async signUp(user: User){
    try {
      const result = await this.afAuth.auth.createUserWithEmailAndPassword(user.email, user.password);
      console.log(result);
      this.navCtrl.setRoot('tolog');
      this.toast.create({
        message:"Compte créé avec succées", duration: 3000
      }).present();
    }
    catch (e){
      console.error(e);
    }
  }  
  }
