Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BCFC433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 12:50:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF1093CAE9D
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 14:50:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2E373C010A
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:50:13 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 23A451000B26
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 14:50:10 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmwV95GtNzHtpp;
 Tue, 11 Oct 2022 20:45:05 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 20:50:04 +0800
To: <ltp@lists.linux.it>
Date: Tue, 11 Oct 2022 20:46:30 +0800
Message-ID: <20221011124630.62647-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/add_key05: Add userdel and groupdel
 before useradd
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
index 71a88d1a8..e8d249040 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -34,10 +34,15 @@ static void add_user(char n)
 {
 	char username[] = "ltp_add_key05_n";
 	const char *const cmd_useradd[] = {"useradd", username, NULL};
+	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
+	const char *const cmd_groupdel[] = {"groupdel", username, NULL};
 	struct passwd *pw;

 	username[sizeof(username) - 2] = '0' + n;

+	tst_cmd(cmd_userdel, NULL, "/dev/null", TST_CMD_PASS_RETVAL);
+	tst_cmd(cmd_groupdel, NULL, "/dev/null", TST_CMD_PASS_RETVAL);
+
 	SAFE_CMD(cmd_useradd, NULL, NULL);
 	pw = SAFE_GETPWNAM(username);
 	ltpuser[(unsigned int)n] = pw->pw_uid;
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
