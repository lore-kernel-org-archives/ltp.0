Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30550105F7A6
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 14:28:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE3033E12E9
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 15:28:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFB0B3E1A4A
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 42C23601060
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C9815BD20;
 Fri, 13 Mar 2026 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773411967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocHmv99kq1cchyILnqZJlf8DmRVZX802xHaBm8B7xpA=;
 b=LSv05zC62IccIMYc22eGBs/GNjMqLbCI4nLh4EyOW+tSSDxBfPJWFAn7dcBI/jRtHAK6yv
 /ccmqHDsDPUWYgw8ZK4N9gtX2lU8J9+PgQwpR16KEF4+EejXZr5d7S9MT/riKJpKDspqu0
 a6YkfRjGPHRUb4KmG6iHqKOs4EmsdcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773411967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocHmv99kq1cchyILnqZJlf8DmRVZX802xHaBm8B7xpA=;
 b=ZoFRxTCTPmC2ZxTjyEf8HIvg2PRogZh2yzGoJcc6djSJsWJOaS86Y1gC1u1Y1BbLVmybG2
 LJCUq3xmsa/b8vBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773411967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocHmv99kq1cchyILnqZJlf8DmRVZX802xHaBm8B7xpA=;
 b=LSv05zC62IccIMYc22eGBs/GNjMqLbCI4nLh4EyOW+tSSDxBfPJWFAn7dcBI/jRtHAK6yv
 /ccmqHDsDPUWYgw8ZK4N9gtX2lU8J9+PgQwpR16KEF4+EejXZr5d7S9MT/riKJpKDspqu0
 a6YkfRjGPHRUb4KmG6iHqKOs4EmsdcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773411967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocHmv99kq1cchyILnqZJlf8DmRVZX802xHaBm8B7xpA=;
 b=ZoFRxTCTPmC2ZxTjyEf8HIvg2PRogZh2yzGoJcc6djSJsWJOaS86Y1gC1u1Y1BbLVmybG2
 LJCUq3xmsa/b8vBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6F8840584;
 Fri, 13 Mar 2026 14:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +AYKKX4etGlfQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Mar 2026 14:26:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Mar 2026 15:25:58 +0100
Message-ID: <20260313142600.243939-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313142600.243939-1-pvorel@suse.cz>
References: <20260313142600.243939-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 4/6] run_shell_tcnt: Add test count also for
 test_all
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_test.sh shell API has TST_CNT=1 also for tests which are using only
$TST_TESTFUNC without $TST_CNT, i.e. when running only a single
function. Follow this approach. This will be reused in the following
commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Instead of this, we can just check for 1 or empty:
[ "$1" = 1 -o -z "1" ]

 testcases/lib/tst_run_shell.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index ab6f4fda58..6defa9f7e7 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -11,11 +11,6 @@
 
 static char *shell_filename;
 
-static void run_shell(void)
-{
-	tst_run_script(shell_filename, NULL);
-}
-
 static void run_shell_tcnt(unsigned int n)
 {
 	char buf[128];
@@ -26,6 +21,11 @@ static void run_shell_tcnt(unsigned int n)
 	tst_run_script(shell_filename, params);
 }
 
+static void run_shell(void)
+{
+	run_shell_tcnt(0);
+}
+
 static struct tst_test test = {
 	.runs_script = 1,
 };
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
