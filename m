Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sachinp@in.ibm.com>) id 1MMg7T-0006Xf-6G
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 10:35:51 +0000
Received: from e28smtp06.in.ibm.com ([59.145.155.6])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMg7S-0007UG-3H
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 10:35:51 +0000
Message-ID: <4A4DDEFD.1050506@in.ibm.com>
Date: Fri, 03 Jul 2009 16:05:41 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060600060105070908090306"
Subject: [LTP] [PATCH] Fix Security/Filecaps Build failure.
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
To: serue@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net

This is a multi-part message in MIME format.
--------------060600060105070908090306
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e28smtp06.in.ibm.com id
	n63AZhiA019308

Fix Filecaps build break.
=20
inh_capped.c:70: error: too many arguments to function =91tst_exit=92

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

thanks
-Sachin


--------------060600060105070908090306
Content-Type: text/x-patch;
 name="fix-june-ltp-filecaps-build-break.patch"
Content-Disposition: inline; filename="fix-june-ltp-filecaps-build-break.patch"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e28smtp06.in.ibm.com id
	n63AZhiA019308

Fix Filecaps build break.
=20
inh_capped.c:70: error: too many arguments to function =E2=80=98tst_exit=E2=
=80=99

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/testcases/kernel/security/filecaps/inh_capped.c b/testcases=
/kernel/security/filecaps/inh_capped.c
--- a/testcases/kernel/security/filecaps/inh_capped.c	2008-01-23 19:15:04=
.000000000 +0530
+++ b/testcases/kernel/security/filecaps/inh_capped.c	2009-07-03 15:21:02=
.000000000 +0530
@@ -67,14 +67,14 @@ int main()
 	debug_print_caps("after raising all caps");
 	if (ret) {
 		tst_resm(TFAIL, "failed to raise all caps");
-		tst_exit(ret);
+		tst_exit();
 	}
=20
 	ret =3D set_caps_from_text("all=3Diep cap_sys_admin-iep");
 	debug_print_caps("after first drop cap_sys_admin");
 	if (ret) {
 		tst_resm(TFAIL, "failed to drop capsysadmin from pI");
-		tst_exit(ret);
+		tst_exit();
 	}
=20
 	/* we can't regain cap_sys_admin in pE or pP, only pI */
@@ -82,14 +82,14 @@ int main()
 	debug_print_caps("after first raise cap_sys_admin");
 	if (ret) {
 		tst_resm(TFAIL, "failed to raise capsysadmin in pI");
-		tst_exit(ret);
+		tst_exit();
 	}
=20
 	ret =3D set_caps_from_text("all=3Dip cap_setpcap-e+ip cap_sys_admin+i-e=
p");
 	debug_print_caps("after drop cappset");
 	if (ret) {
 		tst_resm(TFAIL, "failed to drop cappset from pE");
-		tst_exit(ret);
+		tst_exit();
 	}
=20
 	ret =3D set_caps_from_text("all=3Diep cap_sys_admin-iep cap_setpcap-e+i=
p");
@@ -97,17 +97,17 @@ int main()
 	if (ret) {
 		tst_resm(TFAIL, "failed to drop capsysadmin from pI "
 				"after dropping cappset from pE");
-		tst_exit(ret);
+		tst_exit();
 	}
=20
 	ret =3D set_caps_from_text("all=3Diep cap_sys_admin-ep+i cap_setpcap-e+=
ip");
 	debug_print_caps("final");
 	if (ret) {
 		tst_resm(TPASS, "pI is properly capped\n");
-		tst_exit(0);
+		tst_exit();
 	}
=20
 	tst_resm(TFAIL, "succeeded raising capsysadmin in pI "
 			"without having setpcap");
-	tst_exit(ret);
+	tst_exit();
 }
diff -Naurp a/testcases/kernel/security/filecaps/verify_caps_exec.c b/tes=
tcases/kernel/security/filecaps/verify_caps_exec.c
--- a/testcases/kernel/security/filecaps/verify_caps_exec.c	2008-09-30 15=
:00:56.000000000 +0530
+++ b/testcases/kernel/security/filecaps/verify_caps_exec.c	2009-07-03 15=
:21:38.000000000 +0530
@@ -54,7 +54,7 @@ void usage(char *me)
 	tst_resm(TFAIL, "Usage: %s <0|1> [arg]\n", me);
 	tst_resm(TINFO, "  0: set file caps without privilege\n");
 	tst_resm(TINFO, "  1: test that file caps are set correctly on exec\n")=
;
-	tst_exit(1);
+	tst_exit();
 }
=20
 #define DROP_PERMS 0
@@ -79,7 +79,7 @@ int drop_root(int keep_perms)
 	if (ret) {
 		perror("setresuid");
 		tst_resm(TFAIL, "Error dropping root privs\n");
-		tst_exit(4);
+		tst_exit();
 	}
 	if (keep_perms) {
 		cap_t cap =3D cap_from_text("=3Deip");
@@ -123,7 +123,7 @@ void create_fifo(void)
 	if (ret =3D=3D -1 && errno !=3D EEXIST) {
 		perror("mkfifo");
 		tst_resm(TFAIL, "failed creating %s\n", FIFOFILE);
-		tst_exit(1);
+		tst_exit();
 	}
 }
=20
@@ -145,7 +145,7 @@ void read_from_fifo(char *buf)
 	if (fd < 0) {
 		perror("open");
 		tst_resm(TFAIL, "Failed opening fifo\n");
-		tst_exit(1);
+		tst_exit();
 	}
 	read(fd, buf, 199);
 	close(fd);
@@ -164,7 +164,7 @@ int fork_drop_and_exec(int keepperms, ca
 	if (pid < 0) {
 		perror("fork");
 		tst_resm(TFAIL, "%s: failed fork\n", __FUNCTION__);
-		tst_exit(1);
+		tst_exit();
 	}
 	if (pid =3D=3D 0) {
 		drop_root(keepperms);
@@ -177,7 +177,7 @@ int fork_drop_and_exec(int keepperms, ca
 		snprintf(buf, 200, "failed to run as %s\n", capstxt);
 		cap_free(capstxt);
 		write_to_fifo(buf);
-		tst_exit(1);
+		tst_exit();
 	} else {
 		p =3D buf;
 		while (1) {
@@ -192,7 +192,7 @@ int fork_drop_and_exec(int keepperms, ca
 		p =3D index(buf, '.')+1;
 		if (p=3D=3D(char *)1) {
 			tst_resm(TFAIL, "got a bad message from print_caps\n");
-			tst_exit(1);
+			tst_exit();
 		}
 		actual_caps =3D cap_from_text(p);
 		if (cap_compare(actual_caps, expected_caps) !=3D 0) {
@@ -396,5 +396,5 @@ int main(int argc, char *argv[])
 		default: usage(argv[0]);
 	}
=20
-	tst_exit(ret);
+	tst_exit();
 }

--------------060600060105070908090306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------060600060105070908090306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060600060105070908090306--

