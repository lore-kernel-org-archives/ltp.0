Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9E9D11183
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 08:27:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB98A3CC047
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 09:27:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 843523CA9B3
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:26:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A752D200253
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:26:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2C385BCC5;
 Thu, 27 Nov 2025 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764232005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPI/vRKnY36TXn431urPA64MCcqfVj+KOIo8WnfXEM0=;
 b=N9oSLnTduNSZp4fFAWZAMtBqL1i15BTL1cubHqOd2vuzOTsmr/Eo8w9MFGYTqXaRc9XGSH
 qqAp8qywbhhdki9oNp8t5erKS9xWNqZbYIHcZ4EKml9SlcouSRlCdeEBvzUShAKktElikV
 9amxA3+c3NcEox+NIUkh85mDCpMKO7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764232005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPI/vRKnY36TXn431urPA64MCcqfVj+KOIo8WnfXEM0=;
 b=k19UZz+lMYkX4HSkQ1S3ppQFV/Jlf1NARJ6pgeXCCBh1fS2jphMCVRT3c19BBEuOi0rCF7
 8kp0Ua6CrgAGQNBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764232004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPI/vRKnY36TXn431urPA64MCcqfVj+KOIo8WnfXEM0=;
 b=3XzWAi4AOcc0aXlx7V1df2441N00NMU/sUwmlgb64XzxUIPnV2SgF7lHpiJ5ss6rAkj8Q4
 cTcBB8BTY0nYj8pgmXCXgBYetNRurJSIWmIWoNQoRWwhEmInTphnxPzwWMwn0whbUiOMIF
 rzDtpG9vasLi0QIMuWBum5FZeCkiNjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764232004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPI/vRKnY36TXn431urPA64MCcqfVj+KOIo8WnfXEM0=;
 b=+3H7PW/Mo17Io+xso2pfdYCDkDOQDd8du0K4yTQcl38KGfLqDCRteJVIw2saMcGzgV7gfG
 OACcmRv0hwT+LiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E3F23EA65;
 Thu, 27 Nov 2025 08:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gKRTGUQLKGmNJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 08:26:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Nov 2025 09:26:35 +0100
Message-ID: <20251127082638.224110-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127082638.224110-1-pvorel@suse.cz>
References: <20251127082638.224110-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] shell: Add tst_sudo.c helper
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It will be used in LTP IMA tests. Not only it removes external
dependency, but also fixes problem when 'nobody' user is not possible to
use due using /usr/sbin/nologin shell.

Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/users/setup_tests.rst |  4 ++++
 testcases/lib/.gitignore  |  1 +
 testcases/lib/Makefile    |  2 +-
 testcases/lib/tst_sudo.c  | 50 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_sudo.c

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 38976f3b0a..9c49852830 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -71,6 +71,10 @@ users.
    * - LTP_IMA_LOAD_POLICY
      - Load IMA example policy, see :master:`testcases/kernel/security/integrity/ima/README.md`.
 
+   * - LTP_USR_UID, LTP_USR_GID
+     - Set UID and GID of ``nobody`` user for :doc:`../developers/api_shell_tests`,
+       see :master:`testcases/lib/tst_sudo.c`.
+
    * - LTP_VIRT_OVERRIDE
      - Overrides virtual machine detection in the test library. Setting it to
        empty string, tells the library that system is not a virtual machine.
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 19d7c67bbe..785d638cba 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -26,3 +26,4 @@
 /tst_res_
 /tst_run_shell
 /tst_remaining_runtime
+/tst_sudo
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 2309a42a3d..9be9946057 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -17,6 +17,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
 			   tst_check_kconfigs tst_cgctl tst_fsfreeze tst_ns_create tst_ns_exec\
 			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_\
-			   tst_run_shell tst_remaining_runtime
+			   tst_run_shell tst_remaining_runtime tst_sudo
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/lib/tst_sudo.c b/testcases/lib/tst_sudo.c
new file mode 100644
index 0000000000..e8d5d8dd9d
--- /dev/null
+++ b/testcases/lib/tst_sudo.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
+ */
+
+#define LTP_USR_UID 65534
+#define LTP_USR_GID 65534
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+static void print_help(void)
+{
+	fprintf(stderr, "Usage: %s cmd [args] ...\n", __FILE__);
+	fprintf(stderr, "Usage: %s cmd [-h] print help\n\n", __FILE__);
+
+	fprintf(stderr, "Environment Variables\n");
+	fprintf(stderr, "LTP_USR_UID: UID of 'nobody' user, defaults %d\n",
+			LTP_USR_UID);
+	fprintf(stderr, "LTP_USR_GID: GID of 'nobody' user, defaults %d\n",
+			LTP_USR_GID);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc < 2 || !strcmp(argv[1], "-h")) {
+		print_help();
+		return 1;
+	}
+
+	unsigned uid = LTP_USR_UID, gid = LTP_USR_GID;
+
+	char *uid_env = getenv(TST_TO_STR_(LTP_USR_UID));
+	char *gid_env = getenv(TST_TO_STR_(LTP_USR_GID));
+
+	if (uid_env)
+		uid = SAFE_STRTOL(uid_env, 1, INT_MAX);
+
+	if (gid_env)
+		gid = SAFE_STRTOL(gid_env, 1, INT_MAX);
+
+	tst_res(TINFO, "UID: %d, GID: %d", uid, gid);
+	SAFE_SETGROUPS(0, NULL);
+	SAFE_SETRESGID(gid, gid, gid);
+	SAFE_SETRESUID(uid, uid, uid);
+
+	SAFE_CMD((const char * const *)&argv[1], NULL, NULL);
+
+	return 0;
+}
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
