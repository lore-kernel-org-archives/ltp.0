Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <omprakash.pal@stericsson.com>) id 1SlaS5-0006vC-AL
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 06:49:41 +0000
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147])
	by sog-mx-2.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SlaS3-0002kO-J3
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 06:49:41 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B782CB
	for <ltp-list@lists.sourceforge.net>;
	Mon,  2 Jul 2012 06:49:28 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E6DFE2787
	for <ltp-list@lists.sourceforge.net>;
	Mon,  2 Jul 2012 06:49:27 +0000 (GMT)
Received: from exdcvycastm003.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm003", Issuer "exdcvycastm003" (not verified))
	by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 4626424C080
	for <ltp-list@lists.sourceforge.net>;
	Mon,  2 Jul 2012 08:49:23 +0200 (CEST)
From: Om Prakash PAL <omprakash.pal@stericsson.com>
Date: Mon, 2 Jul 2012 08:49:20 +0200
Message-ID: <3ED83A9DB3B6D94CA68BF7C03F2981D35B18E7912E@EXDCVYMBSTM006.EQ1STM.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Failure of syscalls in kernel version 3.4
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7974848030355324697=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============7974848030355324697==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_3ED83A9DB3B6D94CA68BF7C03F2981D35B18E7912EEXDCVYMBSTM00_"

--_000_3ED83A9DB3B6D94CA68BF7C03F2981D35B18E7912EEXDCVYMBSTM00_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I am currently using ltp-full-20110915.bz2.
When I switched to  kernel 3.4(from kernel 3.0)  then these syscalls ltp ar=
e failing.

[1]. get_robust_list01
get_robust_list01    1  TPASS  :  get_robust_list failed as expected with E=
FAULT
get_robust_list01    2  TPASS  :  get_robust_list failed as expected with E=
FAULT
get_robust_list01    3  TPASS  :  get_robust_list failed as expected with E=
SRCH
get_robust_list01    4  TFAIL  :  get_robust_list succeeded unexpectedly
get_robust_list01    5  TPASS  :  get_robust_list succeeded


[2]. gettimeofday02

gettimeofday02    0  TINFO  :  checking if gettimeofday is monotonous, take=
s 30s

gettimeofday02    1  TFAIL  :  Time is going backwards: old 946



[3]. lseek03

lseek03     1  TFAIL  :  lseek(tfile_16887, 1, 4) Failed, errno=3D6 No such=
 device or address, expected 22(EINVAL)

lseek03     2  TPASS  :  lseek(tfile_16887, 1, -1) Failed, errno=3D22 : Inv=
alid argument

lseek03     3  TPASS  :  lseek(tfile_16887, 1, 7) Failed, errno=3D22 : Inva=
lid argument



[4]. readlink03

readlink03    1  TPASS  :  readlink(), No Search permissions to process, re=
turned errno 13

readlink03    2  TPASS  :  readlink(), No Search permissions to process, re=
turned errno 13

readlink03    3  TPASS  :  readlink(), Buffer size is not positive, returne=
d errno 22

readlink03    4  TPASS  :  readlink(), Buffer size is not positive, returne=
d errno 22

readlink03    5  TPASS  :  readlink(), File is not symbolic link, returned =
errno 22

readlink03    6  TPASS  :  readlink(), File is not symbolic link, returned =
errno 22

readlink03    7  TPASS  :  readlink(), Symlink path too long, returned errn=
o 36

readlink03    8  TPASS  :  readlink(), Symlink path too long, returned errn=
o 36

readlink03    9  TFAIL  :  readlink() failed, Symlink Pathname is empty, er=
rno=3D2, expected errno=3D22



[5] shmat01

shmat01     1  TFAIL  :  shmat call failed: TEST_ERRNO=3DEINVAL(22): Invali=
d argument



[6] sysctl01

sysctl01    1  TFAIL  :  sysctl(2) failed unexpectedly errno:38

sysctl01    2  TFAIL  :  sysctl(2) failed unexpectedly errno:38

sysctl01    3  TFAIL  :  sysctl(2) failed unexpectedly errno:38



