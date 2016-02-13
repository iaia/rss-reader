var shiftkey;
var nowArticle;
var maxArticle;
var previousArticle;
$(document).ready( function(){
    shiftkey = false;
    nowArticle = 0;
    maxArticle = 25;
    previousArticle = 0;
});

$(function(){
    $(".article_line").click(function(){
        if(previousArticle != 0){
            article = document.getElementById("article_" + String(previousArticle));
            contentToggle(article);
        }
 
        nowArticle = Number(this.id.split("article_")[1]);
        previousArticle = nowArticle;
        article = document.getElementById("article_" + String(nowArticle));

        contentToggle(article);
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
    previousArticle = nowArticle;
    if(down == true){ // 下
        if(nowArticle >= maxArticle){
            return;
        }
        article = document.getElementById("article_" + String(previousArticle));
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
            article = document.getElementById("article_" + String(previousArticle));
            contentToggle(article); // 前のを閉じる
            nowArticle -= 1;
            article = document.getElementById("article_" + String(nowArticle));
            contentToggle(article);
        }
    }
}

function contentToggle(article){
    $(article).children(".article_line_title_and_content").children(".article_line_content").toggle();
    $(article).parent().children(".article_content").toggle();
    $(article).scrollTop($(article).position())
}



$(function(){
    $("ul.sites").hide();
    $("div.collection").click(function(){
        $("ul.sites").slideUp();
        $("div.collection").removeClass("open");
        if($("+ul",this).css("display")=="none"){
            $("+ul",this).slideDown();
            $(this).addClass("open");
        }
    });

    $("ul.sites li").mouseover(function(){
        $(this).addClass("rollover");
    }).mouseout(function(){
        $(this).removeClass("rollover");
    });
});

