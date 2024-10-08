Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF506CEF148
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 09:46:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 885713C1DFA
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:46:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03DE63C19CB
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:44 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6C5CD10089AA
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5971721A32
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 09:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhjoj7FUJCD71GH8158d1/3lijFctYad3IKbkihQfXE=;
 b=W+TBHzGwWwS2zf6bS+yDc+SUyrt2RjYTCFYVr22VoU7CgxnNuShs+FRyRawalZZCwjjZtV
 pt29mdfN8DnXJcG8x7exQihmSxrtUT9pB2zvl3KCYNUdxBU2AqWSoJ0w3FOn+Iko3pFRuc
 4T8pH7Zoiy7Dl/OSzHWvDedjoNOnS4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhjoj7FUJCD71GH8158d1/3lijFctYad3IKbkihQfXE=;
 b=WyN7ACK8S45DGqfIqBLFT3CoFG3gQLysmuLZAKm+DnfO6WBbgAamdQlCrkDTh+YddM6HUx
 oU/kHb2MG0NETOAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W+TBHzGw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WyN7ACK8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhjoj7FUJCD71GH8158d1/3lijFctYad3IKbkihQfXE=;
 b=W+TBHzGwWwS2zf6bS+yDc+SUyrt2RjYTCFYVr22VoU7CgxnNuShs+FRyRawalZZCwjjZtV
 pt29mdfN8DnXJcG8x7exQihmSxrtUT9pB2zvl3KCYNUdxBU2AqWSoJ0w3FOn+Iko3pFRuc
 4T8pH7Zoiy7Dl/OSzHWvDedjoNOnS4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhjoj7FUJCD71GH8158d1/3lijFctYad3IKbkihQfXE=;
 b=WyN7ACK8S45DGqfIqBLFT3CoFG3gQLysmuLZAKm+DnfO6WBbgAamdQlCrkDTh+YddM6HUx
 oU/kHb2MG0NETOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60AAB1340C
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 09:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kHJ9EZH+BGcZPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 08 Oct 2024 09:42:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 11:42:07 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v5-14-66f4e1a9e7db@suse.com>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
In-Reply-To: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728380526; l=2672;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=vhk0iEF24kWR+ZysQO7C1LRxWH0/jU8KuZMdv6e5p6A=;
 b=nNPPWY/uMd8KXU558TPNehpOZrpbw0ZlpVv6WBCDl85xqmzGnzOLUqrzqu5SAcIS5hPGQgf4e
 cj0aSLCA2XuBlI3s39xvpwryoOY07kBlirXEkzccH63+05gJT/5mRy+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 5971721A32
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 14/16] Add statmount08 test
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

Verify that statmount() raises EPERM when mount point is not accessible.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount08.c | 65 +++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index bf222e466..f8ae25344 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1581,6 +1581,7 @@ statmount04 statmount04
 statmount05 statmount05
 statmount06 statmount06
 statmount07 statmount07
+statmount08 statmount08
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index b2a55c077..6106fcf07 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -5,3 +5,4 @@ statmount04
 statmount05
 statmount06
 statmount07
+statmount08
diff --git a/testcases/kernel/syscalls/statmount/statmount08.c b/testcases/kernel/syscalls/statmount/statmount08.c
new file mode 100644
index 000000000..21b8b7342
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount08.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that statmount() raises EPERM when mount point is not accessible.
+ */
+
+#define _GNU_SOURCE
+
+#include <pwd.h>
+#include "statmount.h"
+#include "lapi/stat.h"
+
+static struct statmount *st_mount;
+static uint64_t root_id;
+static gid_t nobody_gid;
+static uid_t nobody_uid;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETEGID(nobody_gid);
+	SAFE_SETEUID(nobody_uid);
+
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_FAIL(statmount(root_id,	STATMOUNT_SB_BASIC, st_mount,
+		sizeof(struct statmount), 0), EPERM);
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_gid = pw->pw_gid;
+	nobody_uid = pw->pw_uid;
+
+	SAFE_STATX(AT_FDCWD, "/", 0, STATX_MNT_ID_UNIQUE, &sx);
+	root_id = sx.data.stx_mnt_id;
+
+	SAFE_CHROOT(tst_tmpdir_path());
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.min_kver = "6.8",
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
