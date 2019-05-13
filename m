From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 13 May 2019 15:26:32 +0800
Subject: [LTP] [PATCH] ltp-cap.m4: add libcap version detection && fix
	compiler error
Message-ID: <1557732392-7049-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current ltp-cap.m4 defines cap_libs when libcap has
cap_compare function.  This function was introduced by
libcap-2. It is only used for the two places, and another
places work fines with libcap-1. So add libcap version
detection.

If you use the following function or macro, you must use
libcap-2(HAVE_LIBCAP_V2):
cap_compare
cap_get_file
cap_set_file
cap_get_fd
cap_set_fd
CAP_LAST_CAP


This patch also fixes possible compiler error on old distros without
PR_CAPBSET_READ/PR_CAPBSET_DROP flag, the following case:
cap_bound/exec_with_inh.c
cap_bound/exec_without_inh.c
filecaps/verify_caps_exec.c

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 m4/ltp-cap.m4                                 | 35 +++++++------------
 testcases/kernel/containers/userns/userns01.c |  4 +--
 testcases/kernel/containers/userns/userns06.c |  2 +-
 .../containers/userns/userns06_capcheck.c     |  4 +--
 .../kernel/security/cap_bound/cap_bounds_r.c  |  2 +-
 .../kernel/security/cap_bound/cap_bounds_rw.c |  4 +--
 .../security/cap_bound/cap_bset_inh_bounds.c  |  4 +--
 .../kernel/security/cap_bound/check_pe.c      |  2 +-
 .../kernel/security/cap_bound/exec_with_inh.c |  9 +++--
 .../security/cap_bound/exec_without_inh.c     |  6 +++-
 .../security/filecaps/check_simple_capset.c   |  2 +-
 .../kernel/security/filecaps/inh_capped.c     |  4 +--
 .../kernel/security/filecaps/print_caps.c     |  2 +-
 .../security/filecaps/verify_caps_exec.c      |  9 +++--
 .../security/securebits/check_keepcaps.c      |  2 +-
 .../kernel/syscalls/pivot_root/pivot_root01.c |  6 ++--
 16 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
index 834ab36f7..51e85e234 100644
--- a/m4/ltp-cap.m4
+++ b/m4/ltp-cap.m4
@@ -1,37 +1,26 @@
-dnl
+dnl SPDX-License-Identifier: GPL-2.0-or-later
 dnl Copyright (c) Cisco Systems Inc., 2009
 dnl Copyright (c) Linux Test Project, 2010
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl Copyright (c) Fujitsu, 2019
 dnl
 dnl Author: Ngie Cooper <yaneurabeya@gmail.com>
-dnl
+dnl Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
 
