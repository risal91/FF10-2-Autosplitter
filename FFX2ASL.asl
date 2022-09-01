state("FFX-2")
{
    bool loading: 0x928934;             //Load Remover
    int health: 0xA11390, 0x3B4;        //1 Boss fight Health
    int start: 0x9F786C;                //Timer Start and Reset
    int ausw: 0x9641B8;                 //Result Wert
    int zone: 0xD69448;                 // Zonen Wert
    int reset: 0x958AB1;                // Reset Wert
}


init{
    vars.split = 0; 
    vars.split2 = 0;
    vars.split3 = 0;

   vars.HPAdder = new List<Tuple<int, int>>{
        Tuple.Create(130, 0),       //Yuna Dancing
        Tuple.Create(480, 2),       //Gagazet
        Tuple.Create(980, 4),       //Besaid
        Tuple.Create(2886, 6),      //Zanarkand
        Tuple.Create(1935, 8),      //Chapter 1
        Tuple.Create(1150, 10),     //Uniform 1
        Tuple.Create(1220, 12),     //Uniform 2
        Tuple.Create(167, 14),      //Uniform 3
        Tuple.Create(1640, 16),     //Ormi
        Tuple.Create(1840, 18),     //Ormi&Logos
        Tuple.Create(1344, 20),     //Chatea Leblanc
        Tuple.Create(3680, 22),     //Precapts Guard
        Tuple.Create(8400, 24),     //Chapter 2
        Tuple.Create(8430, 26),     //Valefor
        Tuple.Create(8820, 28),     //Ifrit
        Tuple.Create(12380, 30),    //Ixion
        Tuple.Create(12850, 32),    //Thunder Plains
        Tuple.Create(14800, 34),    //Shiva
        Tuple.Create(9788, 36),     //Sisters
        Tuple.Create(36000, 38),    //Anima
        Tuple.Create(34200, 40),    //Tail
        Tuple.Create(18220, 42),    //Leg
        Tuple.Create(34040, 44),    //Core
        Tuple.Create(38420, 46),    //Head
        Tuple.Create(23850, 48),    //Shuyin    

    };

    vars.splitter = new List<Tuple<int, int>>{
        Tuple.Create(0, 1),         //Yuna Dancing
        Tuple.Create(0, 3),         //Gagazet
        Tuple.Create(0, 5),         //Besaid
        Tuple.Create(0, 7),         //Zanarkand
        Tuple.Create(0, 9),         //Chapter 1
        Tuple.Create(0, 23),        //Precapts Guard
        Tuple.Create(0, 25),        //Chapter 2
        Tuple.Create(0, 27),        //Valefor
        Tuple.Create(0, 29),        //Ifrit
        Tuple.Create(0, 31),        //Ixion
        Tuple.Create(0, 33),        //Thunder Plains
        Tuple.Create(0, 35),        //Shiva
        Tuple.Create(0, 39),        //Anima
        Tuple.Create(0, 41),        //Tail
        Tuple.Create(0, 43),        //Leg
        Tuple.Create(0, 45),        //Core
        Tuple.Create(0, 47),        //Head
        Tuple.Create(0, 49),        //Shuyin 

    };

    vars.splitterAusw = new List<Tuple<int, int, int>>{
        Tuple.Create(0, 11, 0),     //Uniform 1
        Tuple.Create(0, 13, 0),     //Uniform 2
        Tuple.Create(0, 15, 0),      //Uniform 3
        Tuple.Create(0, 17, 0),     //Ormi
        Tuple.Create(0, 19, 0),     //Ormi&Logos
        Tuple.Create(0, 21, 0),     //Chatea Leblanc
        Tuple.Create(0, 37, 0),     //Sisters
    };
}

start{
    if(current.start == 1){
        vars.split = 0;
        vars.split2 = 0;
        vars.split3 = 0;
        return true;
    }
}

 reset{
    if(current.reset == 1){
      return true;
    }
}

update{
    //print("Current:" + vars.split3);
}

split{
    //vars.split +1 bei Max Hp erkannt
    if(vars.HPAdder.Contains(Tuple.Create(current.health, vars.split))){
        vars.split++;
    }
    //vars.split +1 & split bei HP 0
    if(vars.splitter.Contains(Tuple.Create(current.health, vars.split))){
        vars.split++;
        return true;
    }
    //vars.split +1 & split bei Hp  0 und auswertungsscreen erkannt
    if(vars.splitterAusw.Contains(Tuple.Create(current.health, current.ausw, vars.split))){
        vars.split++;
        return true;
    }

    //Calm Lands    split
    if(current.zone == 5392 && old.zone == 5098 && vars.split3 == 0){
        vars.split3++;
        return true;
    }

    //Moonflow    split
    if(current.zone == 3005 && old.zone == 2528 && vars.split3 == 2){   
        vars.split3++;
        return true;
    }
}
isLoading
{
    return current.loading;
}
