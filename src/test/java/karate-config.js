function fn() {
    var env = karate.env; 
    if (!env) {
        env = 'release';
    }

    var config = {
        baseUrl: 'https://jsonplaceholder.typicode.com/',
        ContentType: 'application/json',
        Accept: 'application/json'
    };

    karate.configure('connectTimeout', 50000);
    karate.configure('readTimeout', 50000);
    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);
    return config;
}