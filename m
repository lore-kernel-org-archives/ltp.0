Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Awais_Belal@mentor.com>) id 1X6ati-0006Y5-S1
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 07:42:06 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X6atg-0000pg-VY
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 07:42:06 +0000
From: "Belal, Awais" <Awais_Belal@mentor.com>
Date: Mon, 14 Jul 2014 07:41:20 +0000
Message-ID: <2021B186DC632746BD5A3CE32F12BD28E9EC0EE0@EU-MBX-03.mgc.mentorg.com>
References: <2021B186DC632746BD5A3CE32F12BD28E9EBFBC9@EU-MBX-03.mgc.mentorg.com>,
	<360014330.8577649.1405090273068.JavaMail.zimbra@redhat.com>
In-Reply-To: <360014330.8577649.1405090273068.JavaMail.zimbra@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Shell Scripting - Basics
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8230942619326431140=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============8230942619326431140==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2021B186DC632746BD5A3CE32F12BD28E9EC0EE0EUMBX03mgcmento_"

--_000_2021B186DC632746BD5A3CE32F12BD28E9EC0EE0EUMBX03mgcmento_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Thanks for taking the time out to bear my newbie-ness...

I am running this on an mx6q platform.

root@mx6q:~# ls -la /bin/sh
lrwxrwxrwx 1 root root 20 Jul 10 2014 /bin/sh -> /etc/alternatives/sh

Then PATH setting is as follows:

root@mx6q:~#
root@mx6q:~# cd /opt/ltp/
IDcheck.sh bin/ results/ runltplite.sh testcases/
Version runalltests.sh runtest/ testscripts/
abcd output/ runltp scenario_groups/ ver_linux
root@mx6q:~# cd /opt/ltp/
root@mx6q:/opt/ltp#
root@mx6q:/opt/ltp#
root@mx6q:/opt/ltp# echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
root@mx6q:/opt/ltp#
root@mx6q:/opt/ltp#
root@mx6q:/opt/ltp# export PATH=3D$PATH:/opt/ltp/testcases/bin/
root@mx6q:/opt/ltp#
root@mx6q:/opt/ltp# echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ltp/testc=
ases/bin/

/opt/ltp/testcases/bin/ is where I have test.sh present. Now the testcase:

root@mx6q:/opt/ltp/testcases/bin# cat foo.sh
#!/bin/sh
#
# This is a basic test for true shell buildin
#

TCID=3Dtrue01
TST_TOTAL=3D1
. test.sh

false
ret=3D$?

if [ $ret -eq 0 ]; then
tst_resm TPASS "true returned 0"
else
tst_resm TFAIL "true rturned $ret"
fi

tst_exit
root@mx6q:/opt/ltp/testcases/bin#
root@mx6q:/opt/ltp/testcases/bin#
root@mx6q:/opt/ltp/testcases/bin#
root@mx6q:/opt/ltp/testcases/bin# ./foo.sh
## Start Test
Thu Jan 1 00:10:59 UTC 1970
659

## Create files
/opt/ltp/testcases/bin/test.sh: line 14: /home/root/fs-bench/cr: No such fi=
le or directory

real 0m0.004s
user 0m0.000s
sys 0m0.000s

## tar all
tar: invalid option -- 'B'
BusyBox v1.21.1 (2014-07-10 15:06:02 PKT) multi-call binary.

Usage: tar -[cxtzJjhmvO] [-X FILE] [-T FILE] [-f TARFILE] [-C DIR] [FILE]..=
.


## Change owner
chown: ./00: No such file or directory

real 0m0.010s
user 0m0.000s
sys 0m0.000s

## random access
/opt/ltp/testcases/bin/test.sh: line 26: /home/root/fs-bench/ra: No such fi=
le or directory

real 0m0.002s
user 0m0.000s
sys 0m0.000s

## Change mode
chmod: ./00: No such file or directory

real 0m0.009s
user 0m0.000s
sys 0m0.000s

## Random delete and create
/opt/ltp/testcases/bin/test.sh: line 34: /home/root/fs-bench/radc: No such =
file or directory

real 0m0.002s
user 0m0.000s
sys 0m0.000s

## Change mode again
chmod: ./00: No such file or directory

real 0m0.008s
user 0m0.000s
sys 0m0.000s

## Remove all files and directories

real 0m0.007s
user 0m0.000s
sys 0m0.000s

## Finish test
659
Thu Jan 1 00:10:59 UTC 1970
TOTAL(seconds): 0

Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
export TCID=3D<test name>
export TST_TOTAL=3D<Total Number of Tests >
export TST_COUNT=3D<Test case number>

./foo.sh: line 17: 520 Aborted tst_resm TFAIL "true rturned $ret"

Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
export TCID=3D<test name>
export TST_TOTAL=3D<Total Number of Tests >
export TST_COUNT=3D<Test case number>

