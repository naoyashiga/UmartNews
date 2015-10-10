var sponavi = document.getElementsByClassName("mb10p");
var googleMovie = document.getElementsByClassName("card-section");
var googleNews = document.getElementsByClassName("_NNe");

if(googleMovie.length != 0){
    window.scroll(0,googleMovie[1].offsetTop);
}else if(googleNews.length != 0){
    window.scroll(0,googleNews[0].offsetTop);
    //        window.scroll(0,googleNews[0].getBoundingClientRect().top - 100);
}else if(sponavi.length != 0){
    window.scroll(0,300);
    window.scroll(0,sponavi[1].offsetTop);
}