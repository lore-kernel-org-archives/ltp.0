Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Awais_Belal@mentor.com>) id 1X5ZVm-00043G-4q
	for ltp-list@lists.sourceforge.net; Fri, 11 Jul 2014 12:01:10 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X5ZVk-0001yK-QF
	for ltp-list@lists.sourceforge.net; Fri, 11 Jul 2014 12:01:10 +0000
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp 
	id 1X5ZVe-0004NK-8A from Awais_Belal@mentor.com 
	for ltp-list@lists.sourceforge.net; Fri, 11 Jul 2014 05:01:02 -0700
From: "Belal, Awais" <Awais_Belal@mentor.com>
Date: Fri, 11 Jul 2014 12:00:36 +0000
Message-ID: <2021B186DC632746BD5A3CE32F12BD28E9EBFBC9@EU-MBX-03.mgc.mentorg.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Shell Scripting - Basics
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7919489518699047891=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============7919489518699047891==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2021B186DC632746BD5A3CE32F12BD28E9EBFBC9EUMBX03mgcmento_"

--_000_2021B186DC632746BD5A3CE32F12BD28E9EBFBC9EUMBX03mgcmento_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Guys,

I have just started looking into LTP and how test automation can be achieve=
d using the platform. While going through the very basics I am stuck on she=
ll script writing for LTP. I was following https://github.com/linux-test-pr=
oject/ltp/wiki/Test-Writing-Guidelines#231-basic-shell-test-structure and t=
he very first thing that I got hit by was:

Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
export TCID=3D<test name>
export TST_TOTAL=3D<Total Number of Tests >
export TST_COUNT=3D<Test case number>

so I exported the variables in the above mentioned shell script (is the cur=
rent wiki wrong???), the test passed as it should and I thought I was done =
and I understand, but then when I tried to make the test fail by doing the =
following:


true
ret=3D$?

replaced with

false
ret=3D$?

the test still reports success :(

tst_exit says:
"Exits the tests, note that this function has no parameters, the PASSES/FAI=
LS reported by the tst_resm() interfaces were stored and are used for the e=
xit value."

If I explicitly write an 'exit 1' at the end of the testcase, it fails but =
I believe that shouldn't be the case (using an explicit return shouldn't be=
 needed if tst_exit is being used)... What am I missing? (a brain perhaps..=
. :S)

BR,
Awais

--_000_2021B186DC632746BD5A3CE32F12BD28E9EBFBC9EUMBX03mgcmento_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">Hi Guys,<br>
<br>
I have just started looking into LTP and how test automation can be achieve=
d using the platform. While going through the very basics I am stuck on she=
ll script writing for LTP. I was following
<a href=3D"https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guid=
elines#231-basic-shell-test-structure" target=3D"_blank">
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#231-=
basic-shell-test-structure</a> and the very first thing that I got hit by w=
as:<br>
<br>
<b><i>Set variables TCID, TST_TOTAL, and TST_COUNT before each test:<br>
export TCID=3D&lt;test name&gt;<br>
export TST_TOTAL=3D&lt;Total Number of Tests &gt;<br>
export TST_COUNT=3D&lt;Test case number&gt;<br>
</i></b><br>
so I exported the variables in the above mentioned shell script (is the cur=
rent wiki wrong???), the test passed as it should and I thought I was done =
and I understand, but then when I tried to make the test fail by doing the =
following:<br>
<br>
<pre><span class=3D"nb">true</span>=0A=
<span class=3D"nv">ret</span><span class=3D"o">=3D</span><span class=3D"nv"=
>$?</span></pre>
replaced with<br>
<pre><span class=3D"nb">false</span>=0A=
<span class=3D"nv">ret</span><span class=3D"o">=3D</span><span class=3D"nv"=
>$?</span></pre>
<br>
the test still reports success :(<br>
<br>
tst_exit says:<br>
&quot;Exits the tests, note that this function has no parameters, the PASSE=
S/FAILS reported by the
<em>tst_resm()</em> interfaces were stored and are used for the exit value.=
&quot;<br>
<div><br>
If I explicitly write an 'exit 1' at the end of the testcase, it fails but =
I believe that shouldn't be the case (using an explicit return shouldn't be=
 needed if tst_exit is being used)... What am I missing? (a brain perhaps..=
. :S)<br>
<br>
<div style=3D"font-family:Tahoma; font-size:13px"><font face=3D"Tahoma"></f=
ont>
<div style=3D"font-size:13px">
<div><font face=3D"Tahoma" size=3D"2"><span lang=3D"en-US">
<div style=3D"margin:0">BR,</div>
<div style=3D"margin:0"><i>Awais</i></div>
</span></font></div>
</div>
<font face=3D"Tahoma"></font></div>
</div>
</div>
</body>
</html>

--_000_2021B186DC632746BD5A3CE32F12BD28E9EBFBC9EUMBX03mgcmento_--


--===============7919489518699047891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
--===============7919489518699047891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7919489518699047891==--

