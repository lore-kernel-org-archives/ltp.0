Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1UuwpD-0005bB-Na
	for ltp-list@lists.sourceforge.net; Fri, 05 Jul 2013 03:36:47 +0000
Received: from smtpwcom.263xmail.com ([63.217.87.10])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uuwp8-00030C-74
	for ltp-list@lists.sourceforge.net; Fri, 05 Jul 2013 03:36:47 +0000
Received: from mail-pa0-f49.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id 1D15F4FD
	for <ltp-list@lists.sourceforge.net>;
	Fri,  5 Jul 2013 11:36:27 +0800 (CST)
Received: by mail-pa0-f49.google.com with SMTP id ld11so1825539pab.22
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Jul 2013 20:36:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPwn2JTpq-rVATF-_jk3Avok8KXd9x4M-Xse7J2txDhVEFaAkg@mail.gmail.com>
References: <CALGiYOH4uhAoPgEQ+-p889GbjTazpXkyXabXs021xdmOTbYkoA@mail.gmail.com>
	<51D58003.1020500@casparzhang.com>
	<CAPwn2JTpq-rVATF-_jk3Avok8KXd9x4M-Xse7J2txDhVEFaAkg@mail.gmail.com>
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Fri, 5 Jul 2013 11:35:50 +0800
Message-ID: <CALGiYOHZ8jJ_fChY9moEk5fgUU8com_JdC5T5TuE6XumsFto5w@mail.gmail.com>
Subject: Re: [LTP] [PATCH]xinetd/xinetd_tests.sh:disable the IPV6 localhost
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5946135189755145476=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

--===============5946135189755145476==
Content-Type: multipart/alternative; boundary=e89a8ffbace38af54404e0bb6693

--e89a8ffbace38af54404e0bb6693
Content-Type: text/plain; charset=ISO-8859-1

Sorry, I didn't test the telnet command in latest version.
The "Unable to connect to remote host" line comes out in previous version.
Is there any better way to fix the test script?



Thanks,
Lingyun Xie


2013/7/5 Hangbin Liu <liuhangbin@gmail.com>

> 2013/7/4 Caspar Zhang <caspar@casparzhang.com>:
> > Hangbin, have you executed such tests before, and/or met any ipv4/v6
> issue?
> >
> > Thanks,
> > Caspar
> >
> >
> >
> > On 07/04/2013 09:30 PM, Xie Lingyun wrote:
> >>
> >> If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet
> >> 127.0.0.1.
> >> The first one makes the command output different from the expected
> result.
> >>
> >>
> >> Thanks,
> >> Lingyun Xie
> >>
> >> 0001-xinetd-xinetd_tests.sh-disable-the-IPV6-localhost.patch
> >>
> >>
> >>  From 75c79721c095cce27548e74260c1e42681e1a267 Mon Sep 17 00:00:00 2001
> >> From: mellonwand<mellonwand@gmail.com>
> >> Date: Thu, 4 Jul 2013 16:42:42 +0800
> >> Subject: [PATCH] xinetd/xinetd_tests.sh:disable the IPV6 localhost
> >>
> >> If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet
> >> 127.0.0.1. The first one makes the command's output different from the
> >> expected output.
> >>
> >> Signed-off-by: Xie Lingyun<lingyun.xie@bj.cs2c.com.cn>
> >> ---
> >>   testcases/network/xinetd/xinetd_tests.sh | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/testcases/network/xinetd/xinetd_tests.sh
> >> b/testcases/network/xinetd/xinetd_tests.sh
> >> index 83eb8a7..d2c851d 100755
> >> --- a/testcases/network/xinetd/xinetd_tests.sh
> >> +++ b/testcases/network/xinetd/xinetd_tests.sh
> >> @@ -128,6 +128,7 @@ init()
> >>
> >>       # Create expected file with telnet disabled.
> >>       cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
> >> +       telnet: connect to address 127.0.0.1: Connection refused
> >>         telnet: Unable to connect to remote host: Connection refused
>
> Here we should remove the "Unable to connectto remote host" line
>
> >>         EOF
> >>
> >> @@ -263,7 +264,7 @@ test01()
> >>
> >>         # Not checking for exit code from telnet command because telnet
> is
> >>         # not terminated by the test gracefully.
> >> -       echo " " | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
> >> +       echo " " | telnet 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
> >>         diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
> >>                 > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
> >>       if [ $RC -ne 0 ]
> >> @@ -312,7 +313,7 @@ test01()
> >>
> >>         # Not checking for exit code from telnet command because telnet
> is
> >>         # not terminated by the test gracefully.
> >> -       echo " " | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
> >> +       echo " " | telnet 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
> >>
> >>         diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
> >>                 > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
> >> -- 1.8.3.1
> >>
> >
>
>
>

--e89a8ffbace38af54404e0bb6693
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:simsun,s=
erif;color:rgb(0,0,0)">Sorry, I didn&#39;t test the telnet command in lates=
t version. =A0</div><div class=3D"gmail_default" style=3D"font-family:simsu=
n,serif;color:rgb(0,0,0)">

The=A0<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:12px">&quot;Unable to connect to remote host&quot; line comes out in p=
revious version.</span></div><div class=3D"gmail_default"><font face=3D"ari=
al, sans-serif">Is there any better way to fix the test script?</font></div=
>

