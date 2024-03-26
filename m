Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BA5C6FD1F
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 14:42:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BBEB3D0EC2
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 15:42:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3498D3CC7D4
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:41:50 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A6E38601088
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:41:49 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 32AC837CD1;
 Tue, 26 Mar 2024 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxmstvNkto+i2LYJrZU+n/yj3AXoImdkhfgXduDBfpM=;
 b=cXvqpWVdnE/kuP8vd4llvmtR/EHHqv+Is7QTi4MIgAnBuqpZtiTFiZ7qtnLZJ7mFrUrnU9
 PSu0XdHJivjArbd7c6L5p5rCW+/F+1HgZtFewx+3/dD5p+kF73j9JTlC2Gw43Fj58WxA15
 6dzIHMtOq5L8qk/ChqddguX4lP4yiQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxmstvNkto+i2LYJrZU+n/yj3AXoImdkhfgXduDBfpM=;
 b=4/GA1+EHMGOOfGe4wd8JlA7kXk1EjROf7RrTThntcHEhrdRYfjP0R5VKZDGV30SlnO7R7V
 QKOm8ZD9QqrSPwAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxmstvNkto+i2LYJrZU+n/yj3AXoImdkhfgXduDBfpM=;
 b=cXvqpWVdnE/kuP8vd4llvmtR/EHHqv+Is7QTi4MIgAnBuqpZtiTFiZ7qtnLZJ7mFrUrnU9
 PSu0XdHJivjArbd7c6L5p5rCW+/F+1HgZtFewx+3/dD5p+kF73j9JTlC2Gw43Fj58WxA15
 6dzIHMtOq5L8qk/ChqddguX4lP4yiQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxmstvNkto+i2LYJrZU+n/yj3AXoImdkhfgXduDBfpM=;
 b=4/GA1+EHMGOOfGe4wd8JlA7kXk1EjROf7RrTThntcHEhrdRYfjP0R5VKZDGV30SlnO7R7V
 QKOm8ZD9QqrSPwAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D95813215;
 Tue, 26 Mar 2024 14:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 2MmIAq3eAmYTTAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 26 Mar 2024 14:41:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 Mar 2024 15:41:44 +0100
Message-ID: <20240326144145.747735-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326144145.747735-1-pvorel@suse.cz>
References: <20240326144145.747735-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cXvqpWVd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="4/GA1+EH"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 32AC837CD1
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] tst_test_macros.h: Require to pass array size
 in TST_EXP_FAIL*_ARR()
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

Although having to pass ARRAY_SIZE() of the expected errnos is not
ideal, it gives more flexibility to the tests allowing to use just
portion of the array (will be used in fanotify14 in the next commit).

It looks to be better than keep introduce yet another functions.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test_macros.h                         | 8 ++++----
 lib/newlib_tests/test_macros02.c                  | 8 ++++----
 testcases/kernel/syscalls/readahead/readahead01.c | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index d2e50a219..6a7bcdce5 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -242,9 +242,9 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
                                   ##__VA_ARGS__);                              \
 	} while (0)
 
-#define TST_EXP_FAIL_ARR(SCALL, EXP_ERRS, ...)                                 \
+#define TST_EXP_FAIL_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                   \
 		TST_EXP_FAIL_ARR_(SCALL, #SCALL, EXP_ERRS,                     \
-				  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
+				  EXP_ERRS_CNT, ##__VA_ARGS__);
 
 #define TST_EXP_FAIL2_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)         \
 	do {                                                                   \
@@ -254,9 +254,9 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			TST_MSG_(TPASS | TTERRNO, " ", SSCALL, ##__VA_ARGS__); \
 	} while (0)
 
-#define TST_EXP_FAIL2_ARR(SCALL, EXP_ERRS, ...)                                \
+#define TST_EXP_FAIL2_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                \
 		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
-		                  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
+		                  EXP_ERRS_CNT, ##__VA_ARGS__);
 
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
 	do {                                                                   \
diff --git a/lib/newlib_tests/test_macros02.c b/lib/newlib_tests/test_macros02.c
index 6c1ca7a8a..8e5a83346 100644
--- a/lib/newlib_tests/test_macros02.c
+++ b/lib/newlib_tests/test_macros02.c
@@ -39,9 +39,9 @@ static void do_test(void)
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 	TST_EXP_FAIL(inval_ret_fn(), ENOTTY, "inval_ret_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL_ARR(fail_fn(), exp_errs_pass, "fail_fn()");
+	TST_EXP_FAIL_ARR(fail_fn(), exp_errs_pass, ARRAY_SIZE(exp_errs_pass), "fail_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL_ARR(fail_fn(), exp_errs_fail, "fail_fn()");
+	TST_EXP_FAIL_ARR(fail_fn(), exp_errs_fail, ARRAY_SIZE(exp_errs_fail), "fail_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 
 	tst_res(TINFO, "Testing TST_EXP_FAIL2 macro");
@@ -53,9 +53,9 @@ static void do_test(void)
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 	TST_EXP_FAIL2(inval_ret_fn(), ENOTTY, "inval_ret_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL2_ARR(fail_fn(), exp_errs_pass, "fail_fn()");
+	TST_EXP_FAIL2_ARR(fail_fn(), exp_errs_pass, ARRAY_SIZE(exp_errs_pass), "fail_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL2_ARR(fail_fn(), exp_errs_fail, "fail_fn()");
+	TST_EXP_FAIL2_ARR(fail_fn(), exp_errs_fail, ARRAY_SIZE(exp_errs_fail), "fail_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 }
 
diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index 0f610daf8..d4b3f306f 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -61,7 +61,7 @@ static void test_invalid_fd(struct tst_fd *fd)
 	int exp_errnos[] = {EBADF, EINVAL, ESPIPE};
 
 	TST_EXP_FAIL_ARR(readahead(fd->fd, 0, getpagesize()), exp_errnos,
-			"readahead() on %s", tst_fd_desc(fd));
+			ARRAY_SIZE(exp_errnos), "readahead() on %s", tst_fd_desc(fd));
 }
 
 static void test_readahead(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
