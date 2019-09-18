import { Profile } from './../../models/profile';
import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams, AlertController } from 'ionic-angular';
import { User } from "../../models/user";
import { AngularFireAuth } from "angularfire2/auth";
import { AngularFireDatabase, AngularFireObject } from 'angularfire2/database';
import { Observable, Subscription } from 'rxjs';



@IonicPage({
  name: 'tolog',
  defaultHistory:['AccueilPage']
})
@Component({
  selector: 'page-login',
  templateUrl: 'login.html',
})
export class LoginPage {

  user = {} as User; 
  profileRef: AngularFireObject<Profile>;
  profile: Observable<Profile>;
  profile$: Subscription;

  constructor( private afAuth: AngularFireAuth, private db: AngularFireDatabase,
     public navCtrl: NavController, public navParams: NavParams,private alertCtrl: AlertController ) {
  }

 async toMenu(user: User){ 
  
      this.afAuth.auth.signInWithEmailAndPassword(user.email, user.password).then(  data => {
        if(data){
          this.profileRef = this.db.object(`profile/${data.user.uid}`);
          this.profile = this.profileRef.valueChanges();
          this.profile$ =  this.db.object<Profile>(`profile/${data.user.uid}`).valueChanges().subscribe(profileInit => {

            if (profileInit!= null){
              this.navCtrl.setRoot('MenuPage')
              

            }else{
              console.log('test2')
              this.navCtrl.setRoot('InitprofPage')
            }

          });
        }
      }).catch(e=>{
        console.log(e);
        let alert = this.alertCtrl.create({
          title: 'Erreur Connexion', message: 'Vérifiez vos id', buttons: ['OK']
        });
        alert.present();
      });
  }

 
}