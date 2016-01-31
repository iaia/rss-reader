var shiftkey;
var nowArticle;
var maxArticle;
$(function(){
    shiftkey = false;
    nowArticle = 0;
    maxArticle = 25;
});

$(function(){
    $(".article_line").click(function(){
        previousArticle = nowArticle;
        nowArticle = Number(this.id.split("article_")[1]);

        article = document.getElementById("article_" + String(nowArticle));
        contentToggle(article);
    });
});

$(window).keydown(function(e){
    console.log("ok");
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
        if(nowArticle >= maxArticle){
            return;
        }
        article = document.getElementById("article_" + String(nowArticle));
        contentToggle(article); // 前のを閉じる
        nowArticle += 1;
        article = document.getElementById("article_" + String(nowArticle));
        contentToggle(article);
    }else { // 上
        if(nowArticle <= 1){
        }else {
            if(nowArticle <= 1){
                return;
            }
            article = document.getElementById("article_" + String(nowArticle));
            contentToggle(article); // 前のを閉じる
            nowArticle -= 1;
            article = document.getElementById("article_" + String(nowArticle));
            contentToggle(article);
        }
    }
}

function contentToggle(article){
    $(article).children(".article_line_content").toggle();
    $(article).children(".article_content").toggle();
    $(article).get(0).scrollIntoView(true);
}
