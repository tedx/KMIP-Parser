import binascii
file = open("test3.bin","wb")
hs="42007B010000037842007A0100000048420069010000002042006A0200000004000000010000000042006B020000000400000000000000004200920900000008000000004D25F4A542000D0200000004000000010000000042000F010000032042005C05000000040000000A0000000042007F0500000004000000000000000042007C01000002F842005705000000040000000400000000420094070000002461636662306332342D626362332D343438362D623636652D3163376630643331663832310000000042006401000002B042004001000002A842004205000000040000000300000000420045010000027042004308000002613082025D0201000281810098FB0FC85B4431FDA9D5CBC705A54156D8BE4BF4B4E50A2B8777E32DFF0A9D6E3FC13F76221BDC9ADC10515B6C903343ED04FC3892766EED0CB172B0E23D85388236A644272960D8D3DAAE5C511021190A37F7CD4A4D1410FAAC826FF6A22C3B0E65C1D31F8331D240C9C652F501DF0E4355D8F3565F669D1B8BDEA7285EF9050203010001028180402AA68F1281033AF3DEC24FA37592777C082DD1E1826486A796C8CA853C8D962DD5BFE9AC1AE5A86AFFC93040D4273CA9913ABDFBE9035418CBE1608234EDC88349C89281F3B35C2B34BBDB63D8A29A4424674562D32619D8A14E05F3210DFB7D3E6DC8ADA09E4EF1E4006C959381BCEEC09BF662C633B47CAD5E0A7BA75C61024100E4CB4AD64E21A5086269627B7F1929B5D5E9097D1470721FC3B20163F4E076FD43EDCB21F3AAB267D17DCD52CCC77CD04298EB64EFF90CAC478783B400D30069024100AB2BF02BB1A757D5430C099DCA0ED2552E7DAB07BA54E8862CFE68CDA3341FCB25E4AE62E96EE8DC0A39AB87F9A9C319C7E0D27BE3798A638EFB82BEB05CE03D024100C8CE6470934294463799A7061D1748B47F7A79097ED6F2534EBEFCD96E23544C1542AFF6AC9634DF49CED056CBC48A977EDC183E0F20D72E9DD9228EE9EA478102407BD8617FAB9CD11EDAD0C5D065564DF6159A14F99566438A78D965888B3176636C3A45B6090116F7C56A2E62464FFE7A13B4E5757F82FB8EC6EFD08C195C495D0241009D21721EA505EB8FB0574EEFAB90353045034B646E969B0A682D5A56651B1C78FB05E2B42A8ACC813A104B887BA3B02DDC54EE4DA4A8F9BDE5DD95EC80E4C963000000000000004200280500000004000000040000000042002A02000000040000040000000000"
hb=binascii.a2b_hex(hs)
file.write(hb)
file.close()
