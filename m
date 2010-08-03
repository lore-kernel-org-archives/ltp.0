Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Doug.Boari@cubic.com>) id 1OgKJA-0008EG-Ds
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 16:25:40 +0000
Received: from exprod6og110.obsmtp.com ([64.18.1.25])
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1OgKJ5-0006EG-IJ
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 16:25:40 +0000
Received: from bb-corp-ex4.corp.cubic.cub ([149.63.2.70])
	by bb-corp-outmail1.corp.cubic.com (8.13.1/8.13.1) with ESMTP id
	o73FugHN022234
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Aug 2010 08:56:42 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 3 Aug 2010 16:56:34 +0100
Message-ID: <6A4A1EB0E8FDFB46AC5D6C392E82277006AAB64D@me-ex1.ctsl.cubic.cub>
From: "Boari, Doug" <Doug.Boari@cubic.com>
Subject: [LTP] Install failure when cross compiling for ARM
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4640779651335590077=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============4640779651335590077==
Content-Transfer-Encoding: 7bit
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB3324.727AF1CA"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB3324.727AF1CA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,

 

I've just found LTP and it looks to be exactly what we need to stress
test a PXA320 board we're working on. Great!

I'm cross-compiling to ARM on Ubuntu 8.04LTS

 

I have successfully built the tools using the lines:

./configure CFLAGS=-fno-short-enums --target=arm-iwmmxt-linux-gnueabi
--host=arm-iwmmxt-linux-gnueabi

make all

 

I then tried to install using:

 

make DESTDIR=/home/mm6/LTP/arm-install SKIP_IDCHECK=1 install

 

and it chugs along until finally bombing with:

 

make[3]: Entering directory
`/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4'

make[4]: Entering directory
`/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4/acl'

../../../../include/mk/env_post.mk:90: warning: overriding commands for
target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin'

../../../../include/mk/env_post.mk:90: warning: ignoring old commands
for target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin'

../../../../include/mk/env_post.mk:92: warning: overriding commands for
target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma'

../../../../include/mk/env_post.mk:92: warning: ignoring old commands
for target `/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma'

install -m 00775 "/testgamma"
"/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma"

install: cannot stat `/testgamma': No such file or directory

make[4]: *** [/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma]
Error 1

make[4]: Leaving directory
`/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4/acl'

make[3]: *** [install] Error 2

make[3]: Leaving directory
`/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4'

make[2]: *** [install] Error 2

make[2]: Leaving directory
`/home/mm6/LTP/ltp-full-20100630/testcases/network'

make[1]: *** [install] Error 2

make[1]: Leaving directory `/home/mm6/LTP/ltp-full-20100630/testcases'

make: *** [testcases-install] Error 2

 

Now I can see from the error that somewhere something has gotten
confused and it is looking for /testgamma, but I can't find any other
reference to this anywhere in the LTP build tree.

I'm afraid I don't really know where to look to remove this reference.
If anyone has any suggestions I'd appreciate it as a search of the mail
list found nothing.

I've include the config.h, config.mk and config.log files as per the
INSTALL file.

 

If anyone has experience in building for an ARM board, I'd appreciate
any pointers on what I might be doing wrong, and also what tests might
not function correctly.

 

Thanks in advance

Doug

 

 
**********************************************************************

This document is intended for, and should only be read by,
those persons to whom it is addressed. Its contents are
confidential and if you have received this message in error,
please delete it. Any form of reproduction, dissemination,
copying, disclosure, modification, distribution and / or
publication of this message without our prior written
consent is strictly prohibited. 

Any views expressed in this message are those of the
individual sender, and do not necessarily represent the
position of CTSL. Furthermore CTSL does not authorise
or use e-mail for official contractual correspondence. 
Nothing received in e-mail has any contractual validity.

CTSL and each legal entity in Cubic Corporation reserve 
the right to monitor all e-mail communications through
its networks.

Registered Office:
Cubic Transportation Systems Ltd
AFC House
Honeycrock Lane
Salfords
Surrey
RH1 5LA
United Kingdom

Registered in England under number 01381707
**********************************************************************


------_=_NextPart_001_01CB3324.727AF1CA
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" =
xmlns:rtc=3D"http://microsoft.com/officenet/conferencing" =
xmlns:D=3D"DAV:" xmlns:Repl=3D"http://schemas.microsoft.com/repl/" =
xmlns:mt=3D"http://schemas.microsoft.com/sharepoint/soap/meetings/" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttopart" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:dsss=3D"http://schemas.microsoft.com/office/2006/digsig-setup" =
xmlns:dssi=3D"http://schemas.microsoft.com/office/2006/digsig" =
xmlns:mdssi=3D"http://schemas.openxmlformats.org/package/2006/digital-sig=
nature" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" xmlns:spwp=3D"http://microsoft.com/sharepoint/webpartpages" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" =
xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/SlideLibrary/=
" =
xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortalServer/Pub=
lishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" =
xmlns:st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi All,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;ve just found LTP and it looks to be =
exactly what we
need to stress test a PXA320 board we&#8217;re working on. =
Great!<o:p></o:p></p>

<p class=3DMsoNormal>I&#8217;m cross-compiling to ARM on Ubuntu =
8.04LTS<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have successfully built the tools using the =
lines:<o:p></o:p></p>

