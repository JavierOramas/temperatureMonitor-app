class Server {
  List cores = [];
  Map<String,Map> disks = Map<String,Map>();
  Map<String, double> packageId0;
  Map<String, String> date;
  List<dynamic> disksName;
  int nCores;

  Server({
    this.cores,
    this.packageId0,
    this.date,
    this.disksName,
    this.nCores,
    this.disks,
  });

  Server.fromJsonMap( Map json ) {
    this.packageId0 = Map<String,double>.from(json['Package id 0']);       
    this.date       = Map<String,String>.from(json['date']); 
    this.disksName  = json['disks_name'];     
    this.nCores     = json['n_cores'];   
    for(int i = 0; i <= this.nCores; i++ ){
      this.cores.add(json['Core $i']);
    }
    for(String i in this.disksName){
      this.disks[i] = (json[i]);
    }
  }
}


        
