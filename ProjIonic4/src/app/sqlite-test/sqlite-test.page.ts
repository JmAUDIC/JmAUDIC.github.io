import { Component, OnInit } from '@angular/core';

// NativeComp
import { SQLite, SQLiteObject } from '@ionic-native/sqlite/ngx';

const DATABASE_FILE_NAME2 = 'data.db';

@Component({
  selector: 'app-sqlite-test',
  templateUrl: './sqlite-test.page.html',
  styleUrls: ['./sqlite-test.page.scss'],
})
export class SqliteTestPage implements OnInit {

  private db: SQLiteObject;

  constructor(private sqlite: SQLite) {
    this.createDB();
   }

  ngOnInit() {
  }


  private createDB(): void {
    this.sqlite.create({
      name: DATABASE_FILE_NAME2,
      location: 'default'
  })
  .then((db: SQLiteObject ) => {
    console.log('BDD created');
    this.db = db;
    this.createTables();
  })
  .catch(e => console.log(e));
  }

  private createTables(): void {
    // tslint:disable-next-line:max-line-length
    this.db.executeSql('CREATE TABLE IF NOT EXISTE `LISTE`( `id` INTEGER NOT NULL PRIMARY KEY AUTO INCREMENT , `name` TEXT NOT NULL , `surname` TEXT NOT NULL )', [] )
    .then(() => {
      console.log('Table créee');
    }).catch(e => console.log(e));
  }

}
