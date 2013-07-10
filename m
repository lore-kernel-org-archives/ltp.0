Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1UwjsE-0002AL-DO
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 02:11:18 +0000
Received: from smtpwcom.263xmail.com ([63.217.87.10])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uwjrw-0000if-DL
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 02:11:16 +0000
Received: from mail-pa0-f54.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id 2AEBA523
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Jul 2013 10:10:37 +0800 (CST)
Received: by mail-pa0-f54.google.com with SMTP id kx10so6213434pab.27
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Jul 2013 19:10:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPwn2JThzyiSxEtFDixu1W1shoYuQ-ns0zdOiq95uQvVbSAxVQ@mail.gmail.com>
References: <CALGiYOHjLdA=roRGqztO1HjHSvy+=Je7LK-Zi2LTQMsKU5Z=1g@mail.gmail.com>
	<CAPwn2JThzyiSxEtFDixu1W1shoYuQ-ns0zdOiq95uQvVbSAxVQ@mail.gmail.com>
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Wed, 10 Jul 2013 10:09:57 +0800
Message-ID: <CALGiYOGJAC2Msbz5e5BiMsdSCydyOReWUnK52SpXXxXjir0H-w@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] xinetd/xinetd_tests.sh: add IPv6 test for
	xinetd
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1031339443822411656=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--===============1031339443822411656==
Content-Type: multipart/alternative; boundary=047d7b15a2d1ab733f04e11ec81d

--047d7b15a2d1ab733f04e11ec81d
Content-Type: text/plain; charset=ISO-8859-1

Yes, there should be a "^D" in each "echo " line. It seems that the
terminal which I copied from doesn't support the special character.

2013/7/9 Hangbin Liu <liuhangbin@gmail.com>

