Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07155C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:45:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 912003C296A
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:45:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F10783C296A
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:30 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7713610072CC
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 609A81F453
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sq1jbEgyz+KAgbPRyLdDRUtxDIEe4TO0KEAF6HFNNvI=;
 b=1cRJXWI6Zjl+ieuDguUrBSUoiOhkSvNxvj0sOwfc8KmdYw+CbJy2fQ6HiKgAdNiidqLs8I
 TpjAgbwZjWQRhdaXlp78tx/NOpBPv2HDu/DK8WnJu1meg1Qruov4ZZe7d49FtpjdxlK0+7
 g4xOBYk2H/hkyx+XA4GuApqpxIXsNcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sq1jbEgyz+KAgbPRyLdDRUtxDIEe4TO0KEAF6HFNNvI=;
 b=ZSK+tUqF5IIh0D90HkLINPKdbll3j2aq2VmKQiQQ9e4rPdrmsN4kMvBeFlhR8795UwTi2b
 8W48F0YdNCwscaCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1cRJXWI6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZSK+tUqF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sq1jbEgyz+KAgbPRyLdDRUtxDIEe4TO0KEAF6HFNNvI=;
 b=1cRJXWI6Zjl+ieuDguUrBSUoiOhkSvNxvj0sOwfc8KmdYw+CbJy2fQ6HiKgAdNiidqLs8I
 TpjAgbwZjWQRhdaXlp78tx/NOpBPv2HDu/DK8WnJu1meg1Qruov4ZZe7d49FtpjdxlK0+7
 g4xOBYk2H/hkyx+XA4GuApqpxIXsNcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sq1jbEgyz+KAgbPRyLdDRUtxDIEe4TO0KEAF6HFNNvI=;
 b=ZSK+tUqF5IIh0D90HkLINPKdbll3j2aq2VmKQiQQ9e4rPdrmsN4kMvBeFlhR8795UwTi2b
 8W48F0YdNCwscaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57B731387C
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +Lw6Fe3Oj2erPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 17:44:21 +0100
Message-ID: <20250121164426.27977-8-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121164426.27977-1-mdoucha@suse.cz>
References: <20250121164426.27977-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 609A81F453
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 07/10] lib: Add helper function for reloading kernel
 modules
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_module.h |  3 +++
 lib/tst_module.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/tst_module.h b/include/tst_module.h
index 8bbaf08f3..e55321d19 100644
--- a/include/tst_module.h
+++ b/include/tst_module.h
@@ -47,4 +47,7 @@ static inline void tst_requires_module_signature_disabled(void)
 	tst_requires_module_signature_disabled_();
 }
 
+void tst_modprobe(const char *mod_name, char *const argv[]);
+void tst_module_reload(const char *mod_name, char *const argv[]);
+
 #endif /* TST_MODULE_H */
diff --git a/lib/tst_module.c b/lib/tst_module.c
index cec20524f..42d63ede6 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -146,3 +146,31 @@ void tst_requires_module_signature_disabled_(void)
 	if (tst_module_signature_enforced_())
 		tst_brkm(TCONF, NULL, "module signature is enforced, skip test");
 }
+
+void tst_modprobe(const char *mod_name, char *const argv[])
+{
+	const int offset = 2; /* command name & module path */
+	int i, size = 0;
+
+	while (argv && argv[size])
+		++size;
+	size += offset;
+
+	const char *mod_argv[size + 1]; /* + NULL in the end */
+
+	mod_argv[size] = NULL;
+	mod_argv[0] = "modprobe";
+	mod_argv[1] = mod_name;
+
+	for (i = offset; i < size; ++i)
+		mod_argv[i] = argv[i - offset];
+
+	tst_cmd(NULL, mod_argv, NULL, NULL, 0);
+}
+
+void tst_module_reload(const char *mod_name, char *const argv[])
+{
+	tst_resm(TINFO, "Reloading kernel module %s", mod_name);
+	tst_module_unload_(NULL, mod_name);
+	tst_modprobe(mod_name, argv);
+}
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
