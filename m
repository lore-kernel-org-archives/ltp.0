Return-Path: <SRS0=NQiP=OS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF8C433EF
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 03:17:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E2361288
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 03:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14E2361288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5117D3CA0B6
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 05:17:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E9843C71C8
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 05:17:45 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ECA211A00A36
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 05:17:43 +0200 (CEST)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HJPmx5Tqtz8tLx
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 11:16:49 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 28 Sep 2021 11:17:40 +0800
From: Zhao Gongyi <zhaogongyi@huawei.com>
To: <ltp@lists.linux.it>
Date: Sun, 26 Sep 2021 01:47:03 +0800
Message-ID: <20210925174703.7675-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setgroups03: Fix running more iterations (-i 2)
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

When run the test with option "-i 2", test will fail and
report "setgroups03.c:157: setgroups(65537) fails, Size
is > sysconf(_SC_NGROUPS_MAX), errno=1, expected errno=22".

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../kernel/syscalls/setgroups/setgroups03.c   | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index 490b06996..3ddea5635 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -88,6 +88,7 @@ GID_T *groups_list;		/* Array to hold gids for getgroups() */

 int setup1();			/* setup function to test error EPERM */
 void setup();			/* setup function for the test */
+void cleanup1();		/* cleanup function for setup1 */
 void cleanup();			/* cleanup function for the test */

 struct test_case_t {		/* test case struct. to hold ref. test cond's */
@@ -156,6 +157,9 @@ int main(int ac, char **av)
 					 gidsetsize, test_desc, TEST_ERRNO,
 					 Test_cases[i].exp_errno);
 			}
+			if (Test_cases[i].setupfunc != NULL) {
+				cleanup1();
+			}
 		}

 	}
@@ -191,7 +195,7 @@ int setup1(void)
 {
 	struct passwd *user_info;	/* struct. to hold test user info */

-/* Switch to nobody user for correct error code collection */
+	/* Switch to nobody user for correct error code collection */
 	ltpuser = getpwnam(nobody_uid);
 	if (seteuid(ltpuser->pw_uid) == -1) {
 		tst_resm(TINFO, "setreuid failed to "
@@ -212,6 +216,24 @@ int setup1(void)
 	return 0;
 }

+void cleanup1(void)
+{
+	struct passwd *user_info;
+	if (seteuid(0) < 0)
+		tst_brkm(TBROK, cleanup, "seteuid failed");
+
+	if ((user_info = getpwnam("root")) == NULL)
+		tst_brkm(TBROK, cleanup, "getpwnam(2) of root Failed");
+
+	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
+		tst_brkm(TBROK,
+			 cleanup,
+			 "gid returned from getpwnam is too large for testing setgroups16");
+	}
+
+	groups_list[0] = user_info->pw_gid;
+}
+
 /*
  * cleanup() - performs all ONE TIME cleanup for this test at
  *             completion or premature exit.
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
