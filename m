Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <AJOY.JOSEPH@lnttechservices.com>) id 1Wxz4C-0007EZ-96
	for ltp-list@lists.sourceforge.net; Fri, 20 Jun 2014 13:41:20 +0000
Received: from mailout1.ltindia.com ([203.199.60.132])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wxz48-0008A6-BA
	for ltp-list@lists.sourceforge.net; Fri, 20 Jun 2014 13:41:20 +0000
From: Ajoymon Joseph <AJOY.JOSEPH@LNTTECHSERVICES.COM>
Date: Fri, 20 Jun 2014 13:41:06 +0000
Message-ID: <7CF842D49929104A9E5360C8FA9370998CF0D0@POCITMSEXMB03.LntUniverse.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] fstatfs02 issue on mips64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4554491583108726804=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============4554491583108726804==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_7CF842D49929104A9E5360C8FA9370998CF0D0POCITMSEXMB03LntU_"

--_000_7CF842D49929104A9E5360C8FA9370998CF0D0POCITMSEXMB03LntU_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
            I am testing mips64 with LTP.  The problem is with fstatfs02.c =
file. The test case was failing in my particular arch. For debugging purpos=
e I write the same code and executed.

ret =3D fstatfs( -1,&buf );
printf("Retrun value =3D%d, errornumber %d EBADF is %d  %s FD %d pointer %p=
  \n",ret,errno, EBADF,strerror(errno),-1,&buf);

it was giving a output like

Retrun value =3D-1, errornumber 9 EBADF is 9  Bad file descriptor FD -1 poi=
nter 0x120011130

But when I executed LTP testcase with some debug print added

TEST(fstatfs(TC[i].fd, (TC[i]).sbuf));
if (TEST_RETURN !=3D -1) {
        tst_resm(TFAIL, "call succeeded unexpectedly return %d %s FD %d, po=
inter sbuf %p ",TEST_RETURN,strerror(errno),TC[i].fd, TC[i].sbuf);

I got a print like this

fstatfs02    1  TFAIL  :  call succeeded unexpectedly return 1690729072 Suc=
cess FD -1, pointer sbuf 0x12001ba30


I feel like both are doing the same job... But when I am running it in LTP =
environment I am getting a return as 1690729072. I was not able to find any=
 problem in TEST macro. Can anyone please help me out in debugging this.


thanks and regards
Ajoy


L&T Technology Services Ltd

www.LntTechservices.com<http://www.lnttechservices.com/>

This Email may contain confidential or privileged information for the inten=
ded recipient (s). If you are not the intended recipient, please do not use=
 or disseminate the information, notify the sender and delete it from your =
system.

--_000_7CF842D49929104A9E5360C8FA9370998CF0D0POCITMSEXMB03LntU_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
ebuchet MS&quot;,&quot;sans-serif&quot;">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am testing mips64 with LTP. &nbsp;The pr=
oblem is with fstatfs02.c file. The test case was failing in my particular =
arch. For debugging purpose I write the same
 code and executed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">ret =3D fstatfs( -1,&amp;buf );<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">printf(&quot;Retrun value =3D%d, e=
rrornumber %d EBADF is %d&nbsp; %s FD %d pointer %p&nbsp; \n&quot;,ret,errn=
o, EBADF,strerror(errno),-1,&amp;buf);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">it was giving a output like<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">Retrun value =3D-<span style=3D"co=
lor:red">1</span>, errornumber 9 EBADF is 9&nbsp; Bad file descriptor FD -1=
 pointer 0x120011130&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">But when I executed LTP testcase w=
ith some debug print added<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">TEST(fstatfs(TC[i].fd, (TC[i]).sbu=
f));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">if (TEST_RETURN !=3D -1) {<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; tst_resm(TFAIL, &quot;call succeeded unexpectedly return %d %s FD =
%d, pointer sbuf %p &quot;,TEST_RETURN,strerror(errno),TC[i].fd, TC[i].sbuf=
);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">I got a print like this<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;">fstatfs02&nbsp;&nbsp;&nbsp; 1&nbsp=
; TFAIL&nbsp; :&nbsp; call succeeded unexpectedly return
<span style=3D"color:red">1690729072</span> Success FD -1, pointer sbuf 0x1=
2001ba30<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Tr=
ebuchet MS&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I feel like both are doing the same job&#8230; But w=
hen I am running it in LTP environment I am getting a return as
<span style=3D"font-size:10.0pt;font-family:&quot;Trebuchet MS&quot;,&quot;=
sans-serif&quot;;color:red">
1690729072. I was not able to find any problem in TEST macro. </span><span =
style=3D"font-size:10.0pt;font-family:&quot;Trebuchet MS&quot;,&quot;sans-s=
erif&quot;">Can anyone please help me out in debugging this.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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

--_000_7CF842D49929104A9E5360C8FA9370998CF0D0POCITMSEXMB03LntU_--


--===============4554491583108726804==
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
--===============4554491583108726804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4554491583108726804==--

