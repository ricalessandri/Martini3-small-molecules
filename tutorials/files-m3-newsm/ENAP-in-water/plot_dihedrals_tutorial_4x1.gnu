#!/usr/bin/gnuplot -persist
set term pdf dashed enhanced font "Helvetica,12" size 8.25,1.65
set output 'AAvsCG-dih-tutorial-4x1.pdf'
set bar 1.000000
set border 31 lt -1 lw 1.500
set boxwidth
set style fill empty border
set angles radians
unset grid
unset key
set fit noerrorvariables
#-------------------------------#
set multiplot layout 1,4
#set size 2, 2
#-------------------------------#
set title "{/Helvetica-Italic dih}_1 1-3-6-5"
set xrange[-60:60]
set yrange[:0.1]
set xtics 20
set ytics 0.02
plot '5_target-distr/dihedrals_mapped/distr_dih_0.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped",\
     '6_CG-takeCURRENT/dihedrals_mapped/distr_dih_0.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#
set title "{/Helvetica-Italic dih}_2 2-1-4-3"
set xrange[-60:60]
set yrange[:0.1]
set xtics 20
set ytics 0.02
plot '5_target-distr/dihedrals_mapped/distr_dih_1.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped",\
     '6_CG-takeCURRENT/dihedrals_mapped/distr_dih_1.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#
set title "{/Helvetica-Italic dih}_3 2-3-6-5"
set xrange[-60:60]
set yrange[:0.1]
set xtics 20
set ytics 0.02
plot '5_target-distr/dihedrals_mapped/distr_dih_2.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped",\
     '6_CG-takeCURRENT/dihedrals_mapped/distr_dih_2.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#-------------------------------#
unset multiplot        # exit multiplot mode (prompt changes back to 'gnuplot')
#-------------------------------#
