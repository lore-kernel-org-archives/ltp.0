Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE64E87822
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 12:51:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 713733CD23F
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 13:51:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E758A3CD33A
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 13:50:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 434EA1A002D9
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 13:50:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC5535BCC6
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770123029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZbKHT4MUnT3l77+bE/Iv8KP/CiPtz68Xw9OR9Ck8lw=;
 b=eflgRLQd0SKoxXDvcaW3sj+I4P/DrzuU8JuzudXgr1cXS+vsMuzZuawQWt0wK5u3/2h0hH
 b9znhJ5kqBXjG5x8IY96J697I+zJEO9NPoPofUjBz8vQeCUoLbC86lv+l9vQLqwGb7BmAt
 EjPuXGUZwlDIoqZxrjEFdWokcgyzufs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770123029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZbKHT4MUnT3l77+bE/Iv8KP/CiPtz68Xw9OR9Ck8lw=;
 b=FBLtOre/HHjGsaOt6ckQMBOIqd3oQgaXZmZ6cncaTxqrtyhku/1XNHg7RU0yDtdpE8CHi7
 TgFET11s/zG3vbCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eflgRLQd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="FBLtOre/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770123029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZbKHT4MUnT3l77+bE/Iv8KP/CiPtz68Xw9OR9Ck8lw=;
 b=eflgRLQd0SKoxXDvcaW3sj+I4P/DrzuU8JuzudXgr1cXS+vsMuzZuawQWt0wK5u3/2h0hH
 b9znhJ5kqBXjG5x8IY96J697I+zJEO9NPoPofUjBz8vQeCUoLbC86lv+l9vQLqwGb7BmAt
 EjPuXGUZwlDIoqZxrjEFdWokcgyzufs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770123029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZbKHT4MUnT3l77+bE/Iv8KP/CiPtz68Xw9OR9Ck8lw=;
 b=FBLtOre/HHjGsaOt6ckQMBOIqd3oQgaXZmZ6cncaTxqrtyhku/1XNHg7RU0yDtdpE8CHi7
 TgFET11s/zG3vbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 997E63EA63
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 12:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oHhJJRXvgWkNcgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Feb 2026 12:50:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Feb 2026 13:50:24 +0100
Message-ID: <20260203125029.15413-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203125029.15413-1-mdoucha@suse.cz>
References: <20260203125029.15413-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: AC5535BCC6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] openposix/aio_cancel: Add helper functions for
 setup and cleanup
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

Add helper functions for setting up and cleaning up boilerplate
aio requests to a socket pair. The socket pair approach is useful
for tests which need some requests to block in order to prevent
race conditions.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../open_posix_testsuite/include/aio_test.h   | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 testcases/open_posix_testsuite/include/aio_test.h

diff --git a/testcases/open_posix_testsuite/include/aio_test.h b/testcases/open_posix_testsuite/include/aio_test.h
new file mode 100644
index 000000000..9de0a4d93
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/aio_test.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <aio.h>
+#include <sys/socket.h>
+
+static int setup_aio(const char *testname, int fd_pair[2], struct aiocb *reqs,
+	unsigned int count)
+{
+	unsigned int i;
+	int ret;
+	int bufsize;
+	socklen_t argsize = sizeof(bufsize);
+
+	/* Open anonymous sockets */
+	ret = socketpair(AF_UNIX, SOCK_DGRAM, 0, fd_pair);
+
+	if (ret) {
+		printf("%s Error creating sockets(): %s\n", testname,
+			strerror(errno));
+		return -1;
+	}
+
+	ret = getsockopt(fd_pair[0], SOL_SOCKET, SO_SNDBUF, &bufsize, &argsize);
+	if (ret) {
+		printf("%s Error reading socket buffer size: %s\n", testname,
+			strerror(errno));
+		close(fd_pair[0]);
+		close(fd_pair[1]);
+		return -1;
+	}
+
+	/* Socket buffer size is twice the maximum message size */
+	bufsize /= 2;
+	memset(reqs, 0, sizeof(struct aiocb) * count);
+
+	/* Setup basic AIO requests */
+	for (i = 0; i < count; i++) {
+		reqs[i].aio_fildes = fd_pair[0];
+		reqs[i].aio_buf = malloc(bufsize);
+
+		if (!reqs[i].aio_buf) {
+			ret = errno;
+			break;
+		}
+
+		reqs[i].aio_nbytes = bufsize;
+		reqs[i].aio_sigevent.sigev_notify = SIGEV_NONE;
+		memset((void *)reqs[i].aio_buf, 0xaa, bufsize);
+	}
+
+	/* Setup successful */
+	if (i >= count)
+		return 0;
+
+	/* malloc() failed above */
+	for (i = 0; i < count; i++)
+		free((void *)reqs[i].aio_buf);
+
+	printf("%s malloc() failed: %s\n", testname, strerror(ret));
+	close(fd_pair[0]);
+	close(fd_pair[1]);
+	return -1;
+}
+
+static void cleanup_aio(int fd_pair[2], struct aiocb *reqs, unsigned int count)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < count; i++) {
+		if (!reqs[i].aio_buf)
+			break;
+
+		ret = aio_error(reqs + i);
+
+		/* flush written data from the socket */
+		if (ret == 0 || ret == EINPROGRESS) {
+			read(fd_pair[1], (void *)reqs[i].aio_buf,
+				reqs[i].aio_nbytes);
+		}
+
+		free((void *)reqs[i].aio_buf);
+	}
+
+	close(fd_pair[0]);
+	close(fd_pair[1]);
+}
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
