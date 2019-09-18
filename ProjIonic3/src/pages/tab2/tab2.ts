import { MenuPage } from './../menu/menu';
import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams, ToastController } from 'ionic-angular';
import { AngularFireAuth } from 'angularfire2/auth';
import { AngularFireDatabase, AngularFireObject } from 'angularfire2/database';
import { Observable, Subscription } from 'rxjs';
import { Profile } from '../../models/profile';



@IonicPage()
@Component({
  selector: 'page-tab2',
  templateUrl: 'tab2.html',
})
export class Tab2Page {

  profile$: Subscription;
  profileRef: AngularFireObject<Profile>;
  profile: Observable<Profile>;

  constructor(private afAuth: AngularFireAuth, private afDatabase: AngularFireDatabase,
    private toast: ToastController,
    public navCtrl: NavController, public navParams: NavParams) {

  }

   ionViewWillLoad(){
    this.afAuth.authState.take(1).subscribe(data => {
      if(data && data.email && data.uid){
      this.profileRef = this.afDatabase.object(`profile/${data.uid}`);
      this.profile = this.profileRef.valueChanges();
      //this.profile$ = this.afDatabase.object(`profile/${data.uid}`).valueChanges().subscribe(profile => console.log('item2:',profile))
     }
     else{
      console.log("error");
     }
    });
  }

  delete(){
    this.profileRef.remove();
  }

}
