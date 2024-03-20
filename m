Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEBBC54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 10:23:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 447573CF23E
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 11:23:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FF433CE668
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:22:56 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C542C600845
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:22:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CBFAD341C0;
 Wed, 20 Mar 2024 10:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710930173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cncJxq4o2DA4VSW+9sX28hhYF2WiaEKm5AgTzM2nyVc=;
 b=euQoPS97ehc+luYQkDgeJmAJr4kq7OsOQhwJTeRCQ+veSkK1kXhndALnLGX8zD1n+F34sU
 yqpDcjdCR0/fR9fckfMoE2m9K/hQvZh8EUcFxOD10HIb1S9Y8kyGojxk5Kj7WFFl838Pv5
 jl7wDL09WUx/T5olcYopW2E6SDGD4Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710930173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cncJxq4o2DA4VSW+9sX28hhYF2WiaEKm5AgTzM2nyVc=;
 b=BxCON6Sv4KvuWKcURmFwLm6RyhXFlsttbTHTQwqLy2n4kaOln1LluQ0eXghlWOSh7KK65w
 C7D+ongqSdTEp5DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710930173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cncJxq4o2DA4VSW+9sX28hhYF2WiaEKm5AgTzM2nyVc=;
 b=euQoPS97ehc+luYQkDgeJmAJr4kq7OsOQhwJTeRCQ+veSkK1kXhndALnLGX8zD1n+F34sU
 yqpDcjdCR0/fR9fckfMoE2m9K/hQvZh8EUcFxOD10HIb1S9Y8kyGojxk5Kj7WFFl838Pv5
 jl7wDL09WUx/T5olcYopW2E6SDGD4Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710930173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cncJxq4o2DA4VSW+9sX28hhYF2WiaEKm5AgTzM2nyVc=;
 b=BxCON6Sv4KvuWKcURmFwLm6RyhXFlsttbTHTQwqLy2n4kaOln1LluQ0eXghlWOSh7KK65w
 C7D+ongqSdTEp5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AB7D13942;
 Wed, 20 Mar 2024 10:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AOjSHP24+mWyaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 10:22:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Mar 2024 11:22:02 +0100
Message-ID: <20240320102204.475230-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320102204.475230-1-pvorel@suse.cz>
References: <20240320102204.475230-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=euQoPS97;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BxCON6Sv
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.50 / 50.00]; ARC_NA(0.00)[];
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
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.19)[-0.934];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CBFAD341C0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] lib: Merge security related sources
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

Merge FIPS and lockdown related library sources to new tst_security.[ch]
file to shorten number of the files in the library. More security
related code will be added in next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* New commit: lib: Merge security related sources

I'll send more cleanup in a different patchset.

Kind regards,
Petr

 include/tst_fips.h                     | 15 ------
 include/tst_lockdown.h                 | 11 ----
 include/tst_security.h                 | 17 ++++++
 include/tst_test.h                     |  4 +-
 lib/tst_fips.c                         | 24 ---------
 lib/{tst_lockdown.c => tst_security.c} | 73 +++++++++++++++-----------
 6 files changed, 62 insertions(+), 82 deletions(-)
 delete mode 100644 include/tst_fips.h
 delete mode 100644 include/tst_lockdown.h
 create mode 100644 include/tst_security.h
 delete mode 100644 lib/tst_fips.c
 rename lib/{tst_lockdown.c => tst_security.c} (86%)

diff --git a/include/tst_fips.h b/include/tst_fips.h
deleted file mode 100644
index 881c32391..000000000
--- a/include/tst_fips.h
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
- */
-
-#ifndef TST_FIPS_H__
-#define TST_FIPS_H__
-
-/*
- * Detect whether FIPS enabled
- * @return 0: FIPS not enabled, 1: FIPS enabled
- */
-int tst_fips_enabled(void);
-
-#endif /* TST_FIPS_H__ */
diff --git a/include/tst_lockdown.h b/include/tst_lockdown.h
deleted file mode 100644
index 07e90c1af..000000000
--- a/include/tst_lockdown.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later
- * Copyright (c) Linux Test Project, 2020-2021
- */
-
-#ifndef TST_LOCKDOWN_H
-#define TST_LOCKDOWN_H
-
-int tst_secureboot_enabled(void);
-int tst_lockdown_enabled(void);
-
-#endif /* TST_LOCKDOWN_H */
diff --git a/include/tst_security.h b/include/tst_security.h
new file mode 100644
index 000000000..438b16dbb
--- /dev/null
+++ b/include/tst_security.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) Linux Test Project, 2020-2024
+ */
+
+#ifndef TST_SECURITY_H__
+#define TST_SECURITY_H__
+
+/*
+ * Detect whether FIPS enabled
+ * @return 0: FIPS not enabled, 1: FIPS enabled
+ */
+int tst_fips_enabled(void);
+
+int tst_lockdown_enabled(void);
+int tst_secureboot_enabled(void);
+
+#endif /* TST_SECURITY_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 47b5902f9..98d74d82e 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -40,8 +40,8 @@
 #include "tst_capability.h"
 #include "tst_hugepage.h"
 #include "tst_assert.h"
