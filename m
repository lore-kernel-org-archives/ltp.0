Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PXsRQ-0006DG-76
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:32 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXsRP-0004WR-47
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:32 +0000
Received: by gwaa12 with SMTP id a12so1779190gwa.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 01:35:25 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Dec 2010 17:35:25 +0800
Message-ID: <AANLkTi=GnrruHu=2SnXsuc+xHRhLDy1=54YntB9w+325@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: [LTP]  [Bug Fix] write04 will crash on uClinux platform
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2011473543133207812=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP mailing list <ltp-list@lists.sourceforge.net>

--===============2011473543133207812==
Content-Type: multipart/alternative; boundary=001636ed7256f9ca9b0498894943

--001636ed7256f9ca9b0498894943
Content-Type: text/plain; charset=ISO-8859-1

LTP test case write04 will crash on uClinux platform.

Bellow is the fix:
--
Index: testcases/kernel/syscalls/write/write04.c
===================================================================
--- testcases/kernel/syscalls/write/write04.c
+++ testcases/kernel/syscalls/write/write04.c
@@ -71,6 +71,10 @@
 static sigjmp_buf jmp;
 int rfd, wfd;

+#ifdef UCLINUX
+char *wbuf;
+#endif
+
 int main(int argc, char **argv)
 {
        int lc;
@@ -79,7 +83,9 @@
        struct stat buf;
        int fail;
        int cnt;
+#ifndef UCLINUX
        char wbuf[17 * PIPE_SIZE_TEST];
+#endif
        struct sigaction sigptr;        /* set up signal handler */

        /* parse standard options */
@@ -221,6 +227,17 @@
  */
 void setup(void)
 {
+#ifdef UCLINUX
+       /* Allocate wbuf in heap not in the local function stack */
+       int pagesize = getpagesize();
+
+       wbuf = (char *) malloc(17 * pagesize);
+       if (!wbuf) {
+               tst_resm(TBROK, "malloc failed");
+               cleanup();
+       }
+#endif
+
        /* capture signals */
        tst_sig(FORK, DEF_HANDLER, cleanup);

@@ -244,6 +261,12 @@

 void cleanup()
 {
+
+#ifdef UCLINUX
+       if (wbuf)
+               free(wbuf);
+#endif
+
        /*
         * print errno log if that option was specified.
         */
--


Best regards,
Vivi Li

--001636ed7256f9ca9b0498894943
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

LTP test case write04 will crash on uClinux platform.<br><br>Bellow is the =
fix:<br>--<br>Index: testcases/kernel/syscalls/write/write04.c<br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>--- testcases/kernel/syscalls=
/write/write04.c<br>

+++ testcases/kernel/syscalls/write/write04.c<br>@@ -71,6 +71,10 @@<br>=A0s=
tatic sigjmp_buf jmp;<br>=A0int rfd, wfd;<br><br>+#ifdef UCLINUX<br>+char *=
wbuf;<br>+#endif<br>+<br>=A0int main(int argc, char **argv)<br>=A0{<br>=A0=
=A0=A0=A0=A0=A0=A0 int lc;<br>

@@ -79,7 +83,9 @@<br>=A0=A0=A0=A0=A0=A0=A0 struct stat buf;<br>=A0=A0=A0=A0=
=A0=A0=A0 int fail;<br>=A0=A0=A0=A0=A0=A0=A0 int cnt;<br>+#ifndef UCLINUX<b=
r>=A0=A0=A0=A0=A0=A0=A0 char wbuf[17 * PIPE_SIZE_TEST];<br>+#endif<br>=A0=
=A0=A0=A0=A0=A0=A0 struct sigaction sigptr;=A0=A0=A0=A0=A0=A0=A0 /* set up =
signal handler */<br>

<br>=A0=A0=A0=A0=A0=A0=A0 /* parse standard options */<br>@@ -221,6 +227,17=
 @@<br>=A0 */<br>=A0void setup(void)<br>=A0{<br>+#ifdef UCLINUX<br>+=A0=A0=
=A0=A0=A0=A0 /* Allocate wbuf in heap not in the local function stack */<br=
>+=A0=A0=A0=A0=A0=A0 int pagesize =3D getpagesize();<br>

+<br>+=A0=A0=A0=A0=A0=A0 wbuf =3D (char *) malloc(17 * pagesize);<br>+=A0=
=A0=A0=A0=A0=A0 if (!wbuf) {<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 tst_resm(TBROK, &quot;malloc failed&quot;);<br>+=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 cleanup();<br>+=A0=A0=A0=A0=A0=A0 }<br>+#endif<br>+<br>=
=A0=A0=A0=A0=A0=A0=A0 /* capture signals */<br>

=A0=A0=A0=A0=A0=A0=A0 tst_sig(FORK, DEF_HANDLER, cleanup);<br><br>@@ -244,6=
 +261,12 @@<br><br>=A0void cleanup()<br>=A0{<br>+<br>+#ifdef UCLINUX<br>+=
=A0=A0=A0=A0=A0=A0 if (wbuf)<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 free(wbuf);<br>+#endif<br>+<br>=A0=A0=A0=A0=A0=A0=A0 /*<br>=A0=A0=A0=A0=A0=
=A0=A0=A0 * print errno log if that option was specified.<br>

=A0=A0=A0=A0=A0=A0=A0=A0 */<br>--<br><br><br>Best regards,<br>Vivi Li<br>

--001636ed7256f9ca9b0498894943--


--===============2011473543133207812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============2011473543133207812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2011473543133207812==--

