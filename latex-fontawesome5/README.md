# Font Awesome 5 for LaTeX


## How to use icons from `fontawesome5.sty`
1.  Use search on the official [website](https://fontawesome.com/icons?d=gallery) to find icon by name or related tags.

2.  Use unicode of the desired icon to search for latex definition in `fontawesome5.sty`.

3.  Copy and paste the associated definition in your latex document.

### Example
Let's say that after looking through all available free icons, you really liked `github-alt` with unicode `f113`. Search through `fontawesome5.sty` reveals that the associated latex command to display this icon is `\faAlternateGitHub`.


## How to update `fontawesome5.sty`
1.  Download and unpack Font Awesome for Desktop from the official [webiste](https://fontawesome.com/download).

2.  Extract latest `*.otf` files into `fonts` directory. Make sure that you replace all spaces with hyphen, e.g `Font Awesome 5 Brands-Regular-400.otf` should become `Font-Awesome-5-Brands-Regular-400.otf`.

3.  Extract latest `icons.json` metadata.

4.  Run `generateFontAwesomeStyle.js` with Node.js
    ```bash
    node generateFontAwesomeStyle.js
    ```
    This will generate a new style file, `fontawesome5-latest.sty`, with the definitions for the latest Font Awesome icons.

5.  Manually replace content of `fontawesome5.sty` with `fontawesome5-latest.sty`


## Credit
Based on the project [**LaTeX-FontAwesome5**](https://github.com/javydekoning/LaTeX-FontAwesome5/blob/master/createDefinitions.js).
