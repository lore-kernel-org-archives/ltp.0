Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <YanFeng.Shang@windriver.com>) id 1PW07Y-0003u2-QY
	for ltp-list@lists.sourceforge.net; Fri, 24 Dec 2010 05:23:16 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PW07V-0003W1-8J
	for ltp-list@lists.sourceforge.net; Fri, 24 Dec 2010 05:23:16 +0000
From: "Shang, YanFeng" <YanFeng.Shang@windriver.com>
Date: Fri, 24 Dec 2010 05:23:04 +0000
Message-ID: <611ED426031E9E48A80D02BED70BC81003AAA7@ALA-MBB.corp.ad.wrs.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] fix "hugeshmat01 isn't adapt to mips with 64bit ELF"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1558708340347868346=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============1558708340347868346==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_611ED426031E9E48A80D02BED70BC81003AAA7ALAMBBcorpadwrsco_"

--_000_611ED426031E9E48A80D02BED70BC81003AAA7ALAMBBcorpadwrsco_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

cmdline=3D"hugeshmat01 -i 5"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
hugeshmat01    1  TPASS  :  conditions and functionality are correct
hugeshmat01    2  TFAIL  :  hugeshmat01 call failed - errno =3D 22 : Invali=
d argum
ent
hugeshmat01    3  TBROK  :  Remaining cases broken

because userspace memory in mips with 64bit ELF is lower than 2^40,
so shmat failed.


1<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=3D=
blob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch;h=
=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bff7=
d58ad62b780dc2#l1#l1> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshma=
t01.c
2<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=3D=
blob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch;h=
=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bff7=
d58ad62b780dc2#l2#l2> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshma=
t01.c
3<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=3D=
blob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch;h=
=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bff7=
d58ad62b780dc2#l3#l3> @@ -68,7 +68,11 @@ unsigned long huge_pages_shm_to_be=
_alloc
4<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=3D=
blob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch;h=
=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bff7=
d58ad62b780dc2#l4#l4>  #define CASE1          20              /* memory loc=
ation.                */
5<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=3D=
blob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch;h=
=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bff7=
d58ad62b780dc2#l5#l5>  6<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/w=
rll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshmat01-chan=
ge-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd=
2cd2f13afc412023f6bff7d58ad62b780dc2#l6#l6>  #if __WORDSIZE=3D=3D64
7<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=3D=
blob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch;h=
=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bff7=
d58ad62b780dc2#l7#l7> +#if defined(__mips__)
8<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=3D=
blob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch;h=
=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bff7=
d58ad62b780dc2#l8#l8> +#define UNALIGNED      0x1000000eee
9<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=3D=
blob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch;h=
=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bff7=
d58ad62b780dc2#l9#l9> +#else
10<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=
=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch=
;h=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bf=
f7d58ad62b780dc2#l10#l10>  #define UNALIGNED      0x10000000eee
11<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=
=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch=
;h=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bf=
f7d58ad62b780dc2#l11#l11> +#endif
12<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=
=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch=
;h=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bf=
f7d58ad62b780dc2#l12#l12>  #else
13<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=
=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch=
;h=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bf=
f7d58ad62b780dc2#l13#l13>  #define UNALIGNED      0x60000eee
14<http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-userspace_test;a=
=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shmat-addr2.patch=
;h=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13afc412023f6bf=
f7d58ad62b780dc2#l14#l14>  #endif


--_000_611ED426031E9E48A80D02BED70BC81003AAA7ALAMBBcorpadwrsco_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"Section1" style=3D"layout-grid:15.6pt">
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy">cmdline=3D&quot;hugeshmat01 -i 5&quot;<o:p></=
o:p></span></font></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy">contacts=3D&quot;&quot;<o:p></o:p></span></fo=
nt></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy">analysis=3Dexit<o:p></o:p></span></font></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy">&lt;&lt;&lt;test_output&gt;&gt;&gt;<o:p></o:p=
></span></font></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy">hugeshmat01&nbsp;&nbsp;&nbsp; 1&nbsp; TPASS&n=
bsp; :&nbsp; conditions and functionality are correct<o:p></o:p></span></fo=
nt></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy">hugeshmat01&nbsp;&nbsp;&nbsp; 2&nbsp; TFAIL&n=
bsp; :&nbsp; hugeshmat01 call failed - errno =3D
 22 : Invalid argum<o:p></o:p></span></font></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy">ent<o:p></o:p></span></font></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy">hugeshmat01&nbsp;&nbsp;&nbsp; 3&nbsp; TBROK&n=
