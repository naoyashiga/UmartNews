window.onload = function() {
    var googleMovie = document.getElementsByClassName("card-section");
    var googleNews = document.getElementsByClassName("_NNe");
    
    if(googleMovie.length != 0){
        window.scroll(0,googleMovie[2].offsetTop);
    }else if(googleNews.length != 0){
        window.scroll(0,googleNews[0].offsetTop);
//        window.scroll(0,googleNews[0].getBoundingClientRect().top - 100);
    }
};