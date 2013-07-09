Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1UwRFf-0006XZ-C4
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 06:18:15 +0000
Received: from smtpwcom.263xmail.com ([63.217.87.10])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwRFX-0001tK-72
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 06:18:15 +0000
Received: from mail-pa0-f50.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id 58F2A502
	for <ltp-list@lists.sourceforge.net>;
	Tue,  9 Jul 2013 14:17:47 +0800 (CST)
Received: by mail-pa0-f50.google.com with SMTP id fb1so5134771pad.23
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Jul 2013 23:17:51 -0700 (PDT)
MIME-Version: 1.0
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Tue, 9 Jul 2013 14:17:10 +0800
Message-ID: <CALGiYOHjLdA=roRGqztO1HjHSvy+=Je7LK-Zi2LTQMsKU5Z=1g@mail.gmail.com>
Content-Type: multipart/mixed; boundary=047d7b6d850ced804004e10e1e83
Subject: [LTP] [PATCH v2] xinetd/xinetd_tests.sh: add IPv6 test for xinetd
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--047d7b6d850ced804004e10e1e83
Content-Type: multipart/alternative; boundary=047d7b6d850ced803c04e10e1e81

--047d7b6d850ced803c04e10e1e81
Content-Type: text/plain; charset=ISO-8859-1

If IPv6 is enabled, telnet ::1 will be tested. Otherwise, IPv4 only.

Signed-off-by: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
---
 testcases/network/xinetd/xinetd_tests.sh | 90
++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 11 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh
b/testcases/network/xinetd/xinetd_tests.sh
index 83eb8a7..0fb6598 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -84,12 +84,23 @@ init()
          return $RC
     fi

+ # sometimes the default telnet may be /usr/kerberos/bin/telnet
+ TELNET_COMM='/usr/bin/telnet'
+
     # check if commands tst_*, xinetd, awk exists.
     chk_ifexists INIT tst_resm   || return $RC
     chk_ifexists INIT xinetd     || return $RC
     chk_ifexists INIT diff       || return $RC
-    chk_ifexists INIT telnet     || return $RC
-
+    chk_ifexists INIT $TELNET_COMM     || return $RC
+    chk_ifexists INIT ip || return $RC
+
+    IPV6_ENABLED=0
+    ip a | grep inet6 > /dev/null 2>&1
+    if [ $? -eq 0 ]
+    then
+     IPV6_ENABLED=1
+    fi
+
  # Create custom xinetd.conf file.
  # tst_xinetd.conf.1 config file has telnet service disabled.
  cat > $LTPTMP/tst_xinetd.conf.1 <<-EOF || RC=$?
@@ -128,7 +139,7 @@ init()

     # Create expected file with telnet disabled.
     cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
- telnet: Unable to connect to remote host: Connection refused
+ telnet: connect to address 127.0.0.1: Connection refused
  EOF

     if [ $RC -ne 0 ]
@@ -137,11 +148,25 @@ init()
             "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1"
         return $RC
     fi
+
+    if [ $IPV6_ENABLED -eq 1 ]
+    then
+     cat > $LTPTMP/tst_xinetd.exp.1.ipv6 <<-EOF || RC=$?
+ telnet: connect to address ::1: Connection refused
+ EOF
+
+     if [ $RC -ne 0 ]
+   then
+         tst_brkm TBROK  NULL \
+             "INIT: unable to create expected file
$LTPTMP/tst_xinetd.exp.1.ipv6"
+         return $RC
+     fi
+    fi

     # Create expected file with telnet enabled.
  cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
  Trying 127.0.0.1...
- Connected to localhost (127.0.0.1).
+ Connected to 127.0.0.1.
  Escape character is '^]'.
  Connection closed by foreign host.
  EOF
@@ -149,10 +174,27 @@ init()
     if [ $RC -ne 0 ]
     then
         tst_brkm TBROK  NULL \
-            "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1"
+            "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.2"
         return $RC
     fi

+ if [ $IPV6_ENABLED -eq 1 ]
+    then
+     cat > $LTPTMP/tst_xinetd.exp.2.ipv6 <<-EOF || RC=$?
+ Trying ::1...
+ Connected to ::1.
+ Escape character is '^]'.
+ Connection closed by foreign host.
+ EOF
+
+     if [ $RC -ne 0 ]
+     then
+         tst_brkm TBROK  NULL \
+             "INIT: unable to create expected file
$LTPTMP/tst_xinetd.exp.2.ipv6"
+         return $RC
+     fi
+    fi
+
     return $RC
 }

@@ -263,7 +305,7 @@ test01()

  # Not checking for exit code from telnet command because telnet is
  # not terminated by the test gracefully.
- echo " " | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
+ echo " " | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
  diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
  > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
     if [ $RC -ne 0 ]
@@ -272,7 +314,20 @@ test01()
             "Test #1: with telnet diabled expected out differs RC=$RC.
Details:"
         return $RC
     fi
-
+
+    if [ $IPV6_ENABLED -eq 1 ]
+    then
+     echo " " | $TELNET_COMM ::1 2>$LTPTMP/tst_xinetd.out.ipv6 1>/dev/null
+ diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.1.ipv6 \
+ > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
+     if [ $RC -ne 0 ]
+     then
+         tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
+             "Test #1: with telnet diabled of IPv6 expected out differs
RC=$RC. Details:"
+         return $RC
+     fi
+    fi
+
     tst_resm TINFO "Test #1: restart xinetd with telnet enabled."
  # install the xinetd config file with telnet enabled.
  mv $LTPTMP/tst_xinetd.conf.2 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err
2>&1 \
@@ -312,7 +367,7 @@ test01()

  # Not checking for exit code from telnet command because telnet is
  # not terminated by the test gracefully.
- echo " " | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
+ echo " " | $TELNET_COMM 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1

  diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
  > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
@@ -321,11 +376,24 @@ test01()
         tst_res TFAIL $LTPTMP/tst_xinetd.err \
             "Test #1: expected output differes from actual. Details:"
         return $RC
