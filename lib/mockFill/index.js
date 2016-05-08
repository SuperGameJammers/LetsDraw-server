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
    for (var i = 0; i < 50; i++) {
        charac.push(faker.random.word());
    }
    return charac;

}

function fillSubjectModel(values) {
    var complexity = ["easy", "mid", "hard"];
    for (var i = 0; i < 200; i++) {
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
            postDisShit("subjects", JSON.stringify(currentSubject));
        });
    }
};

function postDisShit(route, postBody) {
    console.log(postBody);
    request.post(
        `http://localhost:4000/api/${route}`,
        postBody,
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

fillSubjectModel(characteristics);