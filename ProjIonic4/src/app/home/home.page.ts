import { Component } from '@angular/core';
import { ActionSheetController } from '@ionic/angular';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage  {
  constructor(private actionSheet: ActionSheetController) {}

  async presentActionSheet() {
    const actionSheet = await this.actionSheet.create({
      header: 'TestActionSheet',
      /*cssClass: 'secondary',*/
      buttons: [
        {
        text: 'Cancel',
        cssClass: 'secondary',
        role: 'cancel',
        icon: 'trash',
        handler: () => {
          console.log('ButtonClicked');
        }
      },
      {
        text: 'Ajouter',
        cssClass: 'tertiary',
        role: 'destructive',
        icon: 'add',
        handler: () => {
          console.log('Added');
        }
      }
    ]
    });
    await actionSheet.present();
  }

}
