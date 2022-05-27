Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7C4C433F5
	for <ltp@archiver.kernel.org>; Tue, 31 May 2022 14:29:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38A643C2C3F
	for <ltp@archiver.kernel.org>; Tue, 31 May 2022 16:29:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5469A3C12A6
 for <ltp@lists.linux.it>; Fri, 27 May 2022 09:21:29 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 9F81A6012DC
 for <ltp@lists.linux.it>; Fri, 27 May 2022 09:21:26 +0200 (CEST)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxWeTwe5BiN8gDAA--.13116S2; 
 Fri, 27 May 2022 15:21:25 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Petr Vorel <pvorel@suse.cz>,
	Li Wang <liwang@redhat.com>
Date: Fri, 27 May 2022 15:21:17 +0800
Message-Id: <1653636077-13606-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9BxWeTwe5BiN8gDAA--.13116S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1UuryfuryrWryfCFykKrg_yoWkGrb_ZF
 4xKF1S9wn8Aas2gFn7Jrs5JrnIyryUCFWrua48Gw4UGa4UArn7uryjy3y5AF15Gr4kZrWI
 g3ZrGFn5Jw4DAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 AVWUtwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
 IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
 6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
 IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280
 aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
 ZEXa7VUbhvttUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 31 May 2022 16:29:11 +0200
Subject: [LTP] [PATCH] controllers/cpuset: default cpuset.sched_load_balance
 to 1
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
Cc: ltp@lists.linux.it, Hongchen Zhang <zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

when we exited between the cpuset test,we may leave /dev/cpuset
not cleared. And we did the cpuset test again, we would set the
cpuset.sched_load_balance to 0 as following:
	setup()
        if [ -e "$CPUSET" ]
        cleanup
	echo $SCHED_LB_VALUE > $SCHED_LB
as the default value of cpuset.sched_load_balance is 1 at the time
cpuset mounted, so it is reasonably to be set to 1.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 9939f13..3991475 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -61,7 +61,7 @@ CLONE_CHILDREN="/dev/cpuset/cgroup.clone_children"
 CHILDREN_VALUE="0"
 HOTPLUG_CPU="1"
 SCHED_LB="/dev/cpuset/cpuset.sched_load_balance"
-SCHED_LB_VALUE="0"
+SCHED_LB_VALUE="1"
 
 cpuset_log()
 {
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
