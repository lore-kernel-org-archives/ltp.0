Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCE7C47DDF
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 12:58:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF0393CE1F8
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 13:58:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33EA53C598A
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 13:58:17 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 362D3601A37
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 13:58:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D8F0C1F7E3;
 Wed, 24 Jan 2024 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706101096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1tncTcGVQ4Z7Yy8fwTa/ocAHT8xZmMUvb1qRzYYx9mI=;
 b=AYvYMyp68+wnI9OhC8zahPHSIJYNe5i6SOjYbZUyl/La1Virl3lYT8SUHEtvRtOenJxVK3
 JE7d/rlHY4PdXEot4t2BPincxaN1YmIUUJaOWC1DnPQQe1RCwscFjGRRyuCdU6/CnyMnGO
 8AFVyvTPn2GLrPrFJ7tvQfIYYg2RFWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706101096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1tncTcGVQ4Z7Yy8fwTa/ocAHT8xZmMUvb1qRzYYx9mI=;
 b=kxcEIGziVoTzW0+pFExGs1L8Pj/h1dR8jgZ34ol4V44wuwksWiO47xQpEKNmZUO39jHokc
 IW/ooyPsNhbpkBCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706101095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1tncTcGVQ4Z7Yy8fwTa/ocAHT8xZmMUvb1qRzYYx9mI=;
 b=sgO/N+Q/5tlqSK0+HwcmQV1ZalyKBGG9sk7uOhFhLIvGhIsVC77rBRzRZ+fKEC3qd6n+z7
 PA3OyzR3UInQ2G/PkPlXa1Ui+F1ep7dwo9vLLnUrof001kFWjYKL1/plBC61C2RHWqpTVS
 bBSx9lLvXiLvlK3k7EfbZoTRdJrxbaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706101095;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1tncTcGVQ4Z7Yy8fwTa/ocAHT8xZmMUvb1qRzYYx9mI=;
 b=WrPBQ09bHhgUh2O4t0xsJLV6phSvbdNyCZHCJCIWsq7Niwtz0Lbdco50rQLj62WA1zW3SN
 a5YnYCfO8V2b2eAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAC8413786;
 Wed, 24 Jan 2024 12:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xR2rMGcJsWWVPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jan 2024 12:58:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jan 2024 13:58:13 +0100
Message-ID: <20240124125813.6611-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [7.08 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_SPAM_SHORT(2.78)[0.928]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-0.60)[-0.602]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_fd: Avoid tst_brk(TCONF,
 ...) on older distros
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

All the lapi/ functions does call tst_syscall() that does
tst_brk(TCONF, ...) on ENOSYS which exits the testrun prematurely on older
distributions.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reported-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_fd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/tst_fd.c b/lib/tst_fd.c
index ea84e1c85..ab7de81aa 100644
--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -139,7 +139,7 @@ static void open_timerfd(struct tst_fd *fd)
 
 static void open_pidfd(struct tst_fd *fd)
 {
-	fd->fd = pidfd_open(getpid(), 0);
+	fd->fd = syscall(__NR_pidfd_open, getpid(), 0);
 	if (fd->fd < 0)
 		tst_brk(TBROK | TERRNO, "pidfd_open()");
 }
@@ -194,7 +194,7 @@ static void open_io_uring(struct tst_fd *fd)
 {
 	struct io_uring_params uring_params = {};
 
-	fd->fd = io_uring_setup(1, &uring_params);
+	fd->fd = syscall(__NR_io_uring_setup, 1, &uring_params);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -210,7 +210,7 @@ static void open_bpf_map(struct tst_fd *fd)
 		.max_entries = 1,
 	};
 
-	fd->fd = bpf(BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
+	fd->fd = syscall(__NR_bpf, BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -219,7 +219,7 @@ static void open_bpf_map(struct tst_fd *fd)
 
 static void open_fsopen(struct tst_fd *fd)
 {
-	fd->fd = fsopen("ext2", 0);
+	fd->fd = syscall(__NR_fsopen, "ext2", 0);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -228,7 +228,7 @@ static void open_fsopen(struct tst_fd *fd)
 
 static void open_fspick(struct tst_fd *fd)
 {
-	fd->fd = fspick(AT_FDCWD, "/", 0);
+	fd->fd = syscall(__NR_fspick, AT_FDCWD, "/", 0);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -237,7 +237,7 @@ static void open_fspick(struct tst_fd *fd)
 
 static void open_open_tree(struct tst_fd *fd)
 {
-	fd->fd = open_tree(AT_FDCWD, "/", 0);
+	fd->fd = syscall(__NR_open_tree, AT_FDCWD, "/", 0);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
