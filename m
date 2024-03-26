Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA90C54E67
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 14:42:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1997F3D0EB2
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 15:42:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14B2F3CFED1
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:41:50 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9844F60081C
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:41:49 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06E8437CD0;
 Tue, 26 Mar 2024 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yl9cncS3BgAmk/NMcUayNglC+KbipLJ1paf+ARmNtoc=;
 b=f6vWTEKmbmfk8PX+Yc3qxLBybq1sGpB0UxGIJ+pReoVhhXOh6vWf6fpOdkeWNYsDi3j27X
 /0S8FNif/B5FtvKVMK1XF/4N7d/OHeMnBfF5rmXmGV+7xgo8JStuN+VW6o+i+ndQxqQzG7
 LxmPOQCwUmQdV471pvtLBwxUDwdEOus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yl9cncS3BgAmk/NMcUayNglC+KbipLJ1paf+ARmNtoc=;
 b=ziUMTIzC0+qQni9tkB3WXKcYAbtx3dgE1x9lLhtSQM2Efh38/eXRies2POS/yn6zVkgnX1
 7jhYLF2DS/cdDLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yl9cncS3BgAmk/NMcUayNglC+KbipLJ1paf+ARmNtoc=;
 b=f6vWTEKmbmfk8PX+Yc3qxLBybq1sGpB0UxGIJ+pReoVhhXOh6vWf6fpOdkeWNYsDi3j27X
 /0S8FNif/B5FtvKVMK1XF/4N7d/OHeMnBfF5rmXmGV+7xgo8JStuN+VW6o+i+ndQxqQzG7
 LxmPOQCwUmQdV471pvtLBwxUDwdEOus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yl9cncS3BgAmk/NMcUayNglC+KbipLJ1paf+ARmNtoc=;
 b=ziUMTIzC0+qQni9tkB3WXKcYAbtx3dgE1x9lLhtSQM2Efh38/eXRies2POS/yn6zVkgnX1
 7jhYLF2DS/cdDLDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D5FFA13AF2;
 Tue, 26 Mar 2024 14:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id yGFYMqzeAmYTTAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 26 Mar 2024 14:41:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 Mar 2024 15:41:43 +0100
Message-ID: <20240326144145.747735-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326144145.747735-1-pvorel@suse.cz>
References: <20240326144145.747735-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] lib: Add tst_selinux_enforcing()
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Co-developed-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
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
