Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EE8C433F5
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 03:03:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0241C3CAE63
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 05:03:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE2183CA48F
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 05:03:01 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DA1D81000543
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 05:02:59 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MlRbl2sFxzpVbq
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 10:59:47 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 11:02:54 +0800
To: <ltp@lists.linux.it>
Date: Sun, 9 Oct 2022 10:59:18 +0800
Message-ID: <20221009025918.21277-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/add_key05: Add userdel and groupdel before
 useradd
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

If the test exit abnormal, some user/group will be left, and the
next running of the test will fail and report:

  tst_buffers.c:55: TINFO: Test is using guarded buffers
  tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
  useradd: group ltp_add_key05_0 exists - if you want to add this user to that group, use -g.
  add_key05.c:41: TBROK: useradd failed (9)
  userdel: user 'ltp_add_key05_0' does not exist
  add_key05.c:56: TWARN: 'userdel -r ltp_add_key05_0' failed: ENOENT (2)

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/add_key/add_key05.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index 71a88d1a8..42ad04eec 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -34,8 +34,13 @@ static void add_user(char n)
 {
 	char username[] = "ltp_add_key05_n";
 	const char *const cmd_useradd[] = {"useradd", username, NULL};
+	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
+	const char *const cmd_groupdel[] = {"groupdel", username, NULL};
 	struct passwd *pw;

+	tst_cmd(cmd_userdel, NULL, NULL, TST_CMD_PASS_RETVAL);
+	tst_cmd(cmd_groupdel, NULL, NULL, TST_CMD_PASS_RETVAL);
+
 	username[sizeof(username) - 2] = '0' + n;

 	SAFE_CMD(cmd_useradd, NULL, NULL);
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