any idea why these testcases are failing now?.

How can I resolve it?.



Best Regards,

Om Prakash Pal


--_000_3ED83A9DB3B6D94CA68BF7C03F2981D35B18E7912EEXDCVYMBSTM00_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:p=3D"urn:schemas-m=
icrosoft-com:office:powerpoint" xmlns:a=3D"urn:schemas-microsoft-com:office=
:access" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:s=3D"=
uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:rs=3D"urn:schemas-microsof=
t-com:rowset" xmlns:z=3D"#RowsetSchema" xmlns:b=3D"urn:schemas-microsoft-co=
m:office:publisher" xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadshee=
t" xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" xmlns=
:odc=3D"urn:schemas-microsoft-com:office:odc" xmlns:oa=3D"urn:schemas-micro=
soft-com:office:activation" xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:rtc=3D"http://m=
icrosoft.com/officenet/conferencing" xmlns:D=3D"DAV:" xmlns:Repl=3D"http://=
schemas.microsoft.com/repl/" xmlns:mt=3D"http://schemas.microsoft.com/share=
point/soap/meetings/" xmlns:x2=3D"http://schemas.microsoft.com/office/excel=
/2003/xml" xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" xmlns:ois=
=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" xmlns:dir=3D"http://=
schemas.microsoft.com/sharepoint/soap/directory/" xmlns:ds=3D"http://www.w3=
.org/2000/09/xmldsig#" xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint=
/dsp" xmlns:udc=3D"http://schemas.microsoft.com/data/udc" xmlns:xsd=3D"http=
://www.w3.org/2001/XMLSchema" xmlns:sub=3D"http://schemas.microsoft.com/sha=
repoint/soap/2002/1/alerts/" xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#"=
 xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" xmlns:sps=3D"http://=
schemas.microsoft.com/sharepoint/soap/" xmlns:xsi=3D"http://www.w3.org/2001=
/XMLSchema-instance" xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/so=
ap" xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" xmlns:udc=
p2p=3D"http://schemas.microsoft.com/data/udc/parttopart" xmlns:wf=3D"http:/=
/schemas.microsoft.com/sharepoint/soap/workflow/" xmlns:dsss=3D"http://sche=
mas.microsoft.com/office/2006/digsig-setup" xmlns:dssi=3D"http://schemas.mi=
crosoft.com/office/2006/digsig" xmlns:mdssi=3D"http://schemas.openxmlformat=
s.org/package/2006/digital-signature" xmlns:mver=3D"http://schemas.openxmlf=
ormats.org/markup-compatibility/2006" xmlns:m=3D"http://schemas.microsoft.c=
om/office/2004/12/omml" xmlns:mrels=3D"http://schemas.openxmlformats.org/pa=
ckage/2006/relationships" xmlns:spwp=3D"http://microsoft.com/sharepoint/web=
partpages" xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/20=
06/types" xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/200=
6/messages" xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/Sli=
deLibrary/" xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortal=
Server/PublishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" xmlns:=
st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta http-equi=
v=3DContent-Type content=3D"text/html; charset=3Dus-ascii"><meta name=3DGen=
erator content=3D"Microsoft Word 12 (filtered medium)"><style><!--
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
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'f=
ont-family:"Times New Roman","serif"'>Hi,<o:p></o:p></span></p><p class=3DM=
soNormal><span style=3D'font-family:"Times New Roman","serif"'>I am current=
ly using ltp-full-20110915.bz2.<o:p></o:p></span></p><p class=3DMsoNormal><=
span style=3D'font-family:"Times New Roman","serif"'>When I switched to &nb=
sp;kernel 3.4(from kernel 3.0) &nbsp;then these syscalls ltp are failing.<o=
:p></o:p></span></p><p>[1].<span class=3DMsoHyperlinkFollowed> </span><b>ge=
t_robust_list01</b><o:p></o:p></p><p class=3DMsoNormal><b><span style=3D'fo=
nt-size:10.0pt;font-family:"Times New Roman","serif"'>get_robust_list01&nbs=
p;&nbsp;&nbsp; 1&nbsp; TPASS&nbsp; :&nbsp; get_robust_list failed as expect=
ed with EFAULT <o:p></o:p></span></b></p><p class=3DMsoNormal><b><span styl=
e=3D'font-size:10.0pt;font-family:"Times New Roman","serif"'>get_robust_lis=
t01&nbsp;&nbsp;&nbsp; 2&nbsp; TPASS&nbsp; :&nbsp; get_robust_list failed as=
 expected with EFAULT <o:p></o:p></span></b></p><p class=3DMsoNormal><b><sp=
