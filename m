Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D0EE7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 16:01:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2361A3EF554
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 17:01:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695093EF54D
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 17:00:58 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A802219100
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 17:00:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A97421FB6B;
 Fri, 27 Dec 2024 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735315255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wou9zzUg0gKAsHzP5Y9Wlzk+nrm9k+PIZSQKmMGVlXI=;
 b=DVKxz0Izczt/+0OcyMTS49+39geMPGIen2jMPav8SjtEW0HOaUxiVqGtRBc3adpQsCes53
 LSeMypqSinNHXXhsZcT+XkXtBVDihvy3Lk3ibUH5Hz9YIvQNLS5Up1kbanCd0ywKcZWQUv
 EETfitSoWgIa2S42Po5hqsrN5DXdJn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735315255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wou9zzUg0gKAsHzP5Y9Wlzk+nrm9k+PIZSQKmMGVlXI=;
 b=9IIAx6P1BN1MeaHpv3u+jbfJiu/z9iHoraw+QS7UMU7tZlZPj1AOn5e0wCl09clT5H+qEf
 Lolq2hjjHHVSlHBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735315255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wou9zzUg0gKAsHzP5Y9Wlzk+nrm9k+PIZSQKmMGVlXI=;
 b=DVKxz0Izczt/+0OcyMTS49+39geMPGIen2jMPav8SjtEW0HOaUxiVqGtRBc3adpQsCes53
 LSeMypqSinNHXXhsZcT+XkXtBVDihvy3Lk3ibUH5Hz9YIvQNLS5Up1kbanCd0ywKcZWQUv
 EETfitSoWgIa2S42Po5hqsrN5DXdJn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735315255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wou9zzUg0gKAsHzP5Y9Wlzk+nrm9k+PIZSQKmMGVlXI=;
 b=9IIAx6P1BN1MeaHpv3u+jbfJiu/z9iHoraw+QS7UMU7tZlZPj1AOn5e0wCl09clT5H+qEf
 Lolq2hjjHHVSlHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E3C613A6D;
 Fri, 27 Dec 2024 16:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SHziHDfPbmfrIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 16:00:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Dec 2024 17:00:41 +0100
Message-ID: <20241227160042.363309-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227160042.363309-1-pvorel@suse.cz>
References: <20241227160042.363309-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: Add helpers for module signature enforcement
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
Cc: Po-Hsu Lin <po-hsu.lin@canonical.com>,
 "Ricardo B . Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add them to both legacy and new API (used in both).

NOTE: because test is called often in the setup function
don't call a cleanup function in the old API version.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/old/old_module.h | 33 +++++++++++++++++++++++++++++++++
 include/tst_module.h     | 17 +++++++++++++++++
 lib/tst_module.c         | 24 ++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/include/old/old_module.h b/include/old/old_module.h
index 496520d64d..b2ea06d0c2 100644
--- a/include/old/old_module.h
+++ b/include/old/old_module.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2016-2024
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -34,6 +35,8 @@
 #ifndef TST_MODULE
 #define TST_MODULE
 
+#include <stdbool.h>
+
 void tst_module_exists_(void (cleanup_fn)(void), const char *mod_name,
 					 char **mod_path);
 
@@ -42,6 +45,9 @@ void tst_module_load_(void (cleanup_fn)(void), const char *mod_name,
 
 void tst_module_unload_(void (cleanup_fn)(void), const char *mod_name);
 
+bool tst_module_signature_enforced_(void);
+void tst_check_module_signature_enforced_(void);
+
 /*
  * Check module existence.
  *
@@ -86,4 +92,31 @@ static inline void tst_module_unload(void (cleanup_fn)(void), const char *mod_na
 	tst_module_unload_(cleanup_fn, mod_name);
 }
 
+/**
+ * tst_check_module_signature_enforced() - Check if enforced module signature.
+ *
+ * Module signature is enforced if module.sig_enforce=1 kernel parameter or
+ * CONFIG_MODULE_SIG_FORCE=y.
+ *
+ * return: Returns true if module signature is enforced false otherwise.
+ *
+ */
+static inline bool tst_module_signature_enforced(void)
+{
+	return tst_module_signature_enforced_();
+}
+
+/**
+ * tst_check_module_signature_enforced() - Check if test needs to be skipped due
+ * enforced module signature.
+ *
+ * Skip test with tst_brk(TCONF) due module signature enforcement if
+ * module.sig_enforce=1 kernel parameter or CONFIG_MODULE_SIG_FORCE=y.
+ */
+
+static inline void tst_check_module_signature_enforced(void)
+{
+	tst_check_module_signature_enforced_();
+}
+
 #endif /* TST_MODULE */
diff --git a/include/tst_module.h b/include/tst_module.h
index 2654c5afb6..8353742e1c 100644
--- a/include/tst_module.h
+++ b/include/tst_module.h
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2016-2024
  * Alexey Kodanev <alexey.kodanev@oracle.com>
  */
 
 #ifndef TST_MODULE_H
 #define TST_MODULE_H
 
+#include <stdbool.h>
+
 void tst_module_exists_(void (cleanup_fn)(void), const char *mod_name,
 					 char **mod_path);
 
@@ -30,4 +33,18 @@ static inline void tst_module_unload(const char *mod_name)
 	tst_module_unload_(NULL, mod_name);
 }
 
+bool tst_module_signature_enforced_(void);
+
+static inline bool tst_module_signature_enforced(void)
+{
+	return tst_module_signature_enforced_();
+}
+
+void tst_check_module_signature_enforced_(void);
+
+static inline void tst_check_module_signature_enforced(void)
+{
+	tst_check_module_signature_enforced_();
+}
+
 #endif /* TST_MODULE_H */
diff --git a/lib/tst_module.c b/lib/tst_module.c
index 9bd4436236..caf311f803 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2016-2024
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -23,8 +24,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <stdbool.h>
 
 #include "test.h"
+#include "tst_kconfig.h"
 #include "ltp_priv.h"
 #include "old_module.h"
 
@@ -122,3 +125,24 @@ void tst_module_unload_(void (cleanup_fn)(void), const char *mod_name)
 			 "could not unload %s module", mod_name);
 	}
 }
+
+bool tst_module_signature_enforced_(void)
+{
+	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
+	int rc;
+
+	tst_kcmdline_parse(&params, 1);
+	tst_kconfig_read(&kconfig, 1);
+
+	rc = params.found || kconfig.choice == 'y';
+	tst_resm(TINFO, "module signature enforcement: %s", rc ? "on" : "off");
+
+	return rc;
+}
+
+void tst_check_module_signature_enforced_(void)
+{
+	if (tst_module_signature_enforced_())
+		tst_brkm(TCONF, NULL, "module signature is enforced, skip test");
+}
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
