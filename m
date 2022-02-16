Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122D8C433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 10:04:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9169E3CA088
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 11:04:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A770F3CA068
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:04:39 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 92B9F600D75
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645005877; i=@fujitsu.com;
 bh=MsgEBBJffagj+79j6iyW1JJM6SrIdTuUboEUw3DUOXc=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=dZk3iMzbruCmQ4Z7Bt0H23lXNmh9ngvk188kkiLhyqybGyURG6aNyUTc5Qpnsroba
 UiSscMsuaW0IIVGl0ttQ7Wfps8hO99yCqVO4w878Koz98NQFvOrObfgmnujr8F9AjQ
 VK6hZUkVOhNPyWSJZqS4351I7/oHCW/X+G62E31PWEiJTzngOsniA7L+/CEXmAW4/1
 LhPlMSfnKEPBr9hamfqEf2kGLLdFJoMrMntZ73TMVIo9KWehWY+MGwOfxhDyUOP+D2
 tMT02rW5nJiKcNsphBgK5h+LxrlibY2NbjTyaHevrojcgcBIzr48MdsbKOiXYiwnaI
 jDqvvJDDR8mBA==
Received: from [100.115.7.114] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.ess.symcld.net id F6/D2-00700-53CCC026;
 Wed, 16 Feb 2022 10:04:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRWlGSWpSXmKPExsViZ8MxSVf+DE+
 SwYQGRYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePT/M/sBY/4Kpavf83cwPiXp4uRi0NI4Cyj
 xM7GNkYIZyeTxOV9R9ghnD2MEs9vrwByODnYBDQlnnUuYAaxRQQkJDoa3oLFmQXUJZZP+sUEY
 gsLOEks3HkUzGYRUJW4+XkhWD2vgIfE8+sHweISAgoSUx6+h4oLSpyc+YQFYo6ExMEXL5ghah
 QlLnV8Y4SwKyRmzWqD6lWTuHpuE/MERv5ZSNpnIWlfwMi0itEqqSgzPaMkNzEzR9fQwEDX0NB
 U10DXyMRYL7FKN1EvtVS3PLW4RNdQL7G8WC+1uFivuDI3OSdFLy+1ZBMjMCxTihk+72Bc0PdT
 7xCjJAeTkiiv1SqeJCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvPl7gXKCRanpqRVpmTnAGIFJS
 3DwKInwSp8ESvMWFyTmFmemQ6ROMSpKifNOPgWUEABJZJTmwbXB4vISo6yUMC8jAwODEE9Bal
 FuZgmq/CtGcQ5GJWFej9NAU3gy80rgpr8CWswEtFixkQtkcUkiQkqqgcn0fmj89cSLyrcLfrJ
 5npltczD85mxZw/mPZSW38GyK4ijR/ly/wKJz5WIDsbS8bQViW8McVJfP2uQU/ehBvtihW/NV
 eWun/PTdxPp7R6jhzR1Xz/FlKK9fdJLlzNvbG04dWBskdEA09ZGSWqbG38P/mjZWn3p7RYzr2
 Z4Lm+zSKtiWyTL+b3qjWsfDoCx2V/y+6pa6zcv2m4fXu6j4Fby2D70i8bXhddC0xw/i5+W8bg
 u43Lc6z33zgs3L0zRbppn45N99mfAkaplTl/GsHem7Upp7nq6t0pjVeK2jijeD4farnveTYpe
 v+eM5caLqvNIihhl5dfJXi2Urbrf5Sp58oNYp7da7s8H9zzP/vW1KLMUZiYZazEXFiQDqtzAF
 RgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-29.tower-591.messagelabs.com!1645005855!5887!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15063 invoked from network); 16 Feb 2022 10:04:15 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-29.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Feb 2022 10:04:15 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id E94C0100463
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:04:14 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id DBA65100461
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:04:14 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Wed, 16 Feb 2022 10:04:11 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 16 Feb 2022 18:04:24 +0800
Message-ID: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] kcmp.h: move it to ltp include/lapi directory
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

So other test case can call kcmp directly just include lapi/kcmp.h.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 {testcases/kernel/syscalls/kcmp => include/lapi}/kcmp.h | 0
 testcases/kernel/syscalls/kcmp/kcmp01.c                 | 2 +-
 testcases/kernel/syscalls/kcmp/kcmp02.c                 | 2 +-
 testcases/kernel/syscalls/kcmp/kcmp03.c                 | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename {testcases/kernel/syscalls/kcmp => include/lapi}/kcmp.h (100%)

diff --git a/testcases/kernel/syscalls/kcmp/kcmp.h b/include/lapi/kcmp.h
similarity index 100%
rename from testcases/kernel/syscalls/kcmp/kcmp.h
rename to include/lapi/kcmp.h
diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
index a03a25a2b..903525ff0 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp01.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
@@ -15,7 +15,7 @@
 
 #include "tst_test.h"
 #include "lapi/fcntl.h"
-#include "kcmp.h"
+#include "lapi/kcmp.h"
 
 #define TEST_FILE "test_file"
 #define TEST_FILE2 "test_file2"
diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
index 993d9a4a4..ab07bb866 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp02.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -17,7 +17,7 @@
 
 #include "tst_test.h"
 #include "lapi/fcntl.h"
-#include "kcmp.h"
+#include "lapi/kcmp.h"
 
 #define TEST_FILE "test_file"
 #define TEST_FILE2 "test_file2"
diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index df8633c5f..4b90e6d87 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -20,7 +20,7 @@
 #include <stdlib.h>
 #include <sys/wait.h>
 #include "tst_test.h"
-#include "kcmp.h"
+#include "lapi/kcmp.h"
 #include "lapi/sched.h"
 
 #define STACK_SIZE	(1024*1024)
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
