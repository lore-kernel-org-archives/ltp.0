Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1V7N0p-0006YN-7i
	for ltp-list@lists.sourceforge.net; Thu, 08 Aug 2013 10:00:07 +0000
Received: from smtpwcom.263xmail.com ([63.217.87.10])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7N0f-0000Bx-QH
	for ltp-list@lists.sourceforge.net; Thu, 08 Aug 2013 10:00:07 +0000
Received: from mail-pd0-f169.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id AFEC54C1
	for <ltp-list@lists.sourceforge.net>;
	Thu,  8 Aug 2013 17:59:39 +0800 (CST)
Received: by mail-pd0-f169.google.com with SMTP id y11so1921453pdj.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 08 Aug 2013 02:59:46 -0700 (PDT)
MIME-Version: 1.0
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Thu, 8 Aug 2013 17:59:06 +0800
Message-ID: <CALGiYOHZ8qNPSNSwuQ_BQf3L3J=gXbGUgg9Pk45Lke9-ugBueQ@mail.gmail.com>
Subject: [LTP] [PATCH] network/stress/route/route[4,
 6]-redirect: add PATH setting for ip
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3289470256236004530=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?UTF-8?B?5YiY6Iiq5b2s?= <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--===============3289470256236004530==
Content-Type: multipart/alternative; boundary=e89a8f83aa95d067aa04e36cb781

--e89a8f83aa95d067aa04e36cb781
Content-Type: text/plain; charset=ISO-8859-1

ip command is not in default rsh $PATH, add PATH setting for 'ip addr flush'
the same
change
in route4-redirect and route6-redirect

Signed-off-by: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
---
 testcases/network/stress/route/route4-redirect | 2 +-
 testcases/network/stress/route/route6-redirect | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/stress/route/route4-redirect
b/testcases/network/stress/route/route4-redirect
index 9eb8a46..ab6aaf1 100644
--- a/testcases/network/stress/route/route4-redirect
+++ b/testcases/network/stress/route/route4-redirect
@@ -140,7 +140,7 @@ do_setup()

     # Remove the link-local address of the remote host
     sleep 3
-    $LTP_RSH $RHOST "ip addr flush dev $rhost_ifname" > /dev/null
+    $LTP_RSH $RHOST "PATH=/sbin:/usr/sbin:$PATH ip addr flush dev
$rhost_ifname" > /dev/null

     # Assign IPv4 address to the interface of the local host
     set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
diff --git a/testcases/network/stress/route/route6-redirect
b/testcases/network/stress/route/route6-redirect
index 1c31b62..1e8f5df 100644
--- a/testcases/network/stress/route/route6-redirect
+++ b/testcases/network/stress/route/route6-redirect
@@ -137,7 +137,7 @@ do_setup()

     # Remove the link-local address of the remote host
     sleep 5
-    $LTP_RSH $RHOST "ip addr flush dev $rhost_ifname" > /dev/null
+    $LTP_RSH $RHOST "PATH=/sbin:/usr/sbin:$PATH ip addr flush dev
$rhost_ifname" > /dev/null

     # Assign IPv6 address to the interface of the local host
     add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
-- 
1.8.3.1

--e89a8f83aa95d067aa04e36cb781
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_default" style=3D"font-family:sim=
sun,serif;color:rgb(0,0,0);display:inline"></div><font color=3D"#000000" fa=
ce=3D"simsun, serif">ip command is not in default rsh $PATH, add PATH setti=
ng for &#39;ip addr flush&#39;</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">the same <div class=3D"=
gmail_default" style=3D"font-family:simsun,serif;color:rgb(0,0,0);display:i=
nline">change </div>in route4-redirect and route6-redirect</font></div><div=
><font color=3D"#000000" face=3D"simsun, serif"><br>

