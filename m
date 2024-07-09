Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FF7C3DA42
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 10:46:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FD5B3D392E
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:46:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F6993D0CD5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:57 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 13C512000BC
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 904811F7B3;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hq8mQtgVpW30wmTOInD0zdVl9dzrzV34BCMhIE7mLU4=;
 b=HJxJ5lS1cpGZp1okcC/mLm65QIhGp15ZkEmHFM/LODeRRzEFbG0Fqf1Q2U5CdDZUe3yUvF
 l/BrL3YbdYIX57LzHtAxXHEpQf+DKEH2nWg1YB5npfnMGU0qug3KTmRHL6+J/9fMqZJ749
 lxe74+UWJOhydNlxpsyyw0LLstfJR0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hq8mQtgVpW30wmTOInD0zdVl9dzrzV34BCMhIE7mLU4=;
 b=2OAFAXPW0SbSfnZH4J1SaVcE//ODoXtiXl45xu6mAMA6uNqnigieQvx+LLr/j/numEQ54A
 554brTYy8a9pLFCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HJxJ5lS1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2OAFAXPW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hq8mQtgVpW30wmTOInD0zdVl9dzrzV34BCMhIE7mLU4=;
 b=HJxJ5lS1cpGZp1okcC/mLm65QIhGp15ZkEmHFM/LODeRRzEFbG0Fqf1Q2U5CdDZUe3yUvF
 l/BrL3YbdYIX57LzHtAxXHEpQf+DKEH2nWg1YB5npfnMGU0qug3KTmRHL6+J/9fMqZJ749
 lxe74+UWJOhydNlxpsyyw0LLstfJR0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hq8mQtgVpW30wmTOInD0zdVl9dzrzV34BCMhIE7mLU4=;
 b=2OAFAXPW0SbSfnZH4J1SaVcE//ODoXtiXl45xu6mAMA6uNqnigieQvx+LLr/j/numEQ54A
 554brTYy8a9pLFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CD621369A;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +ByuFOQUjWaBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 09 Jul 2024 10:45:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 09 Jul 2024 12:45:32 +0200
MIME-Version: 1.0
Message-Id: <20240709-stat04-v2-2-2693a473a2ab@suse.com>
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
In-Reply-To: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=IKZyyaaVbgL0KMWLO8D92w1vzje10jrU2Hiqg5gE9Zs=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjRTXVSx5TIWJ9hj+iCL8e/TWayZm3dEBBmbDR
 fadAo3bZfaJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo0U1wAKCRDLzBqyILPm
 Ri9tDACk7L/yIDuQmObR/qi4IFwr8pRQzU/hXUkzLPdAvVYsMRqsaRgusw9qA9Je3Azn1bzBUVa
 b0Vo85ZQBM72WIeAEDIbb3X5fzj1n4JKyG1d0a50u9m1g5BiFXQ6rOv1xC9HldrD1Ecw3lqgMe+
 cmh12lnOIf2D6bfPOjMcuCGXP4KNnGcAy0SXsohkxnVp5+ZPfrT/WH/3iXIooVvyF8++6aoLX45
 0CkZX16QukYkqb81nVAnTFlRxByw0MnUHLv793xkIW4BVItuNtMJVGSgdFFgG4yyMQwjxP2TK3Z
 JtMS2g4XXmaoMsM2obEdsuGRu0WUvnhQIHp1Ryuqb+n7823i8AIjw4KLEjImx63ZHvfCLOIzB51
 cHEgdrxXy+tsm4rUmT6QsDn7ThOucpFNgjM2EPRwpwSOWCw1awWZtqegBbkB+rYPRiTx6rJ28Us
 MjcCD7RF90PsAevld0u2zX1rdKhDrpQJ7Aom85L/ABhQdX16BFwJNOCbDdkVn739CRIc8=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 904811F7B3
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] Fix TST_EXP_EXTR() stringification
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

Reviewed-by: Li Wang <liwang@redhat.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
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
