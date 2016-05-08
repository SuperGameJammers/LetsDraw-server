/**
 * Created by damador on 5/8/16.
 */
var request = require('request');
var faker = require('faker');
var base64 = require('node-base64-image');
var characteristics = fillCharacteristics();
var pincheQ = require('q');

function fillCharacteristics() {
    var charac = [];
    for (var i = 0; i < 10; i++) {
        charac.push(faker.random.word());
    }
    return charac;

}

function fillSubjectModel(values) {
    var complexity = ["easy", "mid", "hard"];
    for (var i = 0; i < 100; i++) {
        var currentChars = [];
        for (var j = 0; j < 5; j++) {
            currentChars.push(values[Math.floor(Math.random() * values.length)])
        }

        encodeImages(faker.image.image()).then(image => {
            var currentSubject = {
                subject: {
                    name: faker.commerce.productName(),
                    complexity: complexity[Math.floor(Math.random() * complexity.length)],
                    characteristics: currentChars,
                    img: image
                }
            };
            postDisShit("subjects", currentSubject);
        });
    }
}

function postDisShit(route, postBody) {
    request.post(
        `http://localhost:4000/api/${route}`,
        {form:postBody},
        function (error, response, body) {
            if (!error && response.statusCode == 200) {
                console.log(body)
            }
        }
    );
}
function encodeImages(link) {
    var options = {string: true};
    var deferred = pincheQ.defer();
    base64.base64encoder(link, options, function (err, image) {
        if (err) {
            console.log(err);
        }
        deferred.resolve(image);
    });
    return deferred.promise
}

function fillDrawingModel(values) {
    for (var i = 0; i < 100; i++) {
        var currentChars = [];
        for (var j = 0; j < 5; j++) {
            currentChars.push(values[Math.floor(Math.random() * values.length)])
        }

        encodeImages(faker.image.image()).then(image => {
            var currentSubject = {
                drawing: {
                    subject_id: 1,
                    name: faker.commerce.productName(),
                    order: Math.floor((Math.random()) * 6),
                    characteristics: currentChars,
                    img: image
                }
            };
            postDisShit("drawings", currentSubject);
        });
    }

}
function fillScores() {
    for(var i = 0; i < 500; i++){
        for(var j = 0; j < 10; j++){
            postDisShit("scores", {drawing_id: i ,rate: (Math.floor(Math.random() * 100))})
        }
    }
}
fillSubjectModel(characteristics);
fillDrawingModel(characteristics);
fillScores();
