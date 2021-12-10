Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E2FC433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 15:37:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B45923C8276
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 16:37:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DC643C1DB8
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 16:37:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C7C48601D54
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 16:37:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0262121111
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 15:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639150663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7Gv8usnXCzuVl6RO9+5GqKaRq9dOub2SGTx35k4nInQ=;
 b=JUqilXYry1XdZvBrWePwEBpINZSNAO2GhGDc7GhdehE4wxWDlEPs/BdXoOeF0r/JrGLZ1Q
 +o1qd9xzJ4nJAEK0fh8f5gvUbEsTs1rx2wrP+rcYkN2p6i07fpAfkZ3zP3NNBr4PY29SNj
 0RBJe7mCce+p3fQtJ7u1yoXjGLFqJh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639150663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7Gv8usnXCzuVl6RO9+5GqKaRq9dOub2SGTx35k4nInQ=;
 b=JwDloBydUuxYivVb9ml9Vt6Nurb29c/Fr9cMfwt5qCKGOGjY35to9TRIvrUyTsBzCSxDiR
 6QKqtbpwrV6qU0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66BC413E15
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 15:37:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sPS1F0Z0s2FmZQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 15:37:42 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Dec 2021 16:39:03 +0100
Message-Id: <20211210153903.7316-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] [PATCH] dio_sparse: Fix compilation on
 alternative libc
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

The LONG_LONG_MAX is not actually correct macro for the long long limits
it should have been LLONG_MAX. Actually I do not have idea where this
comes from on my system, but the test fails to compile on Alpine with
musl.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/dio_sparse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 7a76f4c16..929adbfba 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -69,13 +69,13 @@ static void setup(void)
 	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
 
-	if (tst_parse_filesize(str_writesize, &writesize, 1, LONG_LONG_MAX))
+	if (tst_parse_filesize(str_writesize, &writesize, 1, LLONG_MAX))
 		tst_brk(TBROK, "Invalid write blocks size '%s'", str_writesize);
 
-	if (tst_parse_filesize(str_filesize, &filesize, 1, LONG_LONG_MAX))
+	if (tst_parse_filesize(str_filesize, &filesize, 1, LLONG_MAX))
 		tst_brk(TBROK, "Invalid file size '%s'", str_filesize);
 
-	if (tst_parse_filesize(str_offset, &offset, 0, LONG_LONG_MAX))
+	if (tst_parse_filesize(str_offset, &offset, 0, LLONG_MAX))
 		tst_brk(TBROK, "Invalid file offset '%s'", str_offset);
 
 	SAFE_STAT(".", &sb);
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
