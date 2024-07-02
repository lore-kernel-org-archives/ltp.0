Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAE6C3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 14:13:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2C673D3ED7
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 16:13:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC7093D0F6E
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C7C391000B25
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4ED761FBA9;
 Tue,  2 Jul 2024 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWn4lYeNETVXNkW8z37Fw+Uaqo1ndnBSbd86bJquFxg=;
 b=iDDBGjAoeBIHv+NMTL7Nkg35tlg6x9y+I1ICiKc7pmlA6rfJhchjH0gMPlM8pAkxpHa4jL
 QrHG0FpAePgjNkI9mNVdeKLG/vTk6E/R5ZtOpaGV3OLWxmkGN0W2AwFHR1hRQeX4MxuT5x
 WXPLnTBqdwpQsRa6a696ZgG3bibHURA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWn4lYeNETVXNkW8z37Fw+Uaqo1ndnBSbd86bJquFxg=;
 b=xsK0A0yOv09sNTG8WIT4xDYGAvswnrZEMgDsuJL7UaG42reyzPgcObu7J+iZygK2aZfPHC
 Grk6XIR5MtDFqUAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iDDBGjAo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xsK0A0yO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWn4lYeNETVXNkW8z37Fw+Uaqo1ndnBSbd86bJquFxg=;
 b=iDDBGjAoeBIHv+NMTL7Nkg35tlg6x9y+I1ICiKc7pmlA6rfJhchjH0gMPlM8pAkxpHa4jL
 QrHG0FpAePgjNkI9mNVdeKLG/vTk6E/R5ZtOpaGV3OLWxmkGN0W2AwFHR1hRQeX4MxuT5x
 WXPLnTBqdwpQsRa6a696ZgG3bibHURA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWn4lYeNETVXNkW8z37Fw+Uaqo1ndnBSbd86bJquFxg=;
 b=xsK0A0yOv09sNTG8WIT4xDYGAvswnrZEMgDsuJL7UaG42reyzPgcObu7J+iZygK2aZfPHC
 Grk6XIR5MtDFqUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0623D13AAD;
 Tue,  2 Jul 2024 14:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kDscO/oKhGbpDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jul 2024 14:13:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jul 2024 16:12:48 +0200
MIME-Version: 1.0
Message-Id: <20240702-stat04-v1-2-e27d9953210d@suse.com>
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
In-Reply-To: <20240702-stat04-v1-0-e27d9953210d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=ItyrmYYpGLKmEy5DEusWRssMc9Zyn59MJMhuxag0AQI=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmhArvnGOlfUvvTWxUCiRImD8GQC3LeqDJM7Moq
 H/rP4aCZtiJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoQK7wAKCRDLzBqyILPm
 Rn6qC/9F+MDwq+GSVJ43mslEuK76aBgEf0oPajUAFrW3bdJN4Z/1aLjEfZF5baT6ZpnxaZhOPMI
 jcBK+Tqjk4C8cVzX2dVVQ8wVuprQQRbEy+u40krvEjsjXptewY9wdBxmaTjkYXxB4xe1j27E1OF
 /urVdFd5Y3owG4zQAmvWazALsCm81VtQWM1Y7g4wLPDK3Sz+Jd+3B1uoPzLx4KZ+sh1USlY+Onl
 PE4z3p4WbT//yaGGMzPZSRF9MNwucGOpoHEI1utXfcpZaoFG/BDx6dqjZapENstj99d/+/v2Gkr
 52+EYgHGcSbKYPrmkKhwoKNd+DhT6sKrRJ3EO3ImvJru30zDxwNu3PoxUQBlVwFTbhFERj8GSR6
 dO4+0iG9s9r8WQvwPaUYsP5Q5JOMV0x2ZgrTRSY769aZMDTDu2619DCzRrMIAgBQ2FY9nUSkLaD
 rF+Yw/1sMo1MVAxqMfMQnIDAg5i8tMtsX6+wp3okXwc8zxqdQj/FeCeCfct7mZzv3z0g4=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 4ED761FBA9
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] Fix TST_EXP_EXTR() stringification
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Follow the TST_* macros standards when it comes to stringification of
the expressions.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_test_macros.h               | 5 +++--
 testcases/kernel/syscalls/fork/fork04.c | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 22b39fb14..7a443c803 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -340,8 +340,9 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
 	} while (0)
 
-#define TST_EXP_EXPR(EXPR, FMT, ...)						\
-	tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: " FMT, ##__VA_ARGS__);
+#define TST_EXP_EXPR(EXPR, ...)                                              \
+       tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: "       \
+                TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, #EXPR), __VA_ARGS__));
 
 #define TST_EXP_EQ_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {\
 	TYPE tst_tmp_a__ = VAL_A; \
diff --git a/testcases/kernel/syscalls/fork/fork04.c b/testcases/kernel/syscalls/fork/fork04.c
index b0c6bebe0..413cd5eb4 100644
--- a/testcases/kernel/syscalls/fork/fork04.c
+++ b/testcases/kernel/syscalls/fork/fork04.c
@@ -29,7 +29,7 @@ static void run_child(void)
 
 	TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
 		"%s environ variable has been inherited by the child",
-		ENV_KEY)
+		ENV_KEY);
 
 	tst_res(TINFO, "Unset %s environ variable inside child", ENV_KEY);
 
@@ -72,7 +72,7 @@ static void run(void)
 	} else {
 		TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
 			"%s environ variable is still present inside parent",
-			ENV_KEY)
+			ENV_KEY);
 	}
 
 	TST_CHECKPOINT_WAKE_AND_WAIT(0);
@@ -85,7 +85,7 @@ static void run(void)
 	else {
 		TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
 			"%s environ variable didn't change inside parent",
-			ENV_KEY)
+			ENV_KEY);
 	}
 }
 

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
