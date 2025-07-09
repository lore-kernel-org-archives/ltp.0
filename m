Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E34EC83F09
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 11:38:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFC143CAB13
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 13:38:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4694A3CAC66
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 13:37:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A32C3600E2A
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 13:37:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6162821170;
 Wed,  9 Jul 2025 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752061061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ll7uIJoeoJjXk3Xh7TDjNszhy0Rsv70Z7wUV52FnD+4=;
 b=TDqUrL7xAS/2Qw8NMWTHxFnlj2pWaECiPuq6qm00nYLdg6L6A37KZtDOiurA2H7tQonOUP
 2Ghs5qzqhAziHL1pXGfe3Wc5KlGyI7B0VSheOgL8I/KPyq0zvfsK5hruaxyJYLGOnNWZlE
 rCD/kbej/+xrf1ZNCoRQ3GQsxBDy8ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752061061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ll7uIJoeoJjXk3Xh7TDjNszhy0Rsv70Z7wUV52FnD+4=;
 b=aTpxMzsyoN4DMq70etaf/jX3XK0L4D9UuZrpxrn5h/3nQqkE9SoIvxnWR/c5ZH6sTNxE0y
 CSvbzg6TD7c2i4Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752061061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ll7uIJoeoJjXk3Xh7TDjNszhy0Rsv70Z7wUV52FnD+4=;
 b=TDqUrL7xAS/2Qw8NMWTHxFnlj2pWaECiPuq6qm00nYLdg6L6A37KZtDOiurA2H7tQonOUP
 2Ghs5qzqhAziHL1pXGfe3Wc5KlGyI7B0VSheOgL8I/KPyq0zvfsK5hruaxyJYLGOnNWZlE
 rCD/kbej/+xrf1ZNCoRQ3GQsxBDy8ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752061061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ll7uIJoeoJjXk3Xh7TDjNszhy0Rsv70Z7wUV52FnD+4=;
 b=aTpxMzsyoN4DMq70etaf/jX3XK0L4D9UuZrpxrn5h/3nQqkE9SoIvxnWR/c5ZH6sTNxE0y
 CSvbzg6TD7c2i4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4749613998;
 Wed,  9 Jul 2025 11:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yEOyD4VUbmhhNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Jul 2025 11:37:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Jul 2025 13:36:59 +0200
MIME-Version: 1.0
Message-Id: <20250709-xattr_bug_repr-v3-1-379c2c291bb7@suse.com>
References: <20250709-xattr_bug_repr-v3-0-379c2c291bb7@suse.com>
In-Reply-To: <20250709-xattr_bug_repr-v3-0-379c2c291bb7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752061061; l=1767;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=FQPA7NQO+sYh9H+SZqtQmRmW830uOAJ+rKB566kt1SY=;
 b=Ugx+Jhlw/X6Q2GY3nLS6jJiNjh5UxnVXJSsSQsDCEs47bKN3HlRMf0K5PCaNDWKLmpdtbRBY0
 CT6w63LjwQtCtA0kqwFD9GzJ5SF7hJhkH6Iyi+RJ550PZYP0dJ8ay1g
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] core: add tst_selinux_enabled() utility
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

Add tst_selinux_enabled() utility in tst_security.h in order to verify
if SELinux is currently up and running in the system.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_security.h |  1 +
 lib/tst_security.c     | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/tst_security.h b/include/tst_security.h
index 5d91f8a98f104b0cafaaf2046bc0ceec06870606..cb5490a896f027245064abebb9d7c36270fd2e8a 100644
--- a/include/tst_security.h
+++ b/include/tst_security.h
@@ -14,5 +14,6 @@ int tst_fips_enabled(void);
 int tst_lockdown_enabled(void);
 int tst_secureboot_enabled(void);
 int tst_selinux_enforcing(void);
+int tst_selinux_enabled(void);
 
 #endif /* TST_SECURITY_H__ */
diff --git a/lib/tst_security.c b/lib/tst_security.c
index 7d929fafe729058f55b921bf5cf7806b253496e0..c07f783178fa81da84113d4582230a391ab35b43 100644
--- a/lib/tst_security.c
+++ b/lib/tst_security.c
@@ -7,7 +7,8 @@
 
 #define PATH_FIPS	"/proc/sys/crypto/fips_enabled"
 #define PATH_LOCKDOWN	"/sys/kernel/security/lockdown"
-#define SELINUX_STATUS_PATH "/sys/fs/selinux/enforce"
+#define SELINUX_PATH "/sys/fs/selinux"
+#define SELINUX_STATUS_PATH (SELINUX_PATH "/enforce")
 
 #if defined(__powerpc64__) || defined(__ppc64__)
 # define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
@@ -102,6 +103,18 @@ int tst_secureboot_enabled(void)
 	return data[VAR_DATA_SIZE - 1];
 }
 
+int tst_selinux_enabled(void)
+{
+	int res = 0;
+
+	if (access(SELINUX_PATH, F_OK) == 0 && !tst_dir_is_empty(SELINUX_PATH, 0))
+		res = 1;
+
+	tst_res(TINFO, "SELinux enabled: %s", res ? "yes" : "no");
+
+	return res;
+}
+
 int tst_selinux_enforcing(void)
 {
 	int res = 0;

-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
