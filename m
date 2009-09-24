Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1MquvW-00043n-Uf
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 20:28:30 +0000
Received: from mail-yx0-f198.google.com ([209.85.210.198])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MquvP-0004Nu-30
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 20:28:30 +0000
Received: by yxe36 with SMTP id 36so2569428yxe.11
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2009 13:28:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200909241229.32866.chandru@in.ibm.com>
References: <200909241229.32866.chandru@in.ibm.com>
Date: Thu, 24 Sep 2009 13:28:17 -0700
Message-ID: <b9d696240909241328p25fdc8dcrac4f8bbfa4adad23@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: Re: [LTP] [PATCH] ppoll01: add signal() syscall to register the
	signal handler
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6377939257368379663=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Chandru <chandru@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

--===============6377939257368379663==
Content-Type: multipart/alternative; boundary=001636c597c3f46d62047458ab43

--001636c597c3f46d62047458ab43
Content-Type: text/plain; charset=ISO-8859-1

I applied this patch, and it fixed ppoll01 on an Ubuntu Hardy box which had
been failing. Kernel is 2.6.24.

Kelly

On Wed, Sep 23, 2009 at 11:59 PM, Chandru <chandru@in.ibm.com> wrote:

> The ppoll01 testcase has a signal handler in it but this signal handler is
> not registered with the kernel through the signal() syscal. The testcase
> fails when it sends a SIGINT to itself as part of one of the case of the
> test run.
> The following patch
> 1. Adds a signal() syscall to register the signal handler
> 2. Corrects the expected 'revents' for the case where ppoll() is called on
> a file which is only opened in read/write mode, i.e case00.
> 3. Takes away printing the type of error ( i.e strerror(errno) ) since it
> only prints the last error seen and does not report the failures seen in the
> cases before the last failed one. The reporting of NG or OK shoudl take care
> of
>    letting the user know the cases that have passed and cases that have
> failed.
>
> Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
> ---
>
> --- ppoll01.c.orig      2009-09-22 19:22:39.371235396 +0530
> +++ ppoll01.c   2009-09-24 01:24:38.706487228 +0530
> @@ -106,6 +106,8 @@ extern void cleanup() {
>         tst_exit();
>  }
>
> +void sighandler(int sig);       /* signals handler function for the test
> */
> +
>  /* Local  Functions */
>
>  /******************************************************************************/
>  /*
>    */
> @@ -125,7 +127,8 @@ extern void cleanup() {
>  /*
>    */
>
>  /******************************************************************************/
>  void setup() {
> -        /* Capture signals if any */
> +        /* Capture signals*/
> +       signal(SIGINT, &sighandler);
>         /* Create temporary directories */
>         TEST_PAUSE;
>         tst_tmpdir();
> @@ -191,7 +194,7 @@ struct test_case {
>  static struct test_case tcase[] = {
>        { // case00
>                 .ttype          = NORMAL,
> -                .expect_revents = POLLOUT,
> +                .expect_revents = POLLOUT | POLLIN,
>                 .ret            = 0,
>                 .err            = 0,
>         },
> @@ -463,7 +466,7 @@ int main(int ac, char **av) {
>                                break;
>
>                default:
> -                               tst_resm(TFAIL, "%s failed - errno = %d :
> %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
> +                               tst_resm(TFAIL, "%s failed", TCID);
>                                RPRINTF("NG");
>                                cleanup();
>                                tst_exit();
>
>
>
>
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
K.D. Lucas
kdlucas@gmail.com

--001636c597c3f46d62047458ab43
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I applied this patch, and it fixed ppoll01 on an Ubuntu Hardy box which had=
 been failing. Kernel is 2.6.24.<br><br>Kelly<br><br><div class=3D"gmail_qu=
ote">On Wed, Sep 23, 2009 at 11:59 PM, Chandru <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:chandru@in.ibm.com">chandru@in.ibm.com</a>&gt;</span> wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The ppoll01 testc=
ase has a signal handler in it but this signal handler is not registered wi=
th the kernel through the signal() syscal. The testcase fails when it sends=
 a SIGINT to itself as part of one of the case of the test run.<br>

The following patch<br>
1. Adds a signal() syscall to register the signal handler<br>
2. Corrects the expected &#39;revents&#39; for the case where ppoll() is ca=
lled on a file which is only opened in read/write mode, i.e case00.<br>
3. Takes away printing the type of error ( i.e strerror(errno) ) since it o=
nly prints the last error seen and does not report the failures seen in the=
 cases before the last failed one. The reporting of NG or OK shoudl take ca=
re of<br>

 =A0 =A0letting the user know the cases that have passed and cases that hav=
e failed.<br>
<br>
Signed-off-by: Chandru S &lt;<a href=3D"mailto:chandru@linux.vnet.ibm.com">=
chandru@linux.vnet.ibm.com</a>&gt;<br>
---<br>
<br>
--- ppoll01.c.orig =A0 =A0 =A02009-09-22 19:22:39.371235396 +0530<br>
+++ ppoll01.c =A0 2009-09-24 01:24:38.706487228 +0530<br>
@@ -106,6 +106,8 @@ extern void cleanup() {<br>
 =A0 =A0 =A0 =A0 tst_exit();<br>
=A0}<br>
<br>
+void sighandler(int sig); =A0 =A0 =A0 /* signals handler function for the =
test */<br>
+<br>
=A0/* Local =A0Functions */<br>
=A0/***********************************************************************=
*******/<br>
=A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*/<br>
@@ -125,7 +127,8 @@ extern void cleanup() {<br>
=A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*/<br>
=A0/***********************************************************************=
*******/<br>
=A0void setup() {<br>
- =A0 =A0 =A0 =A0/* Capture signals if any */<br>
+ =A0 =A0 =A0 =A0/* Capture signals*/<br>
+ =A0 =A0 =A0 signal(SIGINT, &amp;sighandler);<br>
 =A0 =A0 =A0 =A0 /* Create temporary directories */<br>
 =A0 =A0 =A0 =A0 TEST_PAUSE;<br>
 =A0 =A0 =A0 =A0 tst_tmpdir();<br>
@@ -191,7 +194,7 @@ struct test_case {<br>
=A0static struct test_case tcase[] =3D {<br>
 =A0 =A0 =A0 =A0{ // case00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ttype =A0 =A0 =A0 =A0 =A0=3D NORMAL,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.expect_revents =3D POLLOUT,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.expect_revents =3D POLLOUT | POLLIN,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0=3D 0,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .err =A0 =A0 =A0 =A0 =A0 =A0=3D 0,<br>
 =A0 =A0 =A0 =A0 },<br>
@@ -463,7 +466,7 @@ int main(int ac, char **av) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAI=
L, &quot;%s failed - errno =3D %d : %s&quot;, TCID, TEST_ERRNO, strerror(TE=
ST_ERRNO));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAI=
L, &quot;%s failed&quot;, TCID);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RPRINTF(&qu=
ot;NG&quot;);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();<=
br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();=
<br>
<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Come build with us! The BlackBerry&amp;reg; Developer Conference in SF, CA<=
br>
is the only developer event you need to attend this year. Jumpstart your<br=
>
developing skills, take BlackBerry mobile applications to market and stay<b=
r>
ahead of the curve. Join us from November 9&amp;#45;12, 2009. Register now&=
amp;#33;<br>
<a href=3D"http://p.sf.net/sfu/devconf" target=3D"_blank">http://p.sf.net/s=
fu/devconf</a><br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>K.D. Lucas<br><a href=
=3D"mailto:kdlucas@gmail.com">kdlucas@gmail.com</a><br>

--001636c597c3f46d62047458ab43--


--===============6377939257368379663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--===============6377939257368379663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6377939257368379663==--

