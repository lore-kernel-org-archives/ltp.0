From: Yang Shi <yang.shi@linux.alibaba.com>
Date: Fri,  1 Jun 2018 03:07:45 +0800
Subject: [LTP] [Resend PATCH] zram03: drop obsolete sysfs interfaces
Message-ID: <1527793665-39150-1-git-send-email-yang.shi@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Due to upstream linux commit c87d1655c29500b459fb135258a93f8309ada9c7
("zram: remove obsolete sysfs attrs"), some sysfs interfaces are not
available anymore. Remove dumping them to avoid test case failure.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
Subscribed LTP mailing list to resend the patch, so that all subscribers
can see it and get reviewed.

 testcases/kernel/device-drivers/zram/zram03.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index 3f7ab4e..f2c166c 100644
--- a/testcases/kernel/device-drivers/zram/zram03.c
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -185,11 +185,5 @@ static void print(char *string)
 static void dump_info(void)
 {
 	print("initstate");
-	print("compr_data_size");
-	print("orig_data_size");
 	print("disksize");
-	print("mem_used_total");
-	print("num_reads");
-	print("num_writes");
-	print("zero_pages");
 }
-- 
1.8.3.1

