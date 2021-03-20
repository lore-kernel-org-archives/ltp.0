From: QI Fuli <fukuri.sai@gmail.com>
Date: Sun, 21 Mar 2021 01:19:33 +0900
Subject: [LTP] [PATCH] syscalls/swapoff/swapoff01: remove the check for BTRFS
Message-ID: <20210320161933.2088737-1-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

remove the redundant task as BTRFS is checked in is_swap_supported()
Fixes: eadffb391("syscalls/swapoff/swapoff0{1,2}: use helpers to check
	support status")

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/swapoff/swapoff01.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index 87a217a89..1a707625a 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -34,8 +34,6 @@ static void verify_swapoff(void);
 char *TCID = "swapoff01";
 int TST_TOTAL = 1;

-static long fs_type;
-
 int main(int ac, char **av)
 {
 	int lc;
@@ -56,11 +54,6 @@ int main(int ac, char **av)
 static void verify_swapoff(void)
 {
 	if (ltp_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
-		if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
-			tst_brkm(TCONF, cleanup,
-			         "Swapfiles on BTRFS are not implemented");
-		}
-
 		tst_resm(TBROK, "Failed to turn on the swap file"
 			 ", skipping test iteration");
 		return;
--
2.29.2

