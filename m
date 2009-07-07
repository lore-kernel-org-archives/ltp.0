Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <praveen@primesoftsolutionsinc.com>)
	id 1MO8eK-0006On-FE
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 11:15:48 +0000
Received: from smtp105.biz.mail.in2.yahoo.com ([203.104.19.14])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MO8eB-0007f1-LD
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 11:15:48 +0000
Received: from unknown (HELO Praveen)
	(praveen@primesoftsolutionsinc.com@[192.168.0.9])
	(envelope-sender <praveen@primesoftsolutionsinc.com>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <ltp-list@lists.sourceforge.net>; 7 Jul 2009 11:09:21 -0000
From: "Praveen" <praveen@primesoftsolutionsinc.com>
Date: Tue, 7 Jul 2009 16:45:16 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0076_01C9FF22.4E511F40"
Subject: [LTP] FW: My first Patch
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
Message-Id: <E1MO8eL-0006Ot-AI@235xhf1.ch3.sourceforge.com>
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, 'Nathan Straz' <nstraz@redhat.com>, 'Naresh' <naresh@primesoftsolutionsinc.com>

This is a multi-part message in MIME format.

------=_NextPart_000_0076_01C9FF22.4E511F40
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0077_01C9FF22.4E511F40"


------=_NextPart_001_0077_01C9FF22.4E511F40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Subrata,

 

Please find my first 'file' command test patch attached with this email.

 

I have added detailed description of what individual test case does at the
top 

of the test. Please feel free to review and provide me with your comments.

 

The 'file' command test case in LTP test suite exists in path:

 "ltp-xxx/testcases/commands/ade/file/"

 

Thanks,

Praveen Kumar k

 


------=_NextPart_001_0077_01C9FF22.4E511F40
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:171.0pt;
	text-indent:-.5in;
	page-break-after:avoid;
	mso-list:l0 level3 lfo3;
	layout-grid-mode:char;
	font-size:12.0pt;
	font-family:Arial;
	color:black;}
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
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1188256032;
	mso-list-template-ids:867725992;}
@list l0:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l0:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l0:level3
	{mso-level-style-link:"Heading 3";
	mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:171.0pt;
	mso-level-number-position:left;
	margin-left:171.0pt;
	text-indent:-.5in;}
@list l0:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l0:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l0:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l0:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l0:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi Subrata,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Please find my first &#8216;file&#8217; command test =
patch attached
with this email.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have added detailed description of what individual =
test
case does at the top <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>of the test. Please feel free to review and provide =
me with
your comments.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The &#8216;file&#8217; command test case in LTP test =
suite exists
in path:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&#8220;ltp-xxx/testcases/commands/ade/file/&#822=
1;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span =
style=3D'font-size:9.0pt;
font-family:Arial'>Thanks,</span></font><font size=3D2><span =
style=3D'font-size:
11.0pt'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span =
style=3D'font-size:9.0pt;
font-family:Arial'>Praveen Kumar k<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_001_0077_01C9FF22.4E511F40--

------=_NextPart_000_0076_01C9FF22.4E511F40
Content-Type: application/octet-stream;
	name="file_test.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="file_test.patch"

*** file_test_old.sh	2009-07-07 14:15:51.000000000 +0530=0A=
--- file_test.sh	2009-07-07 14:05:58.000000000 +0530=0A=
***************=0A=
*** 39,53 ****=0A=
  #                            accordingly.=0A=
  =0A=
  =0A=
! export TST_TOTAL=3D10                # Number of tests in this testcase=0A=
  =0A=
  if [ -z "$LTPTMP" -a -z "$TMPBASE" ]=0A=
  then =0A=
      LTPTMP=3D/tmp/=0A=
  else=0A=
! 	LTPTMP=3D$TMPBASE=0A=
  fi=0A=
  =0A=
  if [ -z "$LTPBIN" -a -z "$LTPROOT" ]=0A=
  then=0A=
      LTPBIN=3D./=0A=
--- 39,135 ----=0A=
  #                            accordingly.=0A=
  =0A=
  =0A=
