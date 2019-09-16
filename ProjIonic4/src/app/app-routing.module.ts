import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', loadChildren: './home/home.module#HomePageModule' },
  { path: 'calendar', loadChildren: './calendar/calendar.module#CalendarPageModule' },
  { path: 'sqlite', loadChildren: './sqlite/sqlite.module#SqlitePageModule' },
  { path: 'sqlite-test', loadChildren: './sqlite-test/sqlite-test.module#SqliteTestPageModule' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
