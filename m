Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370ACC54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 10:24:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AA2F3CFBEF
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 11:24:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4E4B3CE64F
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:22:59 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 64B7F140871B
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:22:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07FC420C96;
 Wed, 20 Mar 2024 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710930174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlegKgozGHmgTzqcKPuSDgkptWq68VO+JL9QMXbzYek=;
 b=1ruP9w31SC6Jzyo6f6hJUD5r490mhORvphxkcGOTCqiqkufZzfD1zBB1SLz9i0iYHTWmKL
 2HwY9jVkn0onfUO0xbE4eXhjKNg7r/FdaxoE7MPBe2gJhR6X/291fAftD+7c/P8kqcurlV
 2Kz8cjYYDIX6QpqtMkM7LnOxSIxL7iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710930174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlegKgozGHmgTzqcKPuSDgkptWq68VO+JL9QMXbzYek=;
 b=Qh4qyDOodbli+IcMp3eDhgsT6PxnAzTrjJiOJ58Q5zCscxVa+dH7PbCpUVKvrC5vPHYYRi
 teH6SDLslqsDGXAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710930174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlegKgozGHmgTzqcKPuSDgkptWq68VO+JL9QMXbzYek=;
 b=1ruP9w31SC6Jzyo6f6hJUD5r490mhORvphxkcGOTCqiqkufZzfD1zBB1SLz9i0iYHTWmKL
 2HwY9jVkn0onfUO0xbE4eXhjKNg7r/FdaxoE7MPBe2gJhR6X/291fAftD+7c/P8kqcurlV
 2Kz8cjYYDIX6QpqtMkM7LnOxSIxL7iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710930174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlegKgozGHmgTzqcKPuSDgkptWq68VO+JL9QMXbzYek=;
 b=Qh4qyDOodbli+IcMp3eDhgsT6PxnAzTrjJiOJ58Q5zCscxVa+dH7PbCpUVKvrC5vPHYYRi
 teH6SDLslqsDGXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0E1A136D6;
 Wed, 20 Mar 2024 10:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SM9lMv24+mWyaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 10:22:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Mar 2024 11:22:03 +0100
Message-ID: <20240320102204.475230-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320102204.475230-1-pvorel@suse.cz>
References: <20240320102204.475230-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1ruP9w31;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Qh4qyDOo
X-Spamd-Result: default: False [3.50 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.19)[-0.962];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 07FC420C96
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] lib: Add tst_selinux_enforcing()
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
Cc: Mete Durlu <meted@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>
Co-developed-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* Add selinux to tst_security.c instead of it's own C file.

 include/tst_security.h |  1 +
 lib/tst_security.c     | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/tst_security.h b/include/tst_security.h
index 438b16dbb..5d91f8a98 100644
--- a/include/tst_security.h
+++ b/include/tst_security.h
@@ -13,5 +13,6 @@ int tst_fips_enabled(void);
 
 int tst_lockdown_enabled(void);
 int tst_secureboot_enabled(void);
+int tst_selinux_enforcing(void);
 
 #endif /* TST_SECURITY_H__ */
diff --git a/lib/tst_security.c b/lib/tst_security.c
index 0fc704dfa..7d929fafe 100644
--- a/lib/tst_security.c
+++ b/lib/tst_security.c
@@ -7,6 +7,7 @@
 
 #define PATH_FIPS	"/proc/sys/crypto/fips_enabled"
 #define PATH_LOCKDOWN	"/sys/kernel/security/lockdown"
+#define SELINUX_STATUS_PATH "/sys/fs/selinux/enforce"
 
 #if defined(__powerpc64__) || defined(__ppc64__)
 # define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
@@ -16,6 +17,7 @@
 # define VAR_DATA_SIZE 5
 #endif
 
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/mount.h>
@@ -30,11 +32,11 @@ int tst_fips_enabled(void)
 {
 	int fips = 0;
 
-	if (access(PATH_FIPS, R_OK) == 0) {
+	if (access(PATH_FIPS, R_OK) == 0)
 		SAFE_FILE_SCANF(PATH_FIPS, "%d", &fips);
-	}
 
 	tst_res(TINFO, "FIPS: %s", fips ? "on" : "off");
+
 	return fips;
 }
 
@@ -99,3 +101,15 @@ int tst_secureboot_enabled(void)
 	tst_res(TINFO, "SecureBoot: %s", data[VAR_DATA_SIZE - 1] ? "on" : "off");
 	return data[VAR_DATA_SIZE - 1];
 }
+
+int tst_selinux_enforcing(void)
+{
+	int res = 0;
+
+	if (access(SELINUX_STATUS_PATH, F_OK) == 0)
+		SAFE_FILE_SCANF(SELINUX_STATUS_PATH, "%d", &res);
+
+	tst_res(TINFO, "SELinux enforcing: %s", res ? "on" : "off");
+
+	return res;
+}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
