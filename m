Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7CBC433FE
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B9560C49
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31B9560C49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D3393C6723
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 18:01:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C238C3C66DA
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B483201035
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1A992195F
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635177647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNMZNKG93HJQDTs/G0Rzw+11IIHNeoVODdDlWphWhKQ=;
 b=GUABaX9S3cU5xj+YTibzigdbFEP7cvrLGVLwWjx9xSQxfcV9l0FGOKspol18vDeOBSlWSX
 qhT6qt/bqoCyMcp87vouwA2Pi8rV/YrBIVqD5Xk5C8XjIJ5oFSaEk7/33H9YBJXw2KeI+H
 V8E092H8rrU1VvA0Vb9iiq63jX5wQFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635177647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNMZNKG93HJQDTs/G0Rzw+11IIHNeoVODdDlWphWhKQ=;
 b=dEZ6cV/PlAcV0sRqXGSDDy1f78QX65REY32kdZGWbcbMPJARmAZ1sjLNMNB5UAJ8QiUdYw
 +hjgTYPhL/P/PQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC6EB13C39
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1LjTLa/UdmGgLAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Oct 2021 18:01:32 +0200
Message-Id: <20211025160134.9283-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025160134.9283-1-chrubis@suse.cz>
References: <20211025160134.9283-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] syscalls/gettimeofday02: Convert to
 tst_remaining_runtime()
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../syscalls/gettimeofday/gettimeofday02.c    | 35 ++-----------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index c0e56ed34..cdd5984b7 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -24,28 +24,15 @@
 #include "tst_timer.h"
 #include "lapi/syscalls.h"
 
-static volatile sig_atomic_t done;
-static char *str_rtime;
-static int rtime = 10;
-
-static void breakout(int sig)
-{
-	done = sig;
-}
-
 static void verify_gettimeofday(void)
 {
 	struct __kernel_old_timeval tv1, tv2;
 	unsigned long long cnt = 0;
 
-	done = 0;
-
-	alarm(rtime);
-
 	if (tst_syscall(__NR_gettimeofday, &tv1, NULL))
 		tst_brk(TFAIL | TERRNO, "gettimeofday() failed");
 
-	while (!done) {
+	while (tst_remaining_runtime()) {
 		if (tst_syscall(__NR_gettimeofday, &tv2, NULL))
 			tst_brk(TFAIL | TERRNO, "gettimeofday() failed");
 
@@ -63,26 +50,10 @@ static void verify_gettimeofday(void)
 	}
 
 	tst_res(TINFO, "gettimeofday() called %llu times", cnt);
-	tst_res(TPASS, "gettimeofday() monotonous in %i seconds", rtime);
-}
-
-static void setup(void)
-{
-	if (str_rtime) {
-		rtime = atoi(str_rtime);
-		if (rtime <= 0)
-			tst_brk(TBROK, "Invalid runtime '%s'", str_rtime);
-		tst_set_timeout(rtime + 60);
-	}
-
-	SAFE_SIGNAL(SIGALRM, breakout);
+	tst_res(TPASS, "gettimeofday() monotonous in %i seconds", test.max_runtime);
 }
 
 static struct tst_test test = {
-	.setup = setup,
-	.options = (struct tst_option[]) {
-		{"T:", &str_rtime, "-T len   Test iteration runtime in seconds"},
-		{},
-	},
+	.max_runtime = 10,
 	.test_all = verify_gettimeofday,
 };
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
