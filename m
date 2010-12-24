Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <YanFeng.Shang@windriver.com>) id 1PW0Xw-0007SX-75
	for ltp-list@lists.sourceforge.net; Fri, 24 Dec 2010 05:50:32 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PW0Xs-0001s5-Rm
	for ltp-list@lists.sourceforge.net; Fri, 24 Dec 2010 05:50:32 +0000
From: "Shang, YanFeng" <YanFeng.Shang@windriver.com>
Date: Fri, 24 Dec 2010 05:50:21 +0000
Message-ID: <611ED426031E9E48A80D02BED70BC81003ACDD@ALA-MBB.corp.ad.wrs.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] [PATCH]hugemmap02 isn't adapt to mips with 32bit ELF
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3876934626188845342=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============3876934626188845342==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_611ED426031E9E48A80D02BED70BC81003ACDDALAMBBcorpadwrsco_"

--_000_611ED426031E9E48A80D02BED70BC81003ACDDALAMBBcorpadwrsco_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


For mips, the usespace address is too high.

1 --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
2 +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
3 @@ -66,8 +66,18 @@
4  #define PAGE_SIZE      ((1UL) << 12)   /* Normal page size */
5  #define HPAGE_SIZE     ((1UL) << 24)   /* Huge page size */
6  #define MAP_SIZE       (2*HPAGE_SIZE)  /* Huge map page size */
7 +#if defined(__mips__)
8 +#if __WORDSIZE=3D=3D32
9 +#define LOW_ADDR       (void *)(0x40000000)
10 +#define LOW_ADDR2      (void *)(0x50000000)
11 +#else
12  #define LOW_ADDR       (void *)(0x80000000)
13  #define LOW_ADDR2      (void *)(0x90000000)
14 +#endif
15 +#else
16 +#define LOW_ADDR       (void *)(0x80000000)
17 +#define LOW_ADDR2      (void *)(0x90000000)
18 +#endif
19
20  char* TEMPFILE=3D"mmapfile";

--_000_611ED426031E9E48A80D02BED70BC81003ACDDALAMBBcorpadwrsco_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:st1=3D"urn:schemas-microsoft-com:off=
ice:smarttags" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"=
 name=3D"place" /><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]--><style>
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
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:navy;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy"><o:p=
>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">For =
mips, the usespace address is too high.<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy"><o:p=
>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">1 --=
- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c<o:p></o:p></span></f=
ont></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">2 &#=
43;&#43;&#43; b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c<o:p></o:=
p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">3 @@=
 -66,8 &#43;66,18 @@<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">4&nb=
sp; #define PAGE_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((1UL) &lt;&lt; 12)&nbs=
p;&nbsp; /*
<st1:place w:st=3D"on">Normal</st1:place> page size */<o:p></o:p></span></f=
ont></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">5&nb=
sp; #define HPAGE_SIZE&nbsp;&nbsp;&nbsp;&nbsp; ((1UL) &lt;&lt; 24)&nbsp;&nb=
sp; /* Huge page size */<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">6&nb=
sp; #define MAP_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2*HPAGE_SIZE)&nbs=
p; /* Huge map page size */<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">7 &#=
43;#if defined(__mips__)<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">8 &#=
43;#if __WORDSIZE=3D=3D32<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">9 &#=
43;#define LOW_ADDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)(0x40000000=
)<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">10 &=
#43;#define LOW_ADDR2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)(0x50000000)<o:=
p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">11 &=
#43;#else<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">12&n=
bsp; #define LOW_ADDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)(0x800000=
00)<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">13&n=
bsp; #define LOW_ADDR2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)(0x90000000)<o=
:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">14 &=
#43;#endif<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">15 &=
#43;#else<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">16 &=
#43;#define LOW_ADDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)(0x8000000=
0)<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">17 &=
#43;#define LOW_ADDR2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)(0x90000000)<o:=
p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">18 &=
#43;#endif<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">19&n=
bsp;
<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"1" color=3D"navy" face=3D"Arial"><span=
 lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:Arial;color:navy">20&n=
bsp; char* TEMPFILE=3D&quot;mmapfile&quot;;<o:p></o:p></span></font></p>
</div>
</body>
</html>

--_000_611ED426031E9E48A80D02BED70BC81003ACDDALAMBBcorpadwrsco_--


--===============3876934626188845342==
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
--===============3876934626188845342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3876934626188845342==--

