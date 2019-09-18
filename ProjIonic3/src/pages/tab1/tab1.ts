import { Roles } from './../../models/profile';
import { MenuPage } from './../menu/menu';
import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams, ToastController, MenuController, App } from 'ionic-angular';
import { AngularFireAuth } from 'angularfire2/auth';
import { AngularFireDatabase, AngularFireObject } from 'angularfire2/database';
import { Observable, Subscription } from 'rxjs';
import { Profile } from '../../models/profile';
import { User } from '../../models/user';


@IonicPage()
@Component({
  selector: 'page-tab1',
  templateUrl: 'tab1.html',
})
export class Tab1Page {

  item: Observable<Profile>;
  user = {} as User;
  menu: MenuPage;
  profile$: Subscription;
  profileRef: AngularFireObject<Profile>;
  profile: Observable<Profile>;
  prof= {} as Profile;

  constructor(private afAuth: AngularFireAuth, private db: AngularFireDatabase,
    private toast: ToastController, private appCtrl: App,
    public navCtrl: NavController, public navParams: NavParams) {


      

  }



  delete(){
    this.afAuth.authState.take(1).subscribe(data => {
      this.profileRef = this.db.object(`profile/${data.uid}`);
      this.profileRef.remove(); 
      
    })
  }

  
  logout(){
    this.afAuth.auth.signOut();  
    this.appCtrl.getRootNav().setRoot('AccueilPage');
  }

  roletest(user:User){
    this.afAuth.authState.take(1).subscribe(data => {
      this.profileRef = this.db.object(`profile/${data.uid}`);
      this.profile = this.profileRef.valueChanges();
      this.profile$ =  this.db.object<Profile>(`profile/${data.uid}`).valueChanges().subscribe(profileInit => {
      console.log(this.profile$);
      console.log(`profile/${data.uid}`);
      console.log(this.profileRef);
      console.log(this.profile);
      })
    })

  }


}
