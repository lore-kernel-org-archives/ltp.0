Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA890C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 11:51:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA9403CBC47
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 12:51:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA8B53C8C27
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 12:50:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63102200237
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 12:50:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A71320424;
 Fri, 16 Dec 2022 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671191456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F8RyjAJm4VSgoqlme7bf79u4UzYEnjmVwAcbYnNYE/I=;
 b=fPImg3an8qjtFfRzUrYv/4tLGCSqnf5dftyJ7setdbePJvqwN1iFTb9jMxT8pY8dQo/Nhb
 z5/ec3RxdN8MLCutYKiy2j0Vwpg2w4olfV7/DrUtRGfElppBBlncJ+rabmuo6v6rNHAEgB
 xfBeGfHZ/w6wIobABVFC7uxMf/15Xv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671191456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F8RyjAJm4VSgoqlme7bf79u4UzYEnjmVwAcbYnNYE/I=;
 b=QO0AFIgG1QVC4NLIEkKi8Gl7oeS8RDva5u2QfkLj0vaWf1v/Ifcp/I74AizGxz4do/Dpd/
 ENdJyrDO1DkyqiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2628F138F0;
 Fri, 16 Dec 2022 11:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TVzDB6BbnGM7GAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 11:50:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 16 Dec 2022 12:50:52 +0100
Message-Id: <20221216115052.30511-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] aiocp.c: TCONF on O_DIRECT on tmpfs
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

O_DIRECT is not supported on tmpfs. This flag is added by -f option,
thus cannot be filtered with .skip_filesystems.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/aiocp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index ee893ab118..275000f3e8 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -240,6 +240,9 @@ static void setup(void)
 		if (strncmp(str_oflag, "SYNC", 4) == 0) {
 			dstflags |= O_SYNC;
 		} else if (strncmp(str_oflag, "DIRECT", 6) == 0) {
+			if (tst_fs_type(".") == TST_TMPFS_MAGIC)
+				tst_brk(TCONF, "O_DIRECT not supported on tmpfs");
+
 			srcflags |= O_DIRECT;
 			dstflags |= O_DIRECT;
 		}
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
