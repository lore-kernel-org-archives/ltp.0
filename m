Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C06D597BC
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 23:36:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC2373D6356
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 00:36:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49A7F3D6338
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 00:35:59 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7FE721BBFB43
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 00:35:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC9782121A;
 Tue, 12 Nov 2024 23:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731454557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hor05tk8B1aJUt1fnxWmKcf4z2JhvycoH24/jlMI0D8=;
 b=kBcVzMTFWVP2O6VT4pjzcP7Mg9Irka+/evOrQTUzhqU/dRMbGWU9Sczvq3bWfWIA+dVLBs
 3Dest9xeTGT/kTC0qNbLxUelJurZ4znUkN/F0MvFmflBsWIpEXHryvaMqCnsl2uEv5sxPe
 9k+6jvER6aicZKHOB9rPIjh+R/eZUXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731454557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hor05tk8B1aJUt1fnxWmKcf4z2JhvycoH24/jlMI0D8=;
 b=bNokeYd65vHQzcPGUwz1GlzG/dfeeDCNcZ1UClKKT0dkl7cjAhZki9lVe8NLi7Qv3eBRhh
 27Sz8eo1SdWDOWAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kBcVzMTF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bNokeYd6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731454557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hor05tk8B1aJUt1fnxWmKcf4z2JhvycoH24/jlMI0D8=;
 b=kBcVzMTFWVP2O6VT4pjzcP7Mg9Irka+/evOrQTUzhqU/dRMbGWU9Sczvq3bWfWIA+dVLBs
 3Dest9xeTGT/kTC0qNbLxUelJurZ4znUkN/F0MvFmflBsWIpEXHryvaMqCnsl2uEv5sxPe
 9k+6jvER6aicZKHOB9rPIjh+R/eZUXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731454557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hor05tk8B1aJUt1fnxWmKcf4z2JhvycoH24/jlMI0D8=;
 b=bNokeYd65vHQzcPGUwz1GlzG/dfeeDCNcZ1UClKKT0dkl7cjAhZki9lVe8NLi7Qv3eBRhh
 27Sz8eo1SdWDOWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B302313A8C;
 Tue, 12 Nov 2024 23:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4IjpKl3mM2fSFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Nov 2024 23:35:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 13 Nov 2024 00:35:53 +0100
Message-ID: <20241112233554.280518-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112233554.280518-1-pvorel@suse.cz>
References: <20241112233554.280518-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: CC9782121A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] kcmp02: Use TST_EXP_FAIL + print more info
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/kcmp/kcmp02.c | 35 +++++++++----------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
index c9481206b4..d5696b70c3 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp02.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -37,20 +37,22 @@ static int fd_fake = -1;
 #include <sys/wait.h>
 #include <limits.h>
 
+#define TYPE_DESC(x) .type = x, .desc = #x
 static struct test_case {
 	int *pid1;
 	int *pid2;
 	int type;
+	char *desc;
 	int *fd1;
 	int *fd2;
 	int exp_errno;
 } test_cases[] = {
-	{&pid1, &pid_unused, KCMP_FILE, &fd1, &fd2, ESRCH},
-	{&pid1, &pid1, KCMP_TYPES + 1, &fd1, &fd2, EINVAL},
-	{&pid1, &pid1, -1, &fd1, &fd2, EINVAL},
-	{&pid1, &pid1, INT_MIN, &fd1, &fd2, EINVAL},
-	{&pid1, &pid1, INT_MAX, &fd1, &fd2, EINVAL},
-	{&pid1, &pid1, KCMP_FILE, &fd1, &fd_fake, EBADF}
+	{&pid1, &pid_unused, TYPE_DESC(KCMP_FILE), &fd1, &fd2, ESRCH},
+	{&pid1, &pid1, TYPE_DESC(KCMP_TYPES + 1), &fd1, &fd2, EINVAL},
+	{&pid1, &pid1, TYPE_DESC(-1), &fd1, &fd2, EINVAL},
+	{&pid1, &pid1, TYPE_DESC(INT_MIN), &fd1, &fd2, EINVAL},
+	{&pid1, &pid1, TYPE_DESC(INT_MAX), &fd1, &fd2, EINVAL},
+	{&pid1, &pid1, TYPE_DESC(KCMP_FILE), &fd1, &fd_fake, EBADF}
 };
 
 static void setup(void)
@@ -73,24 +75,11 @@ static void cleanup(void)
 
 static void verify_kcmp(unsigned int n)
 {
-	struct test_case *test = &test_cases[n];
+	struct test_case *tc = &test_cases[n];
 
-	TEST(kcmp(*(test->pid1), *(test->pid2), test->type,
-		  *(test->fd1), *(test->fd2)));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "kcmp() succeeded unexpectedly");
-		return;
-	}
-
-	if (test->exp_errno == TST_ERR) {
-		tst_res(TPASS | TTERRNO, "kcmp() returned the expected value");
-		return;
-	}
-
-	tst_res(TFAIL | TTERRNO,
-		"kcmp() got unexpected return value: expected: %d - %s",
-			test->exp_errno, tst_strerrno(test->exp_errno));
+	TST_EXP_FAIL(kcmp(*(tc->pid1), *(tc->pid2), tc->type,
+		  *(tc->fd1), *(tc->fd2)), tc->exp_errno, "kcmp(%d,%d,%s,%d,%d)",
+				 *tc->pid1, *tc->pid2, tc->desc, *tc->fd1, *tc->fd2);
 }
 
 static struct tst_test test = {
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
