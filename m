Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79042C433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 08:00:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE85F3C8D04
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 09:00:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D84D73C08C7
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 09:00:33 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5ED2C600C7F
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 09:00:30 +0100 (CET)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HyKM35RHbzcbM4
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 15:55:27 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 16:00:26 +0800
To: <ltp@lists.linux.it>
Date: Mon, 22 Nov 2021 16:01:38 +0800
Message-ID: <20211122080138.55815-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib/tst_tmpdir: Add tst_default_rmdir() for old
 testcases
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In some old testcases, cleanup() will not run since it exit
form tst_brk. For example, because of the calling of ltp_syscall
have no real cleanup when syscall not support, testcase ssetmask01
will leave tmp file.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2: add tst_default_rmdir() in tst_tmpdir.c

 lib/tst_tmpdir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 6e38ae977..0045c7bb6 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -342,6 +342,8 @@ void tst_rmdir(void)
 		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
 			 __func__, TESTDIR, errmsg);
 	}
+
+	TESTDIR == NULL;
 }

 void tst_purge_dir(const char *path)
@@ -351,3 +353,8 @@ void tst_purge_dir(const char *path)
 	if (purge_dir(path, &err))
 		tst_brkm(TBROK, NULL, "%s: %s", __func__, err);
 }
+
+void __attribute__((destructor)) tst_default_rmdir(void)
+{
+	tst_rmdir();
+}
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
