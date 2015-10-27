From: Cui Bixuan <cuibixuan@huawei.com>
Date: Tue, 27 Oct 2015 17:32:28 +0800
Subject: [LTP] [PATCH v2] sched_getattr/sched_getattr01: Use macro
 definitions to replace numbers
In-Reply-To: <20151026152911.GA6772@rei>
References: <1445343078-145058-1-git-send-email-cuibixuan@huawei.com>
 <20151026152911.GA6772@rei>
Message-ID: <562F44AC.4070609@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use 'RUNTIME_VAL','PERIOD_VAL' and 'DEADLINE_VAL' to set attr

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
V2:
    * Add GPL header in testcase;

 .../syscalls/sched_getattr/sched_getattr01.c       |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
index 267b8b1..62faeca 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
@@ -1,3 +1,16 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd., 2015
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ */
+
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <stdio.h>
@@ -38,9 +51,9 @@ void *run_deadline(void *data LTP_ATTRIBUTE_UNUSED)

 	/* This creates a 10ms/30ms reservation */
 	attr.sched_policy = SCHED_DEADLINE;
-	attr.sched_runtime = 10 * 1000 * 1000;
-	attr.sched_period = 30 * 1000 * 1000;
-	attr.sched_deadline = 30 * 1000 * 1000;
+	attr.sched_runtime = RUNTIME_VAL;
+	attr.sched_period = PERIOD_VAL;
+	attr.sched_deadline = DEADLINE_VAL;

 	ret = sched_setattr(0, &attr, flags);
 	if (ret < 0)
-- 
1.6.0.2
