From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 16 May 2019 14:52:59 +0800
Subject: [LTP] [PATCH v2] security: add missing
	PR_CAPBSET_READ/PR_CAPBSET_DROP check
In-Reply-To: <20190515143746.GA7507@dell5510>
References: <20190515143746.GA7507@dell5510>
Message-ID: <1557989579-3661-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

PR_CAPBSET_READ/PR_CAPNSET_DROP was added since linux2.6.25,
current ltp detected them in ltp-prctl.m4, but three places
missed this check. So add it, fix possible compiler error
on some old dirtros without PR_CAPBSET_READ/PR_CAPNSET_DROP flag.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/security/cap_bound/exec_with_inh.c    | 4 ++++
 testcases/kernel/security/cap_bound/exec_without_inh.c | 4 ++++
 testcases/kernel/security/filecaps/verify_caps_exec.c  | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/testcases/kernel/security/cap_bound/exec_with_inh.c b/testcases/kernel/security/cap_bound/exec_with_inh.c
index dd9ddb574..13814798e 100644
--- a/testcases/kernel/security/cap_bound/exec_with_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_with_inh.c
@@ -41,6 +41,7 @@ int TST_TOTAL = 1;
 int main(int argc, char *argv[])
 {
 #if HAVE_SYS_CAPABILITY_H
+#if HAVE_DECL_PR_CAPBSET_DROP
 #ifdef HAVE_LIBCAP
 	int ret = 1;
 	cap_flag_value_t f;
@@ -84,6 +85,9 @@ int main(int argc, char *argv[])
 #else /* HAVE_LIBCAP */
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
+#else /* HAVE_DECL_PR_CAPBSET_DROP*/
+	tst_resm(TCONF, "System doesn't have CAPBSET prctls");
+#endif
 #else /* HAVE_SYS_CAPABILITY_H */
 	tst_resm(TCONF, "System doesn't have sys/capability.h.");
 #endif
diff --git a/testcases/kernel/security/cap_bound/exec_without_inh.c b/testcases/kernel/security/cap_bound/exec_without_inh.c
index 29b31238a..0d13d48c3 100644
--- a/testcases/kernel/security/cap_bound/exec_without_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_without_inh.c
@@ -41,6 +41,7 @@ int TST_TOTAL = 1;
 int main(int argc, char *argv[])
 {
 #if HAVE_SYS_CAPABILITY_H
+#if HAVE_DECL_PR_CAPBSET_DROP
 #ifdef HAVE_LIBCAP
 	int ret = 1;
 	cap_flag_value_t f;
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
diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index 090ac5c90..3e6794102 100644
--- a/testcases/kernel/security/filecaps/verify_caps_exec.c
+++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
@@ -226,7 +226,12 @@ static int caps_actually_set_test(void)
 	int num_caps;
 
 	for (num_caps = 0;; num_caps++) {
+#if HAVE_DECL_PR_CAPBSET_READ
 		ret = prctl(PR_CAPBSET_READ, num_caps);
+#else
+		tst_resm(TCONF, "System doesn't have CAPBSET prctls");
+		ret = -1;
+#endif
 		/*
 		 * Break from the loop in this manner to avoid incrementing,
 		 * then having to decrement value.
-- 
2.18.1