</div><div class=3D"gmail_extra"><br clear=3D"all"><div><div dir=3D"ltr"><b=
r><div><br></div><div>Thanks,<br>Lingyun Xie</div></div></div>
<br><br><div class=3D"gmail_quote">2013/7/5 Hangbin Liu <span dir=3D"ltr">&=
lt;<a href=3D"mailto:liuhangbin@gmail.com" target=3D"_blank">liuhangbin@gma=
il.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

2013/7/4 Caspar Zhang &lt;<a href=3D"mailto:caspar@casparzhang.com">caspar@=
casparzhang.com</a>&gt;:<br>
<div><div class=3D"h5">&gt; Hangbin, have you executed such tests before, a=
nd/or met any ipv4/v6 issue?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Caspar<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 07/04/2013 09:30 PM, Xie Lingyun wrote:<br>
&gt;&gt;<br>
&gt;&gt; If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet=
<br>
&gt;&gt; 127.0.0.1.<br>
&gt;&gt; The first one makes the command output different from the expected=
 result.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Lingyun Xie<br>
&gt;&gt;<br>
&gt;&gt; 0001-xinetd-xinetd_tests.sh-disable-the-IPV6-localhost.patch<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =A0From 75c79721c095cce27548e74260c1e42681e1a267 Mon Sep 17 00:00:=
00 2001<br>
&gt;&gt; From: mellonwand&lt;<a href=3D"mailto:mellonwand@gmail.com">mellon=
wand@gmail.com</a>&gt;<br>
&gt;&gt; Date: Thu, 4 Jul 2013 16:42:42 +0800<br>
&gt;&gt; Subject: [PATCH] xinetd/xinetd_tests.sh:disable the IPV6 localhost=
<br>
&gt;&gt;<br>
&gt;&gt; If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet=
<br>
&gt;&gt; 127.0.0.1. The first one makes the command&#39;s output different =
from the<br>
&gt;&gt; expected output.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Xie Lingyun&lt;<a href=3D"mailto:lingyun.xie@bj.cs2=
c.com.cn">lingyun.xie@bj.cs2c.com.cn</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =A0 testcases/network/xinetd/xinetd_tests.sh | 5 +++--<br>
&gt;&gt; =A0 1 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/testcases/network/xinetd/xinetd_tests.sh<br>
&gt;&gt; b/testcases/network/xinetd/xinetd_tests.sh<br>
&gt;&gt; index 83eb8a7..d2c851d 100755<br>
&gt;&gt; --- a/testcases/network/xinetd/xinetd_tests.sh<br>
&gt;&gt; +++ b/testcases/network/xinetd/xinetd_tests.sh<br>
&gt;&gt; @@ -128,6 +128,7 @@ init()<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 # Create expected file with telnet disabled.<br>
&gt;&gt; =A0 =A0 =A0 cat &gt; $LTPTMP/tst_xinetd.exp.1 &lt;&lt;-EOF || RC=
=3D$?<br>
&gt;&gt; + =A0 =A0 =A0 telnet: connect to address <a href=3D"http://127.0.0=
.1" target=3D"_blank">127.0.0.1</a>: Connection refused<br>
&gt;&gt; =A0 =A0 =A0 =A0 telnet: Unable to connect to remote host: Connecti=
on refused<br>
<br>
</div></div>Here we should remove the &quot;Unable to connectto remote host=
&quot; line<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;&gt; =A0 =A0 =A0 =A0 EOF<br>
&gt;&gt;<br>
&gt;&gt; @@ -263,7 +264,7 @@ test01()<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 # Not checking for exit code from telnet command b=
ecause telnet is<br>
&gt;&gt; =A0 =A0 =A0 =A0 # not terminated by the test gracefully.<br>
&gt;&gt; - =A0 =A0 =A0 echo &quot; &quot; | telnet localhost 2&gt;$LTPTMP/t=
st_xinetd.out 1&gt;/dev/null<br>
&gt;&gt; + =A0 =A0 =A0 echo &quot; &quot; | telnet 127.0.0.1 2&gt;$LTPTMP/t=
st_xinetd.out 1&gt;/dev/null<br>
&gt;&gt; =A0 =A0 =A0 =A0 diff -iwB $LTPTMP/tst_xinetd.out =A0$LTPTMP/tst_xi=
netd.exp.1 \<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; $LTPTMP/tst_xinetd.err 2&gt;&=
amp;1 || RC=3D$?<br>
&gt;&gt; =A0 =A0 =A0 if [ $RC -ne 0 ]<br>
&gt;&gt; @@ -312,7 +313,7 @@ test01()<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 # Not checking for exit code from telnet command b=
ecause telnet is<br>
&gt;&gt; =A0 =A0 =A0 =A0 # not terminated by the test gracefully.<br>
&gt;&gt; - =A0 =A0 =A0 echo &quot; &quot; | telnet localhost &gt; $LTPTMP/t=
st_xinetd.out 2&gt;&amp;1<br>
&gt;&gt; + =A0 =A0 =A0 echo &quot; &quot; | telnet 127.0.0.1 &gt; $LTPTMP/t=
st_xinetd.out 2&gt;&amp;1<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 diff -iwB $LTPTMP/tst_xinetd.out =A0$LTPTMP/tst_xi=
netd.exp.2 \<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; $LTPTMP/tst_xinetd.err 2&gt;&=
amp;1 || RC=3D$?<br>
&gt;&gt; -- 1.8.3.1<br>
&gt;&gt;<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br></div>

--e89a8ffbace38af54404e0bb6693--


--===============5946135189755145476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============5946135189755145476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5946135189755145476==--

