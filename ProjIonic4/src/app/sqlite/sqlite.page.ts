import { Component, OnInit, ɵConsole } from '@angular/core';

// NativeComp
import { SQLite, SQLiteObject } from '@ionic-native/sqlite/ngx';

const DATABASE_FILE_NAME = 'data.db';

@Component({
  selector: 'app-sqlite',
  templateUrl: './sqlite.page.html',
  styleUrls: ['./sqlite.page.scss'],
})
export class SqlitePage implements OnInit {

  private db: SQLiteObject;
  nameItem: number;
  movies: any[] = [];
  titleMovie: string;
  ratingMovie: number;
  descriptionMovie: string;
  categorieMovie: string;

  constructor(private sqlite: SQLite) {
  this.createDataBaseFile();
  }

  ngOnInit() {
  }

  private createDataBaseFile(): void {
    this.sqlite.create({
      name: DATABASE_FILE_NAME,
      location: 'default'
    })
      .then((db: SQLiteObject) => {
        console.log ('BDD crée');
        this.db = db;
        this.createTables();
      })
      .catch(e => console.log(e));
  }

  private createTables (): void {
    // tslint:disable-next-line:max-line-length
    this.db.executeSql('CREATE TABLE IF NOT EXISTS `MOVIES` ( `idMovies` INTEGER NOT NULL, `name` TEXT NOT NULL, `eval` INTEGER NOT NULL DEFAULT 3, `desc` TEXT, `categoryId` INTEGER, PRIMARY KEY(`idMovies`), FOREIGN KEY(`categoryId`) REFERENCES idCategories )', [])
    .then(() => {
      console.log('Table 1 created');

       // tslint:disable-next-line:max-line-length
       this.db.executeSql('CREATE TABLE IF NOT EXISTS `CATEGORIES` ( `idCategories` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL )', [])
       .then(() => console.log('Table 2 created'))
       .catch(e => console.log(e));
    })
    .catch(e => console.log(e));
  }

  public saveMyFilm() {
    console.log('Movie name -> ' + this.titleMovie);
    console.log('Rating -> ' + this.ratingMovie + '/5');
    console.log('Description -> ' + this.descriptionMovie);
    console.log('Categorie -> ' + this.categorieMovie);

    // INSERT INTO `CATEGORIES` (name) VALUES('Test');
    // INSERT INTO `MOVIES`(name, eval, desc, categoryId) VALUES ('Nom film', 3, 'Description', 1)

    this.db.executeSql('INSERT INTO `CATEGORIES` (name) VALUES(\'' + this.categorieMovie + '\')', [] )
      .then(() => {
        console.log('Categorie inserted !');

        // tslint:disable-next-line:max-line-length
        this.db.executeSql('INSERT INTO `MOVIES`(name, eval, desc, categoryId) VALUES (\'' + this.titleMovie + '\', ' + this.ratingMovie + ', \'' + this.descriptionMovie + '\', last_insert_rowid())', [])
        .then(() => console.log('Movie inserted !'))
        .catch(function (e) { return console.log(e); });
        // .catch(e => console.log(e));

      })
      .catch(e => console.log(e));
  }

  public retrieveFilms() {

    this.movies = [];
    this.db.executeSql('SELECT * FROM `MOVIES`', [] )
    .then((data) => {
      console.log('sqlexecuted');
      if (data == null) {
        console.log('data=null');
        return;
      }
      if (data.rows) {
        if (data.rows.length > 0) {
          // tslint:disable-next-line:no-var-keyword
          for ( var i = 0; i < data.rows.length; i++) {
            this.movies.push( data.rows.item(i) );
            console.log('testBoucle :' + data.rows.item(i));
            console.log('Data' + data);
          }
        }
      }
    }).catch(e => {
      console.log('error');
    });
  }

  public retrieveData() {
    return new Promise ((resolve, reject) => {
      this.db.executeSql('SELECT * FROM `MOVIES`' , []  ).then((data) => {
        console.log('drl: ' + data.rows.lenght);
        // tslint:disable-next-line:prefer-const
        let tab = [];
        if (data.rows.lenght > 0 ) {
          for ( let i = 0; i < data.rows.lenght; i++ ) {
            tab.push({
              name: data.rows.item(i).name
            });
          }
        }
        resolve(tab);
      }, (error: any) => {
        reject(error);
      });
    });
  }

  public delete(nameItem) {
    this.db.executeSql('DELETE FROM  `MOVIES` WHERE name=?' , [nameItem] );
    console.log('Delete');
  }

  public deleteAll() {
    this.db.executeSql('DELETE * FROM `MOVIES` ');
    console.log('DeleteAll');
  }


}
