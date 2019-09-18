
export class Profile{
    firstname: string;
    lastname: string;
    username: string;
    roles: Roles;

    constructor(authData){
        this.firstname  = authData.firstname
        this.lastname   = authData.lastname
        this.username   = authData.username
        this.roles      = { reader:true}
    }
}

export interface Roles{
    admin?: boolean;
    reader: boolean;

}