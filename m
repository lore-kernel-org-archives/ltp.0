Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <aaronwu06@gmail.com>) id 1PX35A-0007wS-57
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 02:45:08 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PX359-0006uz-7V
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 02:45:08 +0000
Received: by bwz10 with SMTP id 10so8776465bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 26 Dec 2010 18:45:01 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 27 Dec 2010 10:45:01 +0800
Message-ID: <AANLkTi=bW=XkPHSqDFmChHYKDjbszCOpfSry+OGvyPX0@mail.gmail.com>
From: Aaron Wu <aaronwu06@gmail.com>
Subject: [LTP] Bug report and fix patch for mount03
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5696190563318119515=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5696190563318119515==
Content-Type: multipart/alternative; boundary=00032555adf28cf9d304985b52e5

--00032555adf28cf9d304985b52e5
Content-Type: text/plain; charset=ISO-8859-1

Hello Sir,

For ltp-full-20101031, met a failure for the mount03 test, following is the
failure log, followed by my fix.

root:/> mount03 -D /dev/sdb1
mount03     1  TBROK  :  stat for setuid_test failed
mount03     2  TBROK  :  Remaining cases broken
mount03     3  TBROK  :  Remaining cases broken
mount03     4  TBROK  :  Remaining cases broken
mount03     5  TBROK  :  Remaining cases broken
mount03     6  TBROK  :  Remaining cases broken


Best regards,
Aaron Wu


--- testcases/kernel/syscalls/mount/mount03.c   2010-12-17
18:46:35.493493377 +0800
+++ testcases/kernel/syscalls/mount/mount03.new.c       2010-12-20
10:57:22.593492676 +0800
@@ -496,7 +496,11 @@
                         "errno = %d : %s", DIR_MODE, TEST_ERRNO,
                         strerror(TEST_ERRNO));
        }
-       snprintf(file, PATH_MAX, "%ssetuid_test", Path_name);
+
+       strcpy(testhome_path, test_home);
+       strcat(testhome_path, "/setuid_test");
+
+       snprintf(file, PATH_MAX, "%s", testhome_path);
        if (stat(file, &setuid_test_stat) < 0) {
                tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
        } else {
@@ -518,9 +522,6 @@
         */
        snprintf(Path_name, PATH_MAX, "%s/%s/", Path_name, mntpoint);
-       strcpy(testhome_path, test_home);
-
-       strcat(testhome_path, "/setuid_test");
        /* Pause if that option was specified */
        TEST_PAUSE;

--00032555adf28cf9d304985b52e5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello Sir,</div>
<div>=A0</div>
<div>For ltp-full-20101031, met a failure for the mount03 test,=A0following=
 is the failure log,=A0followed by my fix.<br>=A0<br>root:/&gt; mount03 -D =
/dev/sdb1<br>mount03=A0=A0=A0=A0 1=A0 TBROK=A0 :=A0 stat for setuid_test fa=
iled<br>mount03=A0=A0=A0=A0 2=A0 TBROK=A0 :=A0 Remaining cases broken<br>
mount03=A0=A0=A0=A0 3=A0 TBROK=A0 :=A0 Remaining cases broken<br>mount03=A0=
=A0=A0=A0 4=A0 TBROK=A0 :=A0 Remaining cases broken<br>mount03=A0=A0=A0=A0 =
5=A0 TBROK=A0 :=A0 Remaining cases broken<br>mount03=A0=A0=A0=A0 6=A0 TBROK=
=A0 :=A0 Remaining cases broken</div>
<div>=A0</div>
<div><br>Best regards,<br>Aaron Wu<br>=A0<br>=A0<br>--- testcases/kernel/sy=
scalls/mount/mount03.c=A0=A0 2010-12-17 18:46:35.493493377 +0800<br>+++ tes=
tcases/kernel/syscalls/mount/mount03.new.c=A0=A0=A0=A0=A0=A0 2010-12-20 10:=
57:22.593492676 +0800<br>
@@ -496,7 +496,11 @@<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 &quot;errno =3D %d : %s&quot;, DIR_MODE, TEST_ERRNO,<=
br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 strerror(TEST_ERRNO));<br>=A0=A0=A0=A0=A0=A0=A0 }<br>-=A0=A0=A0=A0=A0=A0 s=
nprintf(file, PATH_MAX, &quot;%ssetuid_test&quot;, Path_name);<br>
+<br>+=A0=A0=A0=A0=A0=A0 strcpy(testhome_path, test_home);<br>+=A0=A0=A0=A0=
=A0=A0 strcat(testhome_path, &quot;/setuid_test&quot;);<br>+<br>+=A0=A0=A0=
=A0=A0=A0 snprintf(file, PATH_MAX, &quot;%s&quot;, testhome_path);<br>=A0=
=A0=A0=A0=A0=A0=A0 if (stat(file, &amp;setuid_test_stat) &lt; 0) {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_brkm(TBROK, cleanup, &quo=
t;stat for setuid_test failed&quot;);<br>=A0=A0=A0=A0=A0=A0=A0 } else {<br>=
@@ -518,9 +522,6 @@<br>=A0=A0=A0=A0=A0=A0=A0=A0 */<br>=A0=A0=A0=A0=A0=A0=A0=
 snprintf(Path_name, PATH_MAX, &quot;%s/%s/&quot;, Path_name, mntpoint);<br=
>
-=A0=A0=A0=A0=A0=A0 strcpy(testhome_path, test_home);<br>-<br>-=A0=A0=A0=A0=
=A0=A0 strcat(testhome_path, &quot;/setuid_test&quot;);<br>=A0=A0=A0=A0=A0=
=A0=A0 /* Pause if that option was specified */<br>=A0=A0=A0=A0=A0=A0=A0 TE=
ST_PAUSE;</div>

--00032555adf28cf9d304985b52e5--


--===============5696190563318119515==
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
--===============5696190563318119515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5696190563318119515==--