- else
- tst_resm TPASS \
- "Test #1: xinetd reads the config file and starts or stops services."
     fi

+ if [ $IPV6_ENABLED -eq 1 ]
+    then
+     echo " " | $TELNET_COMM ::1 > $LTPTMP/tst_xinetd.out.ipv6 2>&1
+
+ diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.2.ipv6 \
+ > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
+     if [ $RC -ne 0 ]
+     then
+         tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
+             "Test #1: expected output differes from actual. Details:"
+         return $RC
+     fi
+    fi
+
+ tst_resm TPASS \
+ "Test #1: xinetd reads the config file and starts or stops services."
     return $RC
 }

-- 
1.8.3.1



Thanks,
Lingyun Xie

--047d7b6d850ced803c04e10e1e81
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default"><span style=3D"color:rgb(0,0,=
0);font-family:simsun,serif">If IPv6 is enabled, telnet ::1 will be tested.=
 Otherwise, IPv4 only.</span><br></div><div class=3D"gmail_default"><font c=
olor=3D"#000000" face=3D"simsun, serif"><div class=3D"gmail_default">

<br></div><div class=3D"gmail_default">Signed-off-by: Xie Lingyun &lt;<a hr=
ef=3D"mailto:lingyun.xie@bj.cs2c.com.cn">lingyun.xie@bj.cs2c.com.cn</a>&gt;=
</div><div class=3D"gmail_default">---</div><div class=3D"gmail_default">=
=A0testcases/network/xinetd/xinetd_tests.sh | 90 ++++++++++++++++++++++++++=
++----</div>

<div class=3D"gmail_default">=A01 file changed, 79 insertions(+), 11 deleti=
ons(-)</div><div class=3D"gmail_default"><br></div><div class=3D"gmail_defa=
ult">diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/netw=
ork/xinetd/xinetd_tests.sh</div>

<div class=3D"gmail_default">index 83eb8a7..0fb6598 100755</div><div class=
=3D"gmail_default">--- a/testcases/network/xinetd/xinetd_tests.sh</div><div=
 class=3D"gmail_default">+++ b/testcases/network/xinetd/xinetd_tests.sh</di=
v>
<div class=3D"gmail_default">
@@ -84,12 +84,23 @@ init()</div><div class=3D"gmail_default">=A0 =A0 =A0 =
=A0 =A0 return $RC</div><div class=3D"gmail_default">=A0 =A0 =A0fi</div><di=
v class=3D"gmail_default">=A0</div><div class=3D"gmail_default">+<span clas=
s=3D"" style=3D"white-space:pre">	</span># sometimes the default telnet may=
 be /usr/kerberos/bin/telnet</div>

<div class=3D"gmail_default">+<span class=3D"" style=3D"white-space:pre">	<=
/span>TELNET_COMM=3D&#39;/usr/bin/telnet&#39;</div><div class=3D"gmail_defa=
ult">+<span class=3D"" style=3D"white-space:pre">	</span></div><div class=
=3D"gmail_default">

=A0 =A0 =A0# check if commands tst_*, xinetd, awk exists.</div><div class=
=3D"gmail_default">=A0 =A0 =A0chk_ifexists INIT tst_resm =A0 || return $RC<=
/div><div class=3D"gmail_default">=A0 =A0 =A0chk_ifexists INIT xinetd =A0 =
=A0 || return $RC</div><div class=3D"gmail_default">

=A0 =A0 =A0chk_ifexists INIT diff =A0 =A0 =A0 || return $RC</div><div class=
=3D"gmail_default">- =A0 =A0chk_ifexists INIT telnet =A0 =A0 || return $RC<=
/div><div class=3D"gmail_default">-</div><div class=3D"gmail_default">+ =A0=
 =A0chk_ifexists INIT $TELNET_COMM =A0 =A0 || return $RC</div>

<div class=3D"gmail_default">+ =A0 =A0chk_ifexists INIT ip<span class=3D"" =
style=3D"white-space:pre">		</span> || return $RC</div><div class=3D"gmail_=
default">+ =A0 =A0</div><div class=3D"gmail_default">+ =A0 =A0IPV6_ENABLED=
=3D0</div><div class=3D"gmail_default">

+ =A0 =A0ip a | grep inet6 &gt; /dev/null 2&gt;&amp;1</div><div class=3D"gm=
ail_default">+ =A0 =A0if [ $? -eq 0 ]</div><div class=3D"gmail_default">+ =
=A0 =A0then</div><div class=3D"gmail_default">+ =A0 =A0<span class=3D"" sty=
le=3D"white-space:pre">	</span>IPV6_ENABLED=3D1</div>

<div class=3D"gmail_default">+ =A0 =A0fi</div><div class=3D"gmail_default">=
+ =A0 =A0</div><div class=3D"gmail_default">=A0<span class=3D"" style=3D"wh=
ite-space:pre">	</span># Create custom xinetd.conf file.</div><div class=3D=
"gmail_default">=A0<span class=3D"" style=3D"white-space:pre">	</span># tst=
_xinetd.conf.1 config file has telnet service disabled.</div>

<div class=3D"gmail_default">=A0<span class=3D"" style=3D"white-space:pre">=
	</span>cat &gt; $LTPTMP/tst_xinetd.conf.1 &lt;&lt;-EOF || RC=3D$?</div><di=
v class=3D"gmail_default">@@ -128,7 +139,7 @@ init()</div><div class=3D"gma=
il_default">

=A0</div><div class=3D"gmail_default">=A0 =A0 =A0# Create expected file wit=
h telnet disabled.</div><div class=3D"gmail_default">=A0 =A0 =A0cat &gt; $L=
TPTMP/tst_xinetd.exp.1 &lt;&lt;-EOF || RC=3D$?</div><div class=3D"gmail_def=
ault">-<span class=3D"" style=3D"white-space:pre">	</span>telnet: Unable to=
 connect to remote host: Connection refused</div>

