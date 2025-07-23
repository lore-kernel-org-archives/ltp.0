Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D76DC83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:06:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB6603CCD5A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 18:06:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 786933CCDC8
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 18:05:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F034510008FC
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 18:05:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66164218F7;
 Wed, 23 Jul 2025 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753286735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl9IZJLvzlNLVxm6hPwN2PQ9D2ggDcLaArM4eYPJ2gA=;
 b=muy8tU24QB4UkLoCSQQmkqLZQS/nzsoGLwoMZm0FxVAaSULPxcHpllZMkTLjOb/9H+Nd9a
 wEd1mMUZ9vIC30mrWfsJIGTZiaXJeVX7ul8uam0FqR9GXSGfrwzhNTpWV1d+PoS/8MrR1c
 gxupQxlaYgsNkimfy9GDxUpERwfVHw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753286735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl9IZJLvzlNLVxm6hPwN2PQ9D2ggDcLaArM4eYPJ2gA=;
 b=8SyqrqJjxJ7tL3tb+C+8s4c87WBCSrKgSZ/3x/spnQgrLldb69oOX3imfsD524qkuH+ZW2
 mrJ4Tyfo2t7aFwCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753286735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl9IZJLvzlNLVxm6hPwN2PQ9D2ggDcLaArM4eYPJ2gA=;
 b=muy8tU24QB4UkLoCSQQmkqLZQS/nzsoGLwoMZm0FxVAaSULPxcHpllZMkTLjOb/9H+Nd9a
 wEd1mMUZ9vIC30mrWfsJIGTZiaXJeVX7ul8uam0FqR9GXSGfrwzhNTpWV1d+PoS/8MrR1c
 gxupQxlaYgsNkimfy9GDxUpERwfVHw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753286735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl9IZJLvzlNLVxm6hPwN2PQ9D2ggDcLaArM4eYPJ2gA=;
 b=8SyqrqJjxJ7tL3tb+C+8s4c87WBCSrKgSZ/3x/spnQgrLldb69oOX3imfsD524qkuH+ZW2
 mrJ4Tyfo2t7aFwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39EB213ADD;
 Wed, 23 Jul 2025 16:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MKGBDE8IgWhiUAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 16:05:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 18:04:49 +0200
MIME-Version: 1.0
Message-Id: <20250723-xattr_bug_repr-v5-1-63183d865e97@suse.com>
References: <20250723-xattr_bug_repr-v5-0-63183d865e97@suse.com>
In-Reply-To: <20250723-xattr_bug_repr-v5-0-63183d865e97@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753286734; l=3980;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=TGmQZNBKhKrD3HH7q5OHz8ym1h+ql1UVZEYuoOfk5YU=;
 b=I+XNTeUMD3+lZW21hmifupVAffjgbOfTfVRFeEfv5VL9pAC3SKhDaqXfP0cRi4yognmx/FT5l
 6mx5KDObv4gDVoVH/NOnKufiM/Od0e/S7OxDZYjyLPux983gw9btNVE
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] core: add tst_selinux_enabled() utility
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

Add tst_lsm_enabled() utility in tst_security.h in order to verify
if a certain LSM is up and running.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Wei Gao <wegao@suse.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_security.h                     |  4 ++++
 lib/tst_security.c                         | 30 +++++++++++++++++++++++++-
 testcases/kernel/syscalls/lsm/lsm_common.h | 34 +++---------------------------
 3 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/include/tst_security.h b/include/tst_security.h
index 5d91f8a98f104b0cafaaf2046bc0ceec06870606..e2d7270daedcd5a303aa6a6184965cacf25c8fad 100644
--- a/include/tst_security.h
+++ b/include/tst_security.h
@@ -5,6 +5,10 @@
 #ifndef TST_SECURITY_H__
 #define TST_SECURITY_H__
 
