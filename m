Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C1DCA0FED
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 13:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725022908; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=jyljwTGZUMR7W7nClC0dTpnxyc9kPNAcTQmJ58tH1DQ=;
 b=aRUhlPAyscYQS/NDFreOYCmrOoDC3KEsdx4pV2jxJRJsTXfxRilDNEx9D8q7iejYUQ8tb
 EKOdzKJ2L+jLeDyORTc1Qg/qzMJIMXC/P3s8S8CFcKFPk8QTnzkaiYAiQvdDfXV2k8Yb091
 /miFiwlN9bmX+AqDFuAQUGoyJNuBWfo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD5C13D2857
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 15:01:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 666113D283D
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 15:01:25 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=wozizhi@huawei.com; receiver=lists.linux.it)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 102A4600BB5
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 15:01:23 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WwJDF4YxGzyR7f
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 21:00:45 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
 by mail.maildlp.com (Postfix) with ESMTPS id 4871714037D
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 21:01:18 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 21:01:17 +0800
To: <ltp@lists.linux.it>, <jack@suse.cz>, <amir73il@gmail.com>
Date: Fri, 30 Aug 2024 21:00:03 +0800
Message-ID: <20240830130003.3245531-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify10: Calling drop_cache twice to ensure the
 inode is evicted
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

In this test case, some scenarios are designed to verify whether the
FANOTIFY_EVICTABLE flag takes effect: by verifying that information cannot
be obtained from the corresponding inode after drop_cache, as this flag
does not ping the inode.

However, drop_cache is only performed once here, which may result in the
inode not being released in NUMA scenarios. Suppose the inode is located
on NUMA0 and the dentry is located on NUMA1; the first drop_cache can only
ensure that the inode is added to the LRU list, but does not guarantee that
evict() can been called because dispose_list does not yet include this
inode when traversing NUMA0, which causes the testcase execution fail.

For the single-file scenario in this testcase, executing drop_cache twice
is necessary to ensure the inode is evicted, thus allowing the testcase to
pass.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 testcases/kernel/syscalls/fanotify/fanotify10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index c6d8ec922..42018de0d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -515,6 +515,8 @@ static void drop_caches(void)
 	if (syncfs(fd_syncfs) < 0)
 		tst_brk(TBROK | TERRNO, "Unexpected error when syncing filesystem");
 
+	/* Need to drop twice to ensure the inode is evicted. */
+	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
 	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
 }
 
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
