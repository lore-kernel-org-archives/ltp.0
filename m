Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172D8CA0ED3
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 12:45:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4560F3C4AED
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 14:45:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B29A3C4ADC
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 14:45:15 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1AB626233C4
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 14:45:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D8C01FBAF;
 Mon,  2 Sep 2024 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725281114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SY80tHsPhm1Z33xwuqBguKD8WRXFvnoeNAPZ6kkjc+M=;
 b=s8RT7Vld9JMg1BC/AgM1q0aLagG3Wi2Cw+LpHMdn4hg+90t/+Kn5CMJ6MfaaCB55hjS02t
 zgVMihH+KVgxdF8JDWkA2UJdKJx5TaUpBSKYUcF0hWKDPjN3jSJw63gpi0aSNpkx6IZzBz
 P5h0l8XMllQMRrEui59iaV/f2KMT554=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725281114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SY80tHsPhm1Z33xwuqBguKD8WRXFvnoeNAPZ6kkjc+M=;
 b=JUuodx9XSHpAsWg0lN/gh3OLrWvf+K3OGHvZjIhaE3w5ifp/f7xvwlyehMq5Vxxqkn5K7m
 8cqWfwVA06bjy8Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s8RT7Vld;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JUuodx9X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725281114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SY80tHsPhm1Z33xwuqBguKD8WRXFvnoeNAPZ6kkjc+M=;
 b=s8RT7Vld9JMg1BC/AgM1q0aLagG3Wi2Cw+LpHMdn4hg+90t/+Kn5CMJ6MfaaCB55hjS02t
 zgVMihH+KVgxdF8JDWkA2UJdKJx5TaUpBSKYUcF0hWKDPjN3jSJw63gpi0aSNpkx6IZzBz
 P5h0l8XMllQMRrEui59iaV/f2KMT554=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725281114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SY80tHsPhm1Z33xwuqBguKD8WRXFvnoeNAPZ6kkjc+M=;
 b=JUuodx9XSHpAsWg0lN/gh3OLrWvf+K3OGHvZjIhaE3w5ifp/f7xvwlyehMq5Vxxqkn5K7m
 8cqWfwVA06bjy8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C94A413AE0;
 Mon,  2 Sep 2024 12:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8FueJFmz1WbqFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Sep 2024 12:45:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Sep 2024 14:45:01 +0200
MIME-Version: 1.0
Message-Id: <20240902-fcntl4_refactoring-v4-1-4446517da427@suse.com>
References: <20240902-fcntl4_refactoring-v4-0-4446517da427@suse.com>
In-Reply-To: <20240902-fcntl4_refactoring-v4-0-4446517da427@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725281112; l=5411;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=UAT3pHTB+AFVV/O5ZHG4XScafAP9nxaedGk2F+KvVi4=;
 b=vI3zknsXEZ5w70cDRYirSW+bzKxkhR7UBjruiNWNJxvPQhok1cCSWQK4Gvgd+wpe0L8M5rRVg
 Z07a51kdvKyBC/xYO9wR0Vxek0wtr03IdLaLbPKiQ20gwGiQA7Bd817
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 7D8C01FBAF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] Add silent macros for TST_EXP_EQ_*
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
index 7a443c803..3ca85a052 100644
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
+	}                                                                      \
+                                                                               \
+	TST_PASS = 1;                                                          \
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