<p class=3DMsoNormal><b>./configure CFLAGS=3D-fno-short-enums
--target=3Darm-iwmmxt-linux-gnueabi =
--host=3Darm-iwmmxt-linux-gnueabi<o:p></o:p></b></p>

<p class=3DMsoNormal><b>make all<o:p></o:p></b></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I then tried to install using:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><b>make DESTDIR=3D/home/mm6/LTP/arm-install =
SKIP_IDCHECK=3D1
install<o:p></o:p></b></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>and it chugs along until finally bombing =
with:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><b>make[3]: Entering directory
`/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4'<o:p></o:p></b><=
/p>

<p class=3DMsoNormal><b>make[4]: Entering directory
`/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4/acl'<o:p></o:p><=
/b></p>

<p class=3DMsoNormal><b>../../../../include/mk/env_post.mk:90: warning:
overriding commands for target
`/home/mm6/LTP/arm-install/opt/ltp/testcases/bin'<o:p></o:p></b></p>

<p class=3DMsoNormal><b>../../../../include/mk/env_post.mk:90: warning: =
ignoring
old commands for target =
`/home/mm6/LTP/arm-install/opt/ltp/testcases/bin'<o:p></o:p></b></p>

<p class=3DMsoNormal><b>../../../../include/mk/env_post.mk:92: warning:
overriding commands for target
`/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma'<o:p></o:p></b=
></p>

<p class=3DMsoNormal><b>../../../../include/mk/env_post.mk:92: warning: =
ignoring
old commands for target
`/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma'<o:p></o:p></b=
></p>

<p class=3DMsoNormal><b>install -m 00775 &quot;/testgamma&quot;
&quot;/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma&quot;<o:p=
></o:p></b></p>

<p class=3DMsoNormal><b>install: cannot stat `/testgamma': No such file =
or
directory<o:p></o:p></b></p>

<p class=3DMsoNormal><b>make[4]: ***
[/home/mm6/LTP/arm-install/opt/ltp/testcases/bin/testgamma] Error =
1<o:p></o:p></b></p>

<p class=3DMsoNormal><b>make[4]: Leaving directory
`/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4/acl'<o:p></o:p><=
/b></p>

<p class=3DMsoNormal><b>make[3]: *** [install] Error =
2<o:p></o:p></b></p>

<p class=3DMsoNormal><b>make[3]: Leaving directory =
`/home/mm6/LTP/ltp-full-20100630/testcases/network/nfsv4'<o:p></o:p></b><=
/p>

<p class=3DMsoNormal><b>make[2]: *** [install] Error =
2<o:p></o:p></b></p>

<p class=3DMsoNormal><b>make[2]: Leaving directory
`/home/mm6/LTP/ltp-full-20100630/testcases/network'<o:p></o:p></b></p>

<p class=3DMsoNormal><b>make[1]: *** [install] Error =
2<o:p></o:p></b></p>

<p class=3DMsoNormal><b>make[1]: Leaving directory
`/home/mm6/LTP/ltp-full-20100630/testcases'<o:p></o:p></b></p>

<p class=3DMsoNormal><b>make: *** [testcases-install] Error =
2<o:p></o:p></b></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Now I can see from the error that somewhere =
something has
gotten confused and it is looking for /testgamma, but I can&#8217;t find =
any
other reference to this anywhere in the LTP build tree.<o:p></o:p></p>

<p class=3DMsoNormal>I&#8217;m afraid I don&#8217;t really know where to =
look to
remove this reference. If anyone has any suggestions I&#8217;d =
appreciate it as
a search of the mail list found nothing.<o:p></o:p></p>

<p class=3DMsoNormal>I&#8217;ve include the config.h, config.mk and =
config.log
files as per the INSTALL file.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>If anyone has experience in building for an ARM =
board, I&#8217;d
appreciate any pointers on what I might be doing wrong, and also what =
tests
might not function correctly.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks in advance<o:p></o:p></p>

<p class=3DMsoNormal>Doug<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<div style=3D"margin: 0px; font-family: Verdana, Arial, Serif; =
font-size: 12px">
    <hr />
    <p>This document is intended for, and should only be read by,
       those persons to whom it is addressed. Its contents are
       confidential and if you have received this message in error,
       please delete it. Any form of reproduction, dissemination,
       copying, disclosure, modification, distribution and / or
       publication of this message without our prior written
       consent is strictly prohibited.
    </p>
    <p>Any views expressed in this message are those of the
       individual sender, and do not necessarily represent the
       position of CTSL. Furthermore CTSL does not authorise
       or use e-mail for official contractual correspondence.=20
       Nothing received in e-mail has any contractual validity.
    </p>
    <p>CTSL and each legal entity in Cubic Corporation reserve=20
       the right to monitor all e-mail communications through
       its networks.
    </p>
    <p>Registered Office:<br />
       Cubic Transportation Systems Ltd<br />
       AFC House<br />
       Honeycrock Lane<br />
       Salfords<br />
       Surrey<br />
       RH1 5LA<br />
       United Kingdom
    </p>
    <p>Registered in England under number 01381707</p>
    <hr />
</div>
</body>

</html>


------_=_NextPart_001_01CB3324.727AF1CA--


--===============4640779651335590077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
--===============4640779651335590077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4640779651335590077==--

