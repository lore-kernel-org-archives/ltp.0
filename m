From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 22 Sep 2017 17:21:41 +0800
Subject: [LTP] [PATCH] cve/cve-2016-10044.c: fix two errors
Message-ID: <1506072101-4550-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) If the number of nr_events exceeds the limit of available events
   defined in /proc/sys/fs/aio-max-nr, it returns EAGAIN.  We should
   call io_destroy() to cleanup the AIO context after finishing test.

   Steps to reproduce this error:
      #echo 4 > /proc/sys/fs/aio-max-nr
      # ./cve-2016-10044 -i 5
      tst_test.c:908: INFO: Timeout per run is 0h 05m 00s
      cve-2016-10044.c:62: FAIL: AIO mapping is executable: rwxs!
      cve-2016-10044.c:62: FAIL: AIO mapping is executable: rwxs!
      cve-2016-10044.c:62: FAIL: AIO mapping is executable: rwxs!
      cve-2016-10044.c:62: FAIL: AIO mapping is executable: rwxs!
      cve-2016-10044.c:49: BROK: Failed to create AIO context: EAGAIN/EWOULDBLOCK

2) The kernel created an AIO pseudo-fs and introduced cve-2016-10044
   by the following patch:
   '71ad7490c1f3("rework aio migrate pages to use aio fs")'

   We should return TCONF rather than TBROK when an AIO pseudo-fs is
   not found in /proc/self/maps.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/cve/cve-2016-10044.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index 7928d27..a84590a 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -53,7 +53,7 @@ static void run(void)
 		if (strstr(line, "/[aio]") != NULL)
 			goto found_mapping;
 	}
-	tst_brk(TBROK, "Could not find mapping in /proc/self/maps");
+	tst_brk(TCONF, "Could not find mapping in /proc/self/maps");
 
 found_mapping:
 	if (sscanf(line, "%*x-%*x %s7", perms) < 0)
@@ -63,6 +63,9 @@ found_mapping:
 	else
 		tst_res(TPASS, "AIO mapping is not executable: %s", perms);
 
+	if (tst_syscall(__NR_io_destroy, ctx))
+		tst_brk(TBROK | TERRNO, "Failed to destroy AIO context");
+
 	SAFE_FCLOSE(f);
 	f = NULL;
 }
-- 
1.8.3.1



