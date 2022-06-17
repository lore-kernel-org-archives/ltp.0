Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FECC43334
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 17:27:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EA1F3C8D4A
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 19:27:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54DB73C0675
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:26:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 66A43600F88
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:26:50 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0EA31474;
 Fri, 17 Jun 2022 10:26:48 -0700 (PDT)
Received: from deb-build-vm.home (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF91C3F792;
 Fri, 17 Jun 2022 10:26:47 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jun 2022 18:26:41 +0100
Message-Id: <20220617172641.122296-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix mountns01/02/03/04 removing unneeded final umounts
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

Running LTP20220527 release it appears that the recently re-written tests
mountns02/03/04 now throw a warning on their final umount attempt:

<<<test_output>>>
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
mountns04.c:38: TPASS: unbindable mount passed
tst_device.c:395: TWARN: umount('A') failed with EINVAL
mountns.h:36: TWARN: umount(A) failed: EINVAL (22)
tst_device.c:434: TINFO: No device is mounted at B

Moreover, the underlying safe_umount() then upgrades the TWARN emitted
from tst_umount to a TBROK, so causing the test to completely fail:

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 2
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=4 corefile=no

In fact, the final umounts on DIRA seem not needed in mountns02/03/04
looking at the previous chain of umounts calls and the tests logic and,
in any case, the .cleanup functions of all these tests take care to
finally unmount both DIRA/DIRB after having checked if they were still
mounted at all.

Remove all the final SAFE_UMOUNT calls (even for mountns01) since all the
possibly needed umounts are already eventually performed by .cleanup.

Cc: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 testcases/kernel/containers/mountns/mountns01.c | 2 --
 testcases/kernel/containers/mountns/mountns02.c | 2 --
 testcases/kernel/containers/mountns/mountns03.c | 2 --
 testcases/kernel/containers/mountns/mountns04.c | 2 --
 4 files changed, 8 deletions(-)

diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index 452fe1d10..7c9461e4d 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -85,8 +85,6 @@ static void run(void)
 		tst_res(TFAIL, "shared mount in child failed");
 
 	TST_CHECKPOINT_WAKE(0);
-
-	SAFE_UMOUNT(DIRA);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
index cbd435958..0693bb9f6 100644
--- a/testcases/kernel/containers/mountns/mountns02.c
+++ b/testcases/kernel/containers/mountns/mountns02.c
@@ -86,8 +86,6 @@ static void run(void)
 		tst_res(TPASS, "private mount in child passed");
 
 	TST_CHECKPOINT_WAKE(0);
-
-	SAFE_UMOUNT(DIRA);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
index 5c19a96a9..aceab32ae 100644
--- a/testcases/kernel/containers/mountns/mountns03.c
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -96,8 +96,6 @@ static void run(void)
 		tst_res(TFAIL, "propagation form slave mount failed");
 
 	TST_CHECKPOINT_WAKE(0);
-
-	SAFE_UMOUNT(DIRA);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
index cc63a03d9..d0ecf7667 100644
--- a/testcases/kernel/containers/mountns/mountns04.c
+++ b/testcases/kernel/containers/mountns/mountns04.c
@@ -40,8 +40,6 @@ static void run(void)
 		SAFE_UMOUNT(DIRB);
 		tst_res(TFAIL, "unbindable mount faled");
 	}
-
-	SAFE_UMOUNT(DIRA);
 }
 
 static void setup(void)
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
