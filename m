Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D86EF8FEB
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:12:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C1E43DC870
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:12:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A1AC3CD1F8
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 15:12:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9E48600B31
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 15:12:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D2395BD65
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772633547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiKRts17DDBpAMTWVvdXlEllrTCGPDo9paX0t94W0Po=;
 b=e15QbsoO3ot2neV4+pCFGTLlyC41/LPZjqEI071zYRyYJ2HBXbUiOjPITL9qYmkmnTwURW
 ASzUsUBCPw5KktoLhRIhDFlwM4nccOgq9enjRWoSb2Cqm90F6oKaDKh2cK+1OcTZFYwlLJ
 LWD7c7c6O9HgOi5U7hjL3kl0xviWgtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772633547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiKRts17DDBpAMTWVvdXlEllrTCGPDo9paX0t94W0Po=;
 b=ZdVZNZN/iqo4aAxyi+qz9dAIuw5266CsHLv9R5z9FAV1Sh3TQTiLnbThNkWfb4G5HEsvjK
 UNWGS1rW1xZNxKBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772633547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiKRts17DDBpAMTWVvdXlEllrTCGPDo9paX0t94W0Po=;
 b=e15QbsoO3ot2neV4+pCFGTLlyC41/LPZjqEI071zYRyYJ2HBXbUiOjPITL9qYmkmnTwURW
 ASzUsUBCPw5KktoLhRIhDFlwM4nccOgq9enjRWoSb2Cqm90F6oKaDKh2cK+1OcTZFYwlLJ
 LWD7c7c6O9HgOi5U7hjL3kl0xviWgtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772633547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiKRts17DDBpAMTWVvdXlEllrTCGPDo9paX0t94W0Po=;
 b=ZdVZNZN/iqo4aAxyi+qz9dAIuw5266CsHLv9R5z9FAV1Sh3TQTiLnbThNkWfb4G5HEsvjK
 UNWGS1rW1xZNxKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE1553EA69
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NPTvOMo9qGl1fwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 14:12:26 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Mar 2026 15:12:34 +0100
Message-ID: <20260304141236.9080-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304141236.9080-1-chrubis@suse.cz>
References: <20260304141236.9080-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tst_test_macros: Add TST_EXP_LE_LU*()
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

For less or equal comparsions.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test_macros.h | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index ee6599df2..3d2287753 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -693,6 +693,51 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	}                                                                      \
 } while (0)
 
+#define TST_EXP_LE_SILENT_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {       \
+	TYPE tst_tmp_a__ = VAL_A;                                              \
+	TYPE tst_tmp_b__ = VAL_B;                                              \
+                                                                               \
+	TST_PASS = 0;                                                          \
+                                                                               \
+	if (tst_tmp_a__ > tst_tmp_b__) {                                       \
+		tst_res_(__FILE__, __LINE__, TFAIL,                            \
+			SVAL_A " (" PFS ") > " SVAL_B " (" PFS ")",            \
+			tst_tmp_a__, tst_tmp_b__);                             \
+	} else {                                                               \
+		TST_PASS = 1;                                                  \
+	}                                                                      \
+} while (0)
+
+/**
+ * TST_EXP_LE_LU() - Compare two unsigned long long values, expect A <= B.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Reports a pass if A <= B and a fail otherwise.
+ */
+#define TST_EXP_LE_LU(VAL_A, VAL_B) do {                                              \
+	TST_EXP_LE_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu"); \
+									              \
+	if (TST_PASS) {                                                               \
+		tst_res_(__FILE__, __LINE__, TPASS,                                   \
+			#VAL_A " <= " #VAL_B " (%llu <= %llu)",                       \
+			(unsigned long long)VAL_A, (unsigned long long)VAL_B);        \
+	}                                                                             \
+} while (0)
+
+/**
+ * TST_EXP_LE_LU_SILENT() - Compare two unsigned long long values, silent variant.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Unlike TST_EXP_LE_LU() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
+#define TST_EXP_LE_LU_SILENT(VAL_A, VAL_B) \
+	TST_EXP_LE_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
+
 /**
  * TST_EXP_EQ_LI() - Compare two long long values.
  *
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
