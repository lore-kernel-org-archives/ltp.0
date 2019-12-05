From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 5 Dec 2019 15:55:37 +0800
Subject: [LTP] [PATCH] syscalls/userfaultfd01: Always require CAP_SYS_PTRACE
Message-ID: <1575532537-27105-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit cefdca0a86be ("userfaultfd/sysctl: add vm.unprivileged_userfaultfd").
, it adds a global sysctl knob "vm.unprivileged_userfaultfd" to control whether
unprivileged users can use the userfaultfd system calls.  Set this to 1 to allow
unprivileged users to use the userfaultfd system calls, or set this to 0 to
restrict userfaultfd to only privileged users (with SYS_CAP_PTRACE capability).The
default value is 1. In order to use userfaultfd always, require CAP_SYS_PTRACE.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/capability.h                             | 4 ++++
 testcases/kernel/syscalls/userfaultfd/userfaultfd01.c | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 8833f0605..06c3f4921 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -24,6 +24,10 @@
 # define CAP_NET_RAW          13
 #endif
 
+#ifndef CAP_SYS_PTRACE
+# define CAP_SYS_PTRACE       19
+#endif
+
 #ifndef CAP_SYS_ADMIN
 # define CAP_SYS_ADMIN        21
 #endif
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index a5e142209..74d2d2253 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -19,6 +19,7 @@
 #include "tst_safe_macros.h"
 #include "tst_safe_pthread.h"
 #include "lapi/syscalls.h"
+#include "lapi/capability.h"
 
 static int page_size;
 static char *page;
@@ -114,7 +115,11 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.min_kver = "4.3",
-	.timeout = 20
+	.timeout = 20,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_PTRACE),
+		{}
+	}
 };
 
 #else
-- 
2.18.0