> 2013/7/9 Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>:
> > If IPv6 is enabled, telnet ::1 will be tested. Otherwise, IPv4 only.
> >
> > Signed-off-by: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
> > ---
> >  testcases/network/xinetd/xinetd_tests.sh | 90
> > ++++++++++++++++++++++++++++----
> >  1 file changed, 79 insertions(+), 11 deletions(-)
> >
> > diff --git a/testcases/network/xinetd/xinetd_tests.sh
> > b/testcases/network/xinetd/xinetd_tests.sh
> > index 83eb8a7..0fb6598 100755
> > --- a/testcases/network/xinetd/xinetd_tests.sh
> > +++ b/testcases/network/xinetd/xinetd_tests.sh
> > @@ -84,12 +84,23 @@ init()
> >           return $RC
> >      fi
> >
> > + # sometimes the default telnet may be /usr/kerberos/bin/telnet
> > + TELNET_COMM='/usr/bin/telnet'
> > +
> >      # check if commands tst_*, xinetd, awk exists.
> >      chk_ifexists INIT tst_resm   || return $RC
> >      chk_ifexists INIT xinetd     || return $RC
> >      chk_ifexists INIT diff       || return $RC
> > -    chk_ifexists INIT telnet     || return $RC
> > -
> > +    chk_ifexists INIT $TELNET_COMM     || return $RC
> > +    chk_ifexists INIT ip || return $RC
> > +
> > +    IPV6_ENABLED=0
> > +    ip a | grep inet6 > /dev/null 2>&1
> > +    if [ $? -eq 0 ]
> > +    then
> > +     IPV6_ENABLED=1
> > +    fi
> > +
> >   # Create custom xinetd.conf file.
> >   # tst_xinetd.conf.1 config file has telnet service disabled.
> >   cat > $LTPTMP/tst_xinetd.conf.1 <<-EOF || RC=$?
> > @@ -128,7 +139,7 @@ init()
> >
> >      # Create expected file with telnet disabled.
> >      cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
> > - telnet: Unable to connect to remote host: Connection refused
> > + telnet: connect to address 127.0.0.1: Connection refused
> >   EOF
> >
> >      if [ $RC -ne 0 ]
> > @@ -137,11 +148,25 @@ init()
> >              "INIT: unable to create expected file
> $LTPTMP/tst_xinetd.exp.1"
> >          return $RC
> >      fi
> > +
> > +    if [ $IPV6_ENABLED -eq 1 ]
> > +    then
> > +     cat > $LTPTMP/tst_xinetd.exp.1.ipv6 <<-EOF || RC=$?
> > + telnet: connect to address ::1: Connection refused
> > + EOF
> > +
> > +     if [ $RC -ne 0 ]
> > +   then
> > +         tst_brkm TBROK  NULL \
> > +             "INIT: unable to create expected file
> > $LTPTMP/tst_xinetd.exp.1.ipv6"
> > +         return $RC
> > +     fi
> > +    fi
> >
> >      # Create expected file with telnet enabled.
> >   cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
> >   Trying 127.0.0.1...
> > - Connected to localhost (127.0.0.1).
> > + Connected to 127.0.0.1.
> >   Escape character is '^]'.
> >   Connection closed by foreign host.
> >   EOF
> > @@ -149,10 +174,27 @@ init()
> >      if [ $RC -ne 0 ]
> >      then
> >          tst_brkm TBROK  NULL \
> > -            "INIT: unable to create expected file
> $LTPTMP/tst_xinetd.exp.1"
> > +            "INIT: unable to create expected file
> $LTPTMP/tst_xinetd.exp.2"
> >          return $RC
> >      fi
> >
> > + if [ $IPV6_ENABLED -eq 1 ]
> > +    then
> > +     cat > $LTPTMP/tst_xinetd.exp.2.ipv6 <<-EOF || RC=$?
> > + Trying ::1...
> > + Connected to ::1.
> > + Escape character is '^]'.
> > + Connection closed by foreign host.
> > + EOF
> > +
> > +     if [ $RC -ne 0 ]
> > +     then
> > +         tst_brkm TBROK  NULL \
> > +             "INIT: unable to create expected file
> > $LTPTMP/tst_xinetd.exp.2.ipv6"
> > +         return $RC
> > +     fi
> > +    fi
> > +
> >      return $RC
> >  }
> >
> > @@ -263,7 +305,7 @@ test01()
> >
> >   # Not checking for exit code from telnet command because telnet is
> >   # not terminated by the test gracefully.
> > - echo " " | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
> > + echo " " | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
>
> Should there be a "^D" ? I can't see it here, does gmail support this
> kind of special character ?
>
> >   diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
> >   > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
> >      if [ $RC -ne 0 ]
> > @@ -272,7 +314,20 @@ test01()
> >              "Test #1: with telnet diabled expected out differs RC=$RC.
> > Details:"
> >          return $RC
> >      fi
> > -
> > +
> > +    if [ $IPV6_ENABLED -eq 1 ]
> > +    then
> > +     echo " " | $TELNET_COMM ::1 2>$LTPTMP/tst_xinetd.out.ipv6
> 1>/dev/null
>
> Also here and other echo lines.
>
> > + diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.1.ipv6 \
> > + > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
> > +     if [ $RC -ne 0 ]
> > +     then
> > +         tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
> > +             "Test #1: with telnet diabled of IPv6 expected out differs
> > RC=$RC. Details:"
> > +         return $RC
> > +     fi
> > +    fi
> > +
> >      tst_resm TINFO "Test #1: restart xinetd with telnet enabled."
> >   # install the xinetd config file with telnet enabled.
> >   mv $LTPTMP/tst_xinetd.conf.2 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err
> > 2>&1 \
> > @@ -312,7 +367,7 @@ test01()
> >
> >   # Not checking for exit code from telnet command because telnet is
> >   # not terminated by the test gracefully.
> > - echo " " | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
> > + echo " " | $TELNET_COMM 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
> >
> >   diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
> >   > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
> > @@ -321,11 +376,24 @@ test01()
> >          tst_res TFAIL $LTPTMP/tst_xinetd.err \
> >              "Test #1: expected output differes from actual. Details:"
> >          return $RC
> > - else
> > - tst_resm TPASS \
> > - "Test #1: xinetd reads the config file and starts or stops services."
> >      fi
> >
> > + if [ $IPV6_ENABLED -eq 1 ]
> > +    then
> > +     echo " " | $TELNET_COMM ::1 > $LTPTMP/tst_xinetd.out.ipv6 2>&1
> > +
> > + diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.2.ipv6 \
> > + > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
> > +     if [ $RC -ne 0 ]
> > +     then
> > +         tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
> > +             "Test #1: expected output differes from actual. Details:"
> > +         return $RC
> > +     fi
> > +    fi
> > +
> > + tst_resm TPASS \
> > + "Test #1: xinetd reads the config file and starts or stops services."
>
> This will PASS the test anyway. The previous test only pass when $RC eq 0.
>
In fact, if $RC -ne 0, the script should exit before this line. So I simply
move this line from if statement to here.


