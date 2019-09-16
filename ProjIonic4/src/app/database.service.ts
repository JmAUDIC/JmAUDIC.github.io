import { Injectable } from '@angular/core';

// NativeComp
import { SQLite, SQLiteObject } from '@ionic-native/sqlite/ngx';

@Injectable({
  providedIn: 'root'
})
export class DatabaseService {

  db: any;
  isOpen: Boolean = false;

  constructor(private sqlite: SQLite) {

  }

  createDatabase() {
    return new Promise((resolve, reject) => {
      this.sqlite.create({
        name: 'todo.db',
        location: 'default'
      }).then((db: SQLiteObject) => {
        this.isOpen = true;
        resolve(db);
      }).catch(err => reject(err));
    });
  }

  openDb() {
    return new Promise((resolve, reject) => {
      if (this.isOpen) {
        console.log('DB OPEN');
        resolve({});
      } else {
        this.createDatabase().then(db => {
          this.db = db;
          this.db.execute('CREATE TABLE IF NOT EXIST tb_todo(todo_id INTEGER PRIMARY KEY, todo_label TEXT' , [] )
          .then(res => resolve(res))
          .catch(err => reject(err));
        }).catch(err => reject(err));
      }
    });
  }
}