<div class=3D"gmail_default">+<span class=3D"" style=3D"white-space:pre">	<=
/span>telnet: connect to address <a href=3D"http://127.0.0.1">127.0.0.1</a>=
: Connection refused</div><div class=3D"gmail_default">=A0<span class=3D"" =
style=3D"white-space:pre">	</span>EOF</div>

<div class=3D"gmail_default">=A0</div><div class=3D"gmail_default">=A0 =A0 =
=A0if [ $RC -ne 0 ]</div><div class=3D"gmail_default">@@ -137,11 +148,25 @@=
 init()</div><div class=3D"gmail_default">=A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;=
INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1&quot;</div>

<div class=3D"gmail_default">=A0 =A0 =A0 =A0 =A0return $RC</div><div class=
=3D"gmail_default">=A0 =A0 =A0fi</div><div class=3D"gmail_default">+ =A0 =
=A0</div><div class=3D"gmail_default">+ =A0 =A0if [ $IPV6_ENABLED -eq 1 ]</=
div><div class=3D"gmail_default">

+ =A0 =A0then</div><div class=3D"gmail_default">+ =A0 =A0<span class=3D"" s=
tyle=3D"white-space:pre">	</span>cat &gt; $LTPTMP/tst_xinetd.exp.1.ipv6 &lt=
;&lt;-EOF || RC=3D$?</div><div class=3D"gmail_default">+<span class=3D"" st=
yle=3D"white-space:pre">		</span>telnet: connect to address ::1: Connection=
 refused</div>

<div class=3D"gmail_default">+<span class=3D"" style=3D"white-space:pre">		=
</span>EOF</div><div class=3D"gmail_default">+</div><div class=3D"gmail_def=
ault">+ =A0 =A0<span class=3D"" style=3D"white-space:pre">	</span>if [ $RC =
-ne 0 ]</div>
<div class=3D"gmail_default">
+ =A0 <span class=3D"" style=3D"white-space:pre">		</span>then</div><div cl=
ass=3D"gmail_default">+ =A0 =A0 =A0 =A0<span class=3D"" style=3D"white-spac=
e:pre">	</span>tst_brkm TBROK =A0NULL \</div><div class=3D"gmail_default">+=
 =A0 =A0 =A0 =A0 =A0 =A0<span class=3D"" style=3D"white-space:pre">	</span>=
&quot;INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1.ipv6&qu=
ot;</div>

<div class=3D"gmail_default">+ =A0 =A0 =A0 =A0<span class=3D"" style=3D"whi=
te-space:pre">	</span>return $RC</div><div class=3D"gmail_default">+ =A0 =
=A0<span class=3D"" style=3D"white-space:pre">	</span>fi</div><div class=3D=
"gmail_default">+ =A0 =A0fi</div>

<div class=3D"gmail_default">=A0</div><div class=3D"gmail_default">=A0 =A0 =
=A0# Create expected file with telnet enabled.</div><div class=3D"gmail_def=
ault">=A0<span class=3D"" style=3D"white-space:pre">	</span>cat &gt; $LTPTM=
P/tst_xinetd.exp.2 &lt;&lt;-EOF || RC=3D$?</div>

<div class=3D"gmail_default">=A0<span class=3D"" style=3D"white-space:pre">=
	</span>Trying 127.0.0.1...</div><div class=3D"gmail_default">-<span class=
=3D"" style=3D"white-space:pre">	</span>Connected to localhost (127.0.0.1).=
</div><div class=3D"gmail_default">

+<span class=3D"" style=3D"white-space:pre">	</span>Connected to 127.0.0.1.=
</div><div class=3D"gmail_default">=A0<span class=3D"" style=3D"white-space=
:pre">	</span>Escape character is &#39;^]&#39;.</div><div class=3D"gmail_de=
fault">=A0<span class=3D"" style=3D"white-space:pre">	</span>Connection clo=
sed by foreign host.</div>

<div class=3D"gmail_default">=A0<span class=3D"" style=3D"white-space:pre">=
	</span>EOF</div><div class=3D"gmail_default">@@ -149,10 +174,27 @@ init()<=
/div><div class=3D"gmail_default">=A0 =A0 =A0if [ $RC -ne 0 ]</div><div cla=
ss=3D"gmail_default">

=A0 =A0 =A0then</div><div class=3D"gmail_default">=A0 =A0 =A0 =A0 =A0tst_br=
km TBROK =A0NULL \</div><div class=3D"gmail_default">- =A0 =A0 =A0 =A0 =A0 =
=A0&quot;INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1&quot=
;</div><div class=3D"gmail_default">

+ =A0 =A0 =A0 =A0 =A0 =A0&quot;INIT: unable to create expected file $LTPTMP=
/tst_xinetd.exp.2&quot;</div><div class=3D"gmail_default">=A0 =A0 =A0 =A0 =
=A0return $RC</div><div class=3D"gmail_default">=A0 =A0 =A0fi</div><div cla=
ss=3D"gmail_default">=A0</div><div class=3D"gmail_default">

+<span class=3D"" style=3D"white-space:pre">	</span>if [ $IPV6_ENABLED -eq =
1 ]</div><div class=3D"gmail_default">+ =A0 =A0then</div><div class=3D"gmai=
l_default">+ =A0 =A0<span class=3D"" style=3D"white-space:pre">	</span>cat =
&gt; $LTPTMP/tst_xinetd.exp.2.ipv6 &lt;&lt;-EOF || RC=3D$?</div>

<div class=3D"gmail_default">+<span class=3D"" style=3D"white-space:pre">		=
</span>Trying ::1...</div><div class=3D"gmail_default">+<span class=3D"" st=
yle=3D"white-space:pre">		</span>Connected to ::1.</div><div class=3D"gmail=
_default">

+<span class=3D"" style=3D"white-space:pre">		</span>Escape character is &#=
39;^]&#39;.</div><div class=3D"gmail_default">+<span class=3D"" style=3D"wh=
ite-space:pre">		</span>Connection closed by foreign host.</div><div class=
=3D"gmail_default">

