Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ED2D3C54C
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 07:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1729235802; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=4FYFnDYCbs8f2ux9ZRO4Q4ED2tagZjPppU8TREzX7D8=;
 b=Ks9AuPdR0eIe0LK2PRB9XwS7d6OI8WsMXFJXF8NfTTgBKw85BxHDKVlLcBZJWH+hdIxYp
 +z9O5KUlcGlHT20LoXYnKaSeewlJv6G67q64oXU6hl3yfLw2mfM6vJY8BeSYJjgI06mSdzP
 RgQoJFpStRbLDZMdRTYzrtkuER3W5mE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 159623C61E2
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 09:16:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DF8C3C55A6
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 09:16:20 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=wozizhi@huawei.com; receiver=lists.linux.it)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9A5DC65387D
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 09:16:17 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XVGCs67DPz10Njb
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 15:14:17 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
 by mail.maildlp.com (Postfix) with ESMTPS id 12D8E180113
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 15:16:13 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 15:16:12 +0800
To: <ltp@lists.linux.it>, <jack@suse.cz>, <amir73il@gmail.com>,
 <pvorel@suse.cz>
Date: Fri, 18 Oct 2024 15:13:53 +0800
Message-ID: <20241018071353.2732203-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify10: Calling drop_cache three times to ensure
 the inode is evicted
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
From: Zizhi Wo via ltp <ltp@lists.linux.it>
Reply-To: Zizhi Wo <wozizhi@huawei.com>
Cc: yangerkun@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In commmit 6df425bb7040 ("fanotify10: Calling drop_cache twice to ensure
the inode is evicted"), the number of drop_cache operations was increased
to two in order to prevent inodes from being left uncleared due to inodes
and dentries being on different NUMA nodes, which would cause the testcase
to fail.

However, during our local testing, I found that this testcase still
occasionally fails:

fanotify10.c:771: TINFO: Test #27: don't ignore fs events created inside a parent with evicted ignore mark
fanotify10.c:510: TPASS: Found 0 ignore marks which is in expected range 0-0
fanotify10.c:510: TPASS: Found 0 ignore marks which is in expected range 0-0
fanotify10.c:510: TPASS: Found 0 ignore marks which is in expected range 0-0
fanotify10.c:510: TPASS: Found 1 ignore marks which is in expected range 0-8
fanotify10.c:510: TPASS: Found 1 ignore marks which is in expected range 0-8
fanotify10.c:510: TPASS: Found 1 ignore marks which is in expected range 0-8
......
fanotify10.c:841: TPASS: group 0 (8) got 16 events: mask 20 pid=22962
fanotify10.c:841: TPASS: group 1 (8) got 16 events: mask 20 pid=22962
fanotify10.c:841: TPASS: group 2 (8) got 16 events: mask 20 pid=22962
fanotify10.c:836: TFAIL: group 0 (4) with FAN_MARK_FILESYSTEM got unexpected number of events (15 != 16)
fanotify10.c:836: TFAIL: group 1 (4) with FAN_MARK_FILESYSTEM got unexpected number of events (15 != 16)
fanotify10.c:836: TFAIL: group 2 (4) with FAN_MARK_FILESYSTEM got unexpected number of events (15 != 16)
......

In this testcase(Test #27), ignore_path is "fs_mnt/testdir", and event_path
is "fs_mnt/testdir/testfile". The purpose of ignore_path is to verify that
the ignore_mark does not pin the corresponding inode. If any inodes remain
after drop_cache, the test case will fail. Here, the ignore_path is located
in a two-level directory structure, and two drop_cache operations might
still not be enough.

Consider the scenario where the parent inode is on NUMA0, the parent dentry
is on NUMA1, the child inode is on NUMA2, and the child dentry is on NUMA3.
After the first drop_cache, the child dentry is cleared, its inode and
parent dentry are placed in the *corresponding* lru link list; after the
second drop_cache, the parent dentry and the child inode are cleared; only
after the third drop_cache would the parent inode be fully released. The
corresponding kernel flow is as follows:

drop_caches_sysctl_handler
  drop_slab
    // Traverse NUMA in order.
    drop_slab_node
    ...
      // Free dentry, child dentry pin parent dentry and its inode.
      prune_dcache_sb
      ...
        dentry_unlink_inode
        ...
          // Place the inode into its corresponding NUMA lru link list.
          list_lru_add
      /*
       * Free inode. If the NUMA where the inode resides is different from
       * its dentry, the inode may not be released this time.
       */
      prune_icache_sb

			drop_cache1	drop_cache2	drop_cache3
NUMA0: parent inode	exist		exist		free
NUMA1: parent dentry	exist		free		free
NUMA2: child inode	exist		free		free
NUMA3: child dentry	free		free		free

Due to the release of the dependency chain, the drop_cache cleanup also
takes several times. Therefore, to be safe, three drop_cache operations are
needed to handle the two-level directory structure.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 testcases/kernel/syscalls/fanotify/fanotify10.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index ce5469580..eedd1442f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -515,7 +515,11 @@ static void drop_caches(void)
 	if (syncfs(fd_syncfs) < 0)
 		tst_brk(TBROK | TERRNO, "Unexpected error when syncing filesystem");
 
-	/* Need to drop twice to ensure the inode is evicted. */
+	/*
+	 * In order to ensure that the inode can be released in the two-tier
+	 * directory structure, drop_cache is required three times.
+	 */
+	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
 	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
 	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
 }
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