</font></div><div><font color=3D"#000000" face=3D"simsun, serif">Signed-off=
-by: Xie Lingyun &lt;<a href=3D"mailto:lingyun.xie@bj.cs2c.com.cn">lingyun.=
xie@bj.cs2c.com.cn</a>&gt;</font></div><div><font color=3D"#000000" face=3D=
"simsun, serif">---</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">=A0testcases/network/st=
ress/route/route4-redirect | 2 +-</font></div><div><font color=3D"#000000" =
face=3D"simsun, serif">=A0testcases/network/stress/route/route6-redirect | =
2 +-</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">=A02 files changed, 2 i=
nsertions(+), 2 deletions(-)</font></div><div><font color=3D"#000000" face=
=3D"simsun, serif"><br></font></div><div><font color=3D"#000000" face=3D"si=
msun, serif">diff --git a/testcases/network/stress/route/route4-redirect b/=
testcases/network/stress/route/route4-redirect</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">index 9eb8a46..ab6aaf1 =
100644</font></div><div><font color=3D"#000000" face=3D"simsun, serif">--- =
a/testcases/network/stress/route/route4-redirect</font></div><div><font col=
or=3D"#000000" face=3D"simsun, serif">+++ b/testcases/network/stress/route/=
route4-redirect</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">@@ -140,7 +140,7 @@ do_=
setup()</font></div><div><font color=3D"#000000" face=3D"simsun, serif">=A0=
</font></div><div><font color=3D"#000000" face=3D"simsun, serif">=A0 =A0 =
=A0# Remove the link-local address of the remote host</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">=A0 =A0 =A0sleep 3</fon=
t></div><div><font color=3D"#000000" face=3D"simsun, serif">- =A0 =A0$LTP_R=
SH $RHOST &quot;ip addr flush dev $rhost_ifname&quot; &gt; /dev/null</font>=
</div><div><font color=3D"#000000" face=3D"simsun, serif">+ =A0 =A0$LTP_RSH=
 $RHOST &quot;PATH=3D/sbin:/usr/sbin:$PATH ip addr flush dev $rhost_ifname&=
quot; &gt; /dev/null</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">=A0</font></div><div><f=
ont color=3D"#000000" face=3D"simsun, serif">=A0 =A0 =A0# Assign IPv4 addre=
ss to the interface of the local host</font></div><div><font color=3D"#0000=
00" face=3D"simsun, serif">=A0 =A0 =A0set_ipv4addr lhost ${LINK_NUM} ${IPV4=
_NETWORK} ${LHOST_IPV4_HOST}</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">diff --git a/testcases/=
network/stress/route/route6-redirect b/testcases/network/stress/route/route=
6-redirect</font></div><div><font color=3D"#000000" face=3D"simsun, serif">=
index 1c31b62..1e8f5df 100644</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">--- a/testcases/network=
/stress/route/route6-redirect</font></div><div><font color=3D"#000000" face=
=3D"simsun, serif">+++ b/testcases/network/stress/route/route6-redirect</fo=
nt></div>

<div><font color=3D"#000000" face=3D"simsun, serif">@@ -137,7 +137,7 @@ do_=
setup()</font></div><div><font color=3D"#000000" face=3D"simsun, serif">=A0=
</font></div><div><font color=3D"#000000" face=3D"simsun, serif">=A0 =A0 =
=A0# Remove the link-local address of the remote host</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">=A0 =A0 =A0sleep 5</fon=
t></div><div><font color=3D"#000000" face=3D"simsun, serif">- =A0 =A0$LTP_R=
SH $RHOST &quot;ip addr flush dev $rhost_ifname&quot; &gt; /dev/null</font>=
</div><div><font color=3D"#000000" face=3D"simsun, serif">+ =A0 =A0$LTP_RSH=
 $RHOST &quot;PATH=3D/sbin:/usr/sbin:$PATH ip addr flush dev $rhost_ifname&=
quot; &gt; /dev/null</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">=A0</font></div><div><f=
ont color=3D"#000000" face=3D"simsun, serif">=A0 =A0 =A0# Assign IPv6 addre=
ss to the interface of the local host</font></div><div><font color=3D"#0000=
00" face=3D"simsun, serif">=A0 =A0 =A0add_ipv6addr lhost ${LINK_NUM} ${IPV6=
_NETWORK} ${LHOST_IPV6_HOST}</font></div>

<div><font color=3D"#000000" face=3D"simsun, serif">--=A0</font></div><div>=
<font color=3D"#000000" face=3D"simsun, serif">1.8.3.1</font></div><div><br=
></div></div>

--e89a8f83aa95d067aa04e36cb781--


--===============3289470256236004530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
--===============3289470256236004530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3289470256236004530==--

