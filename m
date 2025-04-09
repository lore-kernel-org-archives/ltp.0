Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67501C36002
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 07:49:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4931E3CB3D5
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 09:49:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13EA23CA10A
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 09:49:37 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.243.244.52;
 helo=smtpbguseast3.qq.com; envelope-from=lufei@uniontech.com;
 receiver=lists.linux.it)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85283600763
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 09:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1744184971;
 bh=BQ+9fUCZL6GaEzMQ+xwH3wfAji78OrqBZHIgtSbCMjU=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=NN4Eb3qgqUagmVq9KUy+dVDCMexVUc5M0uCrkaIO8Wr7UM/FpKtn9RK3PLxRzRCqH
 Y6nM+yW47FV6odduUHsLK/LkC08lCwDEd0GHuCjx9xK7TkTxUm1oVbzBY6oEvmc7z6
 33AMPWnKBXq0ABv1PcHqqMN1WURBFX8nhgJ5tbxM=
X-QQ-mid: izesmtpsz17t1744184968tb46f9d
X-QQ-Originating-IP: 5GCdUXFFA1B+TLFlrnLtoa4Oo931Y+te7VyFri59ykM=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 09 Apr 2025 15:49:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3992680846467355153
EX-QQ-RecipientCnt: 5
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed,  9 Apr 2025 15:49:06 +0800
Message-Id: <20250409074906.128290-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250314044257.1673303-1-lufei@uniontech.com>
References: <20250314044257.1673303-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: N3LgZqaw0RikNfI/ThVtlFeVujHkUTxJqzRBD9hzMH9LTrjq+DDzTyzt
 F+dCmsiOI0MGUqWUcqXk4NGaHNhmwjRcFYENik/EPcVi2ke7kA8Iw5b8Qmcd+m6cpxTi0yd
 v4JfnCDxp7QgcfvdlfmgTnG/j/fIwIofXF9hwFtbGJUoXIRW9AdrP5DTNJWkO/n2qaxsizV
 oZW0u4dq0l/gARQmIFhxSfD/RvdjlgzSPst9g5SZqq2BMWr+m2eFUyb0ak69sRM2CN59BZd
 8fFc45WlLj2TpnzNJljDZBDc1ACTN2HiPTNAfMel1GfUSy7f4Qyfa5TIMbeY91QsRI2vLnh
 McCVwNt5AQmBw6hqsB0vz6id7Y6Za7ovChEv9dvKpHevdMpYaq2zVWaHmV3p+/wkIRs4u3j
 9XRMo9IbdfgbNERlpIqCBEj0cEgQKMzew1nIm9JIT6S+nuRch9huLm6PHRsyWgWk0+zqCiY
 L8TtrLi7qvQd24U2Tqgg3OKlikioLQjuIvoOIIyeXsf5Yrnyx2bzb/Z95XJRX2DfLsUMi1K
 O+rAVaKq0nzZmvZSAddAQiu3Yrzr/x8i83jky6YtVvGt+Qtn2XVfCQn83PGMvfzeh+ZuFOH
 /mUNaamsFFnvtZI1bnu+JPeMSWCtEQ7sXzPNT++N/tC/nqMMcjnzgsiW6ISQFijkPL3B4kV
 96E0r4zXv3M+JTFMw1g8w1iRcUK4T5Jn051ewXiIYBV6phNWB16lEgG6KV2OnVH/aopPP+N
 MmT7MYVxQ0YOFwHk4yOP0SRMpghLAAVdnd3t8L98KxJv2zh9ibM0hgYpueHXlvGuzWnk0BO
 Sy3uttGVUzqpw6DrycV/AmW6e/dWXMmN4rI0LOEGIceLv5jw5+Y7pbDAayiYioN/XyiTXrE
 AOg/Kdw37/mju9wxlJQjAWkjX0Q10tZvU1U+0GCcpFSCenAbqGhto4NWhnou55irZQz4SFR
 tMzu4A73qGuxXF/MXnOwSiZPTfGED2whubWlBCtm2o91/LPl0g0bBdwTp
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] unshare03: set nr_open with sizeof(long)*8
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

Set nr_open with sizeof(long)*8 to trigger EMFILE, instead of reading
number of filedescriptors limit.

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
