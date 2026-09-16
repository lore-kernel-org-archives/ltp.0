Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75500C88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:05:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C81093E818E
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:05:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B20F3E76D7
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 64F141A00A39
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 770101F79D;
 Wed, 16 Sep 2026 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uCjKZRezZ4LIAAFyCSq+MLCmGTa76mZziAkxjvOySA=;
 b=yI5+ocsQXHec1zcUCYFi8omBqFqFMiWxNPpzq9OfVvl47SVPhzQDhUTG2MUUfmbPZ0TQTs
 RKIIiX9STL2fMbA6g3hk6lCdDcnaT2dwTpiLqX5DbXN0kE3FinMBrNjOLOLtGplz+zqydz
 SG9OHek3T23RXm2m9H+2+zB0fD8ZyiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uCjKZRezZ4LIAAFyCSq+MLCmGTa76mZziAkxjvOySA=;
 b=0oHoRpUp+brUObJ0/5YeGs6yyRL4jU+ytjynqid2XdOXnEjy5vc6VtiHCJF2SH1mwyzK1x
 A4pmWA7FdPzjUfDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uCjKZRezZ4LIAAFyCSq+MLCmGTa76mZziAkxjvOySA=;
 b=cYXBKNLnwpFQbwOn+aW1eN9EriDMwh2lNLZLfatYYtOtrDqcGIm8heIH7OZbzW4c4Oima4
 N936aE94olTAMCjDF2XvBAZgLBjP4/QGmIdea+VzdWZR1QdDoB5DZqPErMK2PNOWjpXCdn
 oTllyT8B2x6+Wa5gm1ZGpuZyh7Uhuwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uCjKZRezZ4LIAAFyCSq+MLCmGTa76mZziAkxjvOySA=;
 b=d0dFAj2jAWkEccnZt7/V2DiWDrJX2IWgike0cILn0MAOZkM3ADtyR12vX3s74WiZXTD4Km
 oYLOKxlEERZLoZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4D5E137FE;
 Wed, 16 Sep 2026 14:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T5
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:30 +0200
Message-ID: <20260916140402.1797325-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 04/36] keyctl10: Test KEYCTL_DESCRIBE format parsing
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

Test the format parsing of KEYCTL_DESCRIBE: verify that describing
a valid key returns a string formatted as "type;uid;gid;perm;description"
and that all five fields match the key's attributes.

Also add keyctl_common.h helper header for shared test definitions.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: Define as macros, use safe_add_key(), remove search_ring() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore   |  1 +
 testcases/kernel/syscalls/keyctl/keyctl10.c   | 99 +++++++++++++++++++
 .../kernel/syscalls/keyctl/keyctl_common.h    | 33 +++++++
 4 files changed, 134 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl10.c
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl_common.h

diff --git a/runtest/syscalls b/runtest/syscalls
index d953f05588..9840cf678b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -727,6 +727,7 @@ keyctl06 keyctl06
 keyctl07 keyctl07
 keyctl08 keyctl08
 keyctl09 keyctl09
+keyctl10 keyctl10
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index f9948c1766..08b2d101db 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -7,3 +7,4 @@
 /keyctl07
 /keyctl08
 /keyctl09
