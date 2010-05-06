Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O9w1V-0000Tn-HQ
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 08:01:33 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O9w1U-0006Hl-JK
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 08:01:33 +0000
Received: by pwj5 with SMTP id 5so2410890pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 May 2010 01:01:27 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1078)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20100506065844.23879.29307.sendpatchset@subratamodak.linux.ibm.com>
Date: Thu, 6 May 2010 01:01:30 -0700
Message-Id: <CA8CBDCC-AEE0-4503-8D9E-4DF7D68AB28F@gmail.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065844.23879.29307.sendpatchset@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [11/12 FAILURE] LTP? file test fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9119476466707792929=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>


--===============9119476466707792929==
Content-Type: multipart/alternative; boundary=Apple-Mail-2-620431192


--Apple-Mail-2-620431192
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On May 5, 2010, at 11:58 PM, Subrata Modak wrote:

> Subject: LTP=C5=9B file_test fails
>=20
> Issues Description below:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> # vi runtest/file_test
> file export TCdat=3D$LTPROOT/testcases/bin; file_test.sh
> <EOF>
>=20
> Run LTP with the following command:
> # ./runltp -f file_test
> <<<test_output>>>
> file01      0  TINFO  :  TEST #1: file command recogizes ASCII text =
files
> file01      1  TPASS  :  file: Recognised ASCII file correctly
> file02      0  TINFO  :  TEST #2: file command recognizes bash shell =
scripts
> file02      2  TPASS  :  file: Recognised bash shell script correctly
> file03      0  TINFO  :  TEST #3: file command recognizes korn shell =
scripts
> file03      3  TPASS  :  file: recognised korn shell script
> file04      0  TINFO  :  TEST #4: file command recognizes C shell =
scripts
> file04      4  TPASS  :  file: Recognised C shell script correctly
> file05      0  TINFO  :  TEST #5: file command recognizes C programs =
text
> file05      5  TPASS  :  file: Recognised C program text correctly
> file06      0  TINFO  :  TEST #6: file command recognizes ELF =
executables
> file06      6  TPASS  :  file: Recognized ELF binary executable
> file07      0  TINFO  :  TEST #7: file command recognizes tar files.
> file07      7  TPASS  :  file: Recognised tar files
> file08      0  TINFO  :  TEST #8: file command recognizes tar zip =
files
> file08      8  TPASS  :  file: Recognised tar zip file
> file09      0  TINFO  :  TEST #9: file command recognizes RPM files
> file09      9  TFAIL  :  file: Failed to Recognize RPM file. Reason:
> /root/rpmbuild/SRPMS/cprog-0.0.7-3.src.rpm: RPM v3.0 src
> file10      0  TINFO  :  TEST #10: file command recognizes vmlinu file
> file10     10  TPASS  :  file: Recognised vmlinu file correctly
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D7 cstime=3D18
> <<<test_end>>>

	This is why:

	grep "RPM v3 src" $LTPTMP/file.out > /dev/null 2>&1

	change that to

	egrep "RPM v3(\.0)? src" $LTPTMP/file.out > /dev/null 2>&1

    -- that should work.
HTH,
-Garrett=

