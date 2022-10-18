import QtQuick 2.1
import MuseScore 3.0

MuseScore {
      version:  "3.0"
      description: "Create random score."
      menuPath: "Plugins.random"
      requiresScore: false

      function addNote(cursor) {
                        // Do, Re, Mi
            var keyo = [ 60, 62, 64 ];

            // var idx    = Math.random() * 2;
            var idx = Math.floor(Math.random() * 3)
          var pitch  = keyo[idx];
            cursor.addNote(pitch);
            }

        function getRandomDuration(){
            var random = Math.random();
            var durationList = [1, 2, 4, 8];
            var idx = Math.floor(random * 4);
            return durationList[idx];
        }


      onRun: {
            var measures    = 10; //in 4/4 default time signature
            var numerator   = 4;
            var denominator = 4;
         //   var octaves     = 0;
            var key         = 3;

            var score = newScore("Random.mscz", "eletric_bass", measures);

            score.addText("title", "==Random==");
            score.addText("subtitle", "subtitle");
            

            var cursor = score.newCursor();
            cursor.track = 0;

            cursor.rewind(0);

            var ts = newElement(Element.TIMESIG);
            ts.timesig = fraction(numerator, denominator);
            cursor.add(ts);
            console.log("------------")

            cursor.rewind(0);

            var realMeasures = Math.ceil(measures * denominator / numerator);
            console.log(realMeasures);
            var notes = realMeasures * 4.0; //number of 1/4th notes
            var duration = 0;
             for (var i = 0; i < measures; ++i) {
                var countNotesOnMeasure = denominator;
                duration = getRandomDuration();
                while(countNotesOnMeasure != 0 ){
                    if((denominator/duration) <= countNotesOnMeasure){
                       cursor.setDuration(1, duration);
                       addNote(cursor);
                       countNotesOnMeasure = countNotesOnMeasure - (denominator/duration);
                    }
                    duration = getRandomDuration();
                    console.log("countnotesmeasure: " + countNotesOnMeasure);
                }

            }
            Qt.quit();
            }
      }
