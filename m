Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A214BC624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:10:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D0433E946B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:10:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5723F3E935B
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C88AA100113D
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A9A41FE6D;
 Fri,  4 Sep 2026 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDt3Osh4F0Ndr3a6w8eNmyXW/1NnVxqv1mpTUZwYKfQ=;
 b=XIvLvpPxGsoGe7nzWFXaY1knXpcgGr+zzS+pRvlYy2mMvDuKNpJ7op3bczPmqiARJk0wBU
 8pM2nxZmXlPBIbLRpL22UeYtOYK/Ny1ipzsqfHpKlD/EYgmYpTJmSE1JpxGI2V7LdO7V5Y
 DE3cE1DnNuwel2T4WwL9cLfK00xWEH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDt3Osh4F0Ndr3a6w8eNmyXW/1NnVxqv1mpTUZwYKfQ=;
 b=EpZqtbARXOkm/qkvXrPUy70adYpjRb7YOTCB3iogOv+BVcDLmdfAGkgttdtXa5UN0zyRP2
 9/QxfL/L1oZph0CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDt3Osh4F0Ndr3a6w8eNmyXW/1NnVxqv1mpTUZwYKfQ=;
 b=rM97pmgFMBW+srUBf8a4PHMzpZA1T/pap9qiy1HjsZxVS+8iYUU8au9O5UVwtXzTEE2WKH
 7HnPS9snT6Jt6mLtDD9wZ7/xNUhdjqziFHW56Q2kV+haJxrPqulyZXgEmk5DGR6V3c45PY
 c1txshuTt00Vjta4V7FvB4dtI3y5wBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523732;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDt3Osh4F0Ndr3a6w8eNmyXW/1NnVxqv1mpTUZwYKfQ=;
 b=gq9LDzLFh4Y3pkPNzEoziOddSf5cYdMbiVGB5sejO8tgQzvvMkMibzDDjrcS70ds/bUOjZ
 vOA8Y3+ip9DUEfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AA0713738;
 Fri,  4 Sep 2026 12:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QNKvC9S0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:08:51 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-2-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=5911;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=phLhOlZdY3fpJi72Y9BC+4qQOULjrVmm4kxIDDPRmi0=;
 b=2clK/kkhOfjcDK9OdmQZaoT6m26F0Fe3U3GPyClQaLzIc9Tg5AiKLUaMSIu2xUZI9JWZgtdge
 aXa6ydWFnlqDEIBzsmRUWIeBCCovNX3biY0qTf9pUNqipT2aNvGV5Xh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/33] keyctl10: Test KEYCTL_DESCRIBE format parsing
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                 |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore      |  1 +
 testcases/kernel/syscalls/keyctl/keyctl10.c      | 99 ++++++++++++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl_common.h | 53 +++++++++++++
 4 files changed, 154 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 737c63e31..bf4c0d46e 100644
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
index f9948c176..08b2d101d 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -7,3 +7,4 @@
 /keyctl07
 /keyctl08
 /keyctl09
+/keyctl10
diff --git a/testcases/kernel/syscalls/keyctl/keyctl10.c b/testcases/kernel/syscalls/keyctl/keyctl10.c
new file mode 100644
index 000000000..105daa63d
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
+	key = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD),
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
index 000000000..c7290cc6e
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl_common.h
@@ -0,0 +1,53 @@
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
+static inline key_serial_t new_ring(const char *desc)
+{
+	TEST(add_key("keyring", desc, NULL, 0, KEY_SPEC_PROCESS_KEYRING));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "failed to create keyring '%s'", desc);
+
+	return TST_RET;
+}
+
+static inline key_serial_t new_user_key(const char *desc, const void *payload,
+					size_t plen, key_serial_t ring)
+{
+	TEST(add_key("user", desc, payload, plen, ring));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "failed to add user key '%s'", desc);
+
+	return TST_RET;
+}
+
+static inline key_serial_t search_ring(key_serial_t ring, const char *type,
+				       const char *desc)
+{
+	return keyctl(KEYCTL_SEARCH, ring, (unsigned long)type,
+		      (unsigned long)desc, 0);
+}
+
+#endif /* KEYCTL_COMMON_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
