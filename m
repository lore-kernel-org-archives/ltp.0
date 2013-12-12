Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <HACAD@vestas.com>) id 1VqynX-0008JH-JV
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 05:26:55 +0000
Received: from mail1.bemta5.messagelabs.com ([195.245.231.142])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VqynV-0002e0-DP
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 05:26:55 +0000
From: Haresh Chavda <HACAD@vestas.com>
Date: Thu, 12 Dec 2013 13:05:45 +0800
Message-ID: <0457982F240D534B8C4CD82E5311A37E1A3B7B6531@SGSINEXC014.vestas.net>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] LTP mount,mtest05mem and times testcase related problem
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5295934791680555811=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============5295934791680555811==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_0457982F240D534B8C4CD82E5311A37E1A3B7B6531SGSINEXC014ve_"

--_000_0457982F240D534B8C4CD82E5311A37E1A3B7B6531SGSINEXC014ve_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We are using LTP "ltp-full-20130503" on linux kernel version 3.10.10-rt7+.
We found that mount, times and  mtest05mem are failing.

We got following error by mount syscall,
mount02     4  TBROK  :  umount of mnt_8649 failed: errno=3DEBUSY(16): Devi=
ce or resource busy
mount02     5  TBROK  :  Remaining cases broken

For times syscall testcase we doesn't get status about TPASS for "times03".
I feel that "times03" testcase need to be modified to generate TPASS status=
.

For mtest05mem syscall we got following error,
mmstress    0  TINFO  :  test6: Test case tests the race condition between =
simultaneous fork -exec - exit faults in the same address space.
mmstress    6  TFAIL  :  TEST 6 Failed
We found that there are two files named "dummy" in separate folders(mtest05=
 and cap_bound). So when we build and install LTP, one of the binary "dummy=
" is replaced by other one.
The possible solution could be to modify the make file to generate binaries=
 with relevant name.

Please let me know if you have faced the similar problem in the past and ha=
ve any work around in the sub sequent releases.

Thanks & regards
Haresh Chavda


--_000_0457982F240D534B8C4CD82E5311A37E1A3B7B6531SGSINEXC014ve_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi,<o:p></o:p></=
p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>We are usi=
ng LTP &#8220;ltp-full-20130503&#8221; on linux kernel version 3.10.10-rt7+=
.<o:p></o:p></p><p class=3DMsoNormal>We found that mount, times and &nbsp;m=
test05mem are failing.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p>=
</p><p class=3DMsoNormal>We got following error by mount syscall, <o:p></o:=
p></p><p class=3DMsoNormal><b><i>mount02&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp; TB=
ROK&nbsp; :&nbsp; umount of mnt_8649 failed: errno=3DEBUSY(16): Device or r=
esource busy<o:p></o:p></i></b></p><p class=3DMsoNormal><b><i>mount02&nbsp;=
&nbsp;&nbsp;&nbsp; 5&nbsp; TBROK&nbsp; :&nbsp; Remaining cases broken<o:p><=
/o:p></i></b></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNo=
rmal>For times syscall testcase we doesn&#8217;t get status about TPASS for=
 &#8220;times03&#8221;.<o:p></o:p></p><p class=3DMsoNormal>I feel that &#82=
20;times03&#8221; testcase need to be modified to generate TPASS status.<o:=
p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>=
For mtest05mem syscall we got following error,<o:p></o:p></p><p class=3DMso=
Normal><b><i>mmstress&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; test6: =
Test case tests the race condition between simultaneous fork -exec - exit f=
aults in the same address space.<o:p></o:p></i></b></p><p class=3DMsoNormal=
><b><i>mmstress&nbsp;&nbsp;&nbsp; 6&nbsp; TFAIL&nbsp; :&nbsp; TEST 6 Failed=
<o:p></o:p></i></b></p><p class=3DMsoNormal>We found that there are two fil=
es named &#8220;dummy&#8221; in separate folders(mtest05 and cap_bound). So=
 when we build and install LTP, one of the binary &#8220;dummy&#8221; is re=
placed by other one.<o:p></o:p></p><p class=3DMsoNormal>The possible soluti=
on could be to modify the make file to generate binaries with relevant name=
.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNor=
mal>Please let me know if you have faced the similar problem in the past an=
d have any work around in the sub sequent releases. <o:p></o:p></p><p class=
=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Thanks &amp; regards=
<o:p></o:p></p><p class=3DMsoNormal>Haresh Chavda<o:p></o:p></p><p class=3D=
MsoNormal><o:p>&nbsp;</o:p></p></div></body></html>=

--_000_0457982F240D534B8C4CD82E5311A37E1A3B7B6531SGSINEXC014ve_--


--===============5295934791680555811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--===============5295934791680555811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5295934791680555811==--

