Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1A0E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 11:56:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB8FF3ED248
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 12:56:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 648563EC824
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 12:56:16 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 36BC81422393
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 12:56:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F11B1F37E;
 Tue, 31 Dec 2024 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735646175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toOGcfg5f+OO4ThaYpoYwKylPi6SXAIOHMyq7TQSbdo=;
 b=nTUxtBuXw0WYIkfmmJf4tESCiEXoFdwziTMIuWhLkjZgHohi8KCdPeof0GXHejRAVXNOMt
 wUVPNZNgeO4NQjxziVw7TUpcHDCUoc2cPwNCuEjCM2MuOASEuIuRZKuxzDPGdhChYU2OW7
 Rv9nRdqKgS4ufcgqcTMfMX223N7JaL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735646175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toOGcfg5f+OO4ThaYpoYwKylPi6SXAIOHMyq7TQSbdo=;
 b=k13D746iOoCHkOaPOFWy1NYo6bdcP3eZs3zjlRhy9572sxPiGo1nyqgIzO0xYULLIUgfR9
 NE9Szxpa4GC8NwDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735646175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toOGcfg5f+OO4ThaYpoYwKylPi6SXAIOHMyq7TQSbdo=;
 b=nTUxtBuXw0WYIkfmmJf4tESCiEXoFdwziTMIuWhLkjZgHohi8KCdPeof0GXHejRAVXNOMt
 wUVPNZNgeO4NQjxziVw7TUpcHDCUoc2cPwNCuEjCM2MuOASEuIuRZKuxzDPGdhChYU2OW7
 Rv9nRdqKgS4ufcgqcTMfMX223N7JaL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735646175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toOGcfg5f+OO4ThaYpoYwKylPi6SXAIOHMyq7TQSbdo=;
 b=k13D746iOoCHkOaPOFWy1NYo6bdcP3eZs3zjlRhy9572sxPiGo1nyqgIzO0xYULLIUgfR9
 NE9Szxpa4GC8NwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E33F13A79;
 Tue, 31 Dec 2024 11:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kHgpCt/bc2cxKQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 31 Dec 2024 11:56:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 31 Dec 2024 12:56:06 +0100
Message-ID: <20241231115607.56105-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241231115607.56105-1-pvorel@suse.cz>
References: <20241231115607.56105-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: Add helpers for module signature
 enforcement
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
The same as in v1.

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
