Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C87C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 11:05:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41ADB3C976A
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 13:05:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AD643C91EE
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 13:05:23 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 38B281000D29
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 13:05:21 +0200 (CEST)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz9Dnj9ZiB1soAA--.35931S3; 
 Tue, 19 Jul 2022 19:05:20 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jul 2022 19:05:10 +0800
Message-Id: <1658228710-37206-2-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1658228710-37206-1-git-send-email-zhanghongchen@loongson.cn>
References: <1658228710-37206-1-git-send-email-zhanghongchen@loongson.cn>
X-CM-TRANSID: AQAAf9Dxz9Dnj9ZiB1soAA--.35931S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWUCrWkuFWDXw1fJr13urg_yoWfuwc_Ja
 10qrsrKrWjyr4IqFW8Aw1q9rZYyrW8CrWrGrnrKr93t3y7Zw15GFn0vryUXrs8Wrs5ur92
 kr42gryqgw4YkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbfkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
 0Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
 x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E
 0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67
 AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48I
 cxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFsqXDUUUU
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] syslog11: save and restore console log level
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
Cc: Hongchen Zhang <zhanghongchen@loongson.cn>, ltp@lists.linux.it,
 Lingling Li <lilingling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

the console loglevel is forced to be 7(LOGLEVEL_DEFAULT) after test,
which is not the desired behavior.So we save and restore the console
loglevel using the .save_restore interface.

Signed-off-by: Lingling Li <lilingling@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 testcases/kernel/syscalls/syslog/syslog11.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
index 8a19a2a..e60bd2b 100644
--- a/testcases/kernel/syscalls/syslog/syslog11.c
+++ b/testcases/kernel/syscalls/syslog/syslog11.c
@@ -57,6 +57,10 @@ static void run(unsigned int n)
 
 static struct tst_test test = {
 	.test = run,
+	.save_restore = (const struct tst_path_val[]) {
+		{"!/proc/sys/kernel/printk", NULL},
+		{NULL, NULL}
+	},
 	.needs_root = 1,
 	.tcnt = ARRAY_SIZE(tcases),
 };
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
