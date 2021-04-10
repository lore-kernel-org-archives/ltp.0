From: Li Wang <liwang@redhat.com>
Date: Sat, 10 Apr 2021 14:31:08 +0800
Subject: [LTP] [COMMITTED PATCH] clock_gettime04: add linux-git commmit in
 tst_tag
Message-ID: <20210410063108.196841-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../syscalls/clock_gettime/clock_gettime04.c     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
index 4a395f394..a8d2c5b38 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -2,9 +2,21 @@
 /*
  * Copyright (c) 2020 Linaro Limited. All rights reserved.
  * Author: Viresh Kumar<viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [Description]
  *
  * Check time difference between successive readings and report a bug if
  * difference found to be over 5 ms.
+ *
+ * This test reports a s390x BUG which has been fixed in:
+ *
+ *    commit 5b43bd184530af6b868d8273b0a743a138d37ee8
+ *    Author: Heiko Carstens <hca@linux.ibm.com>
+ *    Date:   Wed Mar 24 20:23:55 2021 +0100
+ *
+ *    s390/vdso: fix initializing and updating of vdso_data
  */
 
 #include "config.h"
@@ -167,4 +179,8 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(clks),
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "5b43bd184530"},
+		{}
+	}
 };
-- 
2.30.2