>
> >      return $RC
> >  }
> >
> > --
> > 1.8.3.1
> >
> >
> >
> > Thanks,
> > Lingyun Xie
>
>
> Regards
> Hangbin Liu
>
>
>
Thanks,
Lingyun Xie

--047d7b15a2d1ab733f04e11ec81d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:simsun,s=
erif;color:rgb(0,0,0)">Yes, there should be a &quot;^D&quot; in each &quot;=
echo &quot; line. It seems that the terminal which I copied from doesn&#39;=
t support the special=A0<span style=3D"font-family:arial,sans-serif;font-si=
ze:12px;color:rgb(34,34,34)">character.</span></div>

<div class=3D"gmail_extra"><div class=3D"gmail_default" style=3D"font-famil=
y:simsun,serif;color:rgb(0,0,0)"></div><br><div class=3D"gmail_quote">2013/=
7/9 Hangbin Liu <span dir=3D"ltr">&lt;<a href=3D"mailto:liuhangbin@gmail.co=
m" target=3D"_blank">liuhangbin@gmail.com</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">2013/7/9 Xie Lingyun &lt;<a href=3D"mailto:lingyun.xie@bj.=
cs2c.com.cn">lingyun.xie@bj.cs2c.com.cn</a>&gt;:<br>


<div><div class=3D"h5">&gt; If IPv6 is enabled, telnet ::1 will be tested. =
Otherwise, IPv4 only.<br>
&gt;<br>
&gt; Signed-off-by: Xie Lingyun &lt;<a href=3D"mailto:lingyun.xie@bj.cs2c.c=
om.cn">lingyun.xie@bj.cs2c.com.cn</a>&gt;<br>
&gt; ---<br>
&gt; =A0testcases/network/xinetd/xinetd_tests.sh | 90<br>
&gt; ++++++++++++++++++++++++++++----<br>
&gt; =A01 file changed, 79 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/testcases/network/xinetd/xinetd_tests.sh<br>
&gt; b/testcases/network/xinetd/xinetd_tests.sh<br>
&gt; index 83eb8a7..0fb6598 100755<br>
&gt; --- a/testcases/network/xinetd/xinetd_tests.sh<br>
&gt; +++ b/testcases/network/xinetd/xinetd_tests.sh<br>
&gt; @@ -84,12 +84,23 @@ init()<br>
&gt; =A0 =A0 =A0 =A0 =A0 return $RC<br>
&gt; =A0 =A0 =A0fi<br>
&gt;<br>
&gt; + # sometimes the default telnet may be /usr/kerberos/bin/telnet<br>
&gt; + TELNET_COMM=3D&#39;/usr/bin/telnet&#39;<br>
&gt; +<br>
&gt; =A0 =A0 =A0# check if commands tst_*, xinetd, awk exists.<br>
&gt; =A0 =A0 =A0chk_ifexists INIT tst_resm =A0 || return $RC<br>
&gt; =A0 =A0 =A0chk_ifexists INIT xinetd =A0 =A0 || return $RC<br>
&gt; =A0 =A0 =A0chk_ifexists INIT diff =A0 =A0 =A0 || return $RC<br>
&gt; - =A0 =A0chk_ifexists INIT telnet =A0 =A0 || return $RC<br>
&gt; -<br>
&gt; + =A0 =A0chk_ifexists INIT $TELNET_COMM =A0 =A0 || return $RC<br>
&gt; + =A0 =A0chk_ifexists INIT ip || return $RC<br>
&gt; +<br>
&gt; + =A0 =A0IPV6_ENABLED=3D0<br>
&gt; + =A0 =A0ip a | grep inet6 &gt; /dev/null 2&gt;&amp;1<br>
&gt; + =A0 =A0if [ $? -eq 0 ]<br>
&gt; + =A0 =A0then<br>
&gt; + =A0 =A0 IPV6_ENABLED=3D1<br>
&gt; + =A0 =A0fi<br>
&gt; +<br>
&gt; =A0 # Create custom xinetd.conf file.<br>
&gt; =A0 # tst_xinetd.conf.1 config file has telnet service disabled.<br>
&gt; =A0 cat &gt; $LTPTMP/tst_xinetd.conf.1 &lt;&lt;-EOF || RC=3D$?<br>
&gt; @@ -128,7 +139,7 @@ init()<br>
&gt;<br>
&gt; =A0 =A0 =A0# Create expected file with telnet disabled.<br>
&gt; =A0 =A0 =A0cat &gt; $LTPTMP/tst_xinetd.exp.1 &lt;&lt;-EOF || RC=3D$?<b=
r>
&gt; - telnet: Unable to connect to remote host: Connection refused<br>
&gt; + telnet: connect to address <a href=3D"http://127.0.0.1" target=3D"_b=
lank">127.0.0.1</a>: Connection refused<br>
&gt; =A0 EOF<br>
&gt;<br>
&gt; =A0 =A0 =A0if [ $RC -ne 0 ]<br>
&gt; @@ -137,11 +148,25 @@ init()<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;INIT: unable to create expected file =
$LTPTMP/tst_xinetd.exp.1&quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0return $RC<br>
&gt; =A0 =A0 =A0fi<br>
&gt; +<br>
&gt; + =A0 =A0if [ $IPV6_ENABLED -eq 1 ]<br>
&gt; + =A0 =A0then<br>
&gt; + =A0 =A0 cat &gt; $LTPTMP/tst_xinetd.exp.1.ipv6 &lt;&lt;-EOF || RC=3D=
$?<br>
&gt; + telnet: connect to address ::1: Connection refused<br>
&gt; + EOF<br>
&gt; +<br>
&gt; + =A0 =A0 if [ $RC -ne 0 ]<br>
&gt; + =A0 then<br>
&gt; + =A0 =A0 =A0 =A0 tst_brkm TBROK =A0NULL \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 &quot;INIT: unable to create expected file<b=
r>
&gt; $LTPTMP/tst_xinetd.exp.1.ipv6&quot;<br>
&gt; + =A0 =A0 =A0 =A0 return $RC<br>
&gt; + =A0 =A0 fi<br>
&gt; + =A0 =A0fi<br>
&gt;<br>
&gt; =A0 =A0 =A0# Create expected file with telnet enabled.<br>
&gt; =A0 cat &gt; $LTPTMP/tst_xinetd.exp.2 &lt;&lt;-EOF || RC=3D$?<br>
&gt; =A0 Trying 127.0.0.1...<br>
&gt; - Connected to localhost (127.0.0.1).<br>
&gt; + Connected to 127.0.0.1.<br>
&gt; =A0 Escape character is &#39;^]&#39;.<br>
&gt; =A0 Connection closed by foreign host.<br>
&gt; =A0 EOF<br>
&gt; @@ -149,10 +174,27 @@ init()<br>
&gt; =A0 =A0 =A0if [ $RC -ne 0 ]<br>
&gt; =A0 =A0 =A0then<br>
&gt; =A0 =A0 =A0 =A0 =A0tst_brkm TBROK =A0NULL \<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0&quot;INIT: unable to create expected file $L=
TPTMP/tst_xinetd.exp.1&quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0&quot;INIT: unable to create expected file $L=
TPTMP/tst_xinetd.exp.2&quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0return $RC<br>
&gt; =A0 =A0 =A0fi<br>
&gt;<br>
&gt; + if [ $IPV6_ENABLED -eq 1 ]<br>
&gt; + =A0 =A0then<br>
&gt; + =A0 =A0 cat &gt; $LTPTMP/tst_xinetd.exp.2.ipv6 &lt;&lt;-EOF || RC=3D=
$?<br>
&gt; + Trying ::1...<br>
&gt; + Connected to ::1.<br>
&gt; + Escape character is &#39;^]&#39;.<br>
&gt; + Connection closed by foreign host.<br>
&gt; + EOF<br>
&gt; +<br>
&gt; + =A0 =A0 if [ $RC -ne 0 ]<br>
&gt; + =A0 =A0 then<br>
&gt; + =A0 =A0 =A0 =A0 tst_brkm TBROK =A0NULL \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 &quot;INIT: unable to create expected file<b=
r>
&gt; $LTPTMP/tst_xinetd.exp.2.ipv6&quot;<br>
&gt; + =A0 =A0 =A0 =A0 return $RC<br>
&gt; + =A0 =A0 fi<br>
&gt; + =A0 =A0fi<br>
&gt; +<br>
&gt; =A0 =A0 =A0return $RC<br>
&gt; =A0}<br>
&gt;<br>
&gt; @@ -263,7 +305,7 @@ test01()<br>
&gt;<br>
&gt; =A0 # Not checking for exit code from telnet command because telnet is=
<br>
&gt; =A0 # not terminated by the test gracefully.<br>
&gt; - echo &quot; &quot; | telnet localhost 2&gt;$LTPTMP/tst_xinetd.out 1&=
gt;/dev/null<br>
&gt; + echo &quot; &quot; | $TELNET_COMM 127.0.0.1 2&gt;$LTPTMP/tst_xinetd.=
out 1&gt;/dev/null<br>
<br>
</div></div>Should there be a &quot;^D&quot; ? I can&#39;t see it here, doe=
s gmail support this<br>
kind of special character ?<br>
<div class=3D"im"><br>
&gt; =A0 diff -iwB $LTPTMP/tst_xinetd.out =A0$LTPTMP/tst_xinetd.exp.1 \<br>
&gt; =A0 &gt; $LTPTMP/tst_xinetd.err 2&gt;&amp;1 || RC=3D$?<br>
&gt; =A0 =A0 =A0if [ $RC -ne 0 ]<br>
&gt; @@ -272,7 +314,20 @@ test01()<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;Test #1: with telnet diabled expected=
 out differs RC=3D$RC.<br>
