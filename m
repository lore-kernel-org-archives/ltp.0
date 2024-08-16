Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA19C3DA4A
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 04:54:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832503D20B5
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 06:54:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46E5E3C9908
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 06:53:54 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 7E3CD1A002E8
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 06:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Jdy3p
 +cycGqSaX6HZKsYnzLoiZ+O30cy1mxP/34V1Rs=; b=IsHE2Q8fd9+DJ1lmSqxqY
 zPTvEYKuU9aCwGkst0GvpbhyVfpn0+puMyRqwVBEoDGWaZL5rU4VkcOYPfMcULHJ
 9tYxnDFPw7Ot5/0zwmiWNkSxIdy+fRoWjOiH+w9zy7Ke9TTNAkK3WmFDV+LcLgil
 YCnZbVEe2NniLxsfpvsKHc=
Received: from fedora-40.. (unknown [106.146.87.91])
 by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wBH5hNZ275m0MfLHg--.35575S2;
 Fri, 16 Aug 2024 12:53:47 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: ltp@lists.linux.it
Date: Fri, 16 Aug 2024 13:53:26 +0900
Message-ID: <20240816045342.185737-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-CM-TRANSID: _____wBH5hNZ275m0MfLHg--.35575S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1rWrWDWryktw1kKFyUKFg_yoWDuwb_AF
 1Utrs7XrWUAr4akF1Fkw17XFsrtasrKFW8uFnrGFZ7AwsxZw1UGr9YvF1UJrn5WFs5uas2
 kr4rWFn8KrZxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUbOzsJUUUUU==
X-Originating-IP: [106.146.87.91]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqQc9XmVOCPDoMwAAsF
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/landlock05.c: Remove useless tags
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

Fix the following warnings from metadata/metaparse:
testcases/kernel/syscalls/landlock/landlock05.c: useless tag: format_device
testcases/kernel/syscalls/landlock/landlock05.c: useless tag: needs_tmpdir

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 testcases/kernel/syscalls/landlock/landlock05.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock05.c b/testcases/kernel/syscalls/landlock/landlock05.c
index 6899dd1f1..703f7d81c 100644
--- a/testcases/kernel/syscalls/landlock/landlock05.c
+++ b/testcases/kernel/syscalls/landlock/landlock05.c
@@ -90,7 +90,6 @@ static void setup(void)
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
-	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
@@ -102,7 +101,6 @@ static struct tst_test test = {
 		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
 		{}
 	},
-	.format_device = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
