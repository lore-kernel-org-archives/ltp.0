Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7092FCD8C9C
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763050970; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=PXFmjoVLwRYelA5DM7YhL+lklXzwR/1ZuZI+jF4zTAk=;
 b=gOSseasrQSyN7sQUouC1THGTyGDQDZvYWlbUhfvBnz4xpG+QyMv6b7UAors3aO8tOhCuW
 4SDGdebdi4XHoWonAIGGkkJsksib37DEcY1HkDgfFmyb0lWWAvDZJhTHdOPbVoBGfjNPkTd
 +3SSpC4Sz6R9/X4OLYyrwUDTYsixFvk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AC003CF804
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 17:22:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3A933CF7FF
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 17:22:30 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE3DE1401106
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 17:22:29 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C290E402E5
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 16:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E04C4CEF5
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763050945;
 bh=P9GFooM6XEt5FZB3whjILro4u6qgOGuoj+ns38itepY=;
 h=From:To:Subject:Date:From;
 b=qIycZSji16Aao7JXT0SlbzyiH+d+krlCD1Qns2CEmj8CCI5Im6RYKwAicaI7xUq5c
 ZKcfHguZYFgcTR3FttdvjTSymCU9bQ8wuwR9GhlOZ+cFnerGECd4VL8OB/4XsqQnin
 AdkJsYq6cF6rgzlArhTclfrfO32fOF2m3DxWOtTGvIDcoA/ff8ps1UU7g3Fkqrqzp6
 NQf3lB9W+OBgnuUogofgI4aPorpsH8k41Ni6B6v6XSBnm0u8K51kkXqG7oxz1dspTb
 bbC6BoD5UcQ9rzwJs9WNkPUDvyv967EvIR1D4aBaIrYA+k+hEWpk5T9Di2nVqtLI6K
 ECLXyoto7luHQ==
To: ltp@lists.linux.it
Date: Fri, 14 Nov 2025 00:22:17 +0800
Message-ID: <20251113162217.1077332-1-zlang@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/stat04&lstat03: remove fs block size
 related code
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
From: Zorro Lang via ltp <ltp@lists.linux.it>
Reply-To: Zorro Lang <zlang@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The st_blksize isn't equivalent to the filesystem block size. The
stat(3) manual describe st_blksize as:

  "This field gives the "preferred" block size for efficient filesystem I/O."

So the st_blksize is the "preferred" block size for "efficient" fs
I/O, extN might think the "preferred" block size is fs block size.
But not all filesystems think same with extN. For example, xfs thinks
the "preferred" block size is:

  max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize)

So you might get st_blksize=4096, no matter on 1k blocksize xfs or 4k
blocksize xfs. We shouldn't expect to use a different blocksize mkfs
option to get a different st_blksize. This part of code is useless,
except causing unexpected test failures on other filesystems (e.g.
xfs, btrfs and so on).

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Hi,

I tried to fix the mkfs problem last year:
  https://lists.linux.it/pipermail/ltp/2024-December/041038.html

Now I got a chance to look back this test failure, I think it's not a mkfs
option problem, but the test case misunderstood the st_blksize.

Except we limit this test only run on extN, or we don't need to make
fs with a different block size, especially shouldn't expect to get
a different st_blksize from that.

Thanks,
Zorro

 testcases/kernel/syscalls/lstat/lstat03.c | 12 +-----------
 testcases/kernel/syscalls/stat/stat04.c   | 11 +----------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
index 9438e2920..7d9d01ad1 100644
--- a/testcases/kernel/syscalls/lstat/lstat03.c
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -34,7 +34,6 @@ static void run(void)
 	TST_EXP_EXPR(file_stat->st_gid != symb_stat->st_gid);
 	TST_EXP_EXPR(file_stat->st_size != symb_stat->st_size);
 	TST_EXP_EXPR(file_stat->st_blocks != symb_stat->st_blocks);
-	TST_EXP_EXPR(file_stat->st_blksize != symb_stat->st_blksize);
 	TST_EXP_EXPR(file_stat->st_atime != symb_stat->st_atime);
 	TST_EXP_EXPR(file_stat->st_mtime != symb_stat->st_mtime);
 	TST_EXP_EXPR(file_stat->st_ctime != symb_stat->st_ctime);
@@ -42,18 +41,9 @@ static void run(void)
 
 static void setup(void)
 {
-	char opt_bsize[32];
-	const char *const fs_opts[] = {opt_bsize, NULL};
-	struct stat sb;
-	int pagesize;
 	int fd;
 
-	/* change st_blksize / st_dev */
-	SAFE_STAT(".", &sb);
-	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
-
-	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
-	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
 	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
 
 	SAFE_TOUCH(FILENAME, 0777, NULL);
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
index 09a9a6823..3c233df51 100644
--- a/testcases/kernel/syscalls/stat/stat04.c
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -41,21 +41,12 @@ static void run(void)
 
 static void setup(void)
 {
-	char opt_bsize[32];
-	const char *const fs_opts[] = {opt_bsize, NULL};
-	struct stat sb;
-	int pagesize;
 	int fd;
 
 	file_path = tst_tmpdir_genpath(FILENAME);
 	symb_path = tst_tmpdir_genpath(SYMBNAME);
 
-	/* change st_blksize / st_dev */
-	SAFE_STAT(".", &sb);
-	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
-
-	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
-	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
 	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
 
 	SAFE_TOUCH(FILENAME, 0777, NULL);
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