&gt; Details:&quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0return $RC<br>
&gt; =A0 =A0 =A0fi<br>
&gt; -<br>
&gt; +<br>
&gt; + =A0 =A0if [ $IPV6_ENABLED -eq 1 ]<br>
&gt; + =A0 =A0then<br>
&gt; + =A0 =A0 echo &quot; &quot; | $TELNET_COMM ::1 2&gt;$LTPTMP/tst_xinet=
d.out.ipv6 1&gt;/dev/null<br>
<br>
</div>Also here and other echo lines.<br>
<div><div class=3D"h5"><br>
&gt; + diff -iwB $LTPTMP/tst_xinetd.out.ipv6 =A0$LTPTMP/tst_xinetd.exp.1.ip=
v6 \<br>
&gt; + &gt; $LTPTMP/tst_xinetd.err.ipv6 2&gt;&amp;1 || RC=3D$?<br>
&gt; + =A0 =A0 if [ $RC -ne 0 ]<br>
&gt; + =A0 =A0 then<br>
&gt; + =A0 =A0 =A0 =A0 tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 &quot;Test #1: with telnet diabled of IPv6 e=
xpected out differs<br>
&gt; RC=3D$RC. Details:&quot;<br>
&gt; + =A0 =A0 =A0 =A0 return $RC<br>
&gt; + =A0 =A0 fi<br>
&gt; + =A0 =A0fi<br>
&gt; +<br>
&gt; =A0 =A0 =A0tst_resm TINFO &quot;Test #1: restart xinetd with telnet en=
abled.&quot;<br>
&gt; =A0 # install the xinetd config file with telnet enabled.<br>
&gt; =A0 mv $LTPTMP/tst_xinetd.conf.2 /etc/xinetd.conf &gt; $LTPTMP/tst_xin=
etd.err<br>
&gt; 2&gt;&amp;1 \<br>
&gt; @@ -312,7 +367,7 @@ test01()<br>
&gt;<br>
&gt; =A0 # Not checking for exit code from telnet command because telnet is=
<br>
&gt; =A0 # not terminated by the test gracefully.<br>
&gt; - echo &quot; &quot; | telnet localhost &gt; $LTPTMP/tst_xinetd.out 2&=
gt;&amp;1<br>
&gt; + echo &quot; &quot; | $TELNET_COMM 127.0.0.1 &gt; $LTPTMP/tst_xinetd.=
out 2&gt;&amp;1<br>
&gt;<br>
&gt; =A0 diff -iwB $LTPTMP/tst_xinetd.out =A0$LTPTMP/tst_xinetd.exp.2 \<br>
&gt; =A0 &gt; $LTPTMP/tst_xinetd.err 2&gt;&amp;1 || RC=3D$?<br>
&gt; @@ -321,11 +376,24 @@ test01()<br>
&gt; =A0 =A0 =A0 =A0 =A0tst_res TFAIL $LTPTMP/tst_xinetd.err \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;Test #1: expected output differes fro=
m actual. Details:&quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0return $RC<br>
&gt; - else<br>
&gt; - tst_resm TPASS \<br>
&gt; - &quot;Test #1: xinetd reads the config file and starts or stops serv=
ices.&quot;<br>
&gt; =A0 =A0 =A0fi<br>
&gt;<br>
&gt; + if [ $IPV6_ENABLED -eq 1 ]<br>
&gt; + =A0 =A0then<br>
&gt; + =A0 =A0 echo &quot; &quot; | $TELNET_COMM ::1 &gt; $LTPTMP/tst_xinet=
d.out.ipv6 2&gt;&amp;1<br>
&gt; +<br>
&gt; + diff -iwB $LTPTMP/tst_xinetd.out.ipv6 =A0$LTPTMP/tst_xinetd.exp.2.ip=
v6 \<br>
&gt; + &gt; $LTPTMP/tst_xinetd.err.ipv6 2&gt;&amp;1 || RC=3D$?<br>
&gt; + =A0 =A0 if [ $RC -ne 0 ]<br>
&gt; + =A0 =A0 then<br>
&gt; + =A0 =A0 =A0 =A0 tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 &quot;Test #1: expected output differes from=
 actual. Details:&quot;<br>
