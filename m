Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B93FEE0215
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 08:06:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A27BD3C1C6A
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 10:06:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA2883C05E0
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:06:09 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 12969602AC6
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:06:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E416B219C8;
 Wed, 11 Sep 2024 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726041965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tgm+yDinrvdDXXov/DQUyH8ayUvx509pG5PAsPlg9E=;
 b=PSjuTiwwdHDq9BmjYqCOJ2T8L26L+mGMK4cPEJ5dEIyiKVle7jpwAT83ReGZvycbStLTnB
 3IJQoFSV5gHb/DEhIo6GvqRPhgNfp4rFfFnjThb1uXeByHIbxbkpl3JoWuIoPiFS7/N0xT
 kN63WP4MCdqH9fui5NdBAQ8W5BfsBKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726041965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tgm+yDinrvdDXXov/DQUyH8ayUvx509pG5PAsPlg9E=;
 b=o1Eqb9o8hp7axENt2ZACvh0okCYtpTFDz5SlIPu8/qgaKj78FIl+5M6zTSwdUPVhHiL6We
 rtbSvq0W9IZ/e6BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PSjuTiww;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o1Eqb9o8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726041965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tgm+yDinrvdDXXov/DQUyH8ayUvx509pG5PAsPlg9E=;
 b=PSjuTiwwdHDq9BmjYqCOJ2T8L26L+mGMK4cPEJ5dEIyiKVle7jpwAT83ReGZvycbStLTnB
 3IJQoFSV5gHb/DEhIo6GvqRPhgNfp4rFfFnjThb1uXeByHIbxbkpl3JoWuIoPiFS7/N0xT
 kN63WP4MCdqH9fui5NdBAQ8W5BfsBKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726041965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tgm+yDinrvdDXXov/DQUyH8ayUvx509pG5PAsPlg9E=;
 b=o1Eqb9o8hp7axENt2ZACvh0okCYtpTFDz5SlIPu8/qgaKj78FIl+5M6zTSwdUPVhHiL6We
 rtbSvq0W9IZ/e6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA63513A7E;
 Wed, 11 Sep 2024 08:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IM8DMG1P4Wb3VgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 11 Sep 2024 08:06:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Sep 2024 10:06:00 +0200
MIME-Version: 1.0
Message-Id: <20240911-fcntl4_refactoring-v5-1-948401e7131c@suse.com>
References: <20240911-fcntl4_refactoring-v5-0-948401e7131c@suse.com>
In-Reply-To: <20240911-fcntl4_refactoring-v5-0-948401e7131c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726041965; l=5397;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=3O4/RfVSWtS4BLqpiT0UoSABTLCW6QiXoeRI1fYdPNU=;
 b=2pP8VeUu0N9i921F9t15gQCG/gi9hhjFftyDkXgG1Sd8P9umPKkc+fjkFJRaYWWV/qyGw+DHg
 A+KhFngiHmYBYBgsHCD0oSJ+fbiOGzF3LoGvRb2zwfq6odco0trknJO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E416B219C8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] Add silent macros for TST_EXP_EQ_*
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

This patch adds the following macros:

TST_EXP_EQ_LI_SILENT
TST_EXP_EQ_LU_SILENT
TST_EXP_EQ_SZ_SILENT
TST_EXP_EQ_SSI_SILENT

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_test_macros.h | 81 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 19 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 7a443c803..4217700f3 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -344,29 +344,72 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
        tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: "       \
                 TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, #EXPR), __VA_ARGS__));
 
-#define TST_EXP_EQ_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {\
-	TYPE tst_tmp_a__ = VAL_A; \
-	TYPE tst_tmp_b__ = VAL_B; \
-	if (tst_tmp_a__ == tst_tmp_b__) { \
-		tst_res_(__FILE__, __LINE__, TPASS, \
-			SVAL_A " == " SVAL_B " (" PFS ")", tst_tmp_a__); \
-	} else { \
-		tst_res_(__FILE__, __LINE__, TFAIL, \
-			SVAL_A " (" PFS ") != " SVAL_B " (" PFS ")", \
-			tst_tmp_a__, tst_tmp_b__); \
-	} \
+#define TST_EXP_EQ_SILENT_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {       \
+	TYPE tst_tmp_a__ = VAL_A;                                              \
+	TYPE tst_tmp_b__ = VAL_B;                                              \
+                                                                               \
+	TST_PASS = 0;                                                          \
+                                                                               \
+	if (tst_tmp_a__ != tst_tmp_b__) {                                      \
+		tst_res_(__FILE__, __LINE__, TFAIL,                            \
+			SVAL_A " (" PFS ") != " SVAL_B " (" PFS ")",           \
+			tst_tmp_a__, tst_tmp_b__);                             \
+		break;                                                         \
+	} else {                                                               \
+		TST_PASS = 1;                                                  \
+	}                                                                      \
+} while (0)
+
+#define TST_EXP_EQ_LI(VAL_A, VAL_B) do {                                       \
+	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli");   \
+								               \
+	if (TST_PASS) {                                                        \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			#VAL_A " == " #VAL_B " (%lli)",                        \
+			(long long)VAL_A);                                     \
+	}                                                                      \
 } while (0)
 
-#define TST_EXP_EQ_LI(VAL_A, VAL_B) \
-		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli")
+#define TST_EXP_EQ_LI_SILENT(VAL_A, VAL_B) \
+	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli")
+
+#define TST_EXP_EQ_LU(VAL_A, VAL_B) do {                                       \
+	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu"); \
+								               \
+	if (TST_PASS) {                                                        \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			#VAL_A " == " #VAL_B " (%llu)",                        \
+			(unsigned long long)VAL_A);                            \
+	}                                                                      \
+} while (0)
 
-#define TST_EXP_EQ_LU(VAL_A, VAL_B) \
-		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
+#define TST_EXP_EQ_LU_SILENT(VAL_A, VAL_B) \
+	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
+
+#define TST_EXP_EQ_SZ(VAL_A, VAL_B) do {                                       \
+	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu");       \
+								               \
+	if (TST_PASS) {                                                        \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			#VAL_A " == " #VAL_B " (%zu)",                         \
+			(size_t)VAL_A);                                        \
+	}                                                                      \
+} while (0)
 
-#define TST_EXP_EQ_SZ(VAL_A, VAL_B) \
-		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu")
+#define TST_EXP_EQ_SZ_SILENT(VAL_A, VAL_B) \
+	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu")
+
+#define TST_EXP_EQ_SSZ(VAL_A, VAL_B) do {                                      \
+	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zi");       \
+								               \
+	if (TST_PASS) {                                                        \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			#VAL_A " == " #VAL_B " (%zi)",                         \
+			(ssize_t)VAL_A);                                        \
+	}                                                                      \
+} while (0)
 
-#define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
-		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
+#define TST_EXP_EQ_SSZ_SILENT(VAL_A, VAL_B) \
+	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
 
 #endif	/* TST_TEST_MACROS_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
