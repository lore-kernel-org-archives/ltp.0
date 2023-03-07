Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0722AC678D5
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 14:55:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 676693CDA1D
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 15:55:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 973863C2461
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 15:55:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2EB151A0081B
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 15:55:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C94781F8C2;
 Tue,  7 Mar 2023 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678200925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2F9rS7ODagnwJ1o7gZdNgtCbwmjkjd2qFG1Xy39zkzQ=;
 b=USZTFwocMh8t6y7gjtkcUEdnz92MjrUkoKEYLSStT4urofoEV4PaC3Kf9aFwGuXQYq81dg
 0Vd2ZoPE+Y0MebNsyOskL8R5oSU3nJugp0Cm3iBD1BAZoGQIhVq7i3JZYFGUyB0bTTuBYb
 +FmQyNM9mxIsFldRDZ5bamGruQP5mSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678200925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2F9rS7ODagnwJ1o7gZdNgtCbwmjkjd2qFG1Xy39zkzQ=;
 b=UvjhQweMuEBC+aAkmGCwIbgxFySw8b3Q2ikIEdI93fHViBTOiszcTXlVr5KfdHgLUgLNFo
 86IPqv+1cFgLslDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 651DA1341F;
 Tue,  7 Mar 2023 14:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +DFgFl1QB2Q0DwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Mar 2023 14:55:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  7 Mar 2023 15:55:16 +0100
Message-Id: <20230307145517.1359-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307145517.1359-1-pvorel@suse.cz>
References: <20230307145517.1359-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: Add tst_fsfreeze.c
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
Cc: Eric Sandeen <sandeen@sandeen.net>, "Darrick J . Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It will be needed for df01.sh run in XFS since kernel 5.19.
Instead of requiring users to have fsfreeze implement LTP helper.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/.gitignore     |  3 ++-
 testcases/lib/Makefile       |  2 +-
 testcases/lib/tst_fsfreeze.c | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 testcases/lib/tst_fsfreeze.c

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 34dea272d..fc8214b88 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -3,10 +3,12 @@
 /tst_check_kconfigs
 /tst_checkpoint
 /tst_device
+/tst_fsfreeze
 /tst_getconf
 /tst_get_free_pids
 /tst_get_median
 /tst_get_unused_port
+/tst_hexdump
 /tst_kvcmp
 /tst_net_iface_prefix
 /tst_net_ip_prefix
@@ -15,5 +17,4 @@
 /tst_rod
 /tst_sleep
 /tst_supported_fs
-/tst_hexdump
 /tst_timeout_kill
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index f4f8c8524..abdfe464c 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -12,6 +12,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
-			   tst_check_kconfigs tst_cgctl
+			   tst_check_kconfigs tst_cgctl tst_fsfreeze
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_fsfreeze.c b/testcases/lib/tst_fsfreeze.c
new file mode 100644
index 000000000..4b0b12cba
--- /dev/null
+++ b/testcases/lib/tst_fsfreeze.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2010 Hajime Taira <htaira@redhat.com>
+ *                    Masatake Yamato <yamato@redhat.com>
+ * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
+ *
+ * Based on fsfreeze from util-linux.
+ */
+
+#include <linux/fs.h>
+#include <stdio.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+static void help(void)
+{
+	printf("Freeze and unfreeze the device.\n");
+	printf("Usage: tst_fsfreeze device\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int fd;
+
+	if (argc < 2) {
+		help();
+		return 1;
+	}
+
+	fd = SAFE_OPEN(argv[1], O_RDONLY);
+	SAFE_IOCTL(fd, FIFREEZE, 0);
+	SAFE_IOCTL(fd, FITHAW, 0);
+	SAFE_CLOSE(fd);
+
+	return 0;
+}
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
