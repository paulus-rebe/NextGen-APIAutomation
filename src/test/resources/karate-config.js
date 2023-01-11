function() {   
  var env = karate.env; 
  karate.log('Test Environment Selected :', env);
  if (!env) {
    env = 'qa'; 
  }
  var config = { 
		
    BaseURL: 'tere'
 
  };
 
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}
