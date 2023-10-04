Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A84AE7B604
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 12:47:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ABB93CDB7D
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 14:47:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 186323CDADB
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:46:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AC791601002
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:46:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B603E2183A;
 Wed,  4 Oct 2023 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696423589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pad8hg3mqiq7KVkuWJoEhHoGMZyhbam01mzRl/lGIqs=;
 b=LmseKLVyN/nQe/vsWyEixbo+TQsj89cQl+NgsRE2oW1lmP+3kgxfijgl/ES2PXWymSUUmM
 Y2rH17oDll8LSubfe52/DpiZAEHePWcc973T/C1WH3PDaUg+DI7Xy5ecpVuR2xSuo95ku+
 YmMfk+SzFbwwm3XspzmhT/vx55avIB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696423589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pad8hg3mqiq7KVkuWJoEhHoGMZyhbam01mzRl/lGIqs=;
 b=hR9SEoHneh6On1/FWwrqz3BUHW4/M0mDvGSxLasox/mB+RMzo5ZJdjA325fcsqxbTZn6ZX
 5xieGGkHVgqKBdAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A001113A2E;
 Wed,  4 Oct 2023 12:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 772qJaVeHWXbPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 12:46:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Oct 2023 14:47:10 +0200
Message-ID: <20231004124712.3833-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004124712.3833-1-chrubis@suse.cz>
References: <20231004124712.3833-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lib: Add tst_fd_iterate()
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Which allows us to call a function on bunch of different file
descriptors.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_fd.h   |  39 +++++++++++++++
 include/tst_test.h |   1 +
 lib/tst_fd.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 include/tst_fd.h
 create mode 100644 lib/tst_fd.c

diff --git a/include/tst_fd.h b/include/tst_fd.h
new file mode 100644
index 000000000..711e043dd
--- /dev/null
+++ b/include/tst_fd.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_FD_H__
+#define TST_FD_H__
+
+enum tst_fd_type {
+	TST_FD_FILE,
+	TST_FD_DIR,
+	TST_FD_DEV_ZERO,
+	TST_FD_PROC_MAPS,
+	TST_FD_PIPE_IN,
+	TST_FD_PIPE_OUT,
+	TST_FD_UNIX_SOCK,
+	TST_FD_INET_SOCK,
+	TST_FD_IO_URING,
+	TST_FD_BPF_MAP,
+	TST_FD_MAX,
+};
+
+struct tst_fd {
+	enum tst_fd_type type;
+	int fd;
+};
+
+/*
+ * Iterates over all fd types and calls the run_test function for each of them.
+ */
+void tst_fd_iterate(void (*run_test)(struct tst_fd *fd));
+
+/*
+ * Returns human readable name for the file descriptor type.
+ */
+const char *tst_fd_desc(struct tst_fd *fd);
+
+#endif /* TST_FD_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 75c2109b9..5eee36bac 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -44,6 +44,7 @@
 #include "tst_taint.h"
 #include "tst_memutils.h"
 #include "tst_arch.h"
+#include "tst_fd.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/tst_fd.c b/lib/tst_fd.c
new file mode 100644
index 000000000..7b6cb767e
--- /dev/null
+++ b/lib/tst_fd.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/io_uring.h"
+#include "lapi/bpf.h"
+
+#include "tst_fd.h"
+
+const char *tst_fd_desc(struct tst_fd *fd)
+{
+	switch (fd->type) {
+	case TST_FD_FILE:
+		return "regular file";
+	case TST_FD_DIR:
+		return "directory";
+	case TST_FD_DEV_ZERO:
+		return "/dev/zero";
+	case TST_FD_PROC_MAPS:
+		return "/proc/self/maps";
+	case TST_FD_PIPE_IN:
+		return "pipe read end";
+	case TST_FD_PIPE_OUT:
+		return "pipe write end";
+	case TST_FD_UNIX_SOCK:
+		return "unix socket";
+	case TST_FD_INET_SOCK:
+		return "inet socket";
+	case TST_FD_IO_URING:
+		return "io_uring";
+	case TST_FD_BPF_MAP:
+		return "bpf map";
+	case TST_FD_MAX:
+	break;
+	}
+
+	return "invalid";
+}
+
+void tst_fd_iterate(void (*run_test)(struct tst_fd *fd))
+{
+	enum tst_fd_type i;
+	struct tst_fd fd;
+	int pipe[2];
+	struct io_uring_params uring_params = {};
+	union bpf_attr array_attr = {
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = 4,
+		.value_size = 8,
+		.max_entries = 1,
+	};
+
+	SAFE_PIPE(pipe);
+
+	for (i = 0; i < TST_FD_MAX; i++) {
+		fd.type = i;
+
+		switch (i) {
+		case TST_FD_FILE:
+			fd.fd = SAFE_OPEN("fd_file", O_RDWR | O_CREAT);
+			SAFE_UNLINK("fd_file");
+		break;
+		case TST_FD_DIR:
+			SAFE_MKDIR("fd_dir", 0700);
+			fd.fd = SAFE_OPEN("fd_dir", O_DIRECTORY);
+			SAFE_RMDIR("fd_dir");
+		break;
+		case TST_FD_DEV_ZERO:
+			fd.fd = SAFE_OPEN("/dev/zero", O_RDONLY);
+		break;
+		case TST_FD_PROC_MAPS:
+			fd.fd = SAFE_OPEN("/proc/self/maps", O_RDONLY);
+		break;
+		case TST_FD_PIPE_IN:
+			fd.fd = pipe[0];
+		break;
+		case TST_FD_PIPE_OUT:
+			fd.fd = pipe[1];
+		break;
+		case TST_FD_UNIX_SOCK:
+			fd.fd = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+		break;
+		case TST_FD_INET_SOCK:
+			fd.fd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+		break;
+		case TST_FD_IO_URING:
+			fd.fd = io_uring_setup(1, &uring_params);
+			if (fd.fd < 0) {
+				tst_res(TCONF | TERRNO,
+					"Skipping %s", tst_fd_desc(&fd));
+				continue;
+			}
+		break;
+		case TST_FD_BPF_MAP:
+			fd.fd = bpf(BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
+			if (fd.fd < 0) {
+				tst_res(TCONF | TERRNO,
+					"Skipping %s", tst_fd_desc(&fd));
+				continue;
+			}
+		break;
+		case TST_FD_MAX:
+		break;
+		}
+
+		run_test(&fd);
+
+		SAFE_CLOSE(fd.fd);
+	}
+}
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
