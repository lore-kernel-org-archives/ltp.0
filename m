Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC24C3DA79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 12:53:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0481B3CE366
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 13:53:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B2D43CCC5B
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 13:53:25 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C76D160067A
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 13:53:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4788F1FD35;
 Mon, 15 Jan 2024 12:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705323204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqIxisi1ENpcSL7QO9oW3ccJ2h4qZHc+yC8fSbxoqpA=;
 b=A1hsaWif6ZMQqV7F4e1aOUjHOHgrzQmlT+Rz1Tr8P42MXyHOf5qZRq6xv9AYciWw66rhuv
 ZDwM7CSDNn2sRZzVlJh3znQ8T1QbfPSE9Hd/j1DGFL3uxsg0aGweFvM53Z5qgdGEHJOjq/
 FmD6Q/RQSqnWPb8OXu5DW/+uLjbT+zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705323204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqIxisi1ENpcSL7QO9oW3ccJ2h4qZHc+yC8fSbxoqpA=;
 b=EyRfBf4wnZCuNP7wQO4LIYYdF7FYlKeVsOEYaqkfvP35huMOQ99HWLG9MLw/pPPZqJv5CO
 wiKtjhC/WO3SZzBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705323204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqIxisi1ENpcSL7QO9oW3ccJ2h4qZHc+yC8fSbxoqpA=;
 b=A1hsaWif6ZMQqV7F4e1aOUjHOHgrzQmlT+Rz1Tr8P42MXyHOf5qZRq6xv9AYciWw66rhuv
 ZDwM7CSDNn2sRZzVlJh3znQ8T1QbfPSE9Hd/j1DGFL3uxsg0aGweFvM53Z5qgdGEHJOjq/
 FmD6Q/RQSqnWPb8OXu5DW/+uLjbT+zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705323204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqIxisi1ENpcSL7QO9oW3ccJ2h4qZHc+yC8fSbxoqpA=;
 b=EyRfBf4wnZCuNP7wQO4LIYYdF7FYlKeVsOEYaqkfvP35huMOQ99HWLG9MLw/pPPZqJv5CO
 wiKtjhC/WO3SZzBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A18C13751;
 Mon, 15 Jan 2024 12:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7OAkDcQqpWWTVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 12:53:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 15 Jan 2024 13:53:49 +0100
Message-ID: <20240115125351.7266-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115125351.7266-1-chrubis@suse.cz>
References: <20240115125351.7266-1-chrubis@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A1hsaWif;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EyRfBf4w
X-Spamd-Result: default: False [4.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,suse.com];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4788F1FD35
X-Spamd-Bar: ++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] syscalls: readahead01: Make use of tst_fd
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
 linux-fsdevel@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../kernel/syscalls/readahead/readahead01.c   | 52 ++++++++++---------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index bdef7945d..e86a73e3e 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2012 Linux Test Project, Inc.
+ * Copyright (C) 2023-2024 Cyril Hrubis <chrubis@suse.cz>
  */
 
 /*\
@@ -30,43 +31,44 @@
 
 static void test_bad_fd(void)
 {
-	char tempname[PATH_MAX] = "readahead01_XXXXXX";
-	int fd;
+	int fd[2];
+
+	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF,
+	             "readahead() with fd = -1");
 
-	tst_res(TINFO, "%s -1", __func__);
-	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF);
+	SAFE_PIPE(fd);
+	SAFE_CLOSE(fd[0]);
+	SAFE_CLOSE(fd[1]);
 
-	tst_res(TINFO, "%s O_WRONLY", __func__);
-	fd = mkstemp(tempname);
-	if (fd == -1)
-		tst_res(TFAIL | TERRNO, "mkstemp failed");
-	SAFE_CLOSE(fd);
-	fd = SAFE_OPEN(tempname, O_WRONLY);
-	TST_EXP_FAIL(readahead(fd, 0, getpagesize()), EBADF);
-	SAFE_CLOSE(fd);
-	unlink(tempname);
+	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EBADF,
+	             "readahead() with invalid fd");
 }
 
-static void test_invalid_fd(void)
+static void test_invalid_fd(struct tst_fd *fd)
 {
-	int fd[2];
 
-	tst_res(TINFO, "%s pipe", __func__);
-	SAFE_PIPE(fd);
-	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
-	SAFE_CLOSE(fd[0]);
-	SAFE_CLOSE(fd[1]);
+	switch (fd->type) {
+	/* These succeed */
+	case TST_FD_FILE:
+	case TST_FD_MEMFD:
+	case TST_FD_PROC_MAPS:
+		return;
+	default:
+		break;
+	}
 
-	tst_res(TINFO, "%s socket", __func__);
-	fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
-	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
-	SAFE_CLOSE(fd[0]);
+	int exp_errnos[] = {EBADF, EINVAL, ESPIPE};
+
+	TST_EXP_FAIL_ARR(readahead(fd->fd, 0, getpagesize()), exp_errnos,
+			"readahead() on %s", tst_fd_desc(fd));
 }
 
 static void test_readahead(void)
 {
 	test_bad_fd();
-	test_invalid_fd();
+
+	TST_FD_FOREACH(fd)
+		test_invalid_fd(&fd);
 }
 
 static void setup(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
