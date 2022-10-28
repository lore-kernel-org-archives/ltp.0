Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B6AECAAA1
	for <ltp@archiver.kernel.org>; Fri, 28 Oct 2022 03:21:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C4DF3CA91B
	for <ltp@archiver.kernel.org>; Fri, 28 Oct 2022 05:21:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 528D83C1BCA
 for <ltp@lists.linux.it>; Fri, 28 Oct 2022 05:21:16 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A7D5B1A00351
 for <ltp@lists.linux.it>; Fri, 28 Oct 2022 05:21:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666927274; x=1698463274;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FNZclwIqwqNZ4bEIncOybnSu0aMrpiXVYd5NWHN8lwg=;
 b=D+Nvh+fqSndYARulQh+pKRDeCuCVwDdNYnb0haxoTkhwXsQuKRlebbhl
 iu7GCD8fxw90j6If6UWwx75w8ICijLVb6s9STADfZQ0hE1vpBUdfHpqcM
 K52WCQ7ArFLuxeCkkvSU1pyj0VIdkOzpKlB+mJKZesIQzuvkirzK1E14u
 IuBRzIq/6V58fv1vnwO1cdlyUE2iD+3ENwPB2+jt8h1/KnIwymyBDlwLr
 4YCtx67Ssp0idUSfW4uDszXrCSPTS9N7EGbvWrtGzkguZP+ZAyIKoXw3Y
 ZFp3AZfScSSZJ6FT/++xyXsPqAwrZjLI2ahykATukE8T1AmduJD5KUjYM g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288794765"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; d="scan'208";a="288794765"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2022 20:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="627390902"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; d="scan'208";a="627390902"
Received: from yzhou-cometlake-client-platform.sh.intel.com ([10.239.161.131])
 by orsmga007.jf.intel.com with ESMTP; 27 Oct 2022 20:21:09 -0700
From: You Zhou <you.zhou@intel.com>
To: ltp@lists.linux.it
Date: Fri, 28 Oct 2022 11:21:03 +0800
Message-Id: <20221028032103.2050696-1-you.zhou@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setfsuid02: Fix a fake failure for setfsuid02
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

When run setfsuid02 case on x86_64 platform, I got a failure even if
the filesystem user ID is set successfully.
"
./setfsuid02
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
setfsuid02.c:31: TFAIL: setfsuid(invalid_fsuid) test for expected
			failure: retval 11 != 0: SUCCESS (0)

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0
"

On both success and failure, setfsuid syscall returns the previous
filesystem user ID of the caller. In this case, if case sets
filesystem user ID successfully for the first time, this syscall
can return the ID previously set for the second time.

Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: You Zhou <you.zhou@intel.com>
---
 testcases/kernel/syscalls/setfsuid/setfsuid02.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
index 850f17834..441d1e27a 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
@@ -28,8 +28,13 @@ static void run(void)
 	UID16_CHECK(invalid_uid, setfsuid);
 
 	TST_EXP_VAL_SILENT(SETFSUID(invalid_uid), current_uid);
+#if __x86_64__
+	TST_EXP_VAL(SETFSUID(invalid_uid), invalid_uid,
+		    "setfsuid(invalid_fsuid) test for expected failure:");
+#else
 	TST_EXP_VAL(SETFSUID(invalid_uid), current_uid,
 		    "setfsuid(invalid_fsuid) test for expected failure:");
+#endif
 }
 
 static struct tst_test test = {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
