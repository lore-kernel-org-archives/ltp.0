Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vinothkumar.s@jasmin-infotech.com>)
	id 1S4t9B-0002u2-GU
	for ltp-list@lists.sourceforge.net; Tue, 06 Mar 2012 12:05:41 +0000
Received: from relay4.fnetindia.com ([209.160.26.207])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S4t95-00036A-RD
	for ltp-list@lists.sourceforge.net; Tue, 06 Mar 2012 12:05:41 +0000
Date: Tue, 6 Mar 2012 16:23:23 +0530 (IST)
From: Vinoth Kumar S <vinothkumar.s@jasmin-infotech.com>
Message-ID: <10037582.6002.1331031202959.JavaMail.root@zimbra.jasmin-infotech.com>
MIME-Version: 1.0
Subject: [LTP] LTP Installation Help ..!
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7297219755974263483=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sf.net

--===============7297219755974263483==
Content-Type: multipart/alternative; 
	boundary="----=_Part_6001_4834016.1331031202959"

------=_Part_6001_4834016.1331031202959
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Sir,=20

It would be very helpful if you guide me with the installation of Linux tes=
t Project.=20

I followed below steps...=20

cd ltp-yyyymmdd=20

./configure --host=3Dbfin-linux-uclibc=20

Edited the Makefile as=20
UCLINUX ?=3D 1=20

make=20

I got the below error....=20


parse_opts.c:142: warning: =C3=A2STD_LP_sbrk=C3=A2 defined but not used=20
parse_opts.c:143: warning: =C3=A2STD_start_break=C3=A2 defined but not used=
=20
tlibio.c: In function =C3=A2lio_write_buffer=C3=A2:=20
tlibio.c:551: warning: unused variable =C3=A2listio_cmd=C3=A2=20
tlibio.c:550: warning: unused variable =C3=A2omethod=C3=A2=20
tlibio.c: In function =C3=A2lio_read_buffer=C3=A2:=20
tlibio.c:1100: warning: unused variable =C3=A2omethod=C3=A2=20
tlibio.c:1099: warning: unused variable =C3=A2listio_cmd=C3=A2=20
tlibio.c: At top level:=20
tlibio.c:429: warning: =C3=A2lio_async_signal_handler=C3=A2 defined but not=
 used=20
tst_res.c: In function =C3=A2tst_brkm=C3=A2:=20
tst_res.c:671: warning: =C3=A2noreturn=C3=A2 function does return=20
access03.c:109: warning: =C3=A2setup=C3=A2 declared =C3=A2static=C3=A2 but =
never defined=20
access03.c:110: warning: =C3=A2cleanup=C3=A2 declared =C3=A2static=C3=A2 bu=
t never defined=20
cacheflush01.c:74:1: warning: "__NR_cacheflush" redefined=20
In file included from /opt/uClinux-2010R1/bfin-linux-uclibc/bin/../bfin-lin=
ux-uclibc/runtime/usr/include/sys/syscall.h:32,=20
from /home/thangaraj/vinod/Linux_Test_Project/ltp-full-20120104/testcases/k=
ernel/include/linux_syscall_numbers.h:17,=20
from cacheflush01.c:63:=20
/opt/uClinux-2010R1/bfin-linux-uclibc/bin/../bfin-linux-uclibc/runtime/usr/=
include/bits/sysnum.h:935:1: warning: this is the location of the previous =
definition=20
clock_nanosleep01.c: In function =C3=A2do_test=C3=A2:=20
clock_nanosleep01.c:310: warning: implicit declaration of function =C3=A2cl=
ock_nanosleep=C3=A2=20
/tmp/cconrC48.o: In function `do_test':=20
/home/thangaraj/vinod/Linux_Test_Project/ltp-full-20120104/testcases/kernel=
/syscalls/clock_nanosleep/clock_nanosleep01.c:312: undefined reference to `=
_clock_nanosleep'=20
collect2: ld returned 1 exit status=20
make[4]: *** [clock_nanosleep01] Error 1=20
make[3]: *** [all] Error 2=20
make[2]: *** [all] Error 2=20
make[1]: *** [all] Error 2=20
make: *** [testcases-all] Error 2=20