+<span class=3D"" style=3D"white-space:pre">		</span>EOF</div><div class=3D=
"gmail_default">+</div><div class=3D"gmail_default">+ =A0 =A0<span class=3D=
"" style=3D"white-space:pre">	</span>if [ $RC -ne 0 ]</div><div class=3D"gm=
ail_default">
+ =A0 =A0<span class=3D"" style=3D"white-space:pre">	</span>then</div>
<div class=3D"gmail_default">+ =A0 =A0 =A0 =A0<span class=3D"" style=3D"whi=
te-space:pre">	</span>tst_brkm TBROK =A0NULL \</div><div class=3D"gmail_def=
ault">+ =A0 =A0 =A0 =A0 =A0 =A0<span class=3D"" style=3D"white-space:pre">	=
</span>&quot;INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.2.=
ipv6&quot;</div>

<div class=3D"gmail_default">+ =A0 =A0 =A0 =A0<span class=3D"" style=3D"whi=
te-space:pre">	</span>return $RC</div><div class=3D"gmail_default">+ =A0 =
=A0<span class=3D"" style=3D"white-space:pre">	</span>fi</div><div class=3D=
"gmail_default">+ =A0 =A0fi</div>

<div class=3D"gmail_default">+</div><div class=3D"gmail_default">=A0 =A0 =
=A0return $RC</div><div class=3D"gmail_default">=A0}</div><div class=3D"gma=
il_default">=A0</div><div class=3D"gmail_default">@@ -263,7 +305,7 @@ test0=
1()</div><div class=3D"gmail_default">

=A0</div><div class=3D"gmail_default">=A0<span class=3D"" style=3D"white-sp=
ace:pre">	</span># Not checking for exit code from telnet command because t=
elnet is</div><div class=3D"gmail_default">=A0<span class=3D"" style=3D"whi=
te-space:pre">	</span># not terminated by the test gracefully.</div>

<div class=3D"gmail_default">-<span class=3D"" style=3D"white-space:pre">	<=
/span>echo &quot; &quot; | telnet localhost 2&gt;$LTPTMP/tst_xinetd.out 1&g=
t;/dev/null</div><div class=3D"gmail_default">+<span class=3D"" style=3D"wh=
ite-space:pre">	</span>echo &quot; &quot; | $TELNET_COMM 127.0.0.1 2&gt;$LT=
PTMP/tst_xinetd.out 1&gt;/dev/null</div>

<div class=3D"gmail_default">=A0<span class=3D"" style=3D"white-space:pre">=
	</span>diff -iwB $LTPTMP/tst_xinetd.out =A0$LTPTMP/tst_xinetd.exp.1 \</div=
><div class=3D"gmail_default">=A0<span class=3D"" style=3D"white-space:pre"=
>		</span>&gt; $LTPTMP/tst_xinetd.err 2&gt;&amp;1 || RC=3D$?</div>

<div class=3D"gmail_default">=A0 =A0 =A0if [ $RC -ne 0 ]</div><div class=3D=
"gmail_default">@@ -272,7 +314,20 @@ test01()</div><div class=3D"gmail_defa=
ult">=A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;Test #1: with telnet diabled expected=
 out differs RC=3D$RC. Details:&quot;</div>

<div class=3D"gmail_default">=A0 =A0 =A0 =A0 =A0return $RC</div><div class=
=3D"gmail_default">=A0 =A0 =A0fi</div><div class=3D"gmail_default">-</div><=
div class=3D"gmail_default">+ =A0 =A0</div><div class=3D"gmail_default">+ =
=A0 =A0if [ $IPV6_ENABLED -eq 1 ]</div>

<div class=3D"gmail_default">+ =A0 =A0then</div><div class=3D"gmail_default=
">+ =A0 =A0<span class=3D"" style=3D"white-space:pre">	</span>echo &quot; &=
quot; | $TELNET_COMM ::1 2&gt;$LTPTMP/tst_xinetd.out.ipv6 1&gt;/dev/null</d=
iv><div class=3D"gmail_default">

+<span class=3D"" style=3D"white-space:pre">		</span>diff -iwB $LTPTMP/tst_=
xinetd.out.ipv6 =A0$LTPTMP/tst_xinetd.exp.1.ipv6 \</div><div class=3D"gmail=
_default">+<span class=3D"" style=3D"white-space:pre">			</span>&gt; $LTPTM=
P/tst_xinetd.err.ipv6 2&gt;&amp;1 || RC=3D$?</div>

<div class=3D"gmail_default">+ =A0 =A0<span class=3D"" style=3D"white-space=
:pre">	</span>if [ $RC -ne 0 ]</div><div class=3D"gmail_default">+ =A0 =A0<=
span class=3D"" style=3D"white-space:pre">	</span>then</div><div class=3D"g=
mail_default">+ =A0 =A0 =A0 =A0<span class=3D"" style=3D"white-space:pre">	=
</span>tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \</div>

<div class=3D"gmail_default">+ =A0 =A0 =A0 =A0 =A0 =A0<span class=3D"" styl=
e=3D"white-space:pre">	</span>&quot;Test #1: with telnet diabled of IPv6 ex=
pected out differs RC=3D$RC. Details:&quot;</div><div class=3D"gmail_defaul=
t">+ =A0 =A0 =A0 =A0<span class=3D"" style=3D"white-space:pre">	</span>retu=
rn $RC</div>

<div class=3D"gmail_default">+ =A0 =A0<span class=3D"" style=3D"white-space=
:pre">	</span>fi</div><div class=3D"gmail_default">+ =A0 =A0fi</div><div cl=
ass=3D"gmail_default">+ =A0 =A0</div><div class=3D"gmail_default">=A0 =A0 =
=A0tst_resm TINFO &quot;Test #1: restart xinetd with telnet enabled.&quot;<=
/div>

<div class=3D"gmail_default">=A0<span class=3D"" style=3D"white-space:pre">=
	</span># install the xinetd config file with telnet enabled.</div><div cla=
