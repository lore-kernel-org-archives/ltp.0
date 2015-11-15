From: Li Wang <liwang@redhat.com>
Date: Sun, 15 Nov 2015 16:41:00 +0800
Subject: [LTP] [PATCH] futex: skip futex_wake04.c if system not support huge
	pages
Message-ID: <1447576860-9189-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Testcase fails on system which not support hugepages:

futex_wake04    1  TBROK  :  safe_file_ops.c:155: The FILE '/proc/sys/vm/nr_hugepages' ended prematurely at futex_wake04.c:74
futex_wake04    2  TBROK  :  safe_file_ops.c:155: Remaining cases broken

Skip the testcase cases with TCONF rather than failing with TBROK.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/futex/futex_wake04.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index dcefde8..2d6bd4c 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -50,6 +50,7 @@
 
 #define PATH_MEMINFO "/proc/meminfo"
 #define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
+#define PATH_SYS_HUGEPAGES "/sys/kernel/mm/hugepages/"
 
 const char *TCID = "futex_wake04";
 const int TST_TOTAL = 1;
@@ -69,6 +70,9 @@ static void setup(void)
 			"that are 2.6.32 or higher");
 	}
 
+	if (access(PATH_SYS_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	tst_tmpdir();
 
 	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
-- 
1.9.3

