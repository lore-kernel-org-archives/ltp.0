Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F0FC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 09:31:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBA0D3CB5AF
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 11:31:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF5353CAE86
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 11:31:11 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.92.39.34; helo=smtpbgjp3.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D27B91A0088F
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 11:31:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1744363864;
 bh=SuMEp762eGLtzJJ7RvWmsJR9toiUXK7AnqoefGooP1E=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=VrFwv2akesgHxoEhbrSZcxp5rKC7rvsbDctyItDvKFx7DP+8txCGWZ+IRzxkexDEj
 l0VJVOLfQH7mx4XPWvk5sxMgoJK0mSPgR8GKjNKo4vBQnfoi0ZEv4jN+6EwIuY2izm
 7JSkVUY0840L5TgiQ5VFdIahdpanQhoiqHwjRiQc=
X-QQ-mid: bizesmtpsz8t1744363861tf0a86e
X-QQ-Originating-IP: S6sHpQOtWT3JrVK0PZzZeeSSnPYJ4uuG7sjE1ZTBu0g=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 11 Apr 2025 17:30:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16623960031988647301
EX-QQ-RecipientCnt: 7
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 17:30:49 +0800
Message-Id: <20250411093049.131850-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250409074906.128290-1-lufei@uniontech.com>
References: <20250409074906.128290-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MoZhE1FC+PwrVjYp8zQIHge3mEa79L+/aJ32fGt60/LrOKIZtCx/IJ1u
 q5cpV1eZsU12pxpc1NwUqT1hsKWneADGxMqvUuVtXhaRH9DrS+eIJZ1Pb20APCP0HQwtS/X
 mapi61NYPqrvpAP3bRakVJlwyi1JyF/d6fMe+ogpFkkU6kaM4TZ98YJQduivhlg/qniKioj
 aJs4tYD4KNW2wK1MOmkH16/hUTesCJJosVfHx1rK8oQoNO8bp8o9FOXolZHYV4Xu/XtLrT+
 4VIUBMfna+asOYIp9HmArebAyZyKaRehbTY2y/fAOLNLFDO8vA+iZXcjSCQrOtlt29GsWyZ
 JgTXcVYc7MchSEqQh00GXJKXIoGYpRt0qtP/BspMrLQC8pHIav6opaXqzNzPaw/znSFD6C6
 qsiHnSGTxvdNMHvDhzZpVcyRhenrsim4t4jYdBKL070RMs0xP1Xeu/FZh0Vhb5XBh3AnaxY
 X+vKtooBGxnCU5crq7H1Ies4ZVlUwW1SuoJ9AwURO8O5PK2hKi/g5fQVscbKkTn/+0Kow+e
 UWNr5pc8UbQK8k/L6CTHQCsM0tAY3xHjVoqXCGF31kEsScyxINjNVPGPeKostojRLvYFWOs
 E8XRfIBkS+Dio3zQjCsLmBttWtmpGcFzT310+5dovwIacV8QvdT7aEtw17I0TjXxl5e5A6l
 e9oA4X+siW2jDHaFwWy1XlgJ0aSzdwgmxvCNT0EsSE6XeChup0x4N/9Fg/Mrrt+ao05pDqO
 NgzXksJz31y5u7D0QKgudP97/iFQsRH/E6K4yI+3IYAbnoR9Xs3UC5GrpXN0Xkznhaj/sxB
 KsNjLSJbkyJ95b+qaqLSrZturH2jL91yfy90+zgrnusdv8hg/Hy+Q+qSIRT7IWqr3dKkosc
 zOVg2IutYtzbORSsm4AwY7ad+gwDikYfENJ0sn4L+VZ+gidKZJJpO3EbXGt0IGbnTGTl8Ny
 JhtkquIr+wHwT5K/dd3sBNEJcvbxFw7U++r0jIls+GVcNdwbijGoIMYtzN2fnWYnRMnlcCd
 NKJhkT7Apj1SmPb5Pw
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] unshare03: set nr_open with sizeof(long)*8
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
Cc: lufei <lufei@uniontech.com>, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

dup2(2, nr_open+64) may cause ENOMEM error, which makes the testcase
BROKEN. Change to dup2(2, sizeof(long)*8 +1) and set nr_open to sizeof(long)*8

Signed-off-by: lufei <lufei@uniontech.com>
---
 testcases/kernel/syscalls/unshare/unshare03.c | 23 ++-----------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
index 7c5e71c4e..c3b98930d 100644
--- a/testcases/kernel/syscalls/unshare/unshare03.c
+++ b/testcases/kernel/syscalls/unshare/unshare03.c
@@ -17,44 +17,25 @@
 #include "lapi/sched.h"
 
 #define FS_NR_OPEN "/proc/sys/fs/nr_open"
-#define NR_OPEN_LIMIT 1024
-#define NR_OPEN_DUP 64
 
 #ifdef HAVE_UNSHARE
 
 static void run(void)
 {
-	int nr_open;
-	int nr_limit;
-	struct rlimit rlimit;
 	struct tst_clone_args args = {
 		.flags = CLONE_FILES,
 		.exit_signal = SIGCHLD,
 	};
 
-	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
-	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
+	int nr_open = sizeof(long) * 8;
 
-	nr_limit = nr_open + NR_OPEN_LIMIT;
-	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_limit);
-
-	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
-
-	rlimit.rlim_cur = nr_limit;
-	rlimit.rlim_max = nr_limit;
-
-	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlimit);
-	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
-		nr_limit);
-
-	SAFE_DUP2(2, nr_open + NR_OPEN_DUP);
+	SAFE_DUP2(2, nr_open + 1);
 
 	if (!SAFE_CLONE(&args)) {
 		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
 		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
 		exit(0);
 	}
-
 }
 
 static void setup(void)
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
