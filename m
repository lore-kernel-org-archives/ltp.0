Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E19EC28B2F
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 04:45:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34CF83CA60E
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 05:45:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B6533CA52E
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 05:44:54 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.92.39.34; helo=smtpbgjp3.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0535D1400073
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 05:44:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1741927483;
 bh=55Ex6J7AkkchK+z5NTOpwYHBNEPPw5pH8rFq+pZhIBY=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=JsY3yERWVnv0GtJ/PzyFTwFgTr1LSxqCupPMZLLsaEFEP0ZNDrV5jWsvpXl1xNbuh
 SOMiTE58uobqeVPhhGoBYRuYSgX2i5goAlUT2Ms/OGElomBu34rW2cRdhySaBDkUB0
 qaBNgdIozRD3FzcH44XLZE8b7xfoirgESWBtGbOs=
X-QQ-mid: bizesmtpsz8t1741927478t39hiap
X-QQ-Originating-IP: yhBdVk+AQmIUwokpWPvPSjVKtLZWUGNIGUIRDIykXS8=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 14 Mar 2025 12:44:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15718559028157922928
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 14 Mar 2025 12:42:57 +0800
Message-Id: <20250314044257.1673303-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: NDu8aKWRFc7D5nwLuLI0sReGCw+zTcYMo9UecIvSDhVzm/pN9BY6KHHP
 Kl6ZrvgxcwhFLs4Vbdit+6vQLqmamFWDLj69qraBK3L/nfBjGeTf3OarI325V/SO3DKGkI2
 4xx68XyVKa+KPqRvKVZ/CcWULx6yDPWMxu2XstYFLi9vHxrMKgNNAW3+TIl03owygp19CKq
 qQmfVcTftzCm5ojTYn/2AbFCA7E9CI2ueliGGwJCKMnGzNxY6tOJNXHa+J2ilmf9sxDhGUf
 nv+UbBoETSVj6RG0rSUmaI08cnZGS8Zw/g7cTazRidEBhwUilHT4KmkSfQ0xIswvHiY94FU
 qFcxHL23mCZTPwkDf1wX1M5Zz40K6Wgw9U5FFgExfInjQ8tfCIMmA4F/FsbWQGEj0ZTxXkG
 V8Y4a9IC6c6xXW7n0XmsiDAjdLq6QlPOpsNs1LQfilJkKdo7+lcIpdteL+qofnz3j+CZe6q
 /XU3YskAERYhVKDABwsqgOc9PiHrdihccNOsvbRnYBeVYBdEyh9eQ6ZVc4MLwCgeTKnliSq
 ZTyiGP7hFawmP8RNw0Md9+vjstP7ERrm6wppTiX2dRsmxR4L9g2MtU/0pr7cgHmqEB4JgSm
 wvAR8ECNMwItmm1DOwFjKHjmM2x+29uT52N5oKmH8I73UBZLGXlN3xCo3uVN/51V8PI0Rhq
 Zi0z9v/DQCHmewh229S0D3Zreoz/l2rLuhD2pDH2eglPAMSEJh1fSliTKCkEgukXN2GB7tW
 KsUsiSIroC83AmLiQ6EW1wkB11u4DXgqbQdIwGO/EDIi/moY3PENQKY4u+OaNJlT0kSG0ug
 9mc3gwOzYenmRe+BrgeHf6BQrOQ5KE3MncLHe+fjCGFbVJBmsUWe1Mtr4ibxIZ872tBD+WF
 zUzWzsAUjQq340tctbYWmtCS59t2PSTzBZOYn0HwpdXc5KoA2bsSnX9GrtFY/QvR1+HmDKO
 pkZ5n6NtzZ3nn8j8eiV36Y08J
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unshare03: using soft limit of NOFILE
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
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I think it's safer to set NOFILE increasing from soft limit than from
hard limit.

Hard limit may lead to dup2 ENOMEM error which bring the result to
TBROK on little memory machine. (e.g. 2GB memory in my situation, hard
limit in /proc/sys/fs/nr_open come out to be 1073741816)

Signed-off-by: lufei <lufei@uniontech.com>
---
 testcases/kernel/syscalls/unshare/unshare03.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
index 7c5e71c4e..bb568264c 100644
--- a/testcases/kernel/syscalls/unshare/unshare03.c
+++ b/testcases/kernel/syscalls/unshare/unshare03.c
@@ -24,7 +24,7 @@
 
 static void run(void)
 {
-	int nr_open;
+	int rlim_max;
 	int nr_limit;
 	struct rlimit rlimit;
 	struct tst_clone_args args = {
@@ -32,14 +32,12 @@ static void run(void)
 		.exit_signal = SIGCHLD,
 	};
 
-	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
-	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
+	rlim_max = rlimit.rlim_max;
 
-	nr_limit = nr_open + NR_OPEN_LIMIT;
+	nr_limit = rlim_max + NR_OPEN_LIMIT;
 	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_limit);
 
-	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
-
 	rlimit.rlim_cur = nr_limit;
 	rlimit.rlim_max = nr_limit;
 
@@ -47,10 +45,10 @@ static void run(void)
 	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
 		nr_limit);
 
-	SAFE_DUP2(2, nr_open + NR_OPEN_DUP);
+	SAFE_DUP2(2, rlim_max + NR_OPEN_DUP);
 
 	if (!SAFE_CLONE(&args)) {
-		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
+		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", rlim_max);
 		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
 		exit(0);
 	}
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
