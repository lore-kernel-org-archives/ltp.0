Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1U8ndK-0004vg-6m
	for ltp-list@lists.sourceforge.net; Fri, 22 Feb 2013 08:05:30 +0000
Received: from mail-wi0-f173.google.com ([209.85.212.173])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1U8ndI-0007rv-UJ
	for ltp-list@lists.sourceforge.net; Fri, 22 Feb 2013 08:05:30 +0000
Received: by mail-wi0-f173.google.com with SMTP id hq4so570613wib.0
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 Feb 2013 00:05:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1349794116-5016-1-git-send-email-liuhangbin@gmail.com>
References: <1349794116-5016-1-git-send-email-liuhangbin@gmail.com>
Date: Fri, 22 Feb 2013 16:05:21 +0800
Message-ID: <CAPwn2JTfyOE_N5W=Tr8PdBcBsUU3cyfTpUVk1-hx31fk-NEMMw@mail.gmail.com>
From: =?GB2312?B?wfW6vbHy?= <liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] testscripts: add appl test in networkstress.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2314347440497714022=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

--===============2314347440497714022==
Content-Type: multipart/alternative; boundary=f46d0442829626b5b504d64ba767

--f46d0442829626b5b504d64ba767
Content-Type: text/plain; charset=ISO-8859-1

Sorry for the less standard subject, I will be careful next time.

2012/10/9 Hangbin Liu <liuhangbin@gmail.com>

> We have network_stress.appl in runtest dir. But we didn't include this
> test in
> networkstress.sh. Add a new parameter to support appl test.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  testscripts/networkstress.sh |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh
> index e04a143..68673f4 100755
> --- a/testscripts/networkstress.sh
> +++ b/testscripts/networkstress.sh
> @@ -59,6 +59,7 @@ usage () {
>      echo "---------------------------------------------------------"
>      echo -e "\033[31m $0 [options] \033[0m "
>      echo "---------------------------------------------------------"
> +    echo " -A|a: Stress test for appl"
>      echo " -E|e: Stress test for interface"
>      echo " -I|i: Stress test for ICMP protocol"
>      echo " -T|t: Stress test for TCP/IP"
> @@ -76,9 +77,10 @@ usage () {
>      exit 1
>  }
>
> -while getopts EeTtIiUuRrMmSsWwBbVvN:n:D:d: OPTION
> +while getopts AaEeTtIiUuRrMmSsWwBbVvN:n:D:d: OPTION
>  do
>      case $OPTION in
> +       A|a) TEST_CASE="network_stress.appl";;
>         E|e) TEST_CASE="network_stress.interface";;
>         B|b) TEST_CASE="network_stress.broken_ip";;
>         I|i) TEST_CASE="network_stress.icmp";;
> --
> 1.7.7.6
>
>

--f46d0442829626b5b504d64ba767
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry for the less standard subject, I will be careful next time.<br><br><d=
iv class=3D"gmail_quote">2012/10/9 Hangbin Liu <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:liuhangbin@gmail.com" target=3D"_blank">liuhangbin@gmail.com</a=
>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">We have network_stress.appl in runtest dir. =
But we didn&#39;t include this test in<br>
networkstress.sh. Add a new parameter to support appl test.<br>
<br>
Signed-off-by: Hangbin Liu &lt;<a href=3D"mailto:liuhangbin@gmail.com">liuh=
angbin@gmail.com</a>&gt;<br>
---<br>
=A0testscripts/networkstress.sh | =A0 =A04 +++-<br>
=A01 files changed, 3 insertions(+), 1 deletions(-)<br>
<br>
diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh<br=
>
index e04a143..68673f4 100755<br>
--- a/testscripts/networkstress.sh<br>
+++ b/testscripts/networkstress.sh<br>
@@ -59,6 +59,7 @@ usage () {<br>
=A0 =A0 =A0echo &quot;-----------------------------------------------------=
----&quot;<br>
=A0 =A0 =A0echo -e &quot;\033[31m $0 [options] \033[0m &quot;<br>
=A0 =A0 =A0echo &quot;-----------------------------------------------------=
----&quot;<br>
+ =A0 =A0echo &quot; -A|a: Stress test for appl&quot;<br>
=A0 =A0 =A0echo &quot; -E|e: Stress test for interface&quot;<br>
=A0 =A0 =A0echo &quot; -I|i: Stress test for ICMP protocol&quot;<br>
=A0 =A0 =A0echo &quot; -T|t: Stress test for TCP/IP&quot;<br>
@@ -76,9 +77,10 @@ usage () {<br>
=A0 =A0 =A0exit 1<br>
=A0}<br>
<br>
-while getopts EeTtIiUuRrMmSsWwBbVvN:n:D:d: OPTION<br>
+while getopts AaEeTtIiUuRrMmSsWwBbVvN:n:D:d: OPTION<br>
=A0do<br>
=A0 =A0 =A0case $OPTION in<br>
+ =A0 =A0 =A0 A|a) TEST_CASE=3D&quot;network_stress.appl&quot;;;<br>
=A0 =A0 =A0 =A0 E|e) TEST_CASE=3D&quot;network_stress.interface&quot;;;<br>
=A0 =A0 =A0 =A0 B|b) TEST_CASE=3D&quot;network_stress.broken_ip&quot;;;<br>
=A0 =A0 =A0 =A0 I|i) TEST_CASE=3D&quot;network_stress.icmp&quot;;;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.7.6<br>
<br>
</font></span></blockquote></div><br>

--f46d0442829626b5b504d64ba767--


--===============2314347440497714022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
--===============2314347440497714022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2314347440497714022==--

