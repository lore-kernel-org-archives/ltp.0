From: Steve Muckle <smuckle.linux@gmail.com>
Date: Tue, 20 Feb 2018 15:55:23 -0800
Subject: [LTP] [PATCH] syscalls/swapon03: do not fail if /proc/swaps is
	absent
Message-ID: <20180220235523.29663-1-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the /proc/swaps file is absent the test should be skipped due
to incompatible configuration.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
 testcases/kernel/syscalls/swapon/swapon03.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index d3f73b044fe1..f690389c55a3 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -165,8 +165,7 @@ static int setup_swap(void)
 
 	/* This includes the first (header) line */
 	if ((fd = open("/proc/swaps", O_RDONLY)) == -1) {
-		tst_brkm(TFAIL | TERRNO, cleanup,
-			 "Failed to find out existing number of swap files");
+		tst_brkm(TCONF, cleanup, "Unable to open /proc/swaps");
 	}
 	do {
 		char *p = buf;
-- 
2.13.6

