

var overlay = true;
$(document).keydown(function(e) {
    if(e.which == Config.HideoverlayKeybind) {
        overlay = !overlay;
        if(!overlay) {
            $(".overlay").css("opacity", ".0")
            $(".bg").css("filter", "none");
        } else {
            $(".overlay").css("opacity", "")
            $(".bg").css("filter", "");
        }
    }
})

$(".hideoverlay .bind").html(Config.CustomBindText == "" ? String.fromCharCode(Config.HideoverlayKeybind).toUpperCase() : Config.CustomBindText)

$(document).on('mousemove', function(e) {
    $('#cursor').css({top: e.pageY + 'px', left: e.pageX + 'px'});
});

var song;
var muted = true;
function setup() {


    // Carousel
    Config.Team.forEach((member, index) => {
        $(".team .innercards").append(`<div class="card" data-id="${index}">
            <p class="name">${member.name}</p>
            <p class="description">${member.description}</p>
            <img class="avatar" src="${member.image}">
        </div>`);
        if(index < Config.Team.length - 2) {
            $(".team .pages").append(`<div data-id="${index}"></div>`);
        }
        $(`.team .pages > div[data-id="0"]`).addClass("active")

        if(Config.Team.length < 4) {
            $(".team .pages").hide();
            $(".team .previous").hide();
            $(".team .next").hide();
        }
    })

    var currentPage = 0;
    $(".team .next").on("click", function() {
        if(currentPage < Config.Team.length - 3) {
            $(`.team .pages > div[data-id="${currentPage}"]`).removeClass("active")
            currentPage++
            $(`.team .pages > div[data-id="${currentPage}"]`).addClass("active")
            $(".team .innercards").css("transform", `translate3d(calc(-${currentPage * 50}% - ${(currentPage+1) * .7}vw), 0, 0)`)
        }
    });

    $(".team .previous").on("click", function() {
        if(currentPage > 0) {
            $(`.team .pages > div[data-id="${currentPage}"]`).removeClass("active")
            currentPage--
            $(`.team .pages > div[data-id="${currentPage}"]`).addClass("active")
            $(".team .innercards").css("transform", `translate3d(calc(-${currentPage * 50}% - ${(currentPage+1) * .7}vw), 0, 0)`)
        }
    });

        // Social
        Config.Social.forEach((member, index) => {
            $(".social .innercards").append(`<div class="card" data-id="${index}"style="--color: ${member.color}" data-link="${member.link}" >
                <img class="avatar" src="${member.image}">
                <p class="name">${member.name}</p>
            </div>`);
            if(index < Config.Social.length - 4) {
                $(".social .pages").append(`<div data-id="${index}"></div>`);
            }
            $(`.social .pages > div[data-id="0"]`).addClass("active")
    
            if(Config.Social.length < 4) {
                $(".social .pages").hide();

            }
        })

        var copyTimeouts = {};
        $(".social .card").on("click", function() {
            let id = $(this).data("id")
            let link = $(this).data("link")
            if(copyTimeouts[id]) clearTimeout(copyTimeouts[id]);
    

            window.invokeNative("openUrl", link);
            
            $(this).addClass("copied");
            copyTimeouts[id] = setTimeout(() => {
                $(this).removeClass("copied")
                copyTimeouts[id] = undefined;
            }, 1000);
        })
}

function loadProgress(progress) {
    $(".load-bar-y").css("width", progress + "%");
}

window.addEventListener('message', function(e) {
    if(e.data.eventName === 'loadProgress') {
        loadProgress(parseInt(e.data.loadFraction * 100));
    }
});

// global variable for the player
var player;
var paused = true
// this function gets called when API is ready to use
function onYouTubePlayerAPIReady() {
   // create the global player from the specific iframe (#video)
   player = new YT.Player('videso', {
      events: {
         // call this function when player is ready to use
         'onReady': onPlayerReady
      }
   });
}

function onPlayerReady(event) {

   $('#video').on("change", function(){
    paused = !paused;
    if(paused) {
       // player.playVideo();
        vid.volume = 0.4;
    } else {
      //  player.pauseVideo();
      //  $(".videso").contents().find(".ytp-pause-overlay").remove();
        vid.volume = 0.0;
    }
});
}

// Inject YouTube API script
var tag = document.createElement('script');
tag.src = "https://www.youtube.com/player_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

function copyToClipboard(text) {
    const body = document.querySelector('body');
    const area = document.createElement('textarea');
    body.appendChild(area);
  
    area.value = text;
    area.select();
    document.execCommand('copy');
  
    body.removeChild(area);
}

setup();