an style=3D'font-size:10.0pt;font-family:"Times New Roman","serif"'>get_rob=
ust_list01&nbsp;&nbsp;&nbsp; 3&nbsp; TPASS&nbsp; :&nbsp; get_robust_list fa=
iled as expected with ESRCH <o:p></o:p></span></b></p><p class=3DMsoNormal>=
<b><span style=3D'font-size:10.0pt;font-family:"Times New Roman","serif"'>g=
et_robust_list01&nbsp;&nbsp;&nbsp; 4&nbsp; TFAIL&nbsp; :&nbsp; get_robust_l=
ist succeeded unexpectedly <o:p></o:p></span></b></p><p class=3DMsoNormal><=
b><span style=3D'font-size:10.0pt;font-family:"Times New Roman","serif"'>ge=
t_robust_list01&nbsp;&nbsp;&nbsp; 5&nbsp; TPASS&nbsp; :&nbsp; get_robust_li=
st succeeded <o:p></o:p></span></b></p><p class=3DMsoNormal><b><span style=
=3D'font-size:10.0pt;font-family:"Times New Roman","serif"'><o:p>&nbsp;</o:=
p></span></b></p><p><b><span style=3D'font-size:10.0pt'>[2].</span></b><spa=
n class=3DMsoHyperlinkFollowed> </span><strong>gettimeofday02</strong><o:p>=
</o:p></p><pre><strong>gettimeofday02&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp;=
 :&nbsp; checking if gettimeofday is monotonous, takes 30s <o:p></o:p></str=
ong></pre><pre><strong>gettimeofday02&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp;=
 :&nbsp; Time is going backwards: old 946<o:p></o:p></strong></pre><pre><st=
rong><o:p>&nbsp;</o:p></strong></pre><p><strong>[3].</strong><span class=3D=
MsoHyperlinkFollowed> </span><strong>lseek03</strong><o:p></o:p></p><pre><s=
trong>lseek03&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; :&nbsp; lseek(tfi=
le_16887, 1, 4) Failed, errno=3D6 No such device or address, expected 22(EI=
NVAL) <o:p></o:p></strong></pre><pre><strong>lseek03&nbsp;&nbsp;&nbsp;&nbsp=
; 2&nbsp; TPASS&nbsp; :&nbsp; lseek(tfile_16887, 1, -1) Failed, errno=3D22 =
: Invalid argument <o:p></o:p></strong></pre><pre><strong>lseek03&nbsp;&nbs=
p;&nbsp;&nbsp; 3&nbsp; TPASS&nbsp; :&nbsp; lseek(tfile_16887, 1, 7) Failed,=
 errno=3D22 : Invalid argument <o:p></o:p></strong></pre><pre><strong><o:p>=
&nbsp;</o:p></strong></pre><p><strong>[4].</strong><span class=3DMsoHyperli=
nkFollowed> </span><strong>readlink03</strong><o:p></o:p></p><pre><strong>r=
eadlink03&nbsp;&nbsp;&nbsp; 1&nbsp; TPASS&nbsp; :&nbsp; readlink(), No Sear=
ch permissions to process, returned errno 13 <o:p></o:p></strong></pre><pre=
><strong>readlink03&nbsp;&nbsp;&nbsp; 2&nbsp; TPASS&nbsp; :&nbsp; readlink(=
), No Search permissions to process, returned errno 13 <o:p></o:p></strong>=
</pre><pre><strong>readlink03&nbsp;&nbsp;&nbsp; 3&nbsp; TPASS&nbsp; :&nbsp;=
 readlink(), Buffer size is not positive, returned errno 22 <o:p></o:p></st=
