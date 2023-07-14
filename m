Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CB5C0015E
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 11:42:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F5253CB606
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 13:42:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85C1B3C036A
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:42:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76D1310004A7
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:42:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D8392209F;
 Fri, 14 Jul 2023 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689334965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c1ZWmlbDXoUHS7rFh+T5CcSBHfr5C2ik/MscpJIcx8I=;
 b=qgJG5bUNf9E0mvdvOm/vpLikeemYRoBYOnyhs0/HMO8crgG+0SJIujDhrmnbKOKkIIvA9E
 ZiOjVj3rNQ97KEMp7MQAmHOctgwaFzlfYu71AhJ8OuCc1hJivw/wTakoGJrSMcQ6jlYxSn
 IRIhpe/1Vga01D/CTIO9Xu86NQgEPzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689334965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c1ZWmlbDXoUHS7rFh+T5CcSBHfr5C2ik/MscpJIcx8I=;
 b=gEi4q1eYJ4LoMM02XX/TsICXIuP94n6RskjQ8w2ttjvktgm5PLHw2eL+nC3kWQPEJ6Qezs
 rvGD8zcHVBCfHKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05B0C138F8;
 Fri, 14 Jul 2023 11:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EGdQALU0sWRpOgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 14 Jul 2023 11:42:45 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>, Eric Biggers <ebiggers@kernel.org>,
 ltp@lists.linux.it
Date: Fri, 14 Jul 2023 13:42:02 +0200
Message-ID: <20230714114244.32109-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] statx09: Set fs-verity blocksize to FS blocksize
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
blocksize to the filesystem blocksize to avoid errors.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Setting filesystem blocksize to pagesize would require moving the mkfs
command to setup(). We can do that later to fix support for kernels
before v6.3 but let's fix the failure on latest kernel version first.

 testcases/kernel/syscalls/statx/statx09.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
index c03d2c91e..7211d8393 100644
--- a/testcases/kernel/syscalls/statx/statx09.c
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -80,8 +80,10 @@ static void flag_setup(void)
 {
 	int fd, attr, ret;
 	struct fsverity_enable_arg enable;
+	struct stat statbuf;
 
 	fd = SAFE_OPEN(TESTFILE_FLAGGED, O_RDONLY, 0664);
+	SAFE_FSTAT(fd, &statbuf);
 
 	ret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
 	if (ret < 0) {
@@ -94,7 +96,7 @@ static void flag_setup(void)
 	memset(&enable, 0, sizeof(enable));
 	enable.version = 1;
 	enable.hash_algorithm = hash_algorithms[0];
-	enable.block_size = 4096;
+	enable.block_size = statbuf.st_blksize;
 	enable.salt_size = 0;
 	enable.salt_ptr = (intptr_t)NULL;
 	enable.sig_size = 0;
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