./foo.sh: line 19: 521 Aborted tst_exit
root@mx6q:/opt/ltp/testcases/bin#
root@mx6q:/opt/ltp/testcases/bin#
root@mx6q:/opt/ltp/testcases/bin# echo $?
134
root@mx6q:/opt/ltp/testcases/bin#

LTP versioning:
LTP Version: 20140115

I'll be trying this out on a simple desktop now, just to confirm, in the me=
antime please point out anything you see is out of place...

BR,
Awais

________________________________________
From: Jan Stancek [jstancek@redhat.com]
Sent: Friday, July 11, 2014 7:51 PM
To: Belal, Awais
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] Shell Scripting - Basics

----- Original Message -----
> From: "Awais Belal" <Awais_Belal@mentor.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 11 July, 2014 2:00:36 PM
> Subject: [LTP] Shell Scripting - Basics
>
> Hi Guys,
>
> I have just started looking into LTP and how test automation can be achie=
ved
> using the platform. While going through the very basics I am stuck on she=
ll
> script writing for LTP. I was following
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23=
1-basic-shell-test-structure
> and the very first thing that I got hit by was:
>
> Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
> export TCID=3D<test name>
> export TST_TOTAL=3D<Total Number of Tests >
> export TST_COUNT=3D<Test case number>

Hi,

This output suggests that instead of tst_resm from test.sh,
it ran tst_resm from tools/apicmd.