! #=0A=
! # Description of individual test cases=0A=
! # ------------------------------------=0A=
! #=0A=
! # Test01: Test if file command recognizes ASCII text files=0A=
! # -------=0A=
! # 1) Write text to a known file =0A=
! # 2) Use 'file' command to get the type of the known file=0A=
! #    Ex: file xyz.txt=0A=
! # 3) Grep for the keyword "ASCII text" in the output of the =0A=
! #    'file' command=0A=
! # 4) Declare test as PASS if above step is successful else =0A=
! #    declare test as FAIL=0A=
! #=0A=
! # Test02: Test if file command can recognize bash shell script=0A=
! # -------=0A=
! # 1) Write a small bash shell script to a known file=0A=
! # 2) Use 'file' command to get the type of the known file=0A=
! #    Ex: file xyz.sh=0A=
! # 3) Grep for the keyword "Bourne-Again shell script" in =0A=
! #    the output of the 'file' command=0A=
! # 4) Declare test as PASS if above step is successful else =0A=
! #    declare test as FAIL=0A=
! #=0A=
! # Test03: Test if file command can recognize bash shell script=0A=
! # -------=0A=
! #   Similar test(as Test02) is performed with Korn shell script=0A=
! #=0A=
! # Test04: Test if file command can recognize C shell script=0A=
! # -------=0A=
! #   Similar test(as Test02) is performed with C shell script=0A=
! #=0A=
! # Test05: Test if file command can recognize C program text=0A=
! # -------=0A=
! #   Similar test(as Test02) is performed with C program text=0A=
! #=0A=
! # Test06: Test if file command can recognize ELF binay executables=0A=
! # -------  =0A=
! # 1) Grep for 'm68k' or 'sparc' or 'mips' or 'mipseb' or 'sh.eb' =0A=
! #    or 'powerpc' or 'ppc' or 's390' from the output of the command =0A=
! #    'uname -m'=0A=
! # 2) If the above step is successful, assign string 'MSB' to variable =0A=
! #    TARGET_ARCH else assign string 'LSB'=0A=
! # 3) Write small C program to a known '.c' file=0A=
! # 4) Compile it using "cc"=0A=
! #    Ex: cc xyz xyz.c=0A=
! # 5) Use file command to get the type of the object file=0A=
! # 6) Grep for the string "ELF .*-bit $TEST_ARCH executable, .*" =0A=
! #    in the output of the 'file' command=0A=
! # 7) If the above command is successful, declare test as PASS=0A=
! #    else declare test as FAIL=0A=
! #=0A=
! # Test07: Test if file command can recognize tar files=0A=
! # -------=0A=
! # 1) Write text to three different files=0A=
! # 2) Archive the files using "tar" command=0A=
! #    Ex: tar -cf ...=0A=
! # 3) Use 'file' command to get the type of the archive file=0A=
! #    Ex: file xyz.tar=0A=
! # 4) Grep for the string "tar archive" from the output of=0A=
! #    the above 'file' command=0A=
! # 5) Declare test as PASS, if the above step is successfull else=0A=
! #    declare test as FAIL=0A=
! #=0A=
! # Test08: Test if file command can tar zip files=0A=
! # -------=0A=
! # 1) Write text to three different files=0A=
! # 2) Archive the files using "tar" command=0A=
! #    Ex: tar -cf ...=0A=
! # 3) Use 'gzip' command to zip tar files=0A=
! #    Ex: gzip -f xyz.tar=0A=
! # 4) Use 'file' command to get the type of the archive file=0A=
! #    Ex: file xyz.tar.gz=0A=
! # 5) Grep for the string "gzip compressed data, .*" from the above =0A=
! #    file commnand=0A=
! # 6) Declare test as PASS, if the above step is successfull else=0A=
! #    declare test as FAIL=0A=
! #=0A=
  =0A=
+ =0A=
+ export TST_TOTAL=3D10                # Number of tests in this testcase=0A=
+  =0A=
  if [ -z "$LTPTMP" -a -z "$TMPBASE" ]=0A=
  then =0A=
      LTPTMP=3D/tmp/=0A=
  else=0A=
!     LTPTMP=3D$TMPBASE=0A=
  fi=0A=
  =0A=
+ # 'LTPBIN' where actual test cases (test binaries) reside=0A=
+ # 'LTPROOT' where the actual LTP test suite resides=0A=
  if [ -z "$LTPBIN" -a -z "$LTPROOT" ]=0A=
  then=0A=
      LTPBIN=3D./=0A=
***************=0A=
*** 65,71 ****=0A=
  # Test if file command recognizes ASCII text files.=0A=
  =0A=
  export TCID=3Dfile01=0A=
! export TST_COUNT=3D7=0A=
  =0A=
  $LTPBIN/tst_resm TINFO "TEST #1: file commad recogizes ASCII text =
files"=0A=
  =0A=
--- 147,153 ----=0A=
  # Test if file command recognizes ASCII text files.=0A=
  =0A=
  export TCID=3Dfile01=0A=
! export TST_COUNT=3D1=0A=
  =0A=
  $LTPBIN/tst_resm TINFO "TEST #1: file commad recogizes ASCII text =
files"=0A=
  =0A=

------=_NextPart_000_0076_01C9FF22.4E511F40
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
------=_NextPart_000_0076_01C9FF22.4E511F40
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_NextPart_000_0076_01C9FF22.4E511F40--



