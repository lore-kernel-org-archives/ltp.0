From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jul 2019 14:55:24 +0200
Subject: [LTP] [PATCH v2] syscalls/prctl07: New test for prctl() with
 PR_CAP_AMBIENT
In-Reply-To: <1562925275-2390-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190709112046.GC4914@rei.lan>
 <1562925275-2390-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190716125524.GA23024@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

The highlights of the changes are:

* Using proper hexadecimal base when converting CapAmb from string

* Adding the CAP_LIB selectively only for prctl07

The rest is more or less cosmetic to avoid warnings on missing libcap
and such.

diff --git a/testcases/kernel/syscalls/prctl/prctl07.c b/testcases/kernel/syscalls/prctl/prctl07.c
index bbb9161dd..37d77df33 100644
--- a/testcases/kernel/syscalls/prctl/prctl07.c
+++ b/testcases/kernel/syscalls/prctl/prctl07.c
@@ -26,45 +26,44 @@
 #include <stdlib.h>
 #include "config.h"
 #ifdef HAVE_LIBCAP
-#include <sys/capability.h>
+# include <sys/capability.h>
 #endif
 #include "lapi/syscalls.h"
 #include "lapi/prctl.h"
 #include "lapi/securebits.h"
 #include "tst_test.h"
 
-static void check_proc_capamb(char *message, int flag)
+#define PROC_STATUS "/proc/self/status"
+
+static inline void check_proc_capamb(char *message, int flag)
 {
-	unsigned int cap_num;
+	int cap_num;
 	char CapAmb[20];
-	char path[50];
 
-	strcpy(path, "/proc/self/status");
-	SAFE_FILE_LINES_SCANF(path, "CapAmb:%s", CapAmb);
-	cap_num = atoi(CapAmb);
+	SAFE_FILE_LINES_SCANF(PROC_STATUS, "CapAmb:%s", CapAmb);
+	cap_num = strtol(CapAmb, NULL, 16);
 	if (flag == 2) {
 		if (cap_num == 0)
 			tst_res(TPASS,
 				"%s, %s CapAmb has been clear as %d",
-				message, path, cap_num);
+				message, PROC_STATUS, cap_num);
 		else
 			tst_res(TFAIL,
 				"%s, %s CapAmb has been clear expect 0, got %d",
-				message, path, cap_num);
+				message, PROC_STATUS, cap_num);
 		return;
 	}
-	/*1 <<  CAP_NET_BIND_SERVICE*/
-	if (cap_num ==  400)
+	if (cap_num == (1 << CAP_NET_BIND_SERVICE))
 		tst_res(flag ? TPASS : TFAIL,
 			"%s, CapAmb in %s has CAP_NET_BIND_SERVICE",
-			message, path);
+			message, PROC_STATUS);
 	else
 		tst_res(flag ? TFAIL : TPASS,
 			"%s, CapAmb in %s doesn't have CAP_NET_BIND_SERVICE",
-			message, path);
+			message, PROC_STATUS);
 }
 
-static void check_cap_raise(unsigned int cap, char *message, int fail_flag)
+static inline void check_cap_raise(unsigned int cap, char *message, int fail_flag)
 {
 	TEST(prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, cap, 0, 0, 0));
 	switch (fail_flag) {
@@ -84,13 +83,13 @@ static void check_cap_raise(unsigned int cap, char *message, int fail_flag)
 		tst_res(TPASS,
 			"PR_CAP_AMBIENT_RAISE failed with EPERM %s", message);
 	else
-		tst_res(TFAIL | TERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"PR_CAP_AMBIENT_RAISE failed %s", message);
 	break;
 	}
 }
 
-static void check_cap_is_set(unsigned int cap, char *message, int val)
+static inline void check_cap_is_set(unsigned int cap, char *message, int val)
 {
 	TEST(prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET, cap, 0, 0, 0));
 	if (TST_RET == 1)
@@ -100,14 +99,14 @@ static void check_cap_is_set(unsigned int cap, char *message, int val)
 		tst_res(val ? TFAIL : TPASS,
 			"PR_CAP_AMBIENT_IS_SET %s not in AmbientCap", message);
 	else
-		tst_res(TFAIL | TERRNO, "PR_CAP_AMBIENT_IS_SET failed");
+		tst_res(TFAIL | TTERRNO, "PR_CAP_AMBIENT_IS_SET failed");
 }
 
-static void check_cap_lower(unsigned int cap, char *message)
+static inline void check_cap_lower(unsigned int cap, char *message)
 {
 	TEST(prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_LOWER, cap, 0, 0, 0));
 	if (TST_RET == -1)
-		tst_res(TFAIL | TERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"PR_CAP_AMBIENT_LOWER %s failed", message);
 	else
 		tst_res(TPASS, "PR_CAP_AMBIENT_LOWER %s succeeded", message);
@@ -168,7 +167,7 @@ static void verify_prctl(void)
 
 	cap_free(caps);
 #else
-	tst_res(TCONF, "System doesn't have POSIX capabilities support");
+	tst_res(TCONF, "libcap devel files missing during compilation");
 #endif
 }
 
diff --git a/testcases/kernel/syscalls/prctl/Makefile b/testcases/kernel/syscalls/prctl/Makefile
index 1399122e8..cf19507c0 100644
--- a/testcases/kernel/syscalls/prctl/Makefile
+++ b/testcases/kernel/syscalls/prctl/Makefile
@@ -20,6 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS += $(CAP_LIBS)
+prctl07: LDLIBS += $(CAP_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

-- 
Cyril Hrubis
chrubis@suse.cz
