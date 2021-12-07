Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F47C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 07:56:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 173D23C242C
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 08:56:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 496413C0214
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 08:56:14 +0100 (CET)
Received: from mail1.bemta32.sdw.messagelabs.com
 (mail1.bemta32.messagelabs.com [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C4F6A200A1F
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 08:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638863772; i=@fujitsu.com;
 bh=JZeTrDb+p44UrT86cgtubIQPCP6e4QywH+YHPI6gugw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=NvCT5pMn5AsUbPqpSv8DVMQhevUw3ZQJglu/5CBXDy9B5IyXlRwCgSaNhKoy8ivtz
 CscE6TxXdlP3cLJF4UEUjmE07tT1Qbkh7U0bmWDPlT0zMCTJHiMsxzYT4D8AiBx58U
 dzkG4HKcORLM4TQllHOpVUzHXbvs0F0rE4jxZhfpg3dxh89vYvjVPsCeftesYHaiHs
 hKBjuC83DtrFdh3grh00euf2t4DxGzMa6fgoHKwRYws+yLRdb6D2okCWc28fjzQv69
 Jj1nZaq6Meyi92Wf3gT64rR2s+aEKNeJ4YSPefIVmC/9aiivNoyPG04Xty5HnRINLL
 U1wqwUS9VvSmg==
Received: from [100.115.2.64] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.ess.symcld.net id FE/AC-20904-C931FA16;
 Tue, 07 Dec 2021 07:56:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRWlGSWpSXmKPExsViZ8MxRXeO8Pp
 EgycP2C1WfN/B6MDose/3OtYAxijWzLyk/IoE1ox7nz6zFHTxVvw6eYelgXEqdxcjF4eQQCOT
 RMfdfUwQzm5Gib7GLpYuRk4ONgFNiWedC5hBbBEBCYmOhrfsIDazgLrE8km/mEBsYYFQiX2Hm
 1hBbBYBFYkntxeAxXkFPCT+Hd4ONkdCQEFiysP3YHM4gWr653SDxYUElCU+PDvLClEvKHFy5h
 MWiPkSEgdfvGCG6FWUuNTxjRHCrpCYNauNaQIj/ywkLbOQtCxgZFrFaJVUlJmeUZKbmJmja2h
 goGtoaKpromtkbKmXWKWbqJdaqlueWlyia6iXWF6sl1pcrFdcmZuck6KXl1qyiREYlCnFLO93
 MDb1/dQ7xCjJwaQkyjtDYH2iEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQlec5CcYFFqempFWmYOM
 EJg0hIcPEoivKZCQGne4oLE3OLMdIjUKUZFKXHeIyAJAZBERmkeXBssKi8xykoJ8zIyMDAI8R
 SkFuVmlqDKv2IU52BUEuadAjKFJzOvBG76K6DFTECLY/pXgywuSURISTUwCacHPLM1XXzt6nM
 R52VZ57ZlhPMvyZvFwSc34z2zlOO82X31rLXNV5a+tWRizLeu/O1dpvXhYfy3zpO+X7dcVZ2f
 9KJl/YlfGf/7fxbsi909mXWuxhEl7yUcv6bf3XCwPqjfL14w9GOmbZzC8pzS6GSLsC2fz3fkX
 HFskZ16pm6zWWbn3+651j4lq93uW+/suGO3d27lNNOV6z1S623643kLqh+/6S/jZb6ulcK+V2
 CygvOW5XmN0hx7VrGo3Pl2Yc8r96u2z5XMgipixdO5LCMfNkloLTpnEnR9t/DH/T9ur2u8ZyK
 9/0XVvi6rBUekDmT5+rwu0qwSOa72I3HC91yZS1YGt0tOF+aZ3axXYinOSDTUYi4qTgQAdJyC
 qkUDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-587.messagelabs.com!1638863771!4518!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15588 invoked from network); 7 Dec 2021 07:56:12 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-9.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 7 Dec 2021 07:56:12 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1B77u5ds001501
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Tue, 7 Dec 2021 07:56:11 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 07:56:03 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 7 Dec 2021 15:56:21 +0800
Message-ID: <1638863781-2196-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Ya4Fa01xi7/iKaC0@yuki>
References: <Ya4Fa01xi7/iKaC0@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/statx05, 07: Move e4crypt,
 exportfs to tst_test structure
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v1-v2: keep e4crypt info in statx05 description instead of removing
 testcases/kernel/syscalls/statx/statx05.c | 6 ++----
 testcases/kernel/syscalls/statx/statx07.c | 6 ++++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index a3184e7e3..86bd3ace1 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -111,10 +111,7 @@ static void setup(void)
 
 	ret = tst_system("echo qwery | e4crypt add_key "TESTDIR_FLAGGED);
 
-	if (WEXITSTATUS(ret) == 127)
-		tst_brk(TCONF, "e4crypt not installed!");
-
-	if (WEXITSTATUS(ret))
+	if (ret)
 		tst_brk(TCONF, "e4crypt failed (CONFIG_EXT4_ENCRYPTION not set?)");
 }
 
@@ -136,6 +133,7 @@ static struct tst_test test = {
 	.dev_fs_type = "ext4",
 	.needs_cmds = (const char *[]) {
 		"mkfs.ext4",
+		"e4crypt",
 		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 89de0c487..e1ae36a35 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -135,8 +135,6 @@ static void setup(void)
 	exported = 1;
 
 	ret = tst_system(cmd);
-	if (WEXITSTATUS(ret) == 127)
-		tst_brk(TCONF | TST_ERR, "%s not found", cmd);
 	if (ret)
 		tst_brk(TBROK | TST_ERR, "failed to exportfs");
 
@@ -172,4 +170,8 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.dev_fs_type = "nfs",
 	.needs_root = 1,
+	.needs_cmds = (const char *[]) {
+		"exportfs",
+		NULL
+	}
 };
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