How to resolve this error... ?=20

Thanks=20

Regards=20
Vinoth Kumar S=20
Jasmin Infotech Pvt. Ltd .=20
Plot 119, Velachery Tambaram Road, Pallikaranai,=20
Chennai 600 100=20
India=20


------=_Part_6001_4834016.1331031202959
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
>Dear Sir,<br><br>It would be very helpful if you guide me with the install=
ation of Linux test Project.<br><br>I followed below steps...<br><br><stron=
g>cd ltp-yyyymmdd</strong><br style=3D"font-weight: bold;"><br><span style=
=3D"font-weight: bold;">./configure --host=3Dbfin-linux-uclibc</span><br><b=
r>Edited the Makefile as <br><span style=3D"font-weight: bold;">UCLINUX&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ?=3D 1</span><br><br><span style=3D"font-weight: bold;">m=
ake</span><br><br>I got the below error....<br><br>&nbsp;<br><span style=3D=
"color: rgb(51, 51, 153);">parse_opts.c:142: warning: =C3=A2STD_LP_sbrk=C3=
=A2 defined but not used</span><br style=3D"color: rgb(51, 51, 153);"><span=
 style=3D"color: rgb(51, 51, 153);">parse_opts.c:143: warning: =C3=A2STD_st=
art_break=C3=A2 defined but not used</span><br style=3D"color: rgb(51, 51, =
153);"><span style=3D"color: rgb(51, 51, 153);">tlibio.c: In function =C3=
=A2lio_write_buffer=C3=A2:</span><br style=3D"color: rgb(51, 51, 153);"><sp=
an style=3D"color: rgb(51, 51, 153);">tlibio.c:551: warning: unused variabl=
e =C3=A2listio_cmd=C3=A2</span><br style=3D"color: rgb(51, 51, 153);"><span=
 style=3D"color: rgb(51, 51, 153);">tlibio.c:550: warning: unused variable =
=C3=A2omethod=C3=A2</span><br style=3D"color: rgb(51, 51, 153);"><span styl=
e=3D"color: rgb(51, 51, 153);">tlibio.c: In function =C3=A2lio_read_buffer=
=C3=A2:</span><br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: =
rgb(51, 51, 153);">tlibio.c:1100: warning: unused variable =C3=A2omethod=C3=
=A2</span><br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(=
51, 51, 153);">tlibio.c:1099: warning: unused variable =C3=A2listio_cmd=C3=
=A2</span><br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(=
51, 51, 153);">tlibio.c: At top level:</span><br style=3D"color: rgb(51, 51=
, 153);"><span style=3D"color: rgb(51, 51, 153);">tlibio.c:429: warning: =
=C3=A2lio_async_signal_handler=C3=A2 defined but not used</span><br style=
=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(51, 51, 153);">tst_=
res.c: In function =C3=A2tst_brkm=C3=A2:</span><br style=3D"color: rgb(51, =
51, 153);"><span style=3D"color: rgb(51, 51, 153);">tst_res.c:671: warning:=
 =C3=A2noreturn=C3=A2 function does return</span><br style=3D"color: rgb(51=
