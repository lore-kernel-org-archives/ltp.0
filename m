From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat,  2 Sep 2017 02:59:25 +0200
Subject: [LTP] [RFC PATCH 5/6] android: cve/stack_clash: Fix PAGE_MASK
	defined in <sys/user.h>
In-Reply-To: <20170902005926.15923-1-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
Message-ID: <20170902005926.15923-6-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

clash is caused by including <sys/wait.h>

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/cve/stack_clash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 082d362e9..2d2984824 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -48,7 +48,7 @@
 #include "tst_safe_stdio.h"
 
 static unsigned long page_size;
-static unsigned long PAGE_MASK;
+static unsigned long page_mask;
 static unsigned long GAP_PAGES = 256;
 static unsigned long THRESHOLD;
 static int STACK_GROWSDOWN;
@@ -169,7 +169,7 @@ void do_child(void)
 	else
 		mapped_addr = stack_addr + gap;
 
-	mapped_addr &= PAGE_MASK;
+	mapped_addr &= page_mask;
 	map = SAFE_MMAP((void *)mapped_addr, MAPPED_LEN,
 			PROT_READ|PROT_WRITE,
 			MAP_ANON|MAP_PRIVATE|MAP_FIXED, -1, 0);
@@ -201,7 +201,7 @@ void setup(void)
 	char buf[4096], *p;
 
 	page_size = sysconf(_SC_PAGESIZE);
-	PAGE_MASK = ~(page_size - 1);
+	page_mask = ~(page_size - 1);
 
 	buf[4095] = '\0';
 	SAFE_FILE_SCANF("/proc/cmdline", "%4095[^\n]", buf);
-- 
2.14.0