and somehow this condition from ltpapicmd.c was true:
if (!strcmp(cmd_name, "tst_kvercmp") &&
!strcmp(cmd_name, "tst_kvercmp2") &&
!strcmp(cmd_name, "tst_get_unused_port")) {

That's the only place where I can see this message. I'm assuming you
are using latest git LTP.

Can you send your whole script and command how you run it?
What shell are you using? (ls -la /bin/sh)

If I try the example from 2.3.1 with 'false', it fails as expected:

$ cd /usr/src/ltp/testcases/lib

$ cat foo.sh
#!/bin/sh
#
# This is a basic test for true shell buildin
#

TCID=3Dtrue01
TST_TOTAL=3D1
. test.sh

false
ret=3D$?

if [ $ret -eq 0 ]; then
tst_resm TPASS "true returned 0"
else
tst_resm TFAIL "true rturned $ret"
fi

tst_exit

$ PATH=3D.:$PATH sh ./foo.sh
true01 1 TFAIL : true rturned 1

$ echo $?
1

Regards,
Jan

>
> so I exported the variables in the above mentioned shell script (is the
> current wiki wrong???), the test passed as it should and I thought I was
> done and I understand, but then when I tried to make the test fail by doi=
ng
> the following:
>
> true ret =3D $?
> replaced with
> false ret =3D $?
>
> the test still reports success :(
>
> tst_exit says:
> "Exits the tests, note that this function has no parameters, the PASSES/F=
AILS
> reported by the tst_resm() interfaces were stored and are used for the ex=
it
> value."
>
> If I explicitly write an 'exit 1' at the end of the testcase, it fails bu=
t I
> believe that shouldn't be the case (using an explicit return shouldn't be
> needed if tst_exit is being used)... What am I missing? (a brain perhaps.=
..
> :S)
>
> BR,
> Awais
>
> -------------------------------------------------------------------------=
-----
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Editi=
on
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

--_000_2021B186DC632746BD5A3CE32F12BD28E9EC0EE0EUMBX03mgcmento_
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
Hi Jan,<br>
<br>
Thanks for taking the time out to bear my newbie-ness...<br>
<br>
I am running this on an mx6q platform.<br>
<br>
<i>root@mx6q:~# ls -la /bin/sh<br>
lrwxrwxrwx 1 root root 20 Jul 10 2014 /bin/sh -&gt; /etc/alternatives/sh<br=
>
</i><br>
Then PATH setting is as follows:<br>
<br>
<i>root@mx6q:~# <br>
root@mx6q:~# cd /opt/ltp/<br>
IDcheck.sh bin/ results/ runltplite.sh testcases/<br>
Version runalltests.sh runtest/ testscripts/<br>
abcd output/ runltp scenario_groups/ ver_linux<br>
root@mx6q:~# cd /opt/ltp/<br>
root@mx6q:/opt/ltp# <br>
root@mx6q:/opt/ltp# <br>
root@mx6q:/opt/ltp# echo $PATH<br>
/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin<br>
root@mx6q:/opt/ltp# <br>
root@mx6q:/opt/ltp# <br>
root@mx6q:/opt/ltp# export PATH=3D$PATH:/opt/ltp/testcases/bin/<br>
root@mx6q:/opt/ltp# <br>
root@mx6q:/opt/ltp# echo $PATH<br>
/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ltp/testc=
ases/bin/<br>
</i><br>
/opt/ltp/testcases/bin/ is where I have test.sh present. Now the testcase:<=
br>
<br>
<i>root@mx6q:/opt/ltp/testcases/bin# cat foo.sh<br>
#!/bin/sh<br>
#<br>
# This is a basic test for true shell buildin<br>
#<br>
<br>
TCID=3Dtrue01<br>
TST_TOTAL=3D1<br>
. test.sh<br>
<br>
false<br>
ret=3D$?<br>
<br>
if [ $ret -eq 0 ]; then<br>
tst_resm TPASS &quot;true returned 0&quot;<br>
else<br>
tst_resm TFAIL &quot;true rturned $ret&quot;<br>
fi<br>
<br>
tst_exit<br>
root@mx6q:/opt/ltp/testcases/bin# <br>
root@mx6q:/opt/ltp/testcases/bin# <br>
root@mx6q:/opt/ltp/testcases/bin# <br>
root@mx6q:/opt/ltp/testcases/bin# ./foo.sh<br>
## Start Test<br>
Thu Jan 1 00:10:59 UTC 1970<br>
659<br>
<br>
## Create files <br>
/opt/ltp/testcases/bin/test.sh: line 14: /home/root/fs-bench/cr: No such fi=
le or directory<br>
<br>
real 0m0.004s<br>
user 0m0.000s<br>
sys 0m0.000s<br>
<br>
## tar all <br>
tar: invalid option -- 'B'<br>
BusyBox v1.21.1 (2014-07-10 15:06:02 PKT) multi-call binary.<br>
<br>
Usage: tar -[cxtzJjhmvO] [-X FILE] [-T FILE] [-f TARFILE] [-C DIR] [FILE]..=
.<br>
<br>
<br>
## Change owner<br>
chown: ./00: No such file or directory<br>
<br>
real 0m0.010s<br>
user 0m0.000s<br>
sys 0m0.000s<br>
<br>
## random access<br>
/opt/ltp/testcases/bin/test.sh: line 26: /home/root/fs-bench/ra: No such fi=
le or directory<br>
<br>
real 0m0.002s<br>
user 0m0.000s<br>
sys 0m0.000s<br>
<br>
## Change mode <br>
chmod: ./00: No such file or directory<br>
<br>
real 0m0.009s<br>
user 0m0.000s<br>
sys 0m0.000s<br>
<br>
## Random delete and create<br>
/opt/ltp/testcases/bin/test.sh: line 34: /home/root/fs-bench/radc: No such =
file or directory<br>
<br>
real 0m0.002s<br>
user 0m0.000s<br>
sys 0m0.000s<br>
<br>
## Change mode again<br>
chmod: ./00: No such file or directory<br>
<br>
real 0m0.008s<br>
user 0m0.000s<br>
sys 0m0.000s<br>
<br>
## Remove all files and directories<br>
<br>
real 0m0.007s<br>
user 0m0.000s<br>
sys 0m0.000s<br>
<br>
## Finish test<br>
659<br>
Thu Jan 1 00:10:59 UTC 1970<br>
TOTAL(seconds): 0<br>
<br>
Set variables TCID, TST_TOTAL, and TST_COUNT before each test:<br>
export TCID=3D&lt;test name&gt;<br>
export TST_TOTAL=3D&lt;Total Number of Tests &gt;<br>
export TST_COUNT=3D&lt;Test case number&gt;<br>
<br>
./foo.sh: line 17: 520 Aborted tst_resm TFAIL &quot;true rturned $ret&quot;=
<br>
<br>
Set variables TCID, TST_TOTAL, and TST_COUNT before each test:<br>
export TCID=3D&lt;test name&gt;<br>
export TST_TOTAL=3D&lt;Total Number of Tests &gt;<br>
export TST_COUNT=3D&lt;Test case number&gt;<br>
<br>
./foo.sh: line 19: 521 Aborted tst_exit<br>
root@mx6q:/opt/ltp/testcases/bin# <br>
root@mx6q:/opt/ltp/testcases/bin# <br>
root@mx6q:/opt/ltp/testcases/bin# echo $?<br>
134<br>
root@mx6q:/opt/ltp/testcases/bin#<br>
</i><br>
LTP versioning:<br>
<i>LTP Version: 20140115</i><br>
<br>
I'll be trying this out on a simple desktop now, just to confirm, in the me=
antime please point out anything you see is out of place...<br>
<br>
BR,<br>
Awais<br>
<br>
________________________________________<br>
From: Jan Stancek [jstancek@redhat.com]<br>
Sent: Friday, July 11, 2014 7:51 PM<br>
To: Belal, Awais<br>
Cc: ltp-list@lists.sourceforge.net<br>
Subject: Re: [LTP] Shell Scripting - Basics<br>
<br>
----- Original Message -----<br>
&gt; From: &quot;Awais Belal&quot; &lt;Awais_Belal@mentor.com&gt;<br>
&gt; To: ltp-list@lists.sourceforge.net<br>
&gt; Sent: Friday, 11 July, 2014 2:00:36 PM<br>
&gt; Subject: [LTP] Shell Scripting - Basics<br>
&gt;<br>
&gt; Hi Guys,<br>
&gt;<br>
&gt; I have just started looking into LTP and how test automation can be ac=
hieved<br>
&gt; using the platform. While going through the very basics I am stuck on =
shell<br>
&gt; script writing for LTP. I was following<br>
&gt; https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines=
#231-basic-shell-test-structure<br>
&gt; and the very first thing that I got hit by was:<br>
&gt;<br>
&gt; Set variables TCID, TST_TOTAL, and TST_COUNT before each test:<br>
&gt; export TCID=3D&lt;test name&gt;<br>
&gt; export TST_TOTAL=3D&lt;Total Number of Tests &gt;<br>
&gt; export TST_COUNT=3D&lt;Test case number&gt;<br>
<br>
Hi,<br>
<br>
This output suggests that instead of tst_resm from test.sh,<br>
it ran tst_resm from tools/apicmd.<br>
<br>
and somehow this condition from ltpapicmd.c was true:<br>
if (!strcmp(cmd_name, &quot;tst_kvercmp&quot;) &amp;&amp;<br>
!strcmp(cmd_name, &quot;tst_kvercmp2&quot;) &amp;&amp;<br>
!strcmp(cmd_name, &quot;tst_get_unused_port&quot;)) {<br>
<br>
That's the only place where I can see this message. I'm assuming you<br>
are using latest git LTP.<br>
<br>
Can you send your whole script and command how you run it?<br>
What shell are you using? (ls -la /bin/sh)<br>
<br>
If I try the example from 2.3.1 with 'false', it fails as expected:<br>
<br>
$ cd /usr/src/ltp/testcases/lib<br>
<br>
$ cat foo.sh<br>
#!/bin/sh<br>
#<br>
# This is a basic test for true shell buildin<br>
#<br>
<br>
TCID=3Dtrue01<br>
TST_TOTAL=3D1<br>
. test.sh<br>
<br>
false<br>
ret=3D$?<br>
<br>
if [ $ret -eq 0 ]; then<br>
tst_resm TPASS &quot;true returned 0&quot;<br>
else<br>
tst_resm TFAIL &quot;true rturned $ret&quot;<br>
fi<br>
<br>
tst_exit<br>
<br>
$ PATH=3D.:$PATH sh ./foo.sh<br>
true01 1 TFAIL : true rturned 1<br>
<br>
$ echo $?<br>
1<br>
<br>
Regards,<br>
Jan<br>
<br>
&gt;<br>
&gt; so I exported the variables in the above mentioned shell script (is th=
e<br>
&gt; current wiki wrong???), the test passed as it should and I thought I w=
as<br>
&gt; done and I understand, but then when I tried to make the test fail by =
doing<br>
&gt; the following:<br>
&gt;<br>
&gt; true ret =3D $?<br>
&gt; replaced with<br>
&gt; false ret =3D $?<br>
&gt;<br>
&gt; the test still reports success :(<br>
&gt;<br>
&gt; tst_exit says:<br>
&gt; &quot;Exits the tests, note that this function has no parameters, the =
PASSES/FAILS<br>
&gt; reported by the tst_resm() interfaces were stored and are used for the=
 exit<br>
&gt; value.&quot;<br>
&gt;<br>
&gt; If I explicitly write an 'exit 1' at the end of the testcase, it fails=
 but I<br>
&gt; believe that shouldn't be the case (using an explicit return shouldn't=
 be<br>
&gt; needed if tst_exit is being used)... What am I missing? (a brain perha=
ps...<br>
&gt; :S)<br>
&gt;<br>
&gt; BR,<br>
&gt; Awais<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--------<br>
&gt; Open source business process management suite built on Java and Eclips=
e<br>
&gt; Turn processes into business applications with Bonita BPM Community Ed=
ition<br>
&gt; Quickly connect people, data, and systems into organized workflows<br>
&gt; Winner of BOSSIE, CODIE, OW2 and Gartner awards<br>
&gt; http://p.sf.net/sfu/Bonitasoft<br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; Ltp-list@lists.sourceforge.net<br>
&gt; https://lists.sourceforge.net/lists/listinfo/ltp-list<br>
&gt;<br>
</body>
</html>

--_000_2021B186DC632746BD5A3CE32F12BD28E9EC0EE0EUMBX03mgcmento_--


--===============8230942619326431140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck&#174;
Code Sight&#153; - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
--===============8230942619326431140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8230942619326431140==--

