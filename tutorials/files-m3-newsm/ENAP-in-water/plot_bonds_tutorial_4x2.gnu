#!/usr/bin/gnuplot -persist
set term pdf dashed enhanced font "Helvetica,12" size 8.25,3.3
set output 'AAvsCG-bond-tutorial-4x2.pdf'
set bar 1.000000
set border 31 lt -1 lw 1.500
set boxwidth
set style fill empty border
set angles radians
unset grid
unset key
set fit noerrorvariables
#-------------------------------#
set multiplot layout 2,4
#-------------------------------#
set title "{/Helvetica-Italic b}_1, 1-2"
set yrange[0:200]
set xrange[0.2:0.4]
set xtics 0.05
plot '5_target-distr/bonds_mapped/distr_bond_0.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped", \
     '6_CG-takeCURRENT/bonds_mapped/distr_bond_0.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#
set title "{/Helvetica-Italic b}_2, 1-4"
set yrange[0:200]
set xrange[0.3:0.5]
set xtics 0.05
plot '5_target-distr/bonds_mapped/distr_bond_1.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped", \
     '6_CG-takeCURRENT/bonds_mapped/distr_bond_1.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#
set title "{/Helvetica-Italic b}_3, 2-3"
set yrange[0:200]
set xrange[0.2:0.4]
set xtics 0.05
plot '5_target-distr/bonds_mapped/distr_bond_2.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped", \
     '6_CG-takeCURRENT/bonds_mapped/distr_bond_2.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#
set title "{/Helvetica-Italic b}_4, 2-5"
set yrange[0:200]
set xrange[0.4:0.6]
set xtics 0.05
plot '5_target-distr/bonds_mapped/distr_bond_3.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped", \
     '6_CG-takeCURRENT/bonds_mapped/distr_bond_3.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#
set title "{/Helvetica-Italic b}_5, 2-6"
set yrange[0:200]
set xrange[0.4:0.6]
set xtics 0.05
plot '5_target-distr/bonds_mapped/distr_bond_4.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped", \
     '6_CG-takeCURRENT/bonds_mapped/distr_bond_4.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#
set title "{/Helvetica-Italic b}_6, 3-6"
set yrange[0:200]
set xrange[0.4:0.6]
set xtics 0.05
plot '5_target-distr/bonds_mapped/distr_bond_5.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped", \
     '6_CG-takeCURRENT/bonds_mapped/distr_bond_5.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#
set title "{/Helvetica-Italic b}_7, 5-6"
set yrange[0:200]
set xrange[0.2:0.4]
set xtics 0.05
plot '5_target-distr/bonds_mapped/distr_bond_6.xvg'  w l lc rgb "#1E90FF" lw 2 title "COG-mapped", \
     '6_CG-takeCURRENT/bonds_mapped/distr_bond_6.xvg'  w l lc rgb "#DC143C" lw 2 title "Martini"
#-------------------------------#
unset multiplot        # exit multiplot mode (prompt changes back to 'gnuplot')
#-------------------------------#