ss=3D"gmail_default">=A0<span class=3D"" style=3D"white-space:pre">	</span>=
mv $LTPTMP/tst_xinetd.conf.2 /etc/xinetd.conf &gt; $LTPTMP/tst_xinetd.err 2=
&gt;&amp;1 \</div>

<div class=3D"gmail_default">@@ -312,7 +367,7 @@ test01()</div><div class=
=3D"gmail_default">=A0</div><div class=3D"gmail_default">=A0<span class=3D"=
" style=3D"white-space:pre">	</span># Not checking for exit code from telne=
t command because telnet is</div>

<div class=3D"gmail_default">=A0<span class=3D"" style=3D"white-space:pre">=
	</span># not terminated by the test gracefully.</div><div class=3D"gmail_d=
efault">-<span class=3D"" style=3D"white-space:pre">	</span>echo &quot; &qu=
ot; | telnet localhost &gt; $LTPTMP/tst_xinetd.out 2&gt;&amp;1</div>

<div class=3D"gmail_default">+<span class=3D"" style=3D"white-space:pre">	<=
/span>echo &quot; &quot; | $TELNET_COMM 127.0.0.1 &gt; $LTPTMP/tst_xinetd.o=
ut 2&gt;&amp;1</div><div class=3D"gmail_default">=A0</div><div class=3D"gma=
il_default">

=A0<span class=3D"" style=3D"white-space:pre">	</span>diff -iwB $LTPTMP/tst=
_xinetd.out =A0$LTPTMP/tst_xinetd.exp.2 \</div><div class=3D"gmail_default"=
>=A0<span class=3D"" style=3D"white-space:pre">		</span>&gt; $LTPTMP/tst_xi=
netd.err 2&gt;&amp;1 || RC=3D$?</div>

<div class=3D"gmail_default">@@ -321,11 +376,24 @@ test01()</div><div class=
=3D"gmail_default">=A0 =A0 =A0 =A0 =A0tst_res TFAIL $LTPTMP/tst_xinetd.err =
\</div><div class=3D"gmail_default">=A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;Test #=
1: expected output differes from actual. Details:&quot;</div>

<div class=3D"gmail_default">=A0 =A0 =A0 =A0 =A0return $RC</div><div class=
=3D"gmail_default">-<span class=3D"" style=3D"white-space:pre">	</span>else=
</div><div class=3D"gmail_default">-<span class=3D"" style=3D"white-space:p=
re">		</span>tst_resm TPASS \</div>

<div class=3D"gmail_default">-<span class=3D"" style=3D"white-space:pre">		=
</span>&quot;Test #1: xinetd reads the config file and starts or stops serv=
ices.&quot;</div><div class=3D"gmail_default">=A0 =A0 =A0fi</div><div class=
=3D"gmail_default">

=A0</div><div class=3D"gmail_default">+<span class=3D"" style=3D"white-spac=
e:pre">	</span>if [ $IPV6_ENABLED -eq 1 ]</div><div class=3D"gmail_default"=
>+ =A0 =A0then</div><div class=3D"gmail_default">+ =A0 =A0<span class=3D"" =
style=3D"white-space:pre">	</span>echo &quot; &quot; | $TELNET_COMM ::1 &gt=
; $LTPTMP/tst_xinetd.out.ipv6 2&gt;&amp;1</div>

<div class=3D"gmail_default">+</div><div class=3D"gmail_default">+<span cla=
ss=3D"" style=3D"white-space:pre">		</span>diff -iwB $LTPTMP/tst_xinetd.out=
.ipv6 =A0$LTPTMP/tst_xinetd.exp.2.ipv6 \</div><div class=3D"gmail_default">=
+<span class=3D"" style=3D"white-space:pre">			</span>&gt; $LTPTMP/tst_xine=
td.err.ipv6 2&gt;&amp;1 || RC=3D$?</div>

<div class=3D"gmail_default">+ =A0 =A0<span class=3D"" style=3D"white-space=
:pre">	</span>if [ $RC -ne 0 ]</div><div class=3D"gmail_default">+ =A0 =A0<=
span class=3D"" style=3D"white-space:pre">	</span>then</div><div class=3D"g=
mail_default">+ =A0 =A0 =A0 =A0<span class=3D"" style=3D"white-space:pre">	=
</span>tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \</div>

<div class=3D"gmail_default">+ =A0 =A0 =A0 =A0 =A0 =A0<span class=3D"" styl=
e=3D"white-space:pre">	</span>&quot;Test #1: expected output differes from =
actual. Details:&quot;</div><div class=3D"gmail_default">+ =A0 =A0 =A0 =A0<=
span class=3D"" style=3D"white-space:pre">	</span>return $RC</div>

<div class=3D"gmail_default">+ =A0 =A0<span class=3D"" style=3D"white-space=
:pre">	</span>fi</div><div class=3D"gmail_default">+ =A0 =A0fi</div><div cl=
ass=3D"gmail_default">+</div><div class=3D"gmail_default">+<span class=3D""=
 style=3D"white-space:pre">	</span>tst_resm TPASS \</div>

<div class=3D"gmail_default">+<span class=3D"" style=3D"white-space:pre">		=
</span>&quot;Test #1: xinetd reads the config file and starts or stops serv=
ices.&quot;</div><div class=3D"gmail_default">=A0 =A0 =A0return $RC</div><d=
iv class=3D"gmail_default">

=A0}</div><div class=3D"gmail_default">=A0</div><div class=3D"gmail_default=
">--=A0</div><div class=3D"gmail_default">1.8.3.1</div></font></div><div cl=
ass=3D"gmail_extra"><br clear=3D"all"><div><div dir=3D"ltr"><br><div><br></=
div><div>Thanks,<br>

Lingyun Xie<div class=3D"gmail_default" style=3D"font-family:simsun,serif;c=
olor:rgb(0,0,0);display:inline"></div></div></div></div></div></div>

--047d7b6d850ced803c04e10e1e81--

--047d7b6d850ced804004e10e1e83
Content-Type: application/octet-stream; 
	name="0001-xinetd-xinetd_tests.sh-add-IPv6-test-for-xinetd.patch"