+#define LSM_SYS_FILE "/sys/kernel/security/lsm"
+
+int tst_lsm_enabled(const char *name);
+
 /*
  * Detect whether FIPS enabled
  * @return 0: FIPS not enabled, 1: FIPS enabled
diff --git a/lib/tst_security.c b/lib/tst_security.c
index 7d929fafe729058f55b921bf5cf7806b253496e0..c515271351bbc3126e58feef28dc2a88f2d40509 100644
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
@@ -19,6 +20,7 @@
 
 #include <fcntl.h>
 #include <stdio.h>
+#include <string.h>
 #include <stdlib.h>
 #include <sys/mount.h>
 
@@ -28,6 +30,32 @@
 #include "tst_security.h"
 #include "tst_private.h"
 
+int tst_lsm_enabled(const char *name)
+{
+	int fd;
+	char *ptr;
+	char data[BUFSIZ];
+
+	if (access(LSM_SYS_FILE, F_OK))
+		tst_brk(TCONF, "%s file is not present", LSM_SYS_FILE);
+
+	fd = SAFE_OPEN(LSM_SYS_FILE, O_RDONLY);
+	SAFE_READ(0, fd, data, BUFSIZ);
+	SAFE_CLOSE(fd);
+
+	ptr = strtok(data, ",");
+	while (ptr != NULL) {
+		if (!strcmp(ptr, name)) {
+			tst_res(TINFO, "%s is enabled", name);
+			return 1;
+		}
+
+		ptr = strtok(NULL, ",");
+	}
+
+	return 0;
+}
+
 int tst_fips_enabled(void)
 {
 	int fips = 0;
diff --git a/testcases/kernel/syscalls/lsm/lsm_common.h b/testcases/kernel/syscalls/lsm/lsm_common.h
index 549f2d49b0b9290c4d75c87025911a81f4fa3c19..cc063eeab25545e8fc9ee40314c591b68c07dda7 100644
--- a/testcases/kernel/syscalls/lsm/lsm_common.h
+++ b/testcases/kernel/syscalls/lsm/lsm_common.h
@@ -9,8 +9,6 @@
 #include "tst_test.h"
 #include "lapi/lsm.h"
 
-#define LSM_SYS_FILE "/sys/kernel/security/lsm"
-
 static inline struct lsm_ctx *next_ctx(struct lsm_ctx *tctx)
 {
 	return (struct lsm_ctx *)((char *)tctx + sizeof(*tctx) + tctx->ctx_len);
@@ -40,43 +38,17 @@ static inline void read_proc_attr(const char *attr, char *val, const size_t size
 	SAFE_CLOSE(fd);
 }
 
-static inline int verify_enabled_lsm(const char *name)
-{
-	int fd;
-	char *ptr;
-	char data[BUFSIZ];
-
-	if (access(LSM_SYS_FILE, F_OK))
-		tst_brk(TCONF, "%s file is not present", LSM_SYS_FILE);
-
-	fd = SAFE_OPEN(LSM_SYS_FILE, O_RDONLY);
-	SAFE_READ(0, fd, data, BUFSIZ);
-	SAFE_CLOSE(fd);
-
-	ptr = strtok(data, ",");
-	while (ptr != NULL) {
-		if (!strcmp(ptr, name)) {
-			tst_res(TINFO, "%s is enabled", name);
-			return 1;
-		}
-
-		ptr = strtok(NULL, ",");
-	}
-
-	return 0;
-}
-
 static inline uint32_t count_supported_attr_current(void)
 {
 	uint32_t lsm_count = 0;
 
-	if (verify_enabled_lsm("selinux"))
+	if (tst_lsm_enabled("selinux"))
 		lsm_count++;
 
-	if (verify_enabled_lsm("apparmor"))
+	if (tst_lsm_enabled("apparmor"))
 		lsm_count++;
 
-	if (verify_enabled_lsm("smack"))
+	if (tst_lsm_enabled("smack"))
 		lsm_count++;
 
 	return lsm_count;

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
