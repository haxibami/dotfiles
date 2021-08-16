  #!/usr/bin/env perl
  $latex = 'lualatex -synctex=1 -halt-on-error %O %S';
  $latex_silent = 'lualatex -synctex=1 -halt-on-error %O %S';
  $pdflatex = 'lualatex -synctex=1 -halt-on-error %O %S';
  $lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
  $pdf_mode = 4;
  $max_repeat = 5;
