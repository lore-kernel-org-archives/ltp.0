From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Fri, 15 Jul 2016 18:35:52 +0300
Subject: [LTP] [PATCH 1/2] syscalls/perf_event_open02: Fix indentation and
	typo in help
Message-ID: <1468596953-3407-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/kernel/syscalls/perf_event_open/perf_event_open02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 5dc205b..ba840f5 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -338,7 +338,7 @@ static void verify(void)
 
 static void help(void)
 {
-	printf("-v  print verbose infomation\n");
+	printf("  -v      Print verbose information\n");
 }
 
 #else
-- 
2.2.0