Content-Disposition: attachment; 
	filename="0001-xinetd-xinetd_tests.sh-add-IPv6-test-for-xinetd.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hiwpf3iq0

RnJvbSBiMDZiNmIyM2IxNWRhMWE0NWEwMWM2MTUwOTIxZTg4YzVhZThjOGNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBtZWxsb253YW5kIDxtZWxsb253YW5kQGdtYWlsLmNvbT4KRGF0
ZTogVHVlLCA5IEp1bCAyMDEzIDEyOjQyOjI5ICswODAwClN1YmplY3Q6IFtQQVRDSF0geGluZXRk
L3hpbmV0ZF90ZXN0cy5zaDogYWRkIElQdjYgdGVzdCBmb3IgeGluZXRkCgpJZiBJUHY2IGlzIGVu
YWJsZWQsIHRlbG5ldCA6OjEgd2lsbCBiZSB0ZXN0ZWQuIE90aGVyd2lzZSwgSVB2NCBvbmx5LgoK
U2lnbmVkLW9mZi1ieTogWGllIExpbmd5dW4gPGxpbmd5dW4ueGllQGJqLmNzMmMuY29tLmNuPgot
LS0KIHRlc3RjYXNlcy9uZXR3b3JrL3hpbmV0ZC94aW5ldGRfdGVzdHMuc2ggfCA5MCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDc5IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9uZXR3b3JrL3hpbmV0
ZC94aW5ldGRfdGVzdHMuc2ggYi90ZXN0Y2FzZXMvbmV0d29yay94aW5ldGQveGluZXRkX3Rlc3Rz
LnNoCmluZGV4IDgzZWI4YTcuLjBmYjY1OTggMTAwNzU1Ci0tLSBhL3Rlc3RjYXNlcy9uZXR3b3Jr
L3hpbmV0ZC94aW5ldGRfdGVzdHMuc2gKKysrIGIvdGVzdGNhc2VzL25ldHdvcmsveGluZXRkL3hp
bmV0ZF90ZXN0cy5zaApAQCAtODQsMTIgKzg0LDIzIEBAIGluaXQoKQogICAgICAgICAgcmV0dXJu
ICRSQwogICAgIGZpCiAKKwkjIHNvbWV0aW1lcyB0aGUgZGVmYXVsdCB0ZWxuZXQgbWF5IGJlIC91
c3Iva2VyYmVyb3MvYmluL3RlbG5ldAorCVRFTE5FVF9DT01NPScvdXNyL2Jpbi90ZWxuZXQnCisJ
CiAgICAgIyBjaGVjayBpZiBjb21tYW5kcyB0c3RfKiwgeGluZXRkLCBhd2sgZXhpc3RzLgogICAg
IGNoa19pZmV4aXN0cyBJTklUIHRzdF9yZXNtICAgfHwgcmV0dXJuICRSQwogICAgIGNoa19pZmV4
aXN0cyBJTklUIHhpbmV0ZCAgICAgfHwgcmV0dXJuICRSQwogICAgIGNoa19pZmV4aXN0cyBJTklU
IGRpZmYgICAgICAgfHwgcmV0dXJuICRSQwotICAgIGNoa19pZmV4aXN0cyBJTklUIHRlbG5ldCAg
ICAgfHwgcmV0dXJuICRSQwotCisgICAgY2hrX2lmZXhpc3RzIElOSVQgJFRFTE5FVF9DT01NICAg
ICB8fCByZXR1cm4gJFJDCisgICAgY2hrX2lmZXhpc3RzIElOSVQgaXAJCSB8fCByZXR1cm4gJFJD
CisgICAgCisgICAgSVBWNl9FTkFCTEVEPTAKKyAgICBpcCBhIHwgZ3JlcCBpbmV0NiA+IC9kZXYv
bnVsbCAyPiYxCisgICAgaWYgWyAkPyAtZXEgMCBdCisgICAgdGhlbgorICAgIAlJUFY2X0VOQUJM
RUQ9MQorICAgIGZpCisgICAgCiAJIyBDcmVhdGUgY3VzdG9tIHhpbmV0ZC5jb25mIGZpbGUuCiAJ
IyB0c3RfeGluZXRkLmNvbmYuMSBjb25maWcgZmlsZSBoYXMgdGVsbmV0IHNlcnZpY2UgZGlzYWJs
ZWQuCiAJY2F0ID4gJExUUFRNUC90c3RfeGluZXRkLmNvbmYuMSA8PC1FT0YgfHwgUkM9JD8KQEAg
LTEyOCw3ICsxMzksNyBAQCBpbml0KCkKIAogICAgICMgQ3JlYXRlIGV4cGVjdGVkIGZpbGUgd2l0
aCB0ZWxuZXQgZGlzYWJsZWQuCiAgICAgY2F0ID4gJExUUFRNUC90c3RfeGluZXRkLmV4cC4xIDw8
LUVPRiB8fCBSQz0kPwotCXRlbG5ldDogVW5hYmxlIHRvIGNvbm5lY3QgdG8gcmVtb3RlIGhvc3Q6
IENvbm5lY3Rpb24gcmVmdXNlZAorCXRlbG5ldDogY29ubmVjdCB0byBhZGRyZXNzIDEyNy4wLjAu
MTogQ29ubmVjdGlvbiByZWZ1c2VkCiAJRU9GCiAKICAgICBpZiBbICRSQyAtbmUgMCBdCkBAIC0x
MzcsMTEgKzE0OCwyNSBAQCBpbml0KCkKICAgICAgICAgICAgICJJTklUOiB1bmFibGUgdG8gY3Jl
YXRlIGV4cGVjdGVkIGZpbGUgJExUUFRNUC90c3RfeGluZXRkLmV4cC4xIgogICAgICAgICByZXR1
cm4gJFJDCiAgICAgZmkKKyAgICAKKyAgICBpZiBbICRJUFY2X0VOQUJMRUQgLWVxIDEgXQorICAg
IHRoZW4KKyAgICAJY2F0ID4gJExUUFRNUC90c3RfeGluZXRkLmV4cC4xLmlwdjYgPDwtRU9GIHx8
IFJDPSQ/CisJCXRlbG5ldDogY29ubmVjdCB0byBhZGRyZXNzIDo6MTogQ29ubmVjdGlvbiByZWZ1
c2VkCisJCUVPRgorCisgICAgCWlmIFsgJFJDIC1uZSAwIF0KKyAgIAkJdGhlbgorICAgICAgICAJ
dHN0X2Jya20gVEJST0sgIE5VTEwgXAorICAgICAgICAgICAgCSJJTklUOiB1bmFibGUgdG8gY3Jl
YXRlIGV4cGVjdGVkIGZpbGUgJExUUFRNUC90c3RfeGluZXRkLmV4cC4xLmlwdjYiCisgICAgICAg
IAlyZXR1cm4gJFJDCisgICAgCWZpCisgICAgZmkKIAogICAgICMgQ3JlYXRlIGV4cGVjdGVkIGZp
bGUgd2l0aCB0ZWxuZXQgZW5hYmxlZC4KIAljYXQgPiAkTFRQVE1QL3RzdF94aW5ldGQuZXhwLjIg
PDwtRU9GIHx8IFJDPSQ/CiAJVHJ5aW5nIDEyNy4wLjAuMS4uLgotCUNvbm5lY3RlZCB0byBsb2Nh
bGhvc3QgKDEyNy4wLjAuMSkuCisJQ29ubmVjdGVkIHRvIDEyNy4wLjAuMS4KIAlFc2NhcGUgY2hh
cmFjdGVyIGlzICdeXScuCiAJQ29ubmVjdGlvbiBjbG9zZWQgYnkgZm9yZWlnbiBob3N0LgogCUVP
RgpAQCAtMTQ5LDEwICsxNzQsMjcgQEAgaW5pdCgpCiAgICAgaWYgWyAkUkMgLW5lIDAgXQogICAg
IHRoZW4KICAgICAgICAgdHN0X2Jya20gVEJST0sgIE5VTEwgXAotICAgICAgICAgICAgIklOSVQ6
IHVuYWJsZSB0byBjcmVhdGUgZXhwZWN0ZWQgZmlsZSAkTFRQVE1QL3RzdF94aW5ldGQuZXhwLjEi
CisgICAgICAgICAgICAiSU5JVDogdW5hYmxlIHRvIGNyZWF0ZSBleHBlY3RlZCBmaWxlICRMVFBU
TVAvdHN0X3hpbmV0ZC5leHAuMiIKICAgICAgICAgcmV0dXJuICRSQwogICAgIGZpCiAKKwlpZiBb
ICRJUFY2X0VOQUJMRUQgLWVxIDEgXQorICAgIHRoZW4KKyAgICAJY2F0ID4gJExUUFRNUC90c3Rf
eGluZXRkLmV4cC4yLmlwdjYgPDwtRU9GIHx8IFJDPSQ/CisJCVRyeWluZyA6OjEuLi4KKwkJQ29u
bmVjdGVkIHRvIDo6MS4KKwkJRXNjYXBlIGNoYXJhY3RlciBpcyAnXl0nLgorCQlDb25uZWN0aW9u
IGNsb3NlZCBieSBmb3JlaWduIGhvc3QuCisJCUVPRgorCisgICAgCWlmIFsgJFJDIC1uZSAwIF0K
KyAgICAJdGhlbgorICAgICAgICAJdHN0X2Jya20gVEJST0sgIE5VTEwgXAorICAgICAgICAgICAg
CSJJTklUOiB1bmFibGUgdG8gY3JlYXRlIGV4cGVjdGVkIGZpbGUgJExUUFRNUC90c3RfeGluZXRk
LmV4cC4yLmlwdjYiCisgICAgICAgIAlyZXR1cm4gJFJDCisgICAgCWZpCisgICAgZmkKKwogICAg
IHJldHVybiAkUkMKIH0KIApAQCAtMjYzLDcgKzMwNSw3IEBAIHRlc3QwMSgpCiAKIAkjIE5vdCBj
aGVja2luZyBmb3IgZXhpdCBjb2RlIGZyb20gdGVsbmV0IGNvbW1hbmQgYmVjYXVzZSB0ZWxuZXQg
aXMKIAkjIG5vdCB0ZXJtaW5hdGVkIGJ5IHRoZSB0ZXN0IGdyYWNlZnVsbHkuCi0JZWNobyAiBCIg
fCB0ZWxuZXQgbG9jYWxob3N0IDI+JExUUFRNUC90c3RfeGluZXRkLm91dCAxPi9kZXYvbnVsbAor
CWVjaG8gIgQiIHwgJFRFTE5FVF9DT01NIDEyNy4wLjAuMSAyPiRMVFBUTVAvdHN0X3hpbmV0ZC5v
dXQgMT4vZGV2L251bGwKIAlkaWZmIC1pd0IgJExUUFRNUC90c3RfeGluZXRkLm91dCAgJExUUFRN
UC90c3RfeGluZXRkLmV4cC4xIFwKIAkJPiAkTFRQVE1QL3RzdF94aW5ldGQuZXJyIDI+JjEgfHwg
UkM9JD8KICAgICBpZiBbICRSQyAtbmUgMCBdCkBAIC0yNzIsNyArMzE0LDIwIEBAIHRlc3QwMSgp
CiAgICAgICAgICAgICAiVGVzdCAjMTogd2l0aCB0ZWxuZXQgZGlhYmxlZCBleHBlY3RlZCBvdXQg
ZGlmZmVycyBSQz0kUkMuIERldGFpbHM6IgogICAgICAgICByZXR1cm4gJFJDCiAgICAgZmkKLQor
ICAgIAorICAgIGlmIFsgJElQVjZfRU5BQkxFRCAtZXEgMSBdCisgICAgdGhlbgorICAgIAllY2hv
ICIEIiB8ICRURUxORVRfQ09NTSA6OjEgMj4kTFRQVE1QL3RzdF94aW5ldGQub3V0LmlwdjYgMT4v
ZGV2L251bGwKKwkJZGlmZiAtaXdCICRMVFBUTVAvdHN0X3hpbmV0ZC5vdXQuaXB2NiAgJExUUFRN
UC90c3RfeGluZXRkLmV4cC4xLmlwdjYgXAorCQkJPiAkTFRQVE1QL3RzdF94aW5ldGQuZXJyLmlw
djYgMj4mMSB8fCBSQz0kPworICAgIAlpZiBbICRSQyAtbmUgMCBdCisgICAgCXRoZW4KKyAgICAg
ICAgCXRzdF9yZXMgVEZBSUwgJExUUFRNUC90c3RfeGluZXRkLmVyci5pcHY2IFwKKyAgICAgICAg
ICAgIAkiVGVzdCAjMTogd2l0aCB0ZWxuZXQgZGlhYmxlZCBvZiBJUHY2IGV4cGVjdGVkIG91dCBk
aWZmZXJzIFJDPSRSQy4gRGV0YWlsczoiCisgICAgICAgIAlyZXR1cm4gJFJDCisgICAgCWZpCisg
ICAgZmkKKyAgICAKICAgICB0c3RfcmVzbSBUSU5GTyAiVGVzdCAjMTogcmVzdGFydCB4aW5ldGQg
d2l0aCB0ZWxuZXQgZW5hYmxlZC4iCiAJIyBpbnN0YWxsIHRoZSB4aW5ldGQgY29uZmlnIGZpbGUg
d2l0aCB0ZWxuZXQgZW5hYmxlZC4KIAltdiAkTFRQVE1QL3RzdF94aW5ldGQuY29uZi4yIC9ldGMv
eGluZXRkLmNvbmYgPiAkTFRQVE1QL3RzdF94aW5ldGQuZXJyIDI+JjEgXApAQCAtMzEyLDcgKzM2
Nyw3IEBAIHRlc3QwMSgpCiAKIAkjIE5vdCBjaGVja2luZyBmb3IgZXhpdCBjb2RlIGZyb20gdGVs
bmV0IGNvbW1hbmQgYmVjYXVzZSB0ZWxuZXQgaXMKIAkjIG5vdCB0ZXJtaW5hdGVkIGJ5IHRoZSB0
ZXN0IGdyYWNlZnVsbHkuCi0JZWNobyAiBCIgfCB0ZWxuZXQgbG9jYWxob3N0ID4gJExUUFRNUC90
c3RfeGluZXRkLm91dCAyPiYxCisJZWNobyAiBCIgfCAkVEVMTkVUX0NPTU0gMTI3LjAuMC4xID4g
JExUUFRNUC90c3RfeGluZXRkLm91dCAyPiYxCiAKIAlkaWZmIC1pd0IgJExUUFRNUC90c3RfeGlu
ZXRkLm91dCAgJExUUFRNUC90c3RfeGluZXRkLmV4cC4yIFwKIAkJPiAkTFRQVE1QL3RzdF94aW5l
dGQuZXJyIDI+JjEgfHwgUkM9JD8KQEAgLTMyMSwxMSArMzc2LDI0IEBAIHRlc3QwMSgpCiAgICAg
ICAgIHRzdF9yZXMgVEZBSUwgJExUUFRNUC90c3RfeGluZXRkLmVyciBcCiAgICAgICAgICAgICAi
VGVzdCAjMTogZXhwZWN0ZWQgb3V0cHV0IGRpZmZlcmVzIGZyb20gYWN0dWFsLiBEZXRhaWxzOiIK
ICAgICAgICAgcmV0dXJuICRSQwotCWVsc2UKLQkJdHN0X3Jlc20gVFBBU1MgXAotCQkiVGVzdCAj
MTogeGluZXRkIHJlYWRzIHRoZSBjb25maWcgZmlsZSBhbmQgc3RhcnRzIG9yIHN0b3BzIHNlcnZp
Y2VzLiIKICAgICBmaQogCisJaWYgWyAkSVBWNl9FTkFCTEVEIC1lcSAxIF0KKyAgICB0aGVuCisg
ICAgCWVjaG8gIgQiIHwgJFRFTE5FVF9DT01NIDo6MSA+ICRMVFBUTVAvdHN0X3hpbmV0ZC5vdXQu
aXB2NiAyPiYxCisKKwkJZGlmZiAtaXdCICRMVFBUTVAvdHN0X3hpbmV0ZC5vdXQuaXB2NiAgJExU
UFRNUC90c3RfeGluZXRkLmV4cC4yLmlwdjYgXAorCQkJPiAkTFRQVE1QL3RzdF94aW5ldGQuZXJy
LmlwdjYgMj4mMSB8fCBSQz0kPworICAgIAlpZiBbICRSQyAtbmUgMCBdCisgICAgCXRoZW4KKyAg
ICAgICAgCXRzdF9yZXMgVEZBSUwgJExUUFRNUC90c3RfeGluZXRkLmVyci5pcHY2IFwKKyAgICAg
ICAgICAgIAkiVGVzdCAjMTogZXhwZWN0ZWQgb3V0cHV0IGRpZmZlcmVzIGZyb20gYWN0dWFsLiBE
ZXRhaWxzOiIKKyAgICAgICAgCXJldHVybiAkUkMKKyAgICAJZmkKKyAgICBmaQorCisJdHN0X3Jl
c20gVFBBU1MgXAorCQkiVGVzdCAjMTogeGluZXRkIHJlYWRzIHRoZSBjb25maWcgZmlsZSBhbmQg
c3RhcnRzIG9yIHN0b3BzIHNlcnZpY2VzLiIKICAgICByZXR1cm4gJFJDCiB9CiAKLS0gCjEuOC4z
LjEKCg==
--047d7b6d850ced804004e10e1e83
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
--047d7b6d850ced804004e10e1e83
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--047d7b6d850ced804004e10e1e83--

