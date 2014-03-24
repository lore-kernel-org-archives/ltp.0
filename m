Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1WSB0E-0004rN-T7
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 19:57:46 +0000
Received: from smtp-out3.electric.net ([72.35.12.184])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSB0D-0007g2-LG
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 19:57:46 +0000
Received: from 1WSAih-0004rX-Vr by out3a.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1WSAii-0004ut-UC
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 12:39:40 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3a.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1WSAih-0004rX-Vr
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 12:39:40 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Mon, 24 Mar 2014 19:41:30 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C548BE3@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] I have changes to suggest, how to handle?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4619999020931103282=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============4619999020931103282==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_4506ACC2AE90484D87F9A883BA36C21C548BE3LCHQEX03lancopelo_"

--_000_4506ACC2AE90484D87F9A883BA36C21C548BE3LCHQEX03lancopelo_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings, all!

Cyril Hrubis was kind enough to handle issue #9 for me.  (Thanks, Cyril!)
That helps for getting the top scripts to invoke cleanly on Debian distros.
However, there's still two dozen or so scripts which will bomb out on Debia=
n systems, presuming incorrectly that /bin/sh is bash.

I have a patch for consideration.  Unless there's objection, I'd like to po=
st it in two chunks.
One has changes for testcases/kernel/containers/netns/** which I'm not yet =
sure are minimal.
The other has changes for fourteen files which I believe are minimal.
I'm using these changes in testing some kernels, which is how I discovered =
this concern in the first place.

Thanks!

Joseph
Joseph Beckenbach, senior QA engineer : Automation
x97166
M 678-602-3192


--_000_4506ACC2AE90484D87F9A883BA36C21C548BE3LCHQEX03lancopelo_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Greetings, all!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Cyril Hrubis was kind enough to handle issue #9 for =
me.&nbsp; (Thanks, Cyril!)<o:p></o:p></p>
<p class=3D"MsoNormal">That helps for getting the top scripts to invoke cle=
anly on Debian distros.<o:p></o:p></p>
<p class=3D"MsoNormal">However, there&#8217;s still two dozen or so scripts=
 which will bomb out on Debian systems, presuming incorrectly that /bin/sh =
is bash.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have a patch for consideration.&nbsp; Unless there=
&#8217;s objection, I&#8217;d like to post it in two chunks.<o:p></o:p></p>
<p class=3D"MsoNormal">One has changes for testcases/kernel/containers/netn=
s/** which I&#8217;m not yet sure are minimal.<o:p></o:p></p>
<p class=3D"MsoNormal">The other has changes for fourteen files which I bel=
ieve are minimal.<o:p></o:p></p>
<p class=3D"MsoNormal">I&#8217;m using these changes in testing some kernel=
s, which is how I discovered this concern in the first place.<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"mso-element:para-border-div;border:none;border-bottom:solid w=
indowtext 1.0pt;padding:0in 0in 1.0pt 0in">
<p class=3D"MsoNormal" style=3D"border:none;padding:0in">Joseph<o:p></o:p><=
/p>
</div>
<p class=3D"MsoNormal">Joseph Beckenbach, senior QA engineer : Automation<o=
:p></o:p></p>
<p class=3D"MsoNormal">x97166<o:p></o:p></p>
<p class=3D"MsoNormal">M 678-602-3192<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_4506ACC2AE90484D87F9A883BA36C21C548BE3LCHQEX03lancopelo_--


--===============4619999020931103282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
--===============4619999020931103282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4619999020931103282==--

