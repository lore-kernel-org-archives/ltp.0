Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169BCCDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:20:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90A303E533F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:20:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E5583E53A5
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 06E71600216
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D1B6176114
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GAuCzwUD3W+xuEwuC3VBhXda0wNHQjzL4AAj+vTfHo=;
 b=ZF8vcw9o/l1K8MekGR1s0SC28wzRFqm6243fFZLvRsZOgM/bAM0i7i0JQaq/EgvLfnUd5G
 e/+/iYjYsmLJkjsDQx4DfH50GuzKYtPkguL2XgVIpie/dhAb/YXmdGlKn+KbBtxCLl1xUI
 /MaKFv08zFuo+zBeH5FWFtl2DFQyPW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GAuCzwUD3W+xuEwuC3VBhXda0wNHQjzL4AAj+vTfHo=;
 b=WL1xgSUc5H1r6pJNnScBlGh0eWQL4kWCdiiK7ME2vXTl5az5ywLJGoQ5XKbFs4wAr3yNMu
 HZM7+nz+eIvzdnDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZF8vcw9o;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WL1xgSUc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GAuCzwUD3W+xuEwuC3VBhXda0wNHQjzL4AAj+vTfHo=;
 b=ZF8vcw9o/l1K8MekGR1s0SC28wzRFqm6243fFZLvRsZOgM/bAM0i7i0JQaq/EgvLfnUd5G
 e/+/iYjYsmLJkjsDQx4DfH50GuzKYtPkguL2XgVIpie/dhAb/YXmdGlKn+KbBtxCLl1xUI
 /MaKFv08zFuo+zBeH5FWFtl2DFQyPW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GAuCzwUD3W+xuEwuC3VBhXda0wNHQjzL4AAj+vTfHo=;
 b=WL1xgSUc5H1r6pJNnScBlGh0eWQL4kWCdiiK7ME2vXTl5az5ywLJGoQ5XKbFs4wAr3yNMu
 HZM7+nz+eIvzdnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 194B0779B0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PcQWBQehO2pSAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:03 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:53 +0200
Message-ID: <20260624091900.4107041-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D1B6176114
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/13] mem/ksm05: Add proper runtime support
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

The test was executed with -I 10 in all instances. It's cleaner to
define the min_runtime in the test and loop the test function until it's
exhausted.

One of the bonuses we get from this conversion is that the TPASS message
is printed once at the end of the test and we do not flood the logs.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/cve                      |  2 +-
 runtest/mm                       |  2 +-
 testcases/kernel/mem/ksm/ksm05.c | 27 ++++++++++++++++-----------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/runtest/cve b/runtest/cve
index cc664bb93..789e16aac 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -1,6 +1,6 @@
 # Tests which check for vulnerabilities by CVE number
 cve-2011-0999 thp01 -I 120
-cve-2011-2183 ksm05 -I 10
+cve-2011-2183 ksm05
 cve-2011-2496 vma03
 cve-2012-0957 uname04
 cve-2014-0196 cve-2014-0196
diff --git a/runtest/mm b/runtest/mm
index 7d75b65c8..98ec0a4c4 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -60,7 +60,7 @@ ksm03 ksm03
 ksm03_1 ksm03 -u 128
 ksm04 ksm04
 ksm04_1 ksm04 -u 128
-ksm05 ksm05 -I 10
+ksm05 ksm05
 ksm06 ksm06
 ksm06_1 ksm06 -n 10
 ksm06_2 ksm06 -n 8000
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 35197914e..0faba54b6 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -57,15 +57,6 @@ static void test_ksm(void)
 	long ps;
 	pid_t pid;
 	void *ptr;
-	struct sigaction sa;
-
-	memset (&sa, '\0', sizeof(sa));
-	sa.sa_handler = sighandler;
-	sa.sa_flags = 0;
-	TEST(sigaction(SIGSEGV, &sa, NULL));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TRERRNO,
-				"SIGSEGV signal setup failed");
 
 	ps = sysconf(_SC_PAGESIZE);
 
@@ -80,7 +71,20 @@ static void test_ksm(void)
 	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 		tst_brk(TBROK, "invalid signal received: %d", status);
 
-	tst_res(TPASS, "still alive.");
+}
+
+static void run(void)
+{
+	struct sigaction sa = {
+		.sa_handler = sighandler
+	};
+
+	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
+
+	while (tst_remaining_runtime())
+		test_ksm();
+
+	tst_res(TPASS, "Still alive");
 }
 
 static void sighandler(int sig)
@@ -91,7 +95,8 @@ static void sighandler(int sig)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.test_all = test_ksm,
+	.test_all = run,
+	.min_runtime = 10,
 	.save_restore = (const struct tst_path_val[]) {
 		{PATH_MM_KSM_RUN, "1", TST_SR_TBROK},
 		{PATH_MM_KSM_SMART_SCAN, "0",
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
