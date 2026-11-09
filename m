Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D07606A330
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=XEdGdcAh;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eqiWpHmD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=nahvPg1i;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6tnPvl1w
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3AE83EB5BB
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 19:32:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4310E3CDE56
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 19:32:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F21FC200905
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 19:32:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AE912296B;
 Mon,  9 Nov 2026 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794249155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qHnwOL5y4+Y2XmeiGhAsm/nPS2I02FOV/Jg/7x/iS8k=;
 b=XEdGdcAhSTnj6CBCwhy69Wqx+08aT/eblZkYPlP8H+wvMPeWug3/AehSJSmURSo33/MiTI
 /uIkRPravD/Whj5t4MvdrQO6mUUSwT8ULB8qQ2Z5bqtKx9LAgZEKupgw99iN7tGY1Owp7W
 aR1SMne3ryIqp1ZeKHicq7+3YIpBYdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794249155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qHnwOL5y4+Y2XmeiGhAsm/nPS2I02FOV/Jg/7x/iS8k=;
 b=eqiWpHmDl+r2ZT93AV6/SwskN3JgagMAd6sHSR3vqaR4GZPg8Xtk9G+fPMy6Kb5FAcodHm
 GsWRbmTVW+yhw5AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nahvPg1i;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6tnPvl1w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794249154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qHnwOL5y4+Y2XmeiGhAsm/nPS2I02FOV/Jg/7x/iS8k=;
 b=nahvPg1iepJGWvEh9APIj3YgIn0X33IFquhmF/WU+IevWoZo0SMgmJZhe5BDMNXmFK5mEP
 28n0kb+PsuRyLuf+XJ4+CLxzMisz8sOJVAScyHYDggQAS0gDBWRUsHNMidnuYOGd+hTVWi
 AK7mSukCe1u6Fv34QA8JCwJ62QZfHJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794249154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qHnwOL5y4+Y2XmeiGhAsm/nPS2I02FOV/Jg/7x/iS8k=;
 b=6tnPvl1wcoccBCQOEXY+4Czm2ws0KQnlM1Gx2ZV3UTe4BvqVdxZBQuA24aZeKNETPti4JH
 gW5Pe5a87nbO4WAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2DFF13319;
 Mon,  9 Nov 2026 18:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ReZoJcER8mpzZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Nov 2026 18:32:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  9 Nov 2026 19:32:22 +0100
Message-ID: <20261109183222.660447-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 5AE912296B
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_fd: Add runtime check for missing
 .needs_tmpdir
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Although it'd be possible to write sparse check for this,
which would be better, runtime check is simpler.

Follow-up: 07a9023085 ("accept03/tst_fd: Harden parallel runs against shared path races")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Also see

[RFC,1/1] sparse: LTP-006: Detect files created in the current directory
https://patchwork.kernel.org/project/ltp/patch/20261104182800.421758-1-pvorel@suse.cz/

Kind regards,
Petr

 lib/tst_fd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/tst_fd.c b/lib/tst_fd.c
index 6538a098c7..7cc5501fae 100644
--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -22,6 +22,8 @@
 #include "lapi/bpf.h"
 #include "lapi/fsmount.h"
 
+#include "tso_tmpdir.h"
+
 #include "tst_fd.h"
 
 struct tst_fd_desc {
@@ -30,8 +32,18 @@ struct tst_fd_desc {
 	const char *desc;
 };
 
+static void require_tmpdir(struct tst_fd *fd)
+{
+	if (tst_tmpdir_created())
+		return;
+
+	tst_brk(TBROK, "%s fd requires .needs_tmpdir = 1 (test bug, report to LTP ML)",
+		tst_fd_desc(fd));
+}
+
 static void open_file(struct tst_fd *fd)
 {
+	require_tmpdir(fd);
 	fd->fd = SAFE_OPEN("fd_file", O_RDWR | O_CREAT, 0666);
 	SAFE_UNLINK("fd_file");
 }
@@ -40,6 +52,7 @@ static void open_path(struct tst_fd *fd)
 {
 	int tfd;
 
+	require_tmpdir(fd);
 	tfd = SAFE_CREAT("fd_file", 0666);
 	SAFE_CLOSE(tfd);
 
@@ -50,6 +63,7 @@ static void open_path(struct tst_fd *fd)
 
 static void open_dir(struct tst_fd *fd)
 {
+	require_tmpdir(fd);
 	SAFE_MKDIR("fd_dir", 0700);
 	fd->fd = SAFE_OPEN("fd_dir", O_DIRECTORY);
 	SAFE_RMDIR("fd_dir");
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
