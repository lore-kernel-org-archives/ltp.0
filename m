Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C3CC0015E
	for <ltp@archiver.kernel.org>; Thu, 27 Jul 2023 14:59:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C54DF3CE6C7
	for <ltp@archiver.kernel.org>; Thu, 27 Jul 2023 16:59:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 877A63C8AF1
 for <ltp@lists.linux.it>; Thu, 27 Jul 2023 16:58:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DEF2010000D8
 for <ltp@lists.linux.it>; Thu, 27 Jul 2023 16:58:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05EDD21A4A;
 Thu, 27 Jul 2023 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690469933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2M6FYNnK57ZjkMOBZPpZsk4jt+rPNi72rv94PbFXFoI=;
 b=diIb7/WBgeFJx4rX5ynLTdLei3axA5vf7T2AIgd9brFSDi3winUcyLcx+scEq8H3vETvHH
 6fKb65kFrrV4zUnVvwfWfQkZWqiOm9buUEoaFaIGcQp56O9K5ZbzWd1HPvmCd9diBxeCOc
 CQm2CtCECoaWiWpGEaUcECiSs+lE9Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690469933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2M6FYNnK57ZjkMOBZPpZsk4jt+rPNi72rv94PbFXFoI=;
 b=CKIUyh14YJVFjyYhgto1LmrWtXLrH7Hd4BpEmvgiWFmEyL4a3jgFB/30iCmSAryDn0JvDw
 iPlqMPcDxTso3ADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D56FA13902;
 Thu, 27 Jul 2023 14:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mZTsMiyGwmQkHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 27 Jul 2023 14:58:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Jul 2023 16:58:49 +0200
Message-ID: <20230727145849.1893-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_clocks: Fix unaddressable byte warning
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Valgrind complains about unaddressable byte:

tst_test.c:1559: TINFO: Timeout per run is 0h 00m 30s
==28379== Syscall param clock_gettime(tp) points to unaddressable byte(s)
==28379==    at 0x497D41D: syscall (in /usr/lib64/libc.so.6)
==28379==    by 0x412CCF: syscall_supported_by_kernel (tst_clocks.c:21)
==28379==    by 0x412CCF: tst_clock_gettime (tst_clocks.c:71)
==28379==    by 0x405A72: heartbeat (tst_test.c:1359)
==28379==    by 0x4063CB: testrun (tst_test.c:1443)
==28379==    by 0x4063CB: fork_testrun (tst_test.c:1593)
==28379==    by 0x40840B: tst_run_tcases (tst_test.c:1687)
==28379==    by 0x404CDD: main (tst_test.h:398)
==28379==  Address 0x0 is not stack'd, malloc'd or (recently) free'd

While this is not a real problem, because it is in the library, this
warning appears in every test, which can be confusing.

Fixes: 4ac3a9c92 ("syscalls: Don't pass struct timespec to tst_syscall()")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_clocks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 0417802fc..2144a6ae5 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -17,8 +17,9 @@ typedef int (*mysyscall)(clockid_t clk_id, void *ts);
 int syscall_supported_by_kernel(long sysnr)
 {
 	int ret;
+	struct timespec foo;
 
-	ret = syscall(sysnr, 0, NULL);
+	ret = syscall(sysnr, 0, &foo);
 	if (ret == -1 && errno == ENOSYS)
 		return 0;
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
