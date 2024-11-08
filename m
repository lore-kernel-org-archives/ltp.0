Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BF2D5C0C1
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 12:22:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C66B03D491E
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 13:21:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44E213D48FE
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 13:21:44 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B6D5420098F
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 13:21:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0801821ADA;
 Fri,  8 Nov 2024 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731068502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dEPMrYYcLKWQf+MCsdr8i2GwXv1UvXPn2I5J0+xOe2I=;
 b=BCtpNZ0Zx8FRavA9P6vENDgiHiGI6ogOtBFSw3KdkSKHrqRNCCJaOwQlTWrdc4vmNVlyUw
 PHuZjt1arQVq5GOCEg+N7xh8LzkUtWntW+3MhaFwA7I3oKYNAa+G/4k03ZUAK4hYlpbrXu
 eGcxF2DOzuN7QIhgXsiTYzse6HN8Qz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731068502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dEPMrYYcLKWQf+MCsdr8i2GwXv1UvXPn2I5J0+xOe2I=;
 b=ga9JpL0b/P3vJy/2t23jnGi5DSnhZUcZGK0WQhaLB27G1f5FQlqX7d20gJNXZanMbueXsX
 gX9PuebXjoyGeHAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731068502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dEPMrYYcLKWQf+MCsdr8i2GwXv1UvXPn2I5J0+xOe2I=;
 b=BCtpNZ0Zx8FRavA9P6vENDgiHiGI6ogOtBFSw3KdkSKHrqRNCCJaOwQlTWrdc4vmNVlyUw
 PHuZjt1arQVq5GOCEg+N7xh8LzkUtWntW+3MhaFwA7I3oKYNAa+G/4k03ZUAK4hYlpbrXu
 eGcxF2DOzuN7QIhgXsiTYzse6HN8Qz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731068502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dEPMrYYcLKWQf+MCsdr8i2GwXv1UvXPn2I5J0+xOe2I=;
 b=ga9JpL0b/P3vJy/2t23jnGi5DSnhZUcZGK0WQhaLB27G1f5FQlqX7d20gJNXZanMbueXsX
 gX9PuebXjoyGeHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCC4813967;
 Fri,  8 Nov 2024 12:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3obNNFUCLmcHWwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Nov 2024 12:21:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Nov 2024 13:21:39 +0100
Message-ID: <20241108122139.87974-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] recvmmsg01: Workaround segfault on libc variant
 on 32 bit
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

EFAULT test segfaults on newer kernels (e.g. 6.4) on libc variant on
32bit.  Use typical LTP workaround to test by forked child + checking
the terminating signal.

NOTE: testing kernel variants could be done without forking child, but
use it as well for simplicity.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: working on other 3 tests affected by the same problem
(mq_timedreceive01.c, mq_timedsend01.c,  sigtimedwait01.c).

 .../kernel/syscalls/recvmmsg/recvmmsg01.c     | 48 +++++++++++++++----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
index fb21ea1e70..46658b133d 100644
--- a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
+++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
@@ -47,7 +47,7 @@ static struct test_case tcase[] = {
 		.desc = "bad message vector address",
 		.fd = &receive_sockfd,
 		.exp_errno = EFAULT,
-		.msg_vec = (void*)&bad_addr,
+		.msg_vec = (void *)&bad_addr,
 	},
 	{
 		.desc = "negative seconds in timeout",
@@ -74,23 +74,54 @@ static struct test_case tcase[] = {
 	}
 };
 
-static void do_test(unsigned int i)
+static void verify_recvmmsg(unsigned int i, void *timeout)
 {
 	struct time64_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
-	void *timeout;
 
 	ts.type = tv->ts_type;
 	tst_ts_set_sec(&ts, tc->tv_sec);
 	tst_ts_set_nsec(&ts, tc->tv_nsec);
 
+	TST_EXP_FAIL2(tv->recvmmsg(*tc->fd, *tc->msg_vec, VLEN, 0, timeout),
+		      tc->exp_errno, "recvmmsg() %s", tc->desc);
+}
+
+static void test_bad_addr(unsigned int i)
+{
+	struct time64_variants *tv = &variants[tst_variant];
+	void *timeout = bad_addr;
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		verify_recvmmsg(i, timeout);
+		_exit(!TST_PASS);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status))
+		return;
+
+	if (tv->ts_type == TST_LIBC_TIMESPEC &&
+		WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "Child killed by signal");
+		return;
+	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
+}
+
+static void do_test(unsigned int i)
+{
+	struct test_case *tc = &tcase[i];
+
 	if (tc->bad_ts_addr)
-		timeout = bad_addr;
+		test_bad_addr(i);
 	else
-		timeout = tst_ts_get(&ts);
-
-	TST_EXP_FAIL2(tv->recvmmsg(*tc->fd, *tc->msg_vec, VLEN, 0, timeout),
-	             tc->exp_errno, "recvmmsg() %s", tc->desc);
+		verify_recvmmsg(i, tst_ts_get(&ts));
 }
 
 static void setup(void)
@@ -139,6 +170,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
 		{&iov, .iov_sizes = (int[]){1, -1}},
 		{&msg, .size = VLEN * sizeof(*msg)},
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