--Apple-Mail-2-620431192
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><div>On May 5, 2010, at 11:58 PM, Subrata Modak wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div>Subject: LTP=C5=9B file_test fails<br><br>Issues =
Description below:<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br># vi =
runtest/file_test<br>file export TCdat=3D$LTPROOT/testcases/bin; =
file_test.sh<br>&lt;EOF&gt;<br><br>Run LTP with the following =
command:<br># ./runltp -f =
file_test<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>file01 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;TEST #1: file =
command recogizes ASCII text files<br>file01 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 &nbsp;TPASS &nbsp;: &nbsp;file: =
Recognised ASCII file correctly<br>file02 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;TEST #2: file =
command recognizes bash shell scripts<br>file02 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 &nbsp;TPASS &nbsp;: &nbsp;file: =
Recognised bash shell script correctly<br>file03 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;TEST #3: file =
command recognizes korn shell scripts<br>file03 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 &nbsp;TPASS &nbsp;: &nbsp;file: =
recognised korn shell script<br>file04 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 =
&nbsp;TINFO &nbsp;: &nbsp;TEST #4: file command recognizes C shell =
scripts<br>file04 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4 &nbsp;TPASS &nbsp;: =
&nbsp;file: Recognised C shell script correctly<br>file05 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;TEST #5: file =
command recognizes C programs text<br>file05 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5 &nbsp;TPASS &nbsp;: &nbsp;file: =
Recognised C program text correctly<br>file06 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;TEST #6: file =
command recognizes ELF executables<br>file06 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6 &nbsp;TPASS &nbsp;: &nbsp;file: =
Recognized ELF binary executable<br>file07 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;TEST #7: file =
command recognizes tar files.<br>file07 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7 =
&nbsp;TPASS &nbsp;: &nbsp;file: Recognised tar files<br>file08 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 &nbsp;TINFO &nbsp;: &nbsp;TEST #8: file =
command recognizes tar zip files<br>file08 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8 &nbsp;TPASS &nbsp;: &nbsp;file: =
Recognised tar zip file<br>file09 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 =
&nbsp;TINFO &nbsp;: &nbsp;TEST #9: file command recognizes RPM =
files<br>file09 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;9 &nbsp;TFAIL &nbsp;: =
&nbsp;file: Failed to Recognize RPM file. =
Reason:<br>/root/rpmbuild/SRPMS/cprog-0.0.7-3.src.rpm: RPM v3.0 =
src<br>file10 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 &nbsp;TINFO &nbsp;: =
&nbsp;TEST #10: file command recognizes vmlinu file<br>file10 =
&nbsp;&nbsp;&nbsp;&nbsp;10 &nbsp;TPASS &nbsp;: &nbsp;file: Recognised =
vmlinu file =
correctly<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=
=3D"ok"<br>duration=3D0 termination_type=3Dexited termination_id=3D1 =
corefile=3Dno<br>cutime=3D7 =
cstime=3D18<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br></div></blockquote><div=
><br></div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>This is why:</div><div><br></div><div><span =
class=3D"Apple-style-span" style=3D"font-family: monospace, helvetica, =
clean, sans-serif; font-size: 12px; line-height: 16px; white-space: pre; =
"><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>grep&nbsp;"RPM&nbsp;v3&nbsp;src"&nbsp;$LTPTMP/file.out&nbsp;&gt;&nb=
sp;/dev/null&nbsp;2&gt;&amp;1</span></div><div><span =
class=3D"Apple-style-span" style=3D"font-family: monospace, helvetica, =
clean, sans-serif; font-size: 13px; line-height: 16px; "><div><font =
class=3D"Apple-style-span" size=3D"3"><span class=3D"Apple-style-span" =
style=3D"font-size: 12px; white-space: =
pre;"><br></span></font></div><div><font class=3D"Apple-style-span" =
size=3D"3"><span class=3D"Apple-style-span" style=3D"font-size: 12px; =
white-space: pre;"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>change that =
to</span></font></div><div><font class=3D"Apple-style-span" =
size=3D"3"><span class=3D"Apple-style-span" style=3D"font-size: 12px; =
white-space: pre;"><br></span></font></div><div><font =
class=3D"Apple-style-span" size=3D"3"><span class=3D"Apple-style-span" =
style=3D"font-size: 12px; white-space: pre;"><span =
class=3D"Apple-style-span" style=3D"font-size: 13px; white-space: =
normal; "><div class=3D"pre" style=3D"font-family: monospace; font-size: =
12px; white-space: pre; "><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>egrep&nbsp;"RPM&nbsp;v3(\.0)?&nbsp;src"&nbsp;$LTPTMP/file.out&nbsp;=
&gt;&nbsp;/dev/null&nbsp;2&gt;&amp;1</div><div><font =
class=3D"Apple-style-span" size=3D"3"><span class=3D"Apple-style-span" =
style=3D"font-size: 12px; white-space: =
pre;"><br></span></font></div></span></span></font></div><div><font =
class=3D"Apple-style-span" size=3D"3"><span class=3D"Apple-style-span" =
style=3D"font-size: 12px; white-space: pre;">    -- that should =
work.</span></font></div><div><font class=3D"Apple-style-span" =
size=3D"3"><span class=3D"Apple-style-span" style=3D"font-size: 12px; =
white-space: pre;">HTH,</span></font></div><div><font =
class=3D"Apple-style-span" size=3D"3"><span class=3D"Apple-style-span" =
style=3D"font-size: 12px; white-space: =
pre;">-Garrett</span></font></div></span></div></body></html>=

--Apple-Mail-2-620431192--


--===============9119476466707792929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============9119476466707792929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9119476466707792929==--

