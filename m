From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 26 Sep 2017 10:04:09 +0800
Subject: [LTP] [PATCH v2] cve/cve-2016-10044.c: fix two errors
In-Reply-To: <87h8vryqo9.fsf@our.domain.is.not.set>
References: <87h8vryqo9.fsf@our.domain.is.not.set>
Message-ID: <1506391449-5646-1-git-send-email-yangx.jy@cn.fujitsu.com>
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

2) This case fails with TBROK on an old kernel(e.g. v2.6.32) because
   the mapping file does not exist.

   The old format of file is set to 'anon_inode:[aio]' by the following
   patch set:
   '55708698c5f1("fs/anon_inode: Introduce a new lib function anon_inode_getfile_private()")'
   '36bc08cc0170("fs/aio: Add support to aio ring pages migration")'

   The current format of file is set to '/[aio]' by the following patch:
   '71ad7490c1f3("rework aio migrate pages to use aio fs")'

   We change the keyword into '[aio]' to match as many formats as
   possible, and return TCONF if the mapping file does not exist.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/cve/cve-2016-10044.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index 7928d27..14fa0a4 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -50,10 +50,10 @@ static void run(void)
 
 	f = SAFE_FOPEN("/proc/self/maps", "r");
 	while (fgets(line, BUFSIZ, f) != NULL) {
-		if (strstr(line, "/[aio]") != NULL)
+		if (strstr(line, "[aio]") != NULL)
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



