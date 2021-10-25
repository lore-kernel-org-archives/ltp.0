Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF1C433F5
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4849760C49
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4849760C49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BC6E3C66DA
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 18:01:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CF5D3C65E7
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7068601CC9
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 607541FD65
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635177645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/Az4qG5dVSc2mZGmz0eOkhcjxObrr1Ah80ld6iDlQQ=;
 b=qKtsod0bGC+f8yJKQkgLU29/hnXm6Un5wUGN+ZnbbpCvhQJnxbDNCtBjey0e1Xe28eU/VY
 efGIeypYU+RGMsdS4QTpZJyLMcKW5ZG+1UHNC/L27VabzryN97YlY+hRmrEsaKdkEf73o3
 qwiO83M27skefqd3hSSx8z533taMEZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635177645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/Az4qG5dVSc2mZGmz0eOkhcjxObrr1Ah80ld6iDlQQ=;
 b=ulrG7f/PugPcwpMO06j0E3wEdkljhDhe1nMW9ENsyIBVOnmaVl2tf3doECUFbfAzmRQ0qy
 KLcIMAxS4TLSrHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E12013C39
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sRPzEq3UdmGTLAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:45 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Oct 2021 18:01:29 +0200
Message-Id: <20211025160134.9283-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025160134.9283-1-chrubis@suse.cz>
References: <20211025160134.9283-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] lib: tst_test: Move timeout scaling out of
 fork_testrun()
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

There is no point in setting the results->timeout in each iteration of
the tests (either for .all_filesystems or .test_variants) and it's cleaner to
do this once at the start of the testrun.

This also fixes a case where .all_filesystems or .test_variants would
call tst_set_timeout() in a test setup() that would be changed back on
second and subsequent runs because we called the tst_set_timeout()
incorrectly at the start of the fork_testrun().

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 02ae28335..71e938466 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1348,7 +1348,7 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	return timeout * timeout_mul;
 }
 
-void tst_set_timeout(int timeout)
+static void set_timeout(int timeout)
 {
 	if (timeout == -1) {
 		tst_res(TINFO, "Timeout per run is disabled");
@@ -1363,24 +1363,22 @@ void tst_set_timeout(int timeout)
 	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
 		results->timeout/3600, (results->timeout%3600)/60,
 		results->timeout % 60);
+}
 
-	if (getpid() == lib_pid)
-		alarm(results->timeout);
-	else
-		heartbeat();
+void tst_set_timeout(int timeout)
+{
+	set_timeout(timeout);
+	heartbeat();
 }
 
 static int fork_testrun(void)
 {
 	int status;
 
-	if (tst_test->timeout)
-		tst_set_timeout(tst_test->timeout);
-	else
-		tst_set_timeout(300);
-
 	SAFE_SIGNAL(SIGINT, sigint_handler);
 
+	alarm(results->timeout);
+
 	test_pid = fork();
 	if (test_pid < 0)
 		tst_brk(TBROK | TERRNO, "fork()");
@@ -1467,6 +1465,11 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
+	if (tst_test->timeout)
+		set_timeout(tst_test->timeout);
+	else
+		set_timeout(300);
+
 	if (tst_test->test_variants)
 		test_variants = tst_test->test_variants;
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
