From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Thu, 12 Sep 2019 13:37:15 +0800
Subject: [LTP] [PATCH V2] madvise09:Update PAGES to a larger value
Message-ID: <1568266635-17666-1-git-send-email-shuang.qiu@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shuang Qiu <shuang.qiu@oracle.com>

In upstream patch 1a61ab (mm: memcontrol: replace zone summing with lruvec_page_state()),
it modify the lruvec state in batch,equal and less than 32 MADV_FREE pages will not trigger
the account of lruvec_stat,and will not be free in memory pressure either.
So the testcase may fail with:
...
madvise09.c:219: INFO: Memory hungry child 6178 started, try 10
madvise09.c:254: INFO: Memory map: pppppppppppppppppppppppppppppppp
madvise09.c:259: FAIL: No MADV_FREE page was freed on low memory
...
We should allocate several megabytes to avoid depending kernel implementation details, 
which would mean allocating thousands of pages.
Setting PAGES=970 so that it will just avoid hitting the WARN that "message is too long" 
in tst_res(TINFO, "Memory map: %s", map).

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 01075f6..3759053 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -57,7 +57,7 @@ static int sleep_between_faults;
 
 static int swap_accounting_enabled;
 
-#define PAGES 32
+#define PAGES 970
 #define TOUCHED_PAGE1 0
 #define TOUCHED_PAGE2 10
 
-- 
1.9.1