, 51, 153);"><span style=3D"color: rgb(51, 51, 153);">access03.c:109: warni=
ng: =C3=A2setup=C3=A2 declared =C3=A2static=C3=A2 but never defined</span><=
br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(51, 51, 153=
);">access03.c:110: warning: =C3=A2cleanup=C3=A2 declared =C3=A2static=C3=
=A2 but never defined</span><br style=3D"color: rgb(51, 51, 153);"><span st=
yle=3D"color: rgb(51, 51, 153);">cacheflush01.c:74:1: warning: "__NR_cachef=
lush" redefined</span><br style=3D"color: rgb(51, 51, 153);"><span style=3D=
"color: rgb(51, 51, 153);">In file included from /opt/uClinux-2010R1/bfin-l=
inux-uclibc/bin/../bfin-linux-uclibc/runtime/usr/include/sys/syscall.h:32,<=
/span><br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(51, =
51, 153);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /home/thangaraj/vinod/Linux_Test_Proj=
ect/ltp-full-20120104/testcases/kernel/include/linux_syscall_numbers.h:17,<=
/span><br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(51, =
51, 153);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from cacheflush01.c:63:</span><br style=3D=
"color: rgb(51, 51, 153);"><span style=3D"color: rgb(51, 51, 153);">/opt/uC=
linux-2010R1/bfin-linux-uclibc/bin/../bfin-linux-uclibc/runtime/usr/include=
/bits/sysnum.h:935:1: warning: this is the location of the previous definit=
ion</span><br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(=
51, 51, 153);">clock_nanosleep01.c: In function =C3=A2do_test=C3=A2:</span>=
<br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(51, 51, 15=
3);">clock_nanosleep01.c:310: warning: implicit declaration of function =C3=
=A2clock_nanosleep=C3=A2</span><br style=3D"color: rgb(51, 51, 153);"><span=
 style=3D"color: rgb(51, 51, 153);">/tmp/cconrC48.o: In function `do_test':=
</span><br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(51,=
 51, 153);">/home/thangaraj/vinod/Linux_Test_Project/ltp-full-20120104/test=
cases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c:312: undefined re=
ference to `_clock_nanosleep'</span><br style=3D"color: rgb(51, 51, 153);">=
<span style=3D"color: rgb(51, 51, 153);">collect2: ld returned 1 exit statu=
s</span><br style=3D"color: rgb(51, 51, 153);"><span style=3D"color: rgb(51=
, 51, 153);">make[4]: *** [clock_nanosleep01] Error 1</span><br style=3D"co=
lor: rgb(51, 51, 153);"><span style=3D"color: rgb(51, 51, 153);">make[3]: *=
** [all] Error 2</span><br style=3D"color: rgb(51, 51, 153);"><span style=
=3D"color: rgb(51, 51, 153);">make[2]: *** [all] Error 2</span><br style=3D=
"color: rgb(51, 51, 153);"><span style=3D"color: rgb(51, 51, 153);">make[1]=
: *** [all] Error 2</span><br style=3D"color: rgb(51, 51, 153);"><span styl=
e=3D"color: rgb(51, 51, 153);">make: *** [testcases-all] Error 2</span><br>=
<br><br>How to resolve this error... ?<br><br>Thanks<br><div><span name=3D"=
x"></span><font size=3D"1"><span style=3D"font-size: 18px; font-family: tah=
oma,new york,times,serif; color: rgb(0, 0, 0);"><span style=3D"font-size: 1=
5px;">Regards</span></span></font><strong style=3D"font-family: Trebuchet M=
S;"><span style=3D"font-size: 19px;"><br><span style=3D"font-family: tahoma=
,new york,times,serif;">Vinoth Kumar S</span></span><span style=3D"backgrou=
nd-color: #00ffff;"><span style=3D"background-color: #111111;"></span></spa=
n></strong><br><font size=3D"1"><span style=3D"font-size: 10pt; font-family=
: tahoma,new york,times,serif;"><span style=3D"font-weight: bold;">Jasmin I=
nfotech Pvt. Ltd</span>.<br>
<span style=3D"color: rgb(102, 102, 102);">Plot 119, Velachery Tambaram Roa=
d, Pallikaranai,</span><br style=3D"color: rgb(102, 102, 102);"><span style=
=3D"color: rgb(102, 102, 102);">
Chennai 600 100</span><br style=3D"color: rgb(102, 102, 102);"><span style=
=3D"color: rgb(102, 102, 102);">
India</span></span></font><em style=3D"color: #737373; font-size: 15px; fon=
t-family: Trebuchet MS;"><br></em><span name=3D"x"></span><br></div></div><=
/body></html>
------=_Part_6001_4834016.1331031202959--


--===============7297219755974263483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--===============7297219755974263483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7297219755974263483==--

