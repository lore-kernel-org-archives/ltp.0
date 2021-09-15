Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E40EC433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:47:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E76961216
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E76961216
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D76593C9201
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 17:47:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41CB63C234D
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:47:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 52A5A6010F8
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:47:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5CA2E222B1
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631720821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e/6ZFl0Xb1YIOwI1AMYh3g1++jGh/c29zJF+N5gEDs4=;
 b=gThJM1QlZAmo9TFYYpdfm88YF5lnPriFckftYZ2nHd8+wQCYPwxZcGRrQy54cZs66kpYf7
 XC4KQJdxVASmoPwam+TRTpIvq2QUhEJ5y6JUYWaOYZUzSyHBa/btXZVlBy9RM0AJCq+7bV
 /5RRdeTfzUlZoKMhZ58M+ldCIlvtRk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631720821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e/6ZFl0Xb1YIOwI1AMYh3g1++jGh/c29zJF+N5gEDs4=;
 b=oI+Q+GytVMXhrydK2boC5/pPo3RMlbVqg1h25mdF0eZoMe75urVjxAtle4TZLe/JJu7NJb
 lSBbHjWGu60LJ5DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4744713C37
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 15:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TOj+D3UVQmEuKwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 15:47:01 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Sep 2021 17:46:59 +0200
Message-ID: <20210915154659.26931-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] misc/crash02: Update syscall blacklist
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
Message-ID: <20210915154659.8FQMRGLP7JahQr4cQPfkkmrAeXwrJ4y3PPoRaBzgepM@z>

- fork() and vfork() are not mutually exclusive, blacklist both
- read() will sleep indefinitely if the first argument is 0

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/misc/crash/crash02.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
index 66f308b70..c68f580ef 100644
--- a/testcases/misc/crash/crash02.c
+++ b/testcases/misc/crash/crash02.c
@@ -464,7 +464,8 @@ int in_blacklist(int sysno)
 		 */
 #if defined(__NR_vfork) && __NR_vfork
 		SYS_vfork,
-#elif defined(__NR_fork) && __NR_fork
+#endif
+#if defined(__NR_fork) && __NR_fork
 		SYS_fork,
 #endif
 #endif /* __ia64__ */
@@ -476,6 +477,13 @@ int in_blacklist(int sysno)
 #endif
 #if defined(__NR_pause) && __NR_pause
 		__NR_pause,	/* int pause(void); - sleep indefinitely */
+#endif
+#if defined(__NR_read) && __NR_read
+		/*
+		 * ssize_t read(int fd, void *buf, size_t count); - will sleep
+		 * indefinitely if the first argument is 0
+		 */
+		__NR_read,
 #endif
 		-1
 	};
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