bsp; :&nbsp; Remaining cases broken<o:p></o:p></span></font></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy"><o:p>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"1" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:9.0pt;
font-family:Arial;color:navy">because userspace memory in mips with 64bit E=
LF is lower than
</span></font><font size=3D"2" color=3D"navy" face=3D"Arial"><span lang=3D"=
EN-US" style=3D"font-size:10.0pt;font-family:Arial;color:navy">2^40,<o:p></=
o:p></span></font></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;layout-grid-=
mode:char"><font size=3D"2" color=3D"navy" face=3D"Arial"><span lang=3D"EN-=
US" style=3D"font-size:10.0pt;
font-family:Arial;color:navy">so shmat failed.<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><o:p>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><o:p>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l1#l1"><font color=3D"#999999"=
><span style=3D"color:#999999;text-decoration:none">1</span></font></a>
 ---&nbsp;a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c<o:p></o:p>=
</span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l2#l2"><font color=3D"#999999"=
><span style=3D"color:#999999;text-decoration:none">2</span></font></a>
 &#43;&#43;&#43;&nbsp;b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.=
c<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l3#l3" id=3D"l3"><font color=
=3D"#999999"><span style=3D"color:#999999;text-decoration:none">3</span></f=
ont></a>
 @@&nbsp;-68,7&nbsp;&#43;68,11&nbsp;@@&nbsp;unsigned&nbsp;long&nbsp;huge_pa=
ges_shm_to_be_alloc<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l4#l4" id=3D"l4"><font color=
=3D"#999999"><span style=3D"color:#999999;text-decoration:none">4</span></f=
ont></a>
 &nbsp;#define&nbsp;CASE1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;/*&nbsp;memory&nbsp;location.&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<o=
:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l5#l5" id=3D"l5"><font color=
=3D"#999999"><span style=3D"color:#999999;text-decoration:none">5</span></f=
ont></a>
 &nbsp;<a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3Dlayers/wrll-use=
rspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshmat01-change-shma=
t-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;hb=3D2fcd2cd2f13=
afc412023f6bff7d58ad62b780dc2#l6#l6"><font color=3D"#999999"><span style=3D=
"color:#999999;text-decoration:none">6</span></font></a>
 &nbsp;#if&nbsp;__WORDSIZE=3D=3D64<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l7#l7" id=3D"l7"><font color=
=3D"#999999"><span style=3D"color:#999999;text-decoration:none">7</span></f=
ont></a>
 &#43;#if&nbsp;defined(__mips__)<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l8#l8" id=3D"l8"><font color=
=3D"#999999"><span style=3D"color:#999999;text-decoration:none">8</span></f=
ont></a>
 &#43;#define&nbsp;UNALIGNED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x1000000ee=
e<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l9#l9" id=3D"l9"><font color=
=3D"#999999"><span style=3D"color:#999999;text-decoration:none">9</span></f=
ont></a>
 &#43;#else<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l10#l10" id=3D"l10"><font colo=
r=3D"#999999"><span style=3D"color:#999999;text-decoration:none">10</span><=
/font></a>
 &nbsp;#define&nbsp;UNALIGNED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x10000000=
eee<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l11#l11" id=3D"l11"><font colo=
r=3D"#999999"><span style=3D"color:#999999;text-decoration:none">11</span><=
/font></a>
 &#43;#endif<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l12#l12" id=3D"l12"><font colo=
r=3D"#999999"><span style=3D"color:#999999;text-decoration:none">12</span><=
/font></a>
 &nbsp;#else<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l13#l13" id=3D"l13"><font colo=
r=3D"#999999"><span style=3D"color:#999999;text-decoration:none">13</span><=
/font></a>
 &nbsp;#define&nbsp;UNALIGNED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x60000eee=
<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"black" face=3D"Courier New=
"><span lang=3D"EN-US" style=3D"font-size:7.0pt;font-family:&quot;Courier N=
ew&quot;;color:black"><a href=3D"http://git.wrs.com/cgi-bin/gitweb.cgi?p=3D=
layers/wrll-userspace_test;a=3Dblob;f=3Ddist/ltp-full/patches/base/hugeshma=
t01-change-shmat-addr2.patch;h=3D4279bee6b05801fc06925ca16745e588c180805a;h=
b=3D2fcd2cd2f13afc412023f6bff7d58ad62b780dc2#l14#l14" id=3D"l14"><font colo=
r=3D"#999999"><span style=3D"color:#999999;text-decoration:none">14</span><=
/font></a>
 &nbsp;#endif<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" face=3D"Arial"><span lang=3D"EN-US"=
 style=3D"font-size:
9.0pt;font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>
</div>
</body>
</html>

--_000_611ED426031E9E48A80D02BED70BC81003AAA7ALAMBBcorpadwrsco_--


--===============1558708340347868346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============1558708340347868346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1558708340347868346==--

