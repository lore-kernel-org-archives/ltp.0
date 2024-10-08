Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C93CEF148
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 09:42:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 203AE3C1876
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:42:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63E5D3C0831
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:16 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A58BD1A027BD
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 90FF91FDC7;
 Tue,  8 Oct 2024 09:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwR/xJpgj+Z5shBdLF/Lid8wDOLZqMnSddGrPKHeyUA=;
 b=G37CL+r/MDiNuEGSi6nNY+hD7dlUa8PJ/91rWG/mT/rKiv92HXALH9fDJ6PzCZcp59j7q2
 nVVsc1ILHx+kNErheQ34db05/pURE0Rct4zUKMBIisCcPRrpWSbig0J20Q3AVCPuixLPiv
 ooiE8T2bo1/vyseeNrZUpp+N6Xttm0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwR/xJpgj+Z5shBdLF/Lid8wDOLZqMnSddGrPKHeyUA=;
 b=YilgjQZG/GZnxQmtmZdtcE5VcJcL8UC9fMY3lkGrmR/WFo8vNe/k0Lq9/ah2xqKbzpkrIJ
 7P+4WciMzAUDj9Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwR/xJpgj+Z5shBdLF/Lid8wDOLZqMnSddGrPKHeyUA=;
 b=G37CL+r/MDiNuEGSi6nNY+hD7dlUa8PJ/91rWG/mT/rKiv92HXALH9fDJ6PzCZcp59j7q2
 nVVsc1ILHx+kNErheQ34db05/pURE0Rct4zUKMBIisCcPRrpWSbig0J20Q3AVCPuixLPiv
 ooiE8T2bo1/vyseeNrZUpp+N6Xttm0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwR/xJpgj+Z5shBdLF/Lid8wDOLZqMnSddGrPKHeyUA=;
 b=YilgjQZG/GZnxQmtmZdtcE5VcJcL8UC9fMY3lkGrmR/WFo8vNe/k0Lq9/ah2xqKbzpkrIJ
 7P+4WciMzAUDj9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B73A1340C;
 Tue,  8 Oct 2024 09:42:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MGH2HXT+BGcZPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Oct 2024 09:42:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 11:41:55 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v5-2-66f4e1a9e7db@suse.com>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
In-Reply-To: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728380526; l=1508;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=wKW7SkkBGBovvRLZKug6J5sa1QDffYz75+yHWRTN5ss=;
 b=mRG/PSejtz7r3fVfCfGaG/RRtM4XfhHM1Qy5ibGMjgDFejCsW5fIEptMHUyLwX+BEto0Y77zr
 0FryIvvyM9iBwV+VQAtGmSZTerJG9vo5uIDcPsYmBFx5vA5MNIfqNvm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 02/16] Add TST_EXP_EQ_STR macro
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
