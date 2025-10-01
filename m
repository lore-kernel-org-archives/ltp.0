Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F76CCA470
	for <ltp@archiver.kernel.org>; Wed,  1 Oct 2025 14:56:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CC6A3CE3BF
	for <ltp@archiver.kernel.org>; Wed,  1 Oct 2025 16:56:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6FC43CDFD3
 for <ltp@lists.linux.it>; Wed,  1 Oct 2025 16:56:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 30FB92009E9
 for <ltp@lists.linux.it>; Wed,  1 Oct 2025 16:56:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 055881FB6C;
 Wed,  1 Oct 2025 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759330565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OsoHHn8Fp4/LDLTQa+fKdkLXB5Q3k/7uVRjOjDfLLWk=;
 b=kuBnRj/0x9vIHnu5ny26SAJ7yBIt+fuxAaX3z+HIigzcSbAo/ITfR8mp8wugkIlO3pl//k
 Z0bDG/0MURokJ79znknFBuzr+EA1/VILUVP6RV2oQslYeJyP0D9t3hx68Y+9FPPp2B5oo+
 yRwwGoO2AJv1OuvpsVEJX9hEeeejbQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759330565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OsoHHn8Fp4/LDLTQa+fKdkLXB5Q3k/7uVRjOjDfLLWk=;
 b=21SknBpWrd7pCbCHxJVZVfmBU6tpg8DrVK5wz/It1fIw+o7zhLwhhWlMONtnvIJCOtSrSb
 obgXoqMgZfVonhDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759330564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OsoHHn8Fp4/LDLTQa+fKdkLXB5Q3k/7uVRjOjDfLLWk=;
 b=OltbIAPe8Rsy3Qf0uUo8fLuO4elLl2xFNtDZN5HrEX+oRdzwgjqSDyu1N8lPzpikFyhB7O
 qX+wyQiGG/6XGFAMVrZqlrYmnqkTGOoo/JM/JJXbN/oWUeijo5N2xJUjPgvqzkUf7h15mc
 HxTqEAmkZkKWjdz9XI2xzdyeYvV6j9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759330564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OsoHHn8Fp4/LDLTQa+fKdkLXB5Q3k/7uVRjOjDfLLWk=;
 b=QF0g8IaixNp5uSI2Qb7I3QhExB3Rue6dUOOlCjWXXruEb74dSarFLpINHaLGlRi94pVaaA
 rONLVw0JDHlSYADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EADC413A42;
 Wed,  1 Oct 2025 14:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /khOOQNB3WhcLwAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 14:56:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 9243DA094F; Wed,  1 Oct 2025 16:56:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  1 Oct 2025 16:56:00 +0200
Message-ID: <20251001145600.24767-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[gmail.com,suse.cz];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_LAST(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] name_to_handle_at: Add test cases for AT_HANDLE_FID
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a few testcases verifying AT_HANDLE_FID flag.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/lapi/fcntl.h                          |  4 +
 .../name_to_handle_at/name_to_handle_at03.c   | 88 +++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at03.c

This is actually a testcase for a kernel regression, the kernel fix is on the
way.

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 7c050248892e..55a5e8b40432 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -98,6 +98,10 @@
 # define AT_HANDLE_FID		AT_REMOVEDIR
 #endif
 
+#ifndef AT_HANDLE_CONNECTABLE
+# define AT_HANDLE_CONNECTABLE	0x002
+#endif
+
 #ifndef AT_SYMLINK_FOLLOW
 # define AT_SYMLINK_FOLLOW	0x400
 #endif
diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at03.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at03.c
new file mode 100644
index 000000000000..4a6df5e46fd7
--- /dev/null
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at03.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * Basic name_to_handle_at() tests.
+ *
+ * [Algorithm]
+ *  - Check that EOVERFLOW is returned as expected by name_to_handle_at().
+ *  - Check that we were able to access a file's stat with name_to_handle_at()
+ *    and open_by_handle_at().
+ */
+
+#define _GNU_SOURCE
+#include <sys/stat.h>
+#include "lapi/name_to_handle_at.h"
+
+#define TEST_FILE "test_file"
+
+static int fd_atcwd = AT_FDCWD;
+static struct file_handle *fhp;
+
+static struct tcase {
+	const char *name;
+	int *dfd;
+	const char *pathname;
+	int name_flags;
+	int exp_errno;
+} tcases[] = {
+	{"test-file", &fd_atcwd, TEST_FILE, AT_HANDLE_FID, 0},
+	{"unexportable-file", &fd_atcwd, "/proc/filesystems", AT_HANDLE_FID, 0},
+	{"test-file-connectable", &fd_atcwd, TEST_FILE, AT_HANDLE_FID | AT_HANDLE_CONNECTABLE, EINVAL},
+};
+
+static bool handle_type_supported(unsigned int flag, const char *name)
+{
+	if (name_to_handle_at(-1, ".", NULL, NULL, flag) && errno == EINVAL) {
+		tst_brk(TCONF, "%s not supported by the kernel.", name);
+		return false;
+	}
+	return true;
+}
+
+#define REQUIRE_HANDLE_TYPE_SUPPORT(flag) handle_type_supported(flag, #flag)
+
+static void setup(void)
+{
+	SAFE_TOUCH(TEST_FILE, 0600, NULL);
+	fhp = malloc(MAX_HANDLE_SZ);
+	if (!fhp)
+		tst_brk(TBROK, "malloc failed");
+
+	REQUIRE_HANDLE_TYPE_SUPPORT(AT_HANDLE_FID);
+	REQUIRE_HANDLE_TYPE_SUPPORT(AT_HANDLE_CONNECTABLE);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int mount_id;
+
+	fhp->handle_bytes = MAX_HANDLE_SZ;
+	TEST(name_to_handle_at(*tc->dfd, tc->pathname, fhp, &mount_id,
+			       tc->name_flags));
+	if (!tc->exp_errno) {
+		if (TST_RET)
+			tst_res(TFAIL | TTERRNO, "%s: name_to_handle_at() failed", tc->name);
+		else
+			tst_res(TPASS, "%s: name_to_handle_at() passed", tc->name);
+		return;
+	}
+
+	if (TST_RET != -1)
+		tst_res(TFAIL, "%s: name_to_handle_at() unexpectedly succeeded", tc->name);
+	else if (TST_ERR != tc->exp_errno)
+		tst_res(TFAIL | TTERRNO, "%s: name_to_handle_at() should fail with errno %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+	else
+		tst_res(TPASS, "%s: name_to_handle_at() failed as expected", tc->name);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
