Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <AJOY.JOSEPH@lnttechservices.com>) id 1WuKXK-0007m2-7j
	for ltp-list@lists.sourceforge.net; Tue, 10 Jun 2014 11:48:18 +0000
Received: from mailout1.ltindia.com ([203.199.60.132])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WuKXG-0004ea-I7
	for ltp-list@lists.sourceforge.net; Tue, 10 Jun 2014 11:48:18 +0000
From: Ajoymon Joseph <AJOY.JOSEPH@LNTTECHSERVICES.COM>
Date: Tue, 10 Jun 2014 11:34:35 +0000
Message-ID: <7CF842D49929104A9E5360C8FA9370998CEA4E@POCITMSEXMB03.LntUniverse.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Request to help in analyzing  the failed test cases in LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7124805642850492203=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============7124805642850492203==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_7CF842D49929104A9E5360C8FA9370998CEA4EPOCITMSEXMB03LntU_"

--_000_7CF842D49929104A9E5360C8FA9370998CEA4EPOCITMSEXMB03LntU_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi ,
            I am not understanding how failed test cases can be checked. Wh=
at is the reason for the failure. These are the failed test cases

cat output/LTP_RUN_ON-2000_Jan_01-05h_26m_37s.failed
chdir01A symlink01 -T
fcntl13_64 fcntl13_64
fcntl18_64 fcntl18_64
fstatfs02_64 fstatfs02_64
gethostid01 gethostid01
ioctl03      ioctl03
linkat01 linkat01
msgctl11 msgctl11
nftw6401 nftw6401
rt_sigprocmask01 rt_sigprocmask01
sendfile02_64 sendfile02_64
sendfile03_64 sendfile03_64
sendfile04_64 sendfile04_64
sendfile05_64 sendfile05_64
sendfile06_64 sendfile06_64
sendfile07_64 sendfile07_64
sendmsg01 sendmsg01
signalfd4_01 signalfd4_01
signalfd4_02 signalfd4_02
statfs02_64 statfs02_64
statfs03_64 statfs03_64
syslog01 syslog01
syslog02 syslog02
syslog03 syslog03
syslog04 syslog04
syslog05 syslog05
syslog07 syslog07
syslog08 syslog08
syslog09 syslog09
syslog10 syslog10
timer_gettime01 timer_gettime01
utimensat01 utimensat_tests.sh
gf01 growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20=
 glseek20.2 -d $TMPDIR
gf10 growfiles -W gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_=
lio14.2 -d $TMPDIR
gf11 growfiles -W gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_=
lio15.2 -d $TMPDIR
gf12 mkfifo $TMPDIR/gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 30 gffif=
o17 -d $TMPDIR
gf13 mkfifo $TMPDIR/gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r =
-r 1-4096 gffifo18 -d $TMPDIR
gf14 growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glse=
ek19.2 -d $TMPDIR
gf15 growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1 -d=
 $TMPDIR
gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -=
C 10 -c 1000 -S 10 -f Lgf02_ -d $TMPDIR
gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -=
C 10 -c 1000 -S 10 -f Lgf03_ -d $TMPDIR
gf18 growfiles -W gf18 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -l -S 2 -f=
 Lgf04_ -d $TMPDIR
rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f


How it can be analyzed. I ran the test individually.

./symlink01 -T chdir01


Given the output.

chdir01     1  TFAIL  :  symlink(object, symbolic) was succesful.
mkdir(object, 0700) was successful
chdir(2) returned successfully, but getcwd(3) indicated new current working=
 directory location /mnt/CPSW/tmp/chdf7a0eK/object not equal to expected /t=
mp/chdf7a0eK/object
chdir01     2  TPASS  :  chdir(2) to non-existent object file location thro=
ugh symbolic link file failed as expected
chdir01     3  TPASS  :  Nested symbolic link access condition caught.  ELO=
OP is returned


How I can fix this issue?



thanks and regards
Ajoy


L&T Technology Services Ltd

www.LntTechservices.com<http://www.lnttechservices.com/>

This Email may contain confidential or privileged information for the inten=
ded recipient (s). If you are not the intended recipient, please do not use=
 or disseminate the information, notify the sender and delete it from your =
system.

--_000_7CF842D49929104A9E5360C8FA9370998CEA4EPOCITMSEXMB03LntU_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Trebuchet MS";
	panose-1:2 11 6 3 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Trebuchet MS","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">Hi ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am not understanding how failed test cas=
es can be checked. What is the reason for the failure. These are the failed=
 test cases<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><b><span style=3D"font=
