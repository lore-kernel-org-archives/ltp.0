Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1V7N2r-0006hJ-JT
	for ltp-list@lists.sourceforge.net; Thu, 08 Aug 2013 10:02:13 +0000
Received: from smtpwcom.263xmail.com ([63.217.87.10])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7N2g-0006IK-7p
	for ltp-list@lists.sourceforge.net; Thu, 08 Aug 2013 10:02:13 +0000
Received: from mail-pd0-f172.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id 6719E4F2
	for <ltp-list@lists.sourceforge.net>;
	Thu,  8 Aug 2013 18:01:43 +0800 (CST)
Received: by mail-pd0-f172.google.com with SMTP id z11so2442582pdj.17
	for <ltp-list@lists.sourceforge.net>;
	Thu, 08 Aug 2013 03:01:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALGiYOHZ8qNPSNSwuQ_BQf3L3J=gXbGUgg9Pk45Lke9-ugBueQ@mail.gmail.com>
References: <CALGiYOHZ8qNPSNSwuQ_BQf3L3J=gXbGUgg9Pk45Lke9-ugBueQ@mail.gmail.com>
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Thu, 8 Aug 2013 18:01:10 +0800
Message-ID: <CALGiYOEhfo8=jxYcLOCe0tQjWuS1r1U5Oq7eDYyR0x6n396wcQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] network/stress/route/route[4,
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
Content-Type: multipart/mixed; boundary="===============5333973964671525431=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?UTF-8?B?5YiY6Iiq5b2s?= <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--===============5333973964671525431==
Content-Type: multipart/alternative; boundary=047d7b15a33d2f882c04e36cbfe0

--047d7b15a33d2f882c04e36cbfe0
Content-Type: text/plain; charset=ISO-8859-1

The result is the same of the original version:

<<<test_output>>>
route4-redirect01    0  TINFO  :  Verify the kernel is not crashed when the
IPv4 route is modified by  ICMP Redirects frequently
route4-redirect01    1  TPASS  :  Test is finished correctly.

<<<test_output>>>
incrementing stop
route6-redirect01    0  TINFO  :  Verify the kernel is not crashed when the
IPv6 route is modified by  ICMP Redirects frequently
route6-redirect01    1  TPASS  :  Test is finished correctly.



2013/8/8 Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

> ip command is not in default rsh $PATH, add PATH setting for 'ip addr
> flush'
> the same
> change
> in route4-redirect and route6-redirect
>
> Signed-off-by: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
> ---
>  testcases/network/stress/route/route4-redirect | 2 +-
>  testcases/network/stress/route/route6-redirect | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/network/stress/route/route4-redirect
> b/testcases/network/stress/route/route4-redirect
> index 9eb8a46..ab6aaf1 100644
> --- a/testcases/network/stress/route/route4-redirect
> +++ b/testcases/network/stress/route/route4-redirect
> @@ -140,7 +140,7 @@ do_setup()
>
>      # Remove the link-local address of the remote host
>      sleep 3
> -    $LTP_RSH $RHOST "ip addr flush dev $rhost_ifname" > /dev/null
> +    $LTP_RSH $RHOST "PATH=/sbin:/usr/sbin:$PATH ip addr flush dev
> $rhost_ifname" > /dev/null
>
>      # Assign IPv4 address to the interface of the local host
>      set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
> diff --git a/testcases/network/stress/route/route6-redirect
> b/testcases/network/stress/route/route6-redirect
> index 1c31b62..1e8f5df 100644
> --- a/testcases/network/stress/route/route6-redirect
> +++ b/testcases/network/stress/route/route6-redirect
> @@ -137,7 +137,7 @@ do_setup()
>
>      # Remove the link-local address of the remote host
>      sleep 5
> -    $LTP_RSH $RHOST "ip addr flush dev $rhost_ifname" > /dev/null
> +    $LTP_RSH $RHOST "PATH=/sbin:/usr/sbin:$PATH ip addr flush dev
> $rhost_ifname" > /dev/null
>
>      # Assign IPv6 address to the interface of the local host
>      add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
>  --
> 1.8.3.1
>
>


-- 


Thanks,
Lingyun Xie

--047d7b15a33d2f882c04e36cbfe0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:simsun,s=
erif;color:rgb(0,0,0)">The result is the same of the=A0original version:</d=
iv><div class=3D"gmail_default" style=3D"font-family:simsun,serif;color:rgb=
(0,0,0)">

<br></div><div class=3D"gmail_default"><div class=3D"gmail_default"><font c=
olor=3D"#000000" face=3D"simsun, serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;=
</font></div><div class=3D"gmail_default"><font color=3D"#000000" face=3D"s=
imsun, serif">route4-redirect01 =A0 =A00 =A0TINFO =A0: =A0Verify the kernel=
 is not crashed when the IPv4 route is modified by =A0ICMP Redirects freque=
ntly</font></div>

<div class=3D"gmail_default"><font color=3D"#000000" face=3D"simsun, serif"=
>route4-redirect01 =A0 =A01 =A0TPASS =A0: =A0Test is finished correctly.</f=
ont></div><div class=3D"gmail_default"><font color=3D"#000000" face=3D"sims=
un, serif"><br></font></div>

<div class=3D"gmail_default"><font color=3D"#000000" face=3D"simsun, serif"=
><div class=3D"gmail_default">&lt;&lt;&lt;test_output&gt;&gt;&gt;</div><div=
 class=3D"gmail_default">incrementing stop</div><div class=3D"gmail_default=
">route6-redirect01 =A0 =A00 =A0TINFO =A0: =A0Verify the kernel is not cras=
hed when the IPv6 route is modified by =A0ICMP Redirects frequently</div>

<div class=3D"gmail_default">route6-redirect01 =A0 =A01 =A0TPASS =A0: =A0Te=
st is finished correctly.</div><div class=3D"gmail_default"><br></div></fon=
t></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote"=
>2013/8/8 Xie Lingyun <span dir=3D"ltr">&lt;<a href=3D"mailto:lingyun.xie@b=
j.cs2c.com.cn" target=3D"_blank">lingyun.xie@bj.cs2c.com.cn</a>&gt;</span><=
br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div style=3D"display:=
inline;font-family:simsun,serif"></div><font color=3D"#000000" face=3D"sims=
un, serif">ip command is not in default rsh $PATH, add PATH setting for &#3=
9;ip addr flush&#39;</font></div>


<div><font color=3D"#000000" face=3D"simsun, serif">the same <div style=3D"=
display:inline;font-family:simsun,serif">change </div>in route4-redirect an=
d route6-redirect</font></div><div><font color=3D"#000000" face=3D"simsun, =
serif"><br>


</font></div><div><font color=3D"#000000" face=3D"simsun, serif">Signed-off=
-by: Xie Lingyun &lt;<a href=3D"mailto:lingyun.xie@bj.cs2c.com.cn" target=
=3D"_blank">lingyun.xie@bj.cs2c.com.cn</a>&gt;</font></div><div><font color=
=3D"#000000" face=3D"simsun, serif">---</font></div>


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

<span class=3D"HOEnZb"><font color=3D"#888888">
<div><font color=3D"#000000" face=3D"simsun, serif">--=A0</font></div><div>=
<font color=3D"#000000" face=3D"simsun, serif">1.8.3.1</font></div><div><br=
></div></font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr"><br><div><br></div><div>Thanks,<br>Lingyun Xie</div></div>
</div></div>

--047d7b15a33d2f882c04e36cbfe0--


--===============5333973964671525431==
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
--===============5333973964671525431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5333973964671525431==--

