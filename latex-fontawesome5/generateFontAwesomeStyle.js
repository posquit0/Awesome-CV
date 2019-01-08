/*
Based on https://github.com/javydekoning/LaTeX-FontAwesome5 project.

Authors:
    Javy de Koning <https://github.com/javydekoning>
    Ilya Kisil <ilyakisil@gmail.com>
*/


/* ========= FUNCTIONS ========= */
function sanitizeLabel(label) {
    if (label == 'Büromöbel-Experte GmbH & Co. KG.') {
        return 'BuromobelExperte'
    }

    var result = label
        .split(/\-|\s|\.|,/)                   // split ' ','.' and '-' to array
        .map(s => s.charAt(0).toUpperCase() // camelCase each word in array
                + s.slice(1)                // rest of string
        )
        .join('')                           // Join new array back to string
        .replace(/'|\(|\)/g,'')             // Remove ', ( and )
        .replace('1/4','Quarter')           // Replace illegal numbers
        .replace('1/2','Half')              // And slashes
        .replace('3/4','ThreeQuarter')
        .replace('500','FiveHundred')
        .replace('2','Two')
        .replace('3','Three')
        .replace('4','Four')
        .replace('5','Five')
        .replace('8','Eight')

    return result;
}

function parseIconsFile(obj) {
    results = [];
    for (i in obj) {
        /*
            A valid definition looks like this in LaTeX: ​​​​​
            \def\faWPBeginner{\FAB\symbol{"F297}}​​​​​
            Let's build that
        */

        // Define start of string '\def\fa'
        var start = '\\def\\fa'

        // Sanatizing the label name for use of Font Awesome 5 in LaTeX
        // e.g. 'red river' -> 'RedRiver', 'html5' -> htmlFive
        var name = sanitizeLabel(obj[i].label)


        // Some icons have solid and regular fonts, we loop over styles to add both.
        // e.g. ​​​​​\def\faWindowRestoreS and ​\def\faWindowRestoreR
        //      Solid               ^ and Regular             ^
        for (j = 0; j < obj[i].styles.length; j++) {
            var suffix = obj[i].styles.length == 1     ? ''  :     // No suffix req
                         obj[i].styles[j] == 'brands'  ? 'B' :     // B  suffix req
                         obj[i].styles[j] == 'solid'   ? 'S' :     // S  suffix req
                         obj[i].styles[j] == 'regular' ? 'R' :''   // R  suffix req

            // Set font prefix FAB, FAS or FAR (Brands, Solid, Regular)
            var prefix = obj[i].styles[j] == 'brands'  ? '\\FAB' :
                         obj[i].styles[j] == 'solid'   ? '\\FAS' :
                         obj[i].styles[j] == 'regular' ? '\\FAR' : ''

            // Create symbol e.g. \symbol{"F0AD}
            var symbol = '\\symbol{"' + obj[i].unicode.toUpperCase() + '}'

            // Concatenate the string
            var str = start + name + suffix + '{' + '{' + prefix + symbol + '}' + '~}'

            // Add to results
            results.push(str);
        }
    }
    return results;
}


/* ========= MAIN ========= */
const fs = require('fs');
const path = require('path');
const filename = path.basename(__filename);
const outputFile = "fontawesome5-latest.sty";
var dateStamp = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '');

var preambule =`% This is autogenerate file.
% Produced by: ${filename}
% Date: ${dateStamp}
%
% ========================================================
% ===     Copy content below into fontawesome5.sty     ===
% ========================================================
\\NeedsTeXFormat{LaTeX2e}
\\ProvidesPackage{fontawesome5}[v5.6.3 Font Awesome Icons]

% Requirements to use.
\\usepackage{fontspec}

% Define shortcut to load the Font Awesome font.
`;
var endInput = '\n\n\\endinput';

fs.readFile('icons.json', 'utf8', function (err, data) {
    if (err) throw(err);

    fs.writeFile(outputFile, preambule, function(err) {
        if (err) throw err;
    });

    var icons = parseIconsFile(JSON.parse(data)).join('\n');
    fs.appendFile(outputFile, icons, function(err) {
        if (err) throw err;
    });

    fs.appendFile(outputFile, endInput, function(err) {
        if (err) throw err;
    });

    console.log('Saved!');
});
