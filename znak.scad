// Maly statni znak CR

// Autor: Jiri Kubicek <jiri@kubicek.cz>
// Promenne pro customizer

// jak hluboko ma byt motiv ve stitu (staci dve vrstvy)
hloubka_motivu = 0.4;
// hloubka stitu v mm
hloubka=2;
// vyska stitu v mm
vyska=50;
echo(vyska);
// zaviraci spendlik?
spendlik = true;
// prumer spendkiku
prumer_spendliku = 1.0;
delka_uchyceni = 14;

// jakou barvu vykreslit?
selected_color="spendlik"; // [all, red, white, gold, black, spendlik]

module customizer_stop_input_placeholder(){};

// jak moc ma relief vystupovat ze stitu
vyska_motivu = 0;

$fn=30;
eps=0.01;
original_height=604.39-48.5;
original_width=454.68;
sirka=vyska*original_width/original_height;
echo(sirka);
vyska_pomer=vyska/original_height;
sirka_pomer=sirka/original_width;
preview=selected_color&&selected_color!="all" ? false : true;

module znak(){
  for(color=["gold", "black", "white"]){
    if (selected_color==color || preview)
      color(color)
        translate([0,0,hloubka-hloubka_motivu-eps])
          scale([sirka_pomer,vyska_pomer,1])
            resize([0,0, hloubka_motivu+vyska_motivu+eps])
                import(str(str("intermediate/",color),".stl"));
  }

  if (selected_color=="red" || preview)
    color("red")
      scale([sirka_pomer,vyska_pomer,1])
        resize([0, 0, hloubka-eps])
          import("intermediate/red.stl");
}

module spendlik(){
  translate([0,vyska/4,-1.5])
    rotate([0,-90,0])
      translate([0,0,-delka_uchyceni/2])
        difference(){
          union(){
            cylinder(h=delka_uchyceni, d=prumer_spendliku+2);
            translate([0,-(prumer_spendliku+2)/2,0])
              cube([2,prumer_spendliku+2,delka_uchyceni]);
          }
          translate([0,0,-eps])
            cylinder(h=delka_uchyceni+2*eps, d=prumer_spendliku);
        }
}

if (selected_color=="spendlik") {
  intersection(){
    spendlik();
    translate([-delka_uchyceni/2,vyska/4-1.5,-3.3])
      cube([delka_uchyceni,3,1.5]);
  }
} else {
  znak();
  if ((selected_color=="red" || preview) && spendlik)
      spendlik();
}
