# Font Awesome 5 for LaTeX

## Update fontawesome5.sty
1.  Download and unpack FontAwesome for Desktop from the official [webiste](https://fontawesome.com/download).

-   Extract latest `*.otf` files into `fonts` directory. Make sure that you replace all spaces with hyphen, e.g `Font Awesome 5 Brands-Regular-400.otf` should become `Font-Awesome-5-Brands-Regular-400.otf`.

-   Extract latest `icons.json` metadata.

-   Run `generateFontAwesomeStyle.js` with Node.js
    ```bash
    node generateFontAwesomeStyle.js
    ```
    This will generate a new style file, `fontawesome5-latest.sty`, with the definitions for the latest FontAwesome icons.

-   Manually replace content of `fontawesome5.sty` with `fontawesome5-latest.sty`

## Finding icons

## Credit
Based on the project [**LaTeX-FontAwesome5**](https://github.com/javydekoning/LaTeX-FontAwesome5/blob/master/createDefinitions.js).