+/keyctl10
diff --git a/testcases/kernel/syscalls/keyctl/keyctl10.c b/testcases/kernel/syscalls/keyctl/keyctl10.c
new file mode 100644
index 0000000000..f069e91d37
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl10.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test the format parsing of ``KEYCTL_DESCRIBE`` of :manpage:`keyctl(2)`.
+ *
+ * ``KEYCTL_DESCRIBE`` formats a key description as
+ * "type;uid;gid;perm;description" and returns the full length of the
+ * string including the terminating NUL byte.
+ *
+ * [Algorithm]
+ *
+ * - describe a valid key and verify all five fields of the description
+ *   match the key's attributes
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+
+#include "keyctl_common.h"
+
+#define KEY_DESC	"ltpkeyctl10"
+#define PAYLOAD		"payload"
+#define BUF_SIZE	64
+
+static key_serial_t key;
+static long desc_len;
+static char buf[BUF_SIZE];
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = SAFE_NEW_USER_KEY(KEY_DESC, PAYLOAD, sizeof(PAYLOAD),
+			   KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+
+	TEST(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)NULL, 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_DESCRIBE failed");
+
+	desc_len = TST_RET;
+}
+
+static void run(void)
+{
+	char type[32], desc[BUF_SIZE];
+	unsigned int uid, gid, perm;
+
+	memset(buf, 0, sizeof(buf));
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)buf,
+				    sizeof(buf), 0), desc_len);
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_SZ_SILENT((size_t)desc_len, strlen(buf) + 1);
+	if (!TST_PASS) {
+		tst_res(TINFO, "unexpected description '%s'", buf);
+		return;
+	}
+
+	if (sscanf(buf, "%31[^;];%u;%u;%x;%63[^\n]",
+		   type, &uid, &gid, &perm, desc) != 5) {
+		tst_res(TFAIL, "malformed description '%s'", buf);
+		return;
+	}
+
+	if (strcmp(type, "user")) {
+		tst_res(TFAIL, "wrong key type '%s', expected 'user'", type);
+		return;
+	}
+
+	if (uid != getuid() || gid != getgid()) {
+		tst_res(TFAIL, "wrong owner uid %u gid %u, expected %u %u",
+			uid, gid, getuid(), getgid());
+		return;
+	}
+
+	if (perm != KEY_PERM_SET) {
+		tst_res(TFAIL, "wrong permissions %08x, expected %08x",
+			perm, KEY_PERM_SET);
+		return;
+	}
+
+	if (strcmp(desc, KEY_DESC)) {
+		tst_res(TFAIL, "wrong description '%s', expected '%s'",
+			desc, KEY_DESC);
+		return;
+	}
+
+	tst_res(TPASS, "described the key correctly");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};
diff --git a/testcases/kernel/syscalls/keyctl/keyctl_common.h b/testcases/kernel/syscalls/keyctl/keyctl_common.h
new file mode 100644
index 0000000000..1063163bc1
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl_common.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef KEYCTL_COMMON_H__
+#define KEYCTL_COMMON_H__
+
+#include <stdint.h>
+#include <string.h>
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+#define KEY_PERM_ALL		(KEY_POS_ALL | KEY_USR_ALL | KEY_GRP_ALL | KEY_OTH_ALL)
+#define KEY_PERM_SET		(KEY_POS_ALL | KEY_USR_ALL)
+
+#define KEY_VIEW_BITS		(KEY_POS_VIEW | KEY_USR_VIEW | KEY_GRP_VIEW | KEY_OTH_VIEW)
+#define KEY_PERM_NO_VIEW	(KEY_PERM_ALL & ~KEY_VIEW_BITS)
+
+#define KEY_WRITE_BITS		(KEY_POS_WRITE | KEY_USR_WRITE | KEY_GRP_WRITE | KEY_OTH_WRITE)
+#define KEY_PERM_NO_WRITE	(KEY_PERM_ALL & ~KEY_WRITE_BITS)
+
+#define KEY_SETATTR_BITS	(KEY_POS_SETATTR | KEY_USR_SETATTR | KEY_GRP_SETATTR | KEY_OTH_SETATTR)
+#define KEY_PERM_NO_SETATTR	(KEY_PERM_ALL & ~KEY_SETATTR_BITS)
+
+#define SAFE_NEW_RING(desc) \
+	safe_add_key(__FILE__, __LINE__, "keyring", (desc), NULL, 0, KEY_SPEC_PROCESS_KEYRING)
+
+#define SAFE_NEW_USER_KEY(desc, payload, plen, ring) \
+	safe_add_key(__FILE__, __LINE__, "user", (desc), (payload), (plen), (ring))
+
+#endif /* KEYCTL_COMMON_H__ */
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
