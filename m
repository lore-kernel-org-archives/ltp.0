Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259EFCEDD89
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:06:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8FF23C2E96
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:05:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6F153C2B8B
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:45 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 947821402E04
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B6C71FE55;
 Wed,  9 Oct 2024 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwR/xJpgj+Z5shBdLF/Lid8wDOLZqMnSddGrPKHeyUA=;
 b=w5T98TIgh6VqAiN06vpMPrYCQlzqW5KCNVhZe0KXV4DhtxP7crDsTm5FdOQIBVHC6k+YDV
 UGTz5QhpgsAC/6+JpevuUTsD5yMmpVn7V7FKjJnp9k/m3i6/qpyHKJAv2zwup3/Fxu0WjP
 ofwR3P2ip4owog2SJfX947UtM7IOHw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwR/xJpgj+Z5shBdLF/Lid8wDOLZqMnSddGrPKHeyUA=;
 b=HLzyM5xbAjesyMPCRx9R2TFjHj61rmpf9xnpcdRLtVg1kP+vFcUCUx0cdz0TcMqyKPh/Qu
 mNcMl/n3ziTcJQAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwR/xJpgj+Z5shBdLF/Lid8wDOLZqMnSddGrPKHeyUA=;
 b=dMgoQIY7hEZXY2Qg4zpqQpp7EEkcK8PQ9WOHuKIPL+6v7NPKFvPnBAmHwBq7juTwKQZVPQ
 XkHVZpfyO2tXlbl6Aek+ttGlLHk8qrOsDE1nU4+dl+27Q+ilp38fH3kZDfsXl/y/wtWAWL
 5gG0rWtTBMW+OjA7v9jWyabQscCBvjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwR/xJpgj+Z5shBdLF/Lid8wDOLZqMnSddGrPKHeyUA=;
 b=Guc1R/u6Nc0BB6AX39SuRreba0GiHBTFUKN7qWR88gpmE4YDp02Gyzzt+cbnhFZUp23Fmp
 pbjGrT7O2A+AceDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFD1613AAF;
 Wed,  9 Oct 2024 12:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iICtMFpxBmfLEwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 12:04:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 14:04:37 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v8-2-182cd6557223@suse.com>
References: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
In-Reply-To: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728475481; l=1508;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=wKW7SkkBGBovvRLZKug6J5sa1QDffYz75+yHWRTN5ss=;
 b=fY/kr5SwQUfBBrAmgxNi17svQ1ZjdeJgORICg6NxsCv6QQTQWFwX9mxx+lnwvcu6iqQVcJnZe
 3DMZZ5gB8iJA9RuDoqy0gro7Z6GuBPrFedyaWBT4sLIMvPZ37CV5viG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 02/16] Add TST_EXP_EQ_STR macro
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_test_macros.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index c02ad38f9..b2ca32f77 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -411,4 +411,18 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 #define TST_EXP_EQ_SSZ_SILENT(VAL_A, VAL_B) \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
 
+#define TST_EXP_EQ_STR(STR_A, STR_B) do {                                      \
+	TST_PASS = strcmp(STR_A, STR_B) == 0;                                  \
+                                                                               \
+	if (TST_PASS) {                                                        \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			"%s == %s (%s)",                                       \
+			#STR_A, #STR_B, STR_B);                                \
+	} else {                                                               \
+		tst_res_(__FILE__, __LINE__, TFAIL,                            \
+			"%s (%s) != %s (%s)",                                  \
+			#STR_A, STR_A, #STR_B, STR_B);                         \
+	}                                                                      \
+} while (0)
+
 #endif	/* TST_TEST_MACROS_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
