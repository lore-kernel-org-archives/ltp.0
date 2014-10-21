Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gary.robertson@linaro.org>) id 1Xgf6L-0005VS-Tg
	for ltp-list@lists.sourceforge.net; Tue, 21 Oct 2014 19:28:13 +0000
Received: from mail-wg0-f47.google.com ([74.125.82.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Xgf6K-0004zT-Lq
	for ltp-list@lists.sourceforge.net; Tue, 21 Oct 2014 19:28:13 +0000
Received: by mail-wg0-f47.google.com with SMTP id x13so2090175wgg.30
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Oct 2014 12:28:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412111759-22198-1-git-send-email-gary.robertson@linaro.org>
References: <1412111759-22198-1-git-send-email-gary.robertson@linaro.org>
Date: Tue, 21 Oct 2014 14:28:06 -0500
Message-ID: <CAF7YWnwbb1ZGpMSt2VKLsJXOG+MVg-s8P60POTUoPdaUUGhB3g@mail.gmail.com>
From: Gary Robertson <gary.robertson@linaro.org>
Subject: Re: [LTP] [PATCH] Realtime tests: Fix bad priority inheritance
	conditionals
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0337972603252736775=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

--===============0337972603252736775==
Content-Type: multipart/alternative; boundary=089e0149342ca230f70505f3d44b

--089e0149342ca230f70505f3d44b
Content-Type: text/plain; charset=UTF-8

LTP developers,

Just wondered if this patch slipped through the cracks as I have heard no
comments for almost a month.
After floundering about for a long while trying to decipher the
macros-within-macros mysteries of autoconf in an OpenEmbedded build
environment I finally arrived at a proper solution for successfully
building the mutex tests for priority inheritance and robust mutexes.
This patch and its counterpart for robust mutex conditionals are the LTP
part of that solution, and address build-time issues which are not confined
to the OE build environment.

Apologies for all the previous noise and thanks for your forbearance while
I groped for understanding.

Gary Robertson

On Tue, Sep 30, 2014 at 4:15 PM, Gary S. Robertson <
gary.robertson@linaro.org> wrote:

> From: "Gary S. Robertson" <gary.robertson@linaro.org>
>
> testcases/realtime/lib/librttest.c and
> testcases/realtime/stress/pi-tests/testpi-3.c
> both referenced a non-existent autoconf configuration setting variable.
> Replaced the invalid variable name with the variable actually created
> by autoconf.
>
> Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>
> ---
>  testcases/realtime/lib/librttest.c            |    2 +-
>  testcases/realtime/stress/pi-tests/testpi-3.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/realtime/lib/librttest.c
> b/testcases/realtime/lib/librttest.c
> index c175148..3679058 100644
> --- a/testcases/realtime/lib/librttest.c
> +++ b/testcases/realtime/lib/librttest.c
> @@ -586,7 +586,7 @@ void *busy_work_us(int us)
>
>  void init_pi_mutex(pthread_mutex_t * m)
>  {
> -#if HAVE_DECL_PTHREAD_PRIO_INHERIT
> +#if HAS_PRIORITY_INHERIT
>         pthread_mutexattr_t attr;
>         int ret;
>         int protocol;
> diff --git a/testcases/realtime/stress/pi-tests/testpi-3.c
> b/testcases/realtime/stress/pi-tests/testpi-3.c
> index 30f38f6..e483945 100644
> --- a/testcases/realtime/stress/pi-tests/testpi-3.c
> +++ b/testcases/realtime/stress/pi-tests/testpi-3.c
> @@ -365,7 +365,7 @@ int main(int argc, char *argv[])
>
>         printf("Start %s\n", argv[0]);
>
> -#if HAVE_DECL_PTHREAD_PRIO_INHERIT
> +#if HAS_PRIORITY_INHERIT
>         if (!nopi) {
>                 pthread_mutexattr_t mutexattr;
>                 int protocol;
> --
> 1.7.9.5
>
>

--089e0149342ca230f70505f3d44b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>LTP developers,<br><br></div>Just=
 wondered if this patch slipped through the cracks as I have heard no comme=
nts for almost a month.<br></div>After floundering about for a long while t=
rying to decipher the macros-within-macros mysteries of autoconf in an Open=
Embedded build environment I finally arrived at a proper solution for succe=
ssfully building the mutex tests for priority inheritance and robust mutexe=
s.<br></div>This patch and its counterpart for robust mutex conditionals ar=
e the LTP part of that solution, and address build-time issues which are no=
t confined to the OE build environment.<br><br></div>Apologies for all the =
previous noise and thanks for your forbearance while I groped for understan=
ding.<br><br></div>Gary Robertson<br></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Tue, Sep 30, 2014 at 4:15 PM, Gary S. Robertso=
n <span dir=3D"ltr">&lt;<a href=3D"mailto:gary.robertson@linaro.org" target=
=3D"_blank">gary.robertson@linaro.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">From: &quot;Gary S. Robertson&quot; &lt;<a href=3D"mailt=
o:gary.robertson@linaro.org">gary.robertson@linaro.org</a>&gt;<br>
<br>
testcases/realtime/lib/librttest.c and<br>
testcases/realtime/stress/pi-tests/testpi-3.c<br>
both referenced a non-existent autoconf configuration setting variable.<br>
Replaced the invalid variable name with the variable actually created<br>
by autoconf.<br>
<br>
Signed-off-by: Gary S. Robertson &lt;<a href=3D"mailto:gary.robertson@linar=
o.org">gary.robertson@linaro.org</a>&gt;<br>
---<br>
=C2=A0testcases/realtime/lib/librttest.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 2 +-<br>
=C2=A0testcases/realtime/stress/pi-tests/testpi-3.c |=C2=A0 =C2=A0 2 +-<br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/li=
brttest.c<br>
index c175148..3679058 100644<br>
--- a/testcases/realtime/lib/librttest.c<br>
+++ b/testcases/realtime/lib/librttest.c<br>
@@ -586,7 +586,7 @@ void *busy_work_us(int us)<br>
<br>
=C2=A0void init_pi_mutex(pthread_mutex_t * m)<br>
=C2=A0{<br>
-#if HAVE_DECL_PTHREAD_PRIO_INHERIT<br>
+#if HAS_PRIORITY_INHERIT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutexattr_t attr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int protocol;<br>
diff --git a/testcases/realtime/stress/pi-tests/testpi-3.c b/testcases/real=
time/stress/pi-tests/testpi-3.c<br>
index 30f38f6..e483945 100644<br>
--- a/testcases/realtime/stress/pi-tests/testpi-3.c<br>
+++ b/testcases/realtime/stress/pi-tests/testpi-3.c<br>
@@ -365,7 +365,7 @@ int main(int argc, char *argv[])<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Start %s\n&quot;, argv[0]);<br>
<br>
-#if HAVE_DECL_PTHREAD_PRIO_INHERIT<br>
+#if HAS_PRIORITY_INHERIT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!nopi) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutexattr_t=
 mutexattr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int protocol;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.9.5<br>
<br>
</font></span></blockquote></div><br></div>

--089e0149342ca230f70505f3d44b--


--===============0337972603252736775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
--===============0337972603252736775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0337972603252736775==--

