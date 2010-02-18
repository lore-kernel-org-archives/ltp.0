Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Pramendra.Singh@lntinfotech.com>) id 1Ni0mw-0003Gn-V4
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 07:27:06 +0000
Received: from mail142.messagelabs.com ([216.82.249.99])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ni0mv-0001TV-39
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 07:27:06 +0000
From: Pramendra Singh <Pramendra.Singh@lntinfotech.com>
Date: Thu, 18 Feb 2010 12:30:03 +0530
Message-ID: <EB1A7C66AD0C92419BFFC785A947865A09EAE44689@BLRINMSMBX01.bglrodc.lntinfotech.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] not able to generate HTML output
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5250815028588854140=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============5250815028588854140==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_EB1A7C66AD0C92419BFFC785A947865A09EAE44689BLRINMSMBX01b_"

--_000_EB1A7C66AD0C92419BFFC785A947865A09EAE44689BLRINMSMBX01b_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Good afternoon!

I am new to LTP and using it to test my code for PPC architecture.
I have patched my kernel with GCOV and it seems working fine. But
I  am not able to get the HTML of code coverage/

I am cross compiling the kernel on my server for PPC and putting the image=

to my PPC target board. After test I am able to get .gcda file for my .c f=
ile
and I take it back to my server where my kernel  source is there.

I use ppc_85xx-gcov for generating coverage and after that I use
"geninfo "  utiliy available in lcov-1.8 but I get error "not able to open=

Basic block .bb files."

Problem is that in my source code there is no .bb files but .gcno files ar=
e there
and I think that is because my gcc compiler version is  3.4.1 but "geninfo=
" binary
is compiled with some low version gcc.

So please let me know where to get source code for geninfo and genhtml so
That I can compile them for  PPC architecture with my gcc version.

Or let me know if I am doing anything wrong is code coverage process.

Thanks in advance!

Thanks and Regards
Pramendra Singh (Sr. Software Engg)
L&T  InfoTech Ltd, Plot No # 25 ~31
EPIP 2nd Phase, KIADB, Whitefield,
Bangalore - 560066, Phone: 080-66242424, Extn: 2106,
Mobile No:  9449718250



________________________________
This Email may contain confidential or privileged information for the inte=
nded recipient (s) If you are not the intended recipient, please do not us=
e or disseminate the information, notify the sender and delete it from you=
r system.

______________________________________________________________________
--_000_EB1A7C66AD0C92419BFFC785A947865A09EAE44689BLRINMSMBX01b_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-mic=
rosoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"ht=
tp://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii=
">
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Verdana;
=09panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;}
@page Section1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
=09{page:Section1;}
-->
</style><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"Section1">
<p class=3D"MsoNormal">Hi everyone,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Good afternoon!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am new to LTP and using it to test my code for PP=
C architecture.<o:p></o:p></p>
<p class=3D"MsoNormal">I have patched my kernel with GCOV and it seems wor=
king fine. But
<o:p></o:p></p>
<p class=3D"MsoNormal">I&nbsp; am not able to get the HTML of code coverag=
e/<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am cross compiling the kernel on my server for PP=
C and putting the image<o:p></o:p></p>
<p class=3D"MsoNormal">to my PPC target board. After test I am able to get=
 .gcda file for my .c file<o:p></o:p></p>
<p class=3D"MsoNormal">and I take it back to my server where my kernel &nb=
sp;source is there.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I use ppc_85xx-gcov for generating coverage and aft=
er that I use<o:p></o:p></p>
<p class=3D"MsoNormal">&#8220;geninfo &#8220; &nbsp;utiliy available in lc=
ov-1.8 but I get error &#8220;not able to open<o:p></o:p></p>
<p class=3D"MsoNormal">Basic block .bb files.&#8221;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Problem is that in my source code there is no .bb f=
iles but .gcno files are there<o:p></o:p></p>
<p class=3D"MsoNormal">and I think that is because my gcc compiler version=
 is &nbsp;3.4.1 but &#8220;geninfo&#8221; binary<o:p></o:p></p>
<p class=3D"MsoNormal">is compiled with some low version gcc.<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So please let me know where to get source code for =
geninfo and genhtml so
<o:p></o:p></p>
<p class=3D"MsoNormal">That I can compile them for &nbsp;PPC architecture =
with my gcc version.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Or let me know if I am doing anything wrong is code=
 coverage process.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advance!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><i><span style=3D"fon=
t-family:
&quot;Arial&quot;,&quot;sans-serif&quot;">Thanks and Regards<o:p></o:p></s=
pan></i></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><i><span style=3D"fon=
t-family:
&quot;Arial&quot;,&quot;sans-serif&quot;">Pramendra Singh (Sr. Software En=
gg)
<o:p></o:p></span></i></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><i><span style=3D"fon=
t-family:
&quot;Arial&quot;,&quot;sans-serif&quot;">L&amp;T&nbsp; InfoTech Ltd, Plot=
 No # 25 ~31<o:p></o:p></span></i></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><i><span style=3D"fon=
t-family:
&quot;Arial&quot;,&quot;sans-serif&quot;">EPIP 2nd Phase, KIADB, Whitefiel=
d,
<o:p></o:p></span></i></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><i><span style=3D"fon=
t-family:
&quot;Arial&quot;,&quot;sans-serif&quot;">Bangalore - 560066, Phone: 080-6=
6242424, Extn: 2106,
<o:p></o:p></span></i></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><i><span style=3D"fon=
t-family:
&quot;Arial&quot;,&quot;sans-serif&quot;">Mobile No:&nbsp; 9449718250<o:p>=
</o:p></span></i></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-s=
ize:9.0pt;
font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p><=
/span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Black" size=3D"3">This Email may contain con=
fidential or privileged information for the intended recipient (s) If you =
are not the intended recipient, please do not use or disseminate the infor=
mation, notify the sender and delete it from
 your system.<br>
</font>
<BR>
______________________________________________________________________<BR>=

</body>
</html>

--_000_EB1A7C66AD0C92419BFFC785A947865A09EAE44689BLRINMSMBX01b_--


--===============5250815028588854140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============5250815028588854140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5250815028588854140==--

