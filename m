From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 7 Sep 2017 10:11:30 +0800
Subject: [LTP] [PATCH v2] cve/cve-2016-7042: Make use of the fallback
	functions in lapi/keyctl.h
In-Reply-To: <20170906122921.GC24177@rei.lan>
References: <20170906122921.GC24177@rei.lan>
Message-ID: <20170907021130.14525-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/cve/Makefile        |  2 ++
 testcases/cve/cve-2016-7042.c | 12 ++++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 04abc1f..0905fd9 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -19,6 +19,8 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CFLAGS			+= -D_GNU_SOURCE
 
+cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
+
 cve-2016-7117:	CFLAGS += -pthread
 cve-2016-7117:	LDLIBS += -lrt
 
diff --git a/testcases/cve/cve-2016-7042.c b/testcases/cve/cve-2016-7042.c
index ff9c057..8719eba 100644
--- a/testcases/cve/cve-2016-7042.c
+++ b/testcases/cve/cve-2016-7042.c
@@ -31,7 +31,6 @@
 #include <stdio.h>
 
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "lapi/keyctl.h"
 
 #define PATH_KEYS	"/proc/keys"
@@ -43,12 +42,11 @@ static void do_test(void)
 {
 	char buf[BUFSIZ];
 
-	key = tst_syscall(__NR_add_key,
-		"user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
+	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
 	if (key == -1)
 		tst_brk(TBROK, "Failed to add key");
 
-	if (tst_syscall(__NR_keyctl, KEYCTL_UPDATE, key, "b", 1))
+	if (keyctl(KEYCTL_UPDATE, key, "b", 1))
 		tst_brk(TBROK, "Failed to update key");
 
 	fd = SAFE_OPEN(PATH_KEYS, O_RDONLY);
@@ -61,8 +59,7 @@ static void do_test(void)
 
 	SAFE_CLOSE(fd);
 
-	if (tst_syscall(__NR_keyctl, KEYCTL_UNLINK, key,
-		KEY_SPEC_SESSION_KEYRING))
+	if (keyctl(KEYCTL_UNLINK, key, KEY_SPEC_SESSION_KEYRING))
 		tst_brk(TBROK, "Failed to unlink key");
 	key = 0;
 }
@@ -75,8 +72,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (key > 0 && tst_syscall(__NR_keyctl, KEYCTL_UNLINK, key,
-		KEY_SPEC_SESSION_KEYRING))
+	if (key > 0 && keyctl(KEYCTL_UNLINK, key, KEY_SPEC_SESSION_KEYRING))
 		tst_res(TWARN, "Failed to unlink key");
 
 	if (fd > 0)
-- 
2.9.4