-#include "tst_lockdown.h"
-#include "tst_fips.h"
+#include "tst_security.h"
+#include "tst_security.h"
 #include "tst_taint.h"
 #include "tst_memutils.h"
 #include "tst_arch.h"
diff --git a/lib/tst_fips.c b/lib/tst_fips.c
deleted file mode 100644
index 82dafef7a..000000000
--- a/lib/tst_fips.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
- */
-
-#define TST_NO_DEFAULT_MAIN
-
-#define PATH_FIPS	"/proc/sys/crypto/fips_enabled"
-
-#include "tst_test.h"
-#include "tst_safe_macros.h"
-#include "tst_fips.h"
-
-int tst_fips_enabled(void)
-{
-	int fips = 0;
-
-	if (access(PATH_FIPS, R_OK) == 0) {
-		SAFE_FILE_SCANF(PATH_FIPS, "%d", &fips);
-	}
-
-	tst_res(TINFO, "FIPS: %s", fips ? "on" : "off");
-	return fips;
-}
diff --git a/lib/tst_lockdown.c b/lib/tst_security.c
similarity index 86%
rename from lib/tst_lockdown.c
rename to lib/tst_security.c
index 3126d67bd..0fc704dfa 100644
--- a/lib/tst_lockdown.c
+++ b/lib/tst_security.c
@@ -1,12 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Linux Test Project, 2020-2023
+ * Copyright (c) Linux Test Project, 2020-2024
  */
 
 #define TST_NO_DEFAULT_MAIN
 
+#define PATH_FIPS	"/proc/sys/crypto/fips_enabled"
 #define PATH_LOCKDOWN	"/sys/kernel/security/lockdown"
 
+#if defined(__powerpc64__) || defined(__ppc64__)
+# define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
+# define VAR_DATA_SIZE 4
+#else
+# define SECUREBOOT_VAR "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
+# define VAR_DATA_SIZE 5
+#endif
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/mount.h>
@@ -14,41 +23,19 @@
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 #include "tst_safe_stdio.h"
-#include "tst_lockdown.h"
+#include "tst_security.h"
 #include "tst_private.h"
 
-#if defined(__powerpc64__) || defined(__ppc64__)
-# define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
-# define VAR_DATA_SIZE 4
-#else
-# define SECUREBOOT_VAR "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
-# define VAR_DATA_SIZE 5
-#endif
-
-int tst_secureboot_enabled(void)
+int tst_fips_enabled(void)
 {
-	int fd;
-	char data[5];
+	int fips = 0;
 
-	if (access(SECUREBOOT_VAR, F_OK)) {
-		tst_res(TINFO, "SecureBoot sysfs file not available");
-		return -1;
+	if (access(PATH_FIPS, R_OK) == 0) {
+		SAFE_FILE_SCANF(PATH_FIPS, "%d", &fips);
 	}
 
-	fd = open(SECUREBOOT_VAR, O_RDONLY);
-
-	if (fd == -1) {
-		tst_res(TINFO | TERRNO,
-			"Cannot open SecureBoot file");
-		return -1;
-	} else if (fd < 0) {
-		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
-		return -1;
-	}
-	SAFE_READ(1, fd, data, VAR_DATA_SIZE);
-	SAFE_CLOSE(fd);
-	tst_res(TINFO, "SecureBoot: %s", data[VAR_DATA_SIZE - 1] ? "on" : "off");
-	return data[VAR_DATA_SIZE - 1];
+	tst_res(TINFO, "FIPS: %s", fips ? "on" : "off");
+	return fips;
 }
 
 int tst_lockdown_enabled(void)
@@ -86,3 +73,29 @@ int tst_lockdown_enabled(void)
 
 	return ret;
 }
+
+int tst_secureboot_enabled(void)
+{
+	int fd;
+	char data[5];
+
+	if (access(SECUREBOOT_VAR, F_OK)) {
+		tst_res(TINFO, "SecureBoot sysfs file not available");
+		return -1;
+	}
+
+	fd = open(SECUREBOOT_VAR, O_RDONLY);
+
+	if (fd == -1) {
+		tst_res(TINFO | TERRNO,
+			"Cannot open SecureBoot file");
+		return -1;
+	} else if (fd < 0) {
+		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
+		return -1;
+	}
+	SAFE_READ(1, fd, data, VAR_DATA_SIZE);
+	SAFE_CLOSE(fd);
+	tst_res(TINFO, "SecureBoot: %s", data[VAR_DATA_SIZE - 1] ? "on" : "off");
+	return data[VAR_DATA_SIZE - 1];
+}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
