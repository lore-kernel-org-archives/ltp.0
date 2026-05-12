Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B978CD4F24
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 16:28:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 084B03D7A74
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 18:28:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA65A3CCB46
 for <ltp@lists.linux.it>; Tue, 12 May 2026 18:27:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 52E596000FD
 for <ltp@lists.linux.it>; Tue, 12 May 2026 18:27:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B3BF66DBF
 for <ltp@lists.linux.it>; Tue, 12 May 2026 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778603260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IXAZ2sb3g+QOSJCRhd5L1yY5tCtziuSmnYFb4G1+5xY=;
 b=ezWXi4DrYKuUcBgIgHzT72HWY8c6uW8t+Wbtip2w8OTIo6VH0y6Vd1z1IJSGEJderDH85g
 a9neSxwnLGre6bsVoVvM2159CuwlJHGhpQ9O893SA+L7KXJgKGulnXa9u5ePMn6OlGnbem
 NefxE8n9z2Jfa6OiKjodTZGgAjxspxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778603260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IXAZ2sb3g+QOSJCRhd5L1yY5tCtziuSmnYFb4G1+5xY=;
 b=2E3ccKB2VbHiLMqGgbQVhRsF5XVdngrkx7XYYdm+x+3TnkFDCTW8ZEg5+WEVXwB7Zz+Ju2
 +njqeubHpJrEWaCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ezWXi4Dr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2E3ccKB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778603260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IXAZ2sb3g+QOSJCRhd5L1yY5tCtziuSmnYFb4G1+5xY=;
 b=ezWXi4DrYKuUcBgIgHzT72HWY8c6uW8t+Wbtip2w8OTIo6VH0y6Vd1z1IJSGEJderDH85g
 a9neSxwnLGre6bsVoVvM2159CuwlJHGhpQ9O893SA+L7KXJgKGulnXa9u5ePMn6OlGnbem
 NefxE8n9z2Jfa6OiKjodTZGgAjxspxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778603260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IXAZ2sb3g+QOSJCRhd5L1yY5tCtziuSmnYFb4G1+5xY=;
 b=2E3ccKB2VbHiLMqGgbQVhRsF5XVdngrkx7XYYdm+x+3TnkFDCTW8ZEg5+WEVXwB7Zz+Ju2
 +njqeubHpJrEWaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70E55593A9
 for <ltp@lists.linux.it>; Tue, 12 May 2026 16:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5j1KG/xUA2oyDAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 12 May 2026 16:27:40 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 12 May 2026 18:27:16 +0200
Message-ID: <20260512162735.80055-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 7B3BF66DBF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add TST_EXP_FAIL_ARR_SILENT() helper macros
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

Add silent version of TST_EXP_FAIL() macros with the possibility
to check multiple expected errno values.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_test_macros.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 2cfbdb586..b1e74278d 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -675,6 +675,36 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
 	} while (0)
 
+/**
+ * TST_EXP_FAIL_ARR_SILENT() - Test syscall to fail with expected errnos, silent variant.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERRS: Array of expected errnos.
+ * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @...: A printf-like parameters.
+ *
+ * Unlike TST_EXP_FAIL_ARR() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
+#define TST_EXP_FAIL_ARR_SILENT(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)            \
+	TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL,                      \
+		EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__)
+
+/**
+ * TST_EXP_FAIL2_ARR_SILENT() - Test syscall to fail with expected errnos, silent variant.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERRS: Array of expected errnos.
+ * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @...: A printf-like parameters.
+ *
+ * Unlike TST_EXP_FAIL2_ARR() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
+#define TST_EXP_FAIL2_ARR_SILENT(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)           \
+	TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL,                     \
+		EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__)
+
 /**
  * TST_EXP_EXPR() - Check for expected expression.
  *
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
