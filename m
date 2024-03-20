Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEFBC54E67
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 06:33:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26B1E3CE666
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 07:33:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90D5E3CE649
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 07:32:41 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 281041401269
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 07:32:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B61A2208D4;
 Wed, 20 Mar 2024 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710916357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0Le2WECK+8U3yGoX5r3GIpNJ/jH1jEk7ctp4EQpDTSg=;
 b=kxJxUB6cL4M+ZnJfmwG2TbZiM7dEfUJHMFtZ0w20Ld3Maopwds+RIh/zVKWcZysoARpOe+
 zlpZbCAtGM/wiIJELKT/5TlucVAEFhsLOIpdCxwG3gABDkFHmB1GpYTdpLXAZaojmNLjmO
 e0TFYrOen7516tyEIJMN3vq4SI15Hzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710916357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0Le2WECK+8U3yGoX5r3GIpNJ/jH1jEk7ctp4EQpDTSg=;
 b=iGN8jrlSwoB2mW1HM3rakii2VLcdk/uYD9C8aj3yKwApY+eG9eFujCebW5jSPoEiUidY8Y
 kFPntpgq6WiUQmDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710916357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0Le2WECK+8U3yGoX5r3GIpNJ/jH1jEk7ctp4EQpDTSg=;
 b=kxJxUB6cL4M+ZnJfmwG2TbZiM7dEfUJHMFtZ0w20Ld3Maopwds+RIh/zVKWcZysoARpOe+
 zlpZbCAtGM/wiIJELKT/5TlucVAEFhsLOIpdCxwG3gABDkFHmB1GpYTdpLXAZaojmNLjmO
 e0TFYrOen7516tyEIJMN3vq4SI15Hzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710916357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0Le2WECK+8U3yGoX5r3GIpNJ/jH1jEk7ctp4EQpDTSg=;
 b=iGN8jrlSwoB2mW1HM3rakii2VLcdk/uYD9C8aj3yKwApY+eG9eFujCebW5jSPoEiUidY8Y
 kFPntpgq6WiUQmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A353136E4;
 Wed, 20 Mar 2024 06:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2KS2JAWD+mU+GwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 06:32:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Mar 2024 07:32:16 +0100
Message-ID: <20240320063218.449072-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kxJxUB6c;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iGN8jrlS
X-Spamd-Result: default: False [3.55 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-0.94)[-0.936];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[10.36%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B61A2208D4
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: Add tst_selinux_enforcing()
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

Co-developed-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

@Li, Cyril:
1) I guess we want to distinguish EACCES for SELinux enforcing, right?
If not, this commit would be dropped and second commit would just use

	const int exp_errs[] = {tc->expected_errno, EACCES};

	TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
			 tc->mask.flags, dirfd, path),
			 exp_errs);

2) Some time ago I proposed to merge some lib/*.c files, not
just have so many files with single functions in the library. E.g.
lib/tst_fips.c, lib/tst_selinux.c, lib/tst_lockdown.c could be merged
into lib/tst_security.c. Or do we want to have these separate?

When I proposed this, I wanted to merge files, which have the same name
as the single function in the file (e.g. tst_dir_is_empty.c,
tst_path_has_mnt_flags.c), having them as single file does not help much
with searching for the content.

Kind regards,
Petr

 include/tst_selinux.h | 10 ++++++++++
 lib/tst_selinux.c     | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 include/tst_selinux.h
 create mode 100644 lib/tst_selinux.c

diff --git a/include/tst_selinux.h b/include/tst_selinux.h
new file mode 100644
index 000000000..18bbcff21
--- /dev/null
+++ b/include/tst_selinux.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) Linux Test Project, 2024
+ */
+
+#ifndef TST_SELINUX_H__
+#define TST_SELINUX_H__
+
+int tst_selinux_enforcing(void);
+
+#endif /* TST_SELINUX_H__ */
diff --git a/lib/tst_selinux.c b/lib/tst_selinux.c
new file mode 100644
index 000000000..2219b85d4
--- /dev/null
+++ b/lib/tst_selinux.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2024
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#define SELINUX_STATUS_PATH "/sys/fs/selinux/enforce"
+
+#include <fcntl.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_selinux.h"
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
