Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95877C83F25
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 06:57:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DD513CCC54
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 08:57:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 884413C2E57
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 08:56:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CB9FF200ACA
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 08:56:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2151E21294;
 Tue, 22 Jul 2025 06:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753167404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRDn5fLn4MC1w7fnkX0NYSGyjqDIWvSG79VDIFkWuCo=;
 b=idVIPoHzZuXGUu/FOjXY1F5ChD8wuQOScLL0gdWq6LznTVjE5SnhZwmJXdSbXBom7TdCbx
 eL9mYWBuamiNDvTCUmj0Eri62JSvFc2M0HXaV1a3YDbNGOEKv+yQHQVlTfwArPjXCqMXx1
 CYYsXBDeN5fc4+d53rnOOUMFiip2Sac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753167404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRDn5fLn4MC1w7fnkX0NYSGyjqDIWvSG79VDIFkWuCo=;
 b=mLUXNG2jK2Y8jcTPW6+D0HARzOudDBrA64jccz00scK6OLWU1YgEdj/rVxC3EUwZx6kwjc
 393qPUTHbGiDEvDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=idVIPoHz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mLUXNG2j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753167404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRDn5fLn4MC1w7fnkX0NYSGyjqDIWvSG79VDIFkWuCo=;
 b=idVIPoHzZuXGUu/FOjXY1F5ChD8wuQOScLL0gdWq6LznTVjE5SnhZwmJXdSbXBom7TdCbx
 eL9mYWBuamiNDvTCUmj0Eri62JSvFc2M0HXaV1a3YDbNGOEKv+yQHQVlTfwArPjXCqMXx1
 CYYsXBDeN5fc4+d53rnOOUMFiip2Sac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753167404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRDn5fLn4MC1w7fnkX0NYSGyjqDIWvSG79VDIFkWuCo=;
 b=mLUXNG2jK2Y8jcTPW6+D0HARzOudDBrA64jccz00scK6OLWU1YgEdj/rVxC3EUwZx6kwjc
 393qPUTHbGiDEvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 018EC13A73;
 Tue, 22 Jul 2025 06:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eFIKOis2f2iKcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 22 Jul 2025 06:56:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 22 Jul 2025 08:55:56 +0200
MIME-Version: 1.0
Message-Id: <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
In-Reply-To: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753167403; l=1726;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=eRQwUjpYtadxi14KFl/szDdC6025JqOskfqqvQNLsBw=;
 b=TpmBDXKcudE8y+Owgg1PTzGODh575brfOSr1vCz0KSY6PMkqOZ638QOt0gcpqcceL7YGsZLLb
 1M7B5mUgArnB6Obi2k3biqhrnoolect7Gdkdqz5O8UcTaE9C+urcGo8
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 2151E21294
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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
index 7d929fafe729058f55b921bf5cf7806b253496e0..f4669c60fbcafeddcab23835ee8c568a4aab46c3 100644
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
+	if (tst_is_mounted(SELINUX_PATH))
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
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
