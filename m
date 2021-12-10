Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03829C433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 14:35:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C715C3C8159
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 15:35:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0B763C0B96
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 15:35:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B008E601016
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 15:35:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2CF71F3A1;
 Fri, 10 Dec 2021 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639146941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IaYJOULNbw7rRKP2UQPr8MaoqVDFqa65Gy4X6qo0lgE=;
 b=F55YKA28Yr+XdIhKRuxcelAZWGRDe1ye0o0OCC0mYSttUl/KeCaFpXVMTFYj6DBu2RjvW4
 srAwj0k5bDW6MfUUJvL2kleR34Jd0O8cntWdDLPephmKHjD/XnZNCAkZHPLuMwuk4TtnwJ
 6FW1J/sB0RQlW3lVuzT4bauS+FriUwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639146941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IaYJOULNbw7rRKP2UQPr8MaoqVDFqa65Gy4X6qo0lgE=;
 b=T7MGCuLkxuZXY2pRTRreF2NWS8zzlhgjAmgStd7Sl7RvGvsRl7RBIwHzI34GgvVgilq9+n
 ienydvPa3fkVweDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9444113BD5;
 Fri, 10 Dec 2021 14:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EXx7Ir1ls2HBSgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Dec 2021 14:35:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Dec 2021 15:35:36 +0100
Message-Id: <20211210143536.31429-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib/safe_net: TCONF SAFE_LISTEN() on ENOSYS
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

This is needed at least on bind04 on SLES with Common Criteria setup,
which is more strict and thus does not allow md5 usage:

bind04.c:138: TBROK: listen(3, 1) failed: ENOSYS (38)
sctp: failed to load transform for md5: -2

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/safe_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/safe_net.c b/lib/safe_net.c
index 211fd9b67d..1717f0745f 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -368,11 +368,14 @@ int safe_listen(const char *file, const int lineno, void (cleanup_fn)(void),
 		int socket, int backlog)
 {
 	int rval;
+	int res = TBROK;
 
 	rval = listen(socket, backlog);
 
 	if (rval == -1) {
-		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+		if (errno == ENOSYS)
+			res = TCONF;
+		tst_brkm_(file, lineno, res | TERRNO, cleanup_fn,
 			"listen(%d, %d) failed", socket, backlog);
 	} else if (rval) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
