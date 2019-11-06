(TeX-add-style-hook "awesome-cv"
 (lambda ()
    (LaTeX-add-environments
     "cvparagraph"
     "cventries"
     "cvsubentries"
     "cvhonors"
     "cvskills"
     "cvitems"
     "cvletter")
    (TeX-add-symbols
     '("makecvheader" ["argument"] 0)
     '("letterenclosure" ["argument"] 1)
     '("letterenclname" ["argument"] 0)
     '("photo" ["argument"] 1)
     '("fontdir" ["argument"] 0)
     '("lettersection" 1)
     '("cvskill" 2)
     '("cvhonor" 4)
     '("cvsubentry" 4)
     '("cventry" 5)
     '("cvsubsection" 1)
     '("cvsection" 1)
     '("makecvfooter" 3)
     '("ifempty" 3)
     '("letterclosing" 1)
     '("letteropening" 1)
     '("letterdate" 1)
     '("lettertitle" 1)
     '("recipientaddress" 1)
     '("recipientname" 1)
     '("recipient" 2)
     '("extrainfo" 1)
     '("googlescholar" 2)
     '("medium" 1)
     '("xing" 1)
     '("reddit" 1)
     '("skype" 1)
     '("twitter" 1)
     '("linkedin" 1)
     '("stackoverflow" 2)
     '("gitlab" 1)
     '("github" 1)
     '("homepage" 1)
     '("email" 1)
     '("mobile" 1)
     '("position" 1)
     '("address" 1)
     '("familyname" 1)
     '("lastname" 1)
     '("firstname" 1)
     '("name" 2)
     '("letterenclosurestyle" 1)
     '("letternamestyle" 1)
     '("letterdatestyle" 1)
     '("lettertitlestyle" 1)
     '("recipienttitlestyle" 1)
     '("recipientaddressstyle" 1)
     '("lettersectionstyle" 1)
     '("skillsetstyle" 1)
     '("skilltypestyle" 1)
     '("honorlocationstyle" 1)
     '("honordatestyle" 1)
     '("honorpositionstyle" 1)
     '("honortitlestyle" 1)
     '("subdescriptionstyle" 1)
     '("subentrylocationstyle" 1)
     '("subentrydatestyle" 1)
     '("subentrypositionstyle" 1)
     '("subentrytitlestyle" 1)
     '("descriptionstyle" 1)
     '("entrylocationstyle" 1)
     '("entrydatestyle" 1)
     '("entrypositionstyle" 1)
     '("entrytitlestyle" 1)
     '("subsectionstyle" 1)
     '("sectionstyle" 1)
     '("footerstyle" 1)
     '("headerquotestyle" 1)
     '("headersocialstyle" 1)
     '("headeraddressstyle" 1)
     '("headerpositionstyle" 1)
     '("headerlastnamestyle" 1)
     '("headerfirstnamestyle" 1)
     "footerfont"
     "bodyfont"
     "bodyfontlight"
     "paragraphstyle"
     "lettertextstyle"
     "acvHeaderNameDelim"
     "acvHeaderAfterNameSkip"
     "acvHeaderAfterPositionSkip"
     "acvHeaderAfterAddressSkip"
     "acvHeaderIconSep"
     "acvHeaderSocialSep"
     "acvHeaderAfterSocialSkip"
     "acvHeaderAfterQuoteSkip"
     "acvSectionTopSkip"
     "acvSectionContentTopSkip"
     "drawphoto"
     "makelettertitle"
     "makeletterclosing"
     "newline"
     "vhrulefill")
    (TeX-run-style-hooks
     "hyperref"
     "hidelinks"
     "unicode"
     "parskip"
     "tcolorbox"
     "skins"
     "sourcesanspro"
     "default"
     "opentype"
     "fontawesome"
     "unicode-math"
     "fontspec"
     "quiet"
     "setspace"
     "etoolbox"
     "xifthen"
     "ifxetex"
     "xcolor"
     "fancyhdr"
     "geometry"
     "ragged2e"
     "enumitem"
     "array"
     "art10"
     "article")))