rong></pre><pre><strong>readlink03&nbsp;&nbsp;&nbsp; 4&nbsp; TPASS&nbsp; :&=
nbsp; readlink(), Buffer size is not positive, returned errno 22 <o:p></o:p=
></strong></pre><pre><strong>readlink03&nbsp;&nbsp;&nbsp; 5&nbsp; TPASS&nbs=
p; :&nbsp; readlink(), File is not symbolic link, returned errno 22 <o:p></=
o:p></strong></pre><pre><strong>readlink03&nbsp;&nbsp;&nbsp; 6&nbsp; TPASS&=
nbsp; :&nbsp; readlink(), File is not symbolic link, returned errno 22 <o:p=
></o:p></strong></pre><pre><strong>readlink03&nbsp;&nbsp;&nbsp; 7&nbsp; TPA=
SS&nbsp; :&nbsp; readlink(), Symlink path too long, returned errno 36 <o:p>=
</o:p></strong></pre><pre><strong>readlink03&nbsp;&nbsp;&nbsp; 8&nbsp; TPAS=
S&nbsp; :&nbsp; readlink(), Symlink path too long, returned errno 36 <o:p><=
/o:p></strong></pre><pre><strong>readlink03&nbsp;&nbsp;&nbsp; 9&nbsp; TFAIL=
&nbsp; :&nbsp; readlink() failed, Symlink Pathname is empty, errno=3D2, exp=
ected errno=3D22 <o:p></o:p></strong></pre><pre><strong><o:p>&nbsp;</o:p></=
strong></pre><p><strong>[5]</strong><span class=3DMsoHyperlinkFollowed> </s=
pan><strong>shmat01</strong><o:p></o:p></p><pre><strong>shmat01&nbsp;&nbsp;=
&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; :&nbsp; shmat call failed: TEST_ERRNO=3DEI=
NVAL(22): Invalid argument <o:p></o:p></strong></pre><pre><strong><o:p>&nbs=
p;</o:p></strong></pre><p><strong>[6]</strong><span class=3DMsoHyperlinkFol=
lowed> </span><strong>sysctl01</strong><o:p></o:p></p><pre><strong>sysctl01=
&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; :&nbsp; sysctl(2) failed unexpectedl=
y errno:38 <o:p></o:p></strong></pre><pre><strong>sysctl01&nbsp;&nbsp;&nbsp=
; 2&nbsp; TFAIL&nbsp; :&nbsp; sysctl(2) failed unexpectedly errno:38 <o:p><=
/o:p></strong></pre><pre><strong>sysctl01&nbsp;&nbsp;&nbsp; 3&nbsp; TFAIL&n=
bsp; :&nbsp; sysctl(2) failed unexpectedly errno:38 <o:p></o:p></strong></p=
re><pre><strong><o:p>&nbsp;</o:p></strong></pre><pre><strong><span style=3D=
'font-weight:normal'>any idea why these testcases are failing now?.<o:p></o=
:p></span></strong></pre><pre><strong><span style=3D'font-weight:normal'>Ho=
w can I resolve it?.<o:p></o:p></span></strong></pre><pre><strong><span sty=
le=3D'font-weight:normal'><o:p>&nbsp;</o:p></span></strong></pre><pre><stro=
ng><span style=3D'font-weight:normal'>Best Regards,<o:p></o:p></span></stro=
ng></pre><pre><strong><span style=3D'font-weight:normal'>Om Prakash Pal</sp=
an></strong><span style=3D'font-family:"Times New Roman","serif"'><o:p></o:=
p></span></pre><p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-fa=
mily:"Times New Roman","serif"'><o:p>&nbsp;</o:p></span></p></div></body></=
html>=

--_000_3ED83A9DB3B6D94CA68BF7C03F2981D35B18E7912EEXDCVYMBSTM00_--


--===============7974848030355324697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============7974848030355324697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7974848030355324697==--

