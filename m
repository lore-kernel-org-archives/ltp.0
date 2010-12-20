Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <aaronwu06@gmail.com>) id 1PUVyA-0006DT-J4
	for ltp-list@lists.sourceforge.net; Mon, 20 Dec 2010 02:59:26 +0000
Received: from mail-bw0-f45.google.com ([209.85.214.45])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUVy9-0002cX-M8
	for ltp-list@lists.sourceforge.net; Mon, 20 Dec 2010 02:59:26 +0000
Received: by bwz16 with SMTP id 16so2881709bwz.4
	for <ltp-list@lists.sourceforge.net>;
	Sun, 19 Dec 2010 18:59:19 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 20 Dec 2010 10:59:19 +0800
Message-ID: <AANLkTikgX9-9fjDMLn_-ZfMhFWWWVp1H4QsbrchcRCS2@mail.gmail.com>
From: Aaron Wu <aaronwu06@gmail.com>
Subject: [LTP] patch for testcases/kernel/syscalls/mount/mount03.c for
	ltp-full-20101031
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7280080596457401308=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7280080596457401308==
Content-Type: multipart/alternative; boundary=0016364991e7d2c6790497ceb41d

--0016364991e7d2c6790497ceb41d
Content-Type: text/plain; charset=ISO-8859-1

For ltp-full-20101031, for fail log:

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

--0016364991e7d2c6790497ceb41d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>For ltp-full-20101031, for fail log:</div>
<div>=A0</div>
<div>root:/&gt; mount03 -D /dev/sdb1<br>mount03=A0=A0=A0=A0 1=A0 TBROK=A0 :=
=A0 stat for setuid_test failed<br>mount03=A0=A0=A0=A0 2=A0 TBROK=A0 :=A0 R=
emaining cases broken<br>mount03=A0=A0=A0=A0 3=A0 TBROK=A0 :=A0 Remaining c=
ases broken<br>mount03=A0=A0=A0=A0 4=A0 TBROK=A0 :=A0 Remaining cases broke=
n<br>
mount03=A0=A0=A0=A0 5=A0 TBROK=A0 :=A0 Remaining cases broken<br>mount03=A0=
=A0=A0=A0 6=A0 TBROK=A0 :=A0 Remaining cases broken<br></div>
<div>=A0</div>
<div>Best regards,</div>
<div>Aaron Wu</div>
<div>=A0</div>
<div>=A0</div>
<div>--- testcases/kernel/syscalls/mount/mount03.c=A0=A0 2010-12-17 18:46:3=
5.493493377 +0800<br>+++ testcases/kernel/syscalls/mount/mount03.new.c=A0=
=A0=A0=A0=A0=A0 2010-12-20 10:57:22.593492676 +0800<br>@@ -496,7 +496,11 @@=
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 &quot;errno =3D %d : %s&quot;, DIR_MODE, TEST_ERRNO,<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
rerror(TEST_ERRNO));<br>=A0=A0=A0=A0=A0=A0=A0 }<br>-=A0=A0=A0=A0=A0=A0 snpr=
intf(file, PATH_MAX, &quot;%ssetuid_test&quot;, Path_name);<br>+<br>+=A0=A0=
=A0=A0=A0=A0 strcpy(testhome_path, test_home);<br>+=A0=A0=A0=A0=A0=A0 strca=
t(testhome_path, &quot;/setuid_test&quot;);<br>
+<br>+=A0=A0=A0=A0=A0=A0 snprintf(file, PATH_MAX, &quot;%s&quot;, testhome_=
path);<br>=A0=A0=A0=A0=A0=A0=A0 if (stat(file, &amp;setuid_test_stat) &lt; =
0) {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_brkm(TBROK, clean=
up, &quot;stat for setuid_test failed&quot;);<br>=A0=A0=A0=A0=A0=A0=A0 } el=
se {<br>
@@ -518,9 +522,6 @@<br>=A0=A0=A0=A0=A0=A0=A0=A0 */<br>=A0=A0=A0=A0=A0=A0=A0=
 snprintf(Path_name, PATH_MAX, &quot;%s/%s/&quot;, Path_name, mntpoint);</d=
iv>
<p>-=A0=A0=A0=A0=A0=A0 strcpy(testhome_path, test_home);<br>-<br>-=A0=A0=A0=
=A0=A0=A0 strcat(testhome_path, &quot;/setuid_test&quot;);</p>
<p>=A0=A0=A0=A0=A0=A0=A0 /* Pause if that option was specified */<br>=A0=A0=
=A0=A0=A0=A0=A0 TEST_PAUSE;</p>

--0016364991e7d2c6790497ceb41d--


--===============7280080596457401308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
--===============7280080596457401308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7280080596457401308==--

