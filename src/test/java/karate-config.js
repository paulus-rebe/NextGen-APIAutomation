function fn() {   
  var env = karate.env; 
  karate.log('Test Environment Selected :', env);
  if (!env) {
    env = 'qa'; 
  }
  var config = { 
		
    StoreBaseURL: 'https://petstore.swagger.io/v2/user'
 
  };
 
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}
