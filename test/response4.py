import binascii
file = open("test4.bin","wb")
hs="42007B010000018042007A0100000048420069010000002042006A0200000004000000020000000042006B020000000400000000000000004200920900000008000000004D25F4A742000D0200000004000000010000000042000F010000012842005C05000000040000000B0000000042007F0500000004000000000000000042007C0100000100420094070000002437313632326166632D323137612D343831632D616565652D33393066623838363037643400000000420008010000005842000A07000000044C696E6B0000000042000B010000004042004B0500000004000001060000000042004C070000002431383631306634392D326634392D343963372D386637352D30666132303135626639666100000000420008010000006842000A07000000044C696E6B000000004200090200000004000000010000000042000B010000004042004B0500000004000001020000000042004C070000002433653863323032382D633237342D346464652D386638342D30366335396335316539653000000000"

hb=binascii.a2b_hex(hs)
file.write(hb)
file.close()