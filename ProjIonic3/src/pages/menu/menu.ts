import { Component, ViewChild } from '@angular/core';
import { IonicPage, NavController, NavParams, Nav, ToastController, App  } from 'ionic-angular';
import { AngularFireObject, AngularFireDatabase } from "angularfire2/database";
import { Profile } from '../../models/profile';
import { AngularFireAuth } from 'angularfire2/auth';
import { Observable, Subscription } from 'rxjs';


//interfaceMenu
export interface PageInterface{
  title        : string;
  pageName     : string;
  tabComponent?: any;
  index?       : number;
  icon         : string;

}

@IonicPage()
@Component({
  selector: 'page-menu',
  templateUrl: 'menu.html',
})
export class MenuPage {

  profile$  : Subscription;
  profileRef: AngularFireObject<Profile>;
  profile   : Observable<Profile>;

  rootPage = 'TabsPage';

  @ViewChild(Nav) nav: Nav;

  pages: PageInterface[]=[
    {title: 'Accueil', pageName  : 'TabsPage', tabComponent: 'Tab1Page', index: 0, icon: 'home' },
    {title: 'Profile', pageName  : 'TabsPage', tabComponent: 'Tab2Page', index: 1, icon: 'contact' },
    {title: 'Evenement', pageName: 'SpecialPage', icon     : 'home' }
  ]

  constructor(private afAuth: AngularFireAuth,
    public navCtrl: NavController, private afDatabase: AngularFireDatabase,
    private toast: ToastController, public navParams: NavParams,
    private appCtrl: App ) {
  }

  openPage(page: PageInterface){
    let params = {};

    if (page.index) {
      params = { tabIndex: page.index };
    }

    if(this.nav.getActiveChildNavs().length && page.index != undefined ) {
      this.nav.getActiveChildNavs()[0].select(page.index);
    } else {
      console.log('test');
      this.nav.setRoot(page.pageName, params);
    }
  }

  isActive(page: PageInterface){
    let childNav = this.nav.getActiveChildNavs()[0];;

    if(childNav) {
      if (childNav.getSelected() && childNav.getSelected().root === page.tabComponent){
        return 'primary';
      }
      return;
    }
  }

   ionViewWillLoad(){
     this.afAuth.authState.take(1).subscribe(data => {
      if(data && data.email && data.uid){

        this.profileRef = this.afDatabase.object(`profile/${data.uid}`);
        this.profile = this.profileRef.valueChanges();
       // this.profile$ = this.afDatabase.object(`profile/${data.uid}`).valueChanges().subscribe(profile => console.log('item2:',profile))


        this.toast.create({
          message:`Bienvenue sur l'appli de vos rèves, ${data.email}`, duration: 3000
       }).present();
      }
      else{
        this.toast.create({
          message:`Problème authentification, ${data.email}`, duration: 3000
        }).present();
      }
     });
   }

   logout(){
    this.afAuth.auth.signOut();  
    this.appCtrl.getRootNav().setRoot('AccueilPage');
  }

}
