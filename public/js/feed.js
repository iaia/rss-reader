var shiftkey;
var nowArticle;
$(function(){
    shiftkey = false;
    nowArticle = 0;
});

$(function(){
    $(".article_line").click(function(){
        if(nowArticle != 0){
            article = document.getElementById("article_" + String(nowArticle));
            contentToggle(article);
        }
        nowArticle = Number(this.id.split("article_")[1]);
        contentToggle(this);
    });
});

$(window).keydown(function(e){
    var keycode = e.keyCode;
    if(keycode == 16){ // shift
        shiftkey = true;
    }
    if(keycode == 74 && shiftkey == true || keycode == 75){ // k, Jで上
        selectedArticle(false);
    }else if(keycode == 74){ // jで下
        selectedArticle(true);
    }
});

function selectedArticle(down){
    if(down == true){ // 下
        article = document.getElementById("article_" + String(nowArticle));
        contentToggle(article);
        nowArticle += 1;
        article = document.getElementById("article_" + String(nowArticle));
        contentToggle(article);
    }else { // 上
        if(nowArticle <= 1){
        }else {
            article = document.getElementById("article_" + String(nowArticle));
            contentToggle(article);
            nowArticle -= 1;
            article = document.getElementById("article_" + String(nowArticle));
            contentToggle(article);
        }
    }
}

function contentToggle(article){
    console.log(nowArticle);
    $(article).children(".article_line_content").toggle();
    $(article).children(".article_content").toggle();
    $(article).get(0).scrollIntoView(true);
}