-dnl
-dnl LTP_CHECK_CAPABILITY_SUPPORT
-dnl ----------------------------
-dnl
 AC_DEFUN([LTP_CHECK_CAPABILITY_SUPPORT],[
-AH_TEMPLATE(HAVE_LIBCAP,
+AH_TEMPLATE(HAVE_LIBCAP_V1,
+[Define to 1 if you have libcap-1 installed.])
+AH_TEMPLATE(HAVE_LIBCAP_V2,
 [Define to 1 if you have libcap-2 installed.])
 AC_CHECK_HEADERS([sys/capability.h],[capability_header_prefix="sys"])
 if test "x$capability_header_prefix" != x; then
-	AC_CHECK_LIB(cap,cap_compare,[cap_libs="-lcap"])
+	AC_CHECK_LIB(cap,cap_set_flag,[cap_libs="-lcap"])
+	AC_CHECK_LIB(cap,cap_compare,[cap_version="2"])
 fi
 if test "x$cap_libs" != x; then
-	AC_DEFINE(HAVE_LIBCAP)
+	AC_DEFINE(HAVE_LIBCAP_V1)
+fi
+if test "x$cap_version" != x; then
+	AC_DEFINE(HAVE_LIBCAP_V2)
 fi
 AC_SUBST(CAP_LIBS,$cap_libs)
 ])
diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 1c8cf570d..cb1c9c4a4 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -51,7 +51,7 @@ static int child_fn1(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	int exit_val = 0;
 	int uid, gid;
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 	cap_t caps;
 	int i, last_cap;
 	cap_flag_value_t flag_val;
@@ -67,7 +67,7 @@ static int child_fn1(void *arg LTP_ATTRIBUTE_UNUSED)
 		exit_val = 1;
 	}
 
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 	caps = cap_get_proc();
 	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
 	for (i = 0; i <= last_cap; i++) {
diff --git a/testcases/kernel/containers/userns/userns06.c b/testcases/kernel/containers/userns/userns06.c
index 23f6da4d0..7aa10409a 100644
--- a/testcases/kernel/containers/userns/userns06.c
+++ b/testcases/kernel/containers/userns/userns06.c
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 	int fd;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
-#ifndef HAVE_LIBCAP
+#ifndef HAVE_LIBCAP_V1
 	tst_brkm(TCONF, NULL, "System is missing libcap.");
 #endif
 	setup();
diff --git a/testcases/kernel/containers/userns/userns06_capcheck.c b/testcases/kernel/containers/userns/userns06_capcheck.c
index 31f7e0a25..434cebeb7 100644
--- a/testcases/kernel/containers/userns/userns06_capcheck.c
+++ b/testcases/kernel/containers/userns/userns06_capcheck.c
@@ -39,7 +39,7 @@ int TST_TOTAL = 1;
 
 int main(int argc, char *argv[])
 {
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 	cap_t caps;
 	int i, last_cap;
 	cap_flag_value_t flag_val;
@@ -47,7 +47,7 @@ int main(int argc, char *argv[])
 #endif
 	tst_parse_opts(argc, argv, NULL, NULL);
 
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 	if (strcmp("privileged", argv[1]))
 		expected_flag = 0;
 
diff --git a/testcases/kernel/security/cap_bound/cap_bounds_r.c b/testcases/kernel/security/cap_bound/cap_bounds_r.c
index d7c2bf0ae..1bf3ac1f8 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_r.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_r.c
@@ -41,7 +41,7 @@ int TST_TOTAL = 1;
 
 int main(void)
 {
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V2
 	int ret = 1;
 	int i;
 	int cap_last_cap = CAP_LAST_CAP;
diff --git a/testcases/kernel/security/cap_bound/cap_bounds_rw.c b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
index f715c703d..39293b9fb 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_rw.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
@@ -63,7 +63,7 @@ int check_remaining_caps(int lastdropped)
 			return i;
 		}
 	}
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V2
 	for (; i <= cap_last_cap; i++) {
 #if HAVE_DECL_PR_CAPBSET_READ
 		ret = prctl(PR_CAPBSET_READ, i);
@@ -92,7 +92,7 @@ int main(void)
 	int ret = 1;
 	int i;
 
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V2
 	cap_last_cap = CAP_LAST_CAP;
 	if (access(PROC_CAP_LAST, R_OK) == 0) {
 		SAFE_FILE_SCANF(NULL, PROC_CAP_LAST, "%d", &cap_last_cap);
diff --git a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
index feb7fbd3f..cf12c0364 100644
--- a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
+++ b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
@@ -42,7 +42,7 @@ int main(int argc, char *argv[])
 {
 #if HAVE_SYS_CAPABILITY_H
 #if HAVE_DECL_PR_CAPBSET_READ && HAVE_DECL_PR_CAPBSET_DROP
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 	int ret = 1;
 	cap_value_t v[1];
 	cap_flag_value_t f;
@@ -122,7 +122,7 @@ int main(int argc, char *argv[])
 
 	tst_resm(TPASS,
 		 "Couldn't put CAP_SYS_ADMIN back into pI when not in bounding set\n");
-#else /* HAVE_LIBCAP */
+#else /* HAVE_LIBCAP_V1*/
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
 #else /* HAVE_DECL_PR_CAPBSET_READ && HAVE_DECL_PR_CAPBSET_DROP */
diff --git a/testcases/kernel/security/cap_bound/check_pe.c b/testcases/kernel/security/cap_bound/check_pe.c
index c4453ecf8..b8c0a5aa1 100644
--- a/testcases/kernel/security/cap_bound/check_pe.c
+++ b/testcases/kernel/security/cap_bound/check_pe.c
@@ -42,7 +42,7 @@ int TST_TOTAL = 1;
 int main(int argc, char *argv[])
 {
 #ifdef HAVE_SYS_CAPABILITY_H
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 	int ret = 1;
 	cap_flag_value_t f;
 	cap_t cur;
diff --git a/testcases/kernel/security/cap_bound/exec_with_inh.c b/testcases/kernel/security/cap_bound/exec_with_inh.c
index dd9ddb574..00eea7d88 100644
--- a/testcases/kernel/security/cap_bound/exec_with_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_with_inh.c
@@ -41,7 +41,8 @@ int TST_TOTAL = 1;
 int main(int argc, char *argv[])
 {
 #if HAVE_SYS_CAPABILITY_H
-#ifdef HAVE_LIBCAP
+#if HAVE_DECL_PR_CAPBSET_DROP
+#ifdef HAVE_LIBCAP_V1
 	int ret = 1;
 	cap_flag_value_t f;
 	cap_t cur = 0;
@@ -81,9 +82,13 @@ int main(int argc, char *argv[])
 	/* execute "check_pe 1" */
 	execl("check_pe", "check_pe", "1", NULL);
 	tst_resm(TBROK, "Failed to execute check_pe (errno %d)\n", errno);
-#else /* HAVE_LIBCAP */
+#else /* HAVE_LIBCAP_V1 */
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
+#else /* HAVE_DECL_PR_CAPBSET_DROP */
+	tst_resm(TCONF, "System doesn't have CAPBSET prctls");
+#endif
+
 #else /* HAVE_SYS_CAPABILITY_H */
 	tst_resm(TCONF, "System doesn't have sys/capability.h.");
 #endif
diff --git a/testcases/kernel/security/cap_bound/exec_without_inh.c b/testcases/kernel/security/cap_bound/exec_without_inh.c
index 29b31238a..05b2eb27f 100644
--- a/testcases/kernel/security/cap_bound/exec_without_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_without_inh.c
@@ -41,7 +41,8 @@ int TST_TOTAL = 1;
 int main(int argc, char *argv[])
 {
 #if HAVE_SYS_CAPABILITY_H
-#ifdef HAVE_LIBCAP
+#if HAVE_DECL_PR_CAPBSET_DROP
+#ifdef HAVE_LIBCAP_V1
 	int ret = 1;
 	cap_flag_value_t f;
 	cap_value_t v[1];
@@ -81,6 +82,9 @@ int main(int argc, char *argv[])
 #else /* libcap */
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
+#else /* HAVE_DECL_PR_CAPBSET_DROP */
+	tst_resm(TCONF, "System doesn't have CAPBSET prctls");
+#endif
 #else /* capability_h */
 	tst_resm(TCONF, "System doesn't have sys/capability.h.");
 #endif
diff --git a/testcases/kernel/security/filecaps/check_simple_capset.c b/testcases/kernel/security/filecaps/check_simple_capset.c
index 81a75babd..3e78ddc65 100644
--- a/testcases/kernel/security/filecaps/check_simple_capset.c
+++ b/testcases/kernel/security/filecaps/check_simple_capset.c
@@ -27,7 +27,7 @@
 
 int main(void)
 {
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V2
 	cap_t caps, caps2;
 	int ret;
 
diff --git a/testcases/kernel/security/filecaps/inh_capped.c b/testcases/kernel/security/filecaps/inh_capped.c
index 4bbe184aa..3ee59c5bd 100644
--- a/testcases/kernel/security/filecaps/inh_capped.c
+++ b/testcases/kernel/security/filecaps/inh_capped.c
@@ -35,7 +35,7 @@
 char *TCID = "filecaps";
 int TST_TOTAL = 1;
 
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 void debug_print_caps(char *when)
 {
 	char buf[2000];
@@ -61,7 +61,7 @@ int set_caps_from_text(char *capstr)
 
 int main(void)
 {
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 	int ret;
 
 	debug_print_caps("start");
diff --git a/testcases/kernel/security/filecaps/print_caps.c b/testcases/kernel/security/filecaps/print_caps.c
index 26fe55c53..a8dccdbc2 100644
--- a/testcases/kernel/security/filecaps/print_caps.c
+++ b/testcases/kernel/security/filecaps/print_caps.c
@@ -41,7 +41,7 @@
 
 int main(int argc, char *argv[])
 {
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 	cap_t cap = cap_get_proc();
 	int fd;
 	int seqno = 0;
diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index 090ac5c90..187257cf9 100644
--- a/testcases/kernel/security/filecaps/verify_caps_exec.c
+++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
@@ -62,7 +62,7 @@ static void usage(const char *me)
 #define DROP_PERMS 0
 #define KEEP_PERMS 1
 
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V2
 static void print_my_caps(void)
 {
 	cap_t cap = cap_get_proc();
@@ -226,11 +226,16 @@ static int caps_actually_set_test(void)
 	int num_caps;
 
 	for (num_caps = 0;; num_caps++) {
+#if HAVE_DECL_PR_CAPBSET_READ
 		ret = prctl(PR_CAPBSET_READ, num_caps);
 		/*
 		 * Break from the loop in this manner to avoid incrementing,
 		 * then having to decrement value.
 		 */
+#else
+		tst_resm(TCONF, "System doesn't have CAPBSET prctls");
+		ret = -1;
+#endif
 		if (ret == -1)
 			break;
 	}
@@ -393,7 +398,7 @@ static int caps_actually_set_test(void)
 
 int main(int argc, char *argv[])
 {
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V2
 	if (argc < 2)
 		usage(argv[0]);
 
diff --git a/testcases/kernel/security/securebits/check_keepcaps.c b/testcases/kernel/security/securebits/check_keepcaps.c
index b49d07078..064e831ed 100644
--- a/testcases/kernel/security/securebits/check_keepcaps.c
+++ b/testcases/kernel/security/securebits/check_keepcaps.c
@@ -28,7 +28,7 @@
 char *TCID = "keepcaps";
 int TST_TOTAL = 1;
 
-#if (HAVE_LINUX_SECUREBITS_H && HAVE_LIBCAP)
+#if (HAVE_LINUX_SECUREBITS_H && HAVE_LIBCAP_V1)
 #include <linux/securebits.h>
 
 static int eff_caps_empty(cap_t c)
diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root01.c b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
index 2e8a7ff24..7002c070a 100644
--- a/testcases/kernel/syscalls/pivot_root/pivot_root01.c
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
@@ -18,7 +18,7 @@
 
 #ifdef HAVE_UNSHARE
 
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_SYS_CAPABILITY_H
 #include <sys/capability.h>
 #endif
 
@@ -74,7 +74,7 @@ static const struct test_case {
 	{NO_CAP_SYS_ADMIN, EPERM},
 };
 
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 static void drop_cap_sys_admin(void)
 {
 	cap_value_t cap_value[] = { CAP_SYS_ADMIN };
@@ -140,7 +140,7 @@ static void run(unsigned int test_case)
 	}
 
 	if (test_cases[test_case].test_case == NO_CAP_SYS_ADMIN) {
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_LIBCAP_V1
 		drop_cap_sys_admin();
 #else
 		tst_res(TCONF,
-- 
2.18.1