-family:&quot;Courier New&quot;">cat output/LTP_RUN_ON-2000_Jan_01-05h_26m_=
37s.failed
<o:p></o:p></span></b></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">chdir01A symlink01 -T &nbsp;&nbsp;&nbsp;&nbsp=
;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">fcntl13_64 fcntl13_64<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">fcntl18_64 fcntl18_64<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">fstatfs02_64 fstatfs02_64<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gethostid01 gethostid01<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">ioctl03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ioctl03=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">linkat01 linkat01<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">msgctl11 msgctl11<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">nftw6401 nftw6401<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">rt_sigprocmask01 rt_sigprocmask01<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">sendfile02_64 sendfile02_64<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">sendfile03_64 sendfile03_64<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">sendfile04_64 sendfile04_64<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">sendfile05_64 sendfile05_64<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">sendfile06_64 sendfile06_64<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">sendfile07_64 sendfile07_64<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">sendmsg01 sendmsg01<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">signalfd4_01 signalfd4_01<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">signalfd4_02 signalfd4_02<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">statfs02_64 statfs02_64<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">statfs03_64 statfs03_64<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">syslog01 syslog01<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">syslog02 syslog02<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">syslog03 syslog03<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">syslog04 syslog04<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">syslog05 syslog05<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">syslog07 syslog07<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">syslog08 syslog08<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">syslog09 syslog09<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">syslog10 syslog10<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">timer_gettime01 timer_gettime01<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">utimensat01 utimensat_tests.sh<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf01 growfiles -W gf01 -b -e 1 -u -i 0 -L 20 =
-w -C 1 -l -I r -T 10 glseek20 glseek20.2 -d $TMPDIR<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf10 growfiles -W gf10 -b -e 1 -u -r 1-5000 -=
i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2 -d $TMPDIR<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf11 growfiles -W gf11 -b -e 1 -u -r 1-5000 -=
i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2 -d $TMPDIR<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf12 mkfifo $TMPDIR/gffifo17; growfiles -b -W=
 gf12 -e 1 -u -i 0 -L 30 gffifo17 -d $TMPDIR<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf13 mkfifo $TMPDIR/gffifo18; growfiles -b -W=
 gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18 -d $TMPDIR<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf14 growfiles -W gf14 -b -e 1 -u -i 0 -L 20 =
-w -l -C 1 -T 10 glseek19 glseek19.2 -d $TMPDIR<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf15 growfiles -W gf15 -b -e 1 -u -r 1-49600 =
-I r -u -i 0 -L 120 Lgfile1 -d $TMPDIR<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u=
 -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_ -d $TMPDIR<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u=
 -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_ -d $TMPDIR<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gf18 growfiles -W gf18 -b -e 1 -i 0 -L 120 -w=
 -u -r 10-5000 -I r -l -S 2 -f Lgf04_ -d $TMPDIR<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">rwtest02 export LTPROOT; rwtest -N rwtest02 -=
c -q -i 60s&nbsp; -f
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">How it can be analyzed. I ran the =
test individually.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
./symlink01 -T chdir01<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">Given the output.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
chdir01&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; :&nbsp; symlink(object,=
 symbolic) was succesful.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
mkdir(object, 0700) was successful<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
chdir(2) returned successfully, but getcwd(3) indicated new current working=
 directory location /mnt/CPSW/tmp/chdf7a0eK/object not equal to expected /t=
mp/chdf7a0eK/object<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
chdir01&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp; TPASS&nbsp; :&nbsp; chdir(2) to non=
-existent object file location through symbolic link file failed as expecte=
d<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
chdir01&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp; TPASS&nbsp; :&nbsp; Nested symbolic=
 link access condition caught.&nbsp; ELOOP is returned<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">How I can fix this issue?<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">thanks and regards<o:p></o:p></p>
<p class=3D"MsoNormal">Ajoy<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p><strong>L&amp;T Technology Services Ltd</strong></p>
<p><a href=3D"http://www.lnttechservices.com/" target=3D"_blank">www.LntTec=
hservices.com</a></p>
<p>This Email may contain confidential or privileged information for the in=
tended recipient (s). If you are not the intended recipient, please do not =
use or disseminate the information, notify the sender and delete it from yo=
ur system.</p>
</body>
</html>

--_000_7CF842D49929104A9E5360C8FA9370998CEA4EPOCITMSEXMB03LntU_--


--===============7124805642850492203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
--===============7124805642850492203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7124805642850492203==--

