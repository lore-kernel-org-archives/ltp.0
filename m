Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB69C433EF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:38:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 709943CA9DD
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:38:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEB2C3CA9DA
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 140C320004D
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C85BB21C70;
 Thu, 12 May 2022 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652358968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2y+r3C50Zn/8uc0wz/gBU2THYvayC3Sxn8vt25DX99g=;
 b=aEDF1KQp5oQD6Pzit511cH7bvSMLPw2hd/vvx/0O6WRQeDJlPI/C/NPpUprQQFl8ooxsps
 ecR2FplACy4jsYUUUObFh9BeqApGwgdRr6r+Q9IrELw6RxZLZ1YZ1W44nQ0TNzQGYP0U6z
 55CM9EGUvQ1GqQx3OHx1mgllumQb4LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652358968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2y+r3C50Zn/8uc0wz/gBU2THYvayC3Sxn8vt25DX99g=;
 b=Bsqc83/TjfcWyJ3geNPXIVZatWEjxHuAxDsQ6DIDLGTETwiGhbGlYYT74BSm9vJW4ucvLU
 /zIK8rU6lUwsQqCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B745813ABE;
 Thu, 12 May 2022 12:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iDPwKzj/fGI0GgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:36:08 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 14:37:59 +0200
Message-Id: <20220512123816.24399-13-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 12/29] syscalls/inotify01: Remove now useless
 timeout
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify11.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify11.c b/testcases/kernel/syscalls/inotify/inotify11.c
index 062b92409..e426f9e1c 100644
--- a/testcases/kernel/syscalls/inotify/inotify11.c
+++ b/testcases/kernel/syscalls/inotify/inotify11.c
@@ -117,7 +117,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.timeout = 10,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.cleanup = cleanup,
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
