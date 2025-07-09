Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0E6C83F0A
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752084667; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=FYuKD2TimzvzNBJBWSmf92mGmlaaGxPzaaYP7bv6iGw=;
 b=aBnzWlmRgJT9s0WRrhLt6s2M0r+F1DjEd1m0JpHPXKXkkcXXwXXJuqByjolHSg8YF5M7J
 tfLLxIZ1I5P8oXC0hxDeVZhIgA8Y7StRy4sMi5MYMo3KmxTed06IQSLyc1ubh1vfCYqkmQY
 N99rFl+juUMVBTGOmknvAxgA6EaAxtE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB4E13CAE3C
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 20:11:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B86A3C7CA7
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 20:10:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1893660095C
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 20:10:45 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 236234545D;
 Wed,  9 Jul 2025 18:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5648FC4CEEF;
 Wed,  9 Jul 2025 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752084643;
 bh=2FAxfnnf/wH32Rop4mxpdmZJ/DQjfkmofTwLRxQw7MA=;
 h=From:To:Cc:Subject:Date:From;
 b=nTck55REhDJ7MwBOj2/mYSQZnQ1+9AgHPoEx5bHStwbGulYQdEV64dHc8ayCfEBdQ
 fwHM5FlpCQCbtuWD6uFq3/kKUZ7AsV2lzQG73Va0jJ3qU+PxuzVG6inuEQkXNrbIv8
 RRFGT+Fv3BEi55n90fGX6xYj3e2RS6F8cEdWU8qZXZJ7rcfo2QOI4AjSybeChTekpU
 giUq5YNGL3rbDhOQolAYjORadiFOevAG4uvYPRaDD5YV6z/v26n+DsduSIJRIXEFvV
 Kle2axFNzreaoI9nyA9WiFtBDhUvityJQ8Y8k/0EK9e41TCCuI8b6ZrA1F3mODsML9
 HPq0bDX2MyVlA==
To: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Anuj Gupta <anuj20.g@samsung.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Date: Wed,  9 Jul 2025 20:10:14 +0200
Message-Id: <20250709181030.236190-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
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
From: Arnd Bergmann via ltp <ltp@lists.linux.it>
Reply-To: Arnd Bergmann <arnd@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, ltp@lists.linux.it, rbm@suse.com,
 benjamin.copeland@linaro.org, Pavel Begunkov <asml.silence@gmail.com>,
 dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Arnd Bergmann <arnd@arndb.de>

Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
handling in the blockdev ioctl handler breaks all ioctls with
_IOC_NR==2, as the new command is not added to the switch but only
a few of the command bits are check.

Refine the check to also validate the direction/type/length bits,
but still allow all supported sizes for future extensions.

Move the new command to the end of the function to avoid slowing
down normal ioctl commands with the added branches.

Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
Link: https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It seems that we have a lot of drivers with the same bug, as the
large majority of all _IOC_NR() users in the kernel fail to also
check the other bits of the ioctl command code. There are currently
55 files referencing _IOC_NR, and they all need to be manually
checked for this problem.
---
 block/ioctl.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 9ad403733e19..5e5a422bd09f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -567,9 +567,6 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 {
 	unsigned int max_sectors;
 
-	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
-		return blk_get_meta_cap(bdev, cmd, argp);
-
 	switch (cmd) {
 	case BLKFLSBUF:
 		return blkdev_flushbuf(bdev, cmd, arg);
@@ -647,9 +644,16 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return blkdev_pr_preempt(bdev, mode, argp, true);
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, mode, argp);
-	default:
-		return -ENOIOCTLCMD;
 	}
+
+	if (_IOC_DIR(cmd)  == _IOC_DIR(FS_IOC_GETLBMD_CAP) &&
+	    _IOC_TYPE(cmd) == _IOC_TYPE(FS_IOC_GETLBMD_CAP) &&
+	    _IOC_NR(cmd)   == _IOC_NR(FS_IOC_GETLBMD_CAP) &&
+	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
+	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))
+		return blk_get_meta_cap(bdev, cmd, argp);
+
+	return -ENOIOCTLCMD;
 }
 
 /*
-- 
2.39.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
