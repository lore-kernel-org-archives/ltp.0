Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PFVof-00013T-U6
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 17:47:37 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0AFBD90847
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Nov 2010 18:47:30 +0100 (CET)
Date: Mon, 8 Nov 2010 18:58:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101108175836.GA20774@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix obvious compilation problems in cap_bounds
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
To: ltp-list@lists.sourceforge.net


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Following patch fixes obvious problems with cap_bounds compilation

* CAP_LAST_CAP is defined in linux/capability.h => include it

* remove int errno; definition

* move #ifdef HAVE_SYS_CAPABILITY_H after int main(int argc, char *argv[])
  in check_pe.c

* small typos and coding style

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--NzB8fVQJ5HfG6fxh
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="cap_bounds.patch"

diff --git a/testcases/kernel/security/cap_bound/cap_bounds_r.c b/testcases/kernel/security/cap_bound/cap_bounds_r.c
index 0b1c5b3..13c5400 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_r.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_r.c
@@ -29,14 +29,13 @@
 #if HAVE_SYS_CAPABILITY_H
 #include <sys/capability.h>
 #endif
+#include <linux/capability.h>
 #include <sys/prctl.h>
 #include <test.h>
 
 char *TCID = "cap_bounds_r";
 int TST_TOTAL=1;
 
-int errno;
-
 int main(int argc, char *argv[])
 {
 #if HAVE_SYS_CAPABILITY_H
diff --git a/testcases/kernel/security/cap_bound/cap_bounds_rw.c b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
index 827a305..c23c598 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_rw.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
@@ -28,20 +28,19 @@
 #if HAVE_SYS_CAPABILITY_H
 #include <sys/capability.h>
 #endif
+#include <linux/capability.h>
 #include <sys/prctl.h>
 #include <test.h>
 
 char *TCID = "cap_bounds_rw";
 int TST_TOTAL=1;
 
-int errno;
-
 int check_remaining_caps(int lastdropped)
 {
 	int i;
 	int ret;
 
-	for (i=0; i <= lastdropped; i++) {
+	for (i = 0; i <= lastdropped; i++) {
 #if HAVE_DECL_PR_CAPBSET_READ
 		ret = prctl(PR_CAPBSET_READ, i);
 #else
@@ -57,7 +56,7 @@ int check_remaining_caps(int lastdropped)
 			return i;
 		}
 	}
-	for (; i<=CAP_LAST_CAP; i++) {
+	for (; i <= CAP_LAST_CAP; i++) {
 #if HAVE_DECL_PR_CAPBSET_READ
 		ret = prctl(PR_CAPBSET_READ, i);
 #else
@@ -108,7 +107,7 @@ int main(int argc, char *argv[])
 		tst_resm(TINFO, " %d is should not exist\n", max(INSANE, CAP_LAST_CAP+1));
 		tst_exit();
 	}
-	for (i=0; i<=CAP_LAST_CAP; i++) {
+	for (i = 0; i <= CAP_LAST_CAP; i++) {
 #if HAVE_DECL_PR_CAPBSET_DROP
 		ret = prctl(PR_CAPBSET_DROP, i);
 #else
diff --git a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
index 7033a37..1f3634b 100644
--- a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
+++ b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
@@ -37,8 +37,6 @@
 char *TCID = "cap_bounds_r";
 int TST_TOTAL=2;
 
-int errno;
-
 int main(int argc, char *argv[])
 {
 #if HAVE_SYS_CAPABILITY_H
diff --git a/testcases/kernel/security/cap_bound/check_pe.c b/testcases/kernel/security/cap_bound/check_pe.c
index f621e70..2f5aec9 100644
--- a/testcases/kernel/security/cap_bound/check_pe.c
+++ b/testcases/kernel/security/cap_bound/check_pe.c
@@ -38,12 +38,10 @@
 char *TCID = "check_pe";
 int TST_TOTAL=1;
 
-int errno;
-
-#if HAVE_SYS_CAPABILITY_H
-#ifdef HAVE_LIBCAP
 int main(int argc, char *argv[])
 {
+#ifdef HAVE_SYS_CAPABILITY_H
+#ifdef HAVE_LIBCAP
 	int ret = 1;
 	cap_flag_value_t f;
 	cap_t cur;
@@ -72,7 +70,7 @@ int main(int argc, char *argv[])
 			tst_resm(TPASS, "cap is in pE\n");
 			tst_exit();
 		}
-		tst_resm(TFAIL, "Cap is not in pE\n");
+		tst_resm(TFAIL, "cap is not in pE\n");
 		tst_exit();
 	}
 	if (f == CAP_CLEAR) {
diff --git a/testcases/kernel/security/cap_bound/dummy.c b/testcases/kernel/security/cap_bound/dummy.c
index e882940..3ee7c9b 100644
--- a/testcases/kernel/security/cap_bound/dummy.c
+++ b/testcases/kernel/security/cap_bound/dummy.c
@@ -5,7 +5,7 @@
 #include <sys/capability.h>
 #endif
 
-int main()
+int main(void)
 {
 #if HAVE_SYS_CAPABILITY_H
 #ifdef HAVE_LIBCAP
diff --git a/testcases/kernel/security/cap_bound/exec_with_inh.c b/testcases/kernel/security/cap_bound/exec_with_inh.c
index 123f665..dc18b63 100644
--- a/testcases/kernel/security/cap_bound/exec_with_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_with_inh.c
@@ -37,8 +37,6 @@
 char *TCID = "exec_with_inh";
 int TST_TOTAL=1;
 
-int errno;
-
 int main(int argc, char *argv[])
 {
 #if HAVE_SYS_CAPABILITY_H
diff --git a/testcases/kernel/security/cap_bound/exec_without_inh.c b/testcases/kernel/security/cap_bound/exec_without_inh.c
index df3c4d9..8d99883 100644
--- a/testcases/kernel/security/cap_bound/exec_without_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_without_inh.c
@@ -37,8 +37,6 @@
 char *TCID = "exec_without_inh";
 int TST_TOTAL=1;
 
-int errno;
-
 int main(int argc, char *argv[])
 {
 #if HAVE_SYS_CAPABILITY_H

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--NzB8fVQJ5HfG6fxh--

