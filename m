Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016EDEDB7CC
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 08:50:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C07A3E2183
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 10:50:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63D093D0F63
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 03:49:19 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id D8272200045
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 03:49:12 +0200 (CEST)
Received: from loongson.cn (unknown [10.180.135.66])
 by gateway (Coremail) with SMTP id _____8Dx_8MWbtBpq9UhAA--.30153S3;
 Sat, 04 Apr 2026 09:49:10 +0800 (CST)
Received: from ubuntu.. (unknown [10.180.135.66])
 by front1 (Coremail) with SMTP id qMiowJCxmuAVbtBppK5kAA--.43789S2;
 Sat, 04 Apr 2026 09:49:10 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: ltp@lists.linux.it
Date: Sat,  4 Apr 2026 09:49:08 +0800
Message-ID: <20260404014908.993667-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: qMiowJCxmuAVbtBppK5kAA--.43789S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAgEHEmnPVqUTDwABse
X-Coremail-Antispam: 1Uk129KBj93XoW7KFWkGFW5WFWkXw1rAFyfXwc_yoW8Xr18p3
 ZIgr12gry5CwnIkr4rGw13X3W8Xas0yF9Igr93WrWIvr4DAFyIqa4YyF1qgryjga9Yq3y5
 uFWUGFWxG34DJFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Jr0_Gr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
 xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
 0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1GQ6JUU
 UUU==
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 07 Apr 2026 10:49:42 +0200
Subject: [LTP] [PATCH] proc01: whitelist biba attr files returning EINVAL
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
Cc: Ming Wang <wangming01@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

proc01 already treats several attr files under /proc/self/attr and
/proc/self/task/*/attr as known exceptions that may return EINVAL
on read.

On systems exposing biba attr files, reads from
/proc/self/attr/biba/* and /proc/self/task/*/attr/biba/* also
return EINVAL, which makes proc01 report false failures.

Add both path patterns to known_issues[] so the testcase keeps
reporting real regressions while ignoring this expected behavior.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 testcases/kernel/fs/proc/proc01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index c90e509a3243..dadfb240fd24 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -100,7 +100,9 @@ static const struct mapping known_issues[] = {
 	{"read", "/proc/self/attr/selinux/*", EINVAL},
 	{"read", "/proc/self/attr/smack/*", EINVAL},
 	{"read", "/proc/self/attr/apparmor/*", EINVAL},
+	{"read", "/proc/self/attr/biba/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/attr/*", EINVAL},
+	{"read", "/proc/self/task/[0-9]*/attr/biba/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/attr/smack/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/attr/selinux/*", EINVAL},
 	{"read", "/proc/self/task/[0-9]*/attr/apparmor/*", EINVAL},
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