&gt; + =A0 =A0 =A0 =A0 return $RC<br>
&gt; + =A0 =A0 fi<br>
&gt; + =A0 =A0fi<br>
&gt; +<br>
&gt; + tst_resm TPASS \<br>
&gt; + &quot;Test #1: xinetd reads the config file and starts or stops serv=
ices.&quot;<br>
<br>
</div></div>This will PASS the test anyway. The previous test only pass whe=
n $RC eq 0.<br></blockquote><div><div class=3D"gmail_default" style=3D"font=
-family:simsun,serif;color:rgb(0,0,0)"></div><div class=3D"gmail_default" s=
tyle=3D"font-family:simsun,serif;color:rgb(0,0,0)">

In fact, if $RC -ne 0, the script should exit before this line. So I simply=
 move this line from if statement to here.</div></div><div>=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-=
left:1ex">


<div class=3D"im"><br>
&gt; =A0 =A0 =A0return $RC<br>
&gt; =A0}<br>
&gt;<br>
&gt; --<br>
&gt; 1.8.3.1<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lingyun Xie<br>
<br>
<br>
</div>Regards<br>
<span class=3D""><font color=3D"#888888">Hangbin Liu<br>
<br>
<br>
</font></span></blockquote></div><div class=3D"gmail_default" style=3D"font=
-family:simsun,serif;color:rgb(0,0,0)"></div><div><div dir=3D"ltr"><div><br=
></div><div>Thanks,<br></div></div></div><div class=3D"gmail_default" style=
=3D"font-family:simsun,serif;color:rgb(0,0,0)">

<span style=3D"font-family:arial;color:rgb(34,34,34)">Lingyun Xie</span></d=
iv><br></div></div>

--047d7b15a2d1ab733f04e11ec81d--


--===============1031339443822411656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
--===============1031339443822411656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1031339443822411656==--

