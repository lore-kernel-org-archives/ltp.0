Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F1EC43334
	for <ltp@archiver.kernel.org>; Mon, 27 Jun 2022 07:40:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 842823C910D
	for <ltp@archiver.kernel.org>; Mon, 27 Jun 2022 09:40:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D97A3C14B2
 for <ltp@lists.linux.it>; Mon, 27 Jun 2022 09:40:20 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id D154D1400743
 for <ltp@lists.linux.it>; Mon, 27 Jun 2022 09:40:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX9fSXrlid8BfAA--.5229S2;
 Mon, 27 Jun 2022 15:40:13 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>
Date: Mon, 27 Jun 2022 15:40:00 +0800
Message-Id: <1656315600-22268-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxX9fSXrlid8BfAA--.5229S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kKrW5Ar1fWF48tr4UCFg_yoW8WF47pr
 n7Gr1rtrs5JFyxJrZ3Gw1qvFWrCwn5tFs8X3yqyw45Z3Z5JrWDZrsFqas8Jr10qrW0grWY
 9Fs5ZFW3Kr9Iy3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
 xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syslog11: fix console loglevel changed after test
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
Cc: Lingling Li <lilingling@loongson.cn>, ltp@lists.linux.it,
 Hongchen Zhang <zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

the console loglevel is force to be 7(LOGLEVEL_DEFAULT) after test,
which is not the desired behavior.So we reset the console loglevel
to its original value after the test body.The method what we take
is just same as commit:
a2ff1c2d141d ("kmsg01: set/restore console log level").

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Lingling Li <lilingling@loongson.cn>
---
 testcases/kernel/syscalls/syslog/syslog11.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
index b9540ef..78a7cc4 100644
--- a/testcases/kernel/syscalls/syslog/syslog11.c
+++ b/testcases/kernel/syscalls/syslog/syslog11.c
@@ -84,6 +84,11 @@ struct test_case_t {		/* test case structure */
 	char *desc;		/* Test description */
 };
 
+#define PRINTK "/proc/sys/kernel/printk"
+#define CONSOLE_LOGLEVEL_QUIET   4
+
+static int console_loglevel = -1;
+
 char *TCID = "syslog11";
 static int testno;
 static char buf;
@@ -195,6 +200,11 @@ void setup(void)
 		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
 	}
 
+	if (access(PRINTK, F_OK) == 0) {
+		SAFE_FILE_SCANF(NULL, PRINTK, "%d", &console_loglevel);
+		SAFE_FILE_PRINTF(NULL, PRINTK, "%d", CONSOLE_LOGLEVEL_QUIET);
+	}
+
 	/* Pause if that option was specified
 	 * TEST_PAUSE contains the code to fork the test with the -c option.
 	 */
@@ -208,5 +218,6 @@ void setup(void)
  */
 void cleanup(void)
 {
-
+	if (console_loglevel != -1)
+		SAFE_FILE_PRINTF(NULL, PRINTK, "%d", console_loglevel);
 }
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
