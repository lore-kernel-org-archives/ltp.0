Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8DBEB64DD
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 13:29:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7ECE3CECEB
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 15:29:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDAD03C0313
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 15:29:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CAEF5100098A
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 15:29:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 916A41FDE4;
 Thu, 13 Jul 2023 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689254942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EniX7MhmuYUdXz28r2di0Fv4cVNtPzKC3I0qb/EYM9E=;
 b=nWZ/qCgyknYVz0IIikWGnQjmNfpzHvuujTMxadlaZ6KEDWDQc1HgR4kqDo8BxhV220h9Jm
 IWN9mcW+SOxikbjKcvzgyisaL8lm4/ZdZmhc8n5VTJvOj05TE6NyCxR+ojlftJh+c255kS
 cs/8mcmSVRr/zCPsyxj4HeiuqKUtPeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689254942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EniX7MhmuYUdXz28r2di0Fv4cVNtPzKC3I0qb/EYM9E=;
 b=YwNsWWT8d8LZVJZCp3XqtZ4SIro5zwM9IWHlNSU1vG5mK3oL+G733uJzGgkcsOPe0ejqJ/
 vTV/5q3JP1AebuDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EDD413489;
 Thu, 13 Jul 2023 13:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YqUcGh78r2TlSwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 13 Jul 2023 13:29:02 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>,
	ltp@lists.linux.it
Date: Thu, 13 Jul 2023 15:28:52 +0200
Message-ID: <20230713132901.28660-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] statx09: Reduce fs-verity blocksize to 1024
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

The kernel requires that fs-verity blocksize must be at most equal
to the filesystem blocksize. Testing on small loop device means that
mkfs.ext4 will very likely default to blocksize of 1024. Set fs-verity
blocksize to the minimum possible value (1024) to avoid blocksize
mismatch.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Alternatively, we could add "-b 4096" to .dev_fs_opts.

 testcases/kernel/syscalls/statx/statx09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
index c03d2c91e..dc9786c76 100644
--- a/testcases/kernel/syscalls/statx/statx09.c
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -94,7 +94,7 @@ static void flag_setup(void)
 	memset(&enable, 0, sizeof(enable));
 	enable.version = 1;
 	enable.hash_algorithm = hash_algorithms[0];
-	enable.block_size = 4096;
+	enable.block_size = 1024;
 	enable.salt_size = 0;
 	enable.salt_ptr = (intptr_t)NULL;
 	enable.sig_size = 0;
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
