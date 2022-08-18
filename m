Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96946C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 10:10:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D94173CA1B8
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 12:10:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5C173CA1EC
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 12:09:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D237410005C0
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 12:09:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26DCA339D1;
 Thu, 18 Aug 2022 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660817391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUAFR3WdoNM60yPqS3yms5ggrO6UY5QODEny5Ysksfo=;
 b=FJwICZcXMXoACbhbMMDe9gZ0UB445HzLykOmnnMHVexWZ7MDmSgyf60LQNeNtXVoEek3rI
 AoRcxnf/5Xmfjjxpd5aOCsL+YtM1elYE5RHBdv8AEGUatQmjPJOKezYrCuMkrxoaawRW1V
 pmIYvf8e05kBvY4JkyAEUm4u8XJbN5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660817391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUAFR3WdoNM60yPqS3yms5ggrO6UY5QODEny5Ysksfo=;
 b=mFIXZ3VIr853aWbL/71LY34CxRLiEVj9qlPzr1MoZV6sb7tTa2u+IU7jhZJsvpzVyoRQN4
 oyYrz0Yl/3Hr2vAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEAD4139B7;
 Thu, 18 Aug 2022 10:09:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eOQ6J+4P/mIBDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 18 Aug 2022 10:09:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Aug 2022 12:09:44 +0200
Message-Id: <20220818100945.7935-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818100945.7935-1-pvorel@suse.cz>
References: <20220818100945.7935-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_device: Increase DEV_MIN_SIZE to 300 MB
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

Previous default 256 MB was not enough for mkfs.xfs since v5.19.0-rc1
[1] which refuses to create filesystems < 300 MB. Although the
limitation can be workarounded by setting three environment variables,
it's better to increase the variable.

[1]: https://lore.kernel.org/all/164738662491.3191861.15611882856331908607.stgit@magnolia/

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index c34cbe6d1..8419b80c3 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -44,7 +44,7 @@
 #define LOOP_CONTROL_FILE "/dev/loop-control"
 
 #define DEV_FILE "test_dev.img"
-#define DEV_SIZE_MB 256u
+#define DEV_SIZE_MB 300u
 
 static char dev_path[1024];
 static int device_acquired;
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
