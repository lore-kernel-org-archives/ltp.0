Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8E3C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 06:52:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C9FC3CA362
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 07:52:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D3A53CA2BC
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 07:52:30 +0100 (CET)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BC2BE10000D2
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 07:52:28 +0100 (CET)
X-QQ-mid: bizesmtp65t1646376742tgoi9je7
Received: from localhost.localdomain ( [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 04 Mar 2022 14:52:14 +0800 (CST)
X-QQ-SSF: 01400000002000B0I000B00A0000000
X-QQ-FEAT: TVoyYaDp2wjTTnuzXCCaQfy3TxC10BX3OWyV384zvxdqHUI+8G3FvYqeo3uwh
 YvNKqDzsBf/26JVTkqZ0uGqeA5iTdT39Xwz+sZrKTxt8Pvt1QnxFHt7gD/Xqds+4Bq704JT
 lJbbQMfEWbSn1PHgpInsjtVKwEXor1+s7mMV9i/XxH0KJqSuxHRSsUGoxQC7j4zrazskOba
 BBlMKsHYDOGia1rHr1YTAf+OAbV1EPP6wAKkhh6JDYJmDJpC0D5wbs50Ru6lT253tNLZrfV
 hL8wuaHq/EHq6wCU3p22NJcB6K9kd/ZlHT28fLOnx9mC+dXrLt/RFhmveWtcIet48rdDU3X
 PX7PgT/k5/O6LczhXo=
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Fri,  4 Mar 2022 14:52:10 +0800
Message-Id: <20220304065210.28591-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/clock_settime03: Fix testcases have been
 waiting, timeout failure
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If the system enables auto-synchronization time configuration,
this test case will wait until the timeout. Therefore,
the automatic synchronization time configuration of the system needs to be turned off in the setup phase.

message:
tst_test.c:1457: TINFO: Timeout per run is 0h 05m 00s
clock_settime03.c:35: TINFO: Testing variant: syscall with old kernel spec
tst_test.c:1506: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1507: TBROK: Test killed! (timeout?)

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
index f196a257c..e783f1d3f 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -14,9 +14,11 @@

 #define TIMER_DELTA	3
 #define ALLOWED_DELTA	(50 * 1000) /* 50 ms */
+#define BUFF_SIZE PATH_MAX

 static struct tst_ts start, end;
 static struct tst_its its;
+static char cmd[BUFF_SIZE];

 static struct time64_variants variants[] = {
 #if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
@@ -31,6 +33,7 @@ static struct time64_variants variants[] = {
 static void setup(void)
 {
 	struct time64_variants *tv = &variants[tst_variant];
+	int ret;

 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	start.type = end.type = its.type = tv->ts_type;
@@ -40,6 +43,11 @@ static void setup(void)
 	    sizeof(start.ts.kern_old_ts.tv_sec) == 4) {
 		tst_brk(TCONF, "Not Y2038 safe to run test");
 	}
+
+	snprintf(cmd, sizeof(cmd), "timedatectl set-ntp false");
+	ret = tst_system(cmd);
+	if (ret)
+		tst_brk(TBROK | TST_ERR, "failed to timedatectl set-ntp");
 }

 static void run(void)
@@ -109,4 +117,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_root = 1,
 	.restore_wallclock = 1,
+	.needs_cmds = (const char *[]) {
+		"timedatectl",
+		NULL
+	},
 };
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
