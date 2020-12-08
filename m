From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Dec 2020 16:46:14 +0100
Subject: [LTP] [PATCH 3/3] syscalls/ipc: msgctl06: Add a test for
 MSG_STAT_ANY
In-Reply-To: <1607422067-15500-3-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1607422067-15500-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1607422067-15500-3-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <X8+fxq1wppq1SjtP@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, thanks.

* Reformatted the top level description so that it's picked by the
  docparser

* Renamed the variables in the proc parsing function to make it more
  clear what they referring to

+ Fixed some typos.

Full diff:

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index c931bbfd3..99e44851c 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -3,7 +3,9 @@
  * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
  * Author: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
  */
-/*
+/*\
+ * [DESCRIPTION]
+ *
  * Call msgctl() with MSG_INFO flag and check that:
  *
  * * The returned index points to a valid MSG by calling MSG_STAT_ANY
@@ -16,7 +18,10 @@
  *
  * Note what we create a MSG segment in the test setup and send msg to make sure
  * that there is at least one during the testrun.
- */
+ *
+ * Also note that for MSG_INFO the members of the msginfo structure have
+ * completely different meaning than their names seems to suggest.
+\*/
 
 #include <stdio.h>
 #include <pwd.h>
@@ -40,8 +45,8 @@ static struct tcases {
 static void parse_proc_sysvipc(struct msginfo *info)
 {
 	FILE *f = fopen("/proc/sysvipc/msg", "r");
-	int used_ids = 0;
-	int queue_nums = 0;
+	int queue_cnt = 0;
+	int msg_cnt = 0;
 	int msg_bytes = 0;
 
 	/* Eat header */
@@ -52,38 +57,38 @@ static void parse_proc_sysvipc(struct msginfo *info)
 			break;
 	}
 
-	int msgid, cbytes, qnum;
+	int cbytes, msgs;
 
 	/*
 	 * Sum queue and byte for all elements listed, which should equal
 	 * the data returned in the msginfo structure.
 	 */
-	while (fscanf(f, "%*i %i %*i %i %i %*i %*i %*i %*i %*i %*i %*i %*i %*i",
-			&msgid, &cbytes, &qnum) > 0){
-		used_ids++;
-		queue_nums += qnum;
+	while (fscanf(f, "%*i %*i %*i %i %i %*i %*i %*i %*i %*i %*i %*i %*i %*i",
+	              &cbytes, &msgs) > 0){
+		queue_cnt++;
+		msg_cnt += msgs;
 		msg_bytes += cbytes;
 	}
 
-	if (info->msgpool != used_ids) {
+	if (info->msgpool != queue_cnt) {
 		tst_res(TFAIL, "msgpool = %i, expected %i",
-			info->msgpool, used_ids);
+			info->msgpool, queue_cnt);
 	} else {
-		tst_res(TPASS, "used_ids = %i", used_ids);
+		tst_res(TPASS, "queue_cnt = %i", queue_cnt);
 	}
 
-	if (info->msgmap != queue_nums) {
+	if (info->msgmap != msg_cnt) {
 		tst_res(TFAIL, "msgmap = %i, expected %i",
-			info->msgpool, queue_nums);
+			info->msgpool, msg_cnt);
 	} else {
-		tst_res(TPASS, "msgnums = %i", queue_nums);
+		tst_res(TPASS, "msg_cnt = %i", msg_cnt);
 	}
 
 	if (info->msgtql != msg_bytes) {
 		tst_res(TFAIL, "msgtql = %i, expected %i",
 			info->msgtql, msg_bytes);
 	} else {
-		tst_res(TPASS, "msgbytes = %i", msg_bytes);
+		tst_res(TPASS, "msg_bytes = %i", msg_bytes);
 	}
 
 	fclose(f);
@@ -100,7 +105,7 @@ static void verify_msgctl(unsigned int n)
 
 	SAFE_SETEUID(*tc->uid);
 
-	TEST(msgctl(0, MSG_INFO, (struct msgid_ds *)&info));
+	TEST(msgctl(0, MSG_INFO, (struct msqid_ds *)&info));
 
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgctl(0, MSG_INFO, ...)");

-- 
Cyril Hrubis
chrubis@suse.cz
