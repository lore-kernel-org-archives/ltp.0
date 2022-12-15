Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061C3C4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 03:46:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6623A3CD7CE
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 04:46:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A09E3CBD01
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 04:46:42 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2DE751400DC9
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 04:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671076000; i=@fujitsu.com;
 bh=y7R9GXoFXacoSp8r7/F6OSr8LQuLkzI1pHu6J81DFwA=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=i2mBZ1sBeQgIjtTrZe1T96mD1Nb3D5znlmi6jRyYlc1vQlFRVMioOgTSMLi+NxOv0
 eaHNSvN0oUcVjHes0wWEcZyRAU6CGP4ezRD1+Y4Xf6+qaBhJ9ExoWoyVRMuk6OGtfc
 xKPn1r5xXlmUlk8tNvXEu3sgcUVvheyuccBqnkOrwYz2I9Pg8a1vm4txduE0Js4VU6
 xuvUqfSP03IkKYKlKQTcDOQoOMjYV3m4r8PSsypPtyg+XHEVXVMwl5TCWK7hxB3l9U
 wjF8uqRbOfjeZ+E7t1vKHcs3DujKSkwdZLl1yNzzqOZsHqy134+MmyRsDDkd/hqVJp
 J2HrwjQvQ0ENA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRWlGSWpSXmKPExsViZ8ORqDt/xqx
 kg6enOSxWfN/B6MDose/3OtYAxijWzLyk/IoE1owFszvZCq6zVyzoM21gfMzWxcjJISRwllHi
 88vyLkYuIPsAk8SZmwcYIZw9jBJLHs8Cq2IT0JR41rmAGcQWEZCQ6Gh4yw5iMwuoSyyf9IsJx
 BYWSJWY+/YMWA2LgKrErO2zWEFsXgFPiU/NN8HqJQQUJKY8fM8MEReUODnzCQvEHAmJgy9eME
 PUKEpc6vjGCGFXSMya1cYEYatJXD23iXkCI/8sJO2zkLQvYGRaxWhWnFpUllqka6KXVJSZnlG
 Sm5iZo5dYpZuol1qqm5dfVJKha6iXWF6sl1pcrFdcmZuck6KXl1qyiREYiinFSTY7GP8u/aN3
 iFGSg0lJlHf+9FnJQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4H04BygkWpaanVqRl5gDjAiYtw
 cGjJMK7H6SVt7ggMbc4Mx0idYpRUUqcdw1IQgAkkVGaB9cGi8VLjLJSwryMDAwMQjwFqUW5mS
 Wo8q8YxTkYlYQhpvBk5pXATX8FtJgJaLHMvZkgi0sSEVJSDUwOD4ombuLTdmsqVC0yb9yeuz6
 3z3OZy7Hid+InmCcy/T7oK3S7hbG/5Eqi5MZXk4NqztmtnG+4WkTPfHmfGi8PyweuxkWxlqVt
 cUKL8jbO2XJ+/aRXkyckMvYc/DV1m6yW5Oorov9cpLW3rbz4W33OdoMTLQFphavyOKTNwrgX/
 tp156W1YPLDEE73Jfc8jerOveN3nZTt8ve+8u1DGp1W5z8E9qzn7tv88e+v9ft5bxj6PD88f6
 OTDXtS3vR5cwtWyP7c7SXkE3z9elKSsXfh0b6iC7unbGa3ZD+6IGjn3oT7IQIteo1/Lhp+Sbc
 WanZ5JLA6/ZPhtQyxpJJre09eN9rOy2Z/5vSCz1WtU6yVWIozEg21mIuKEwGUD+KnQAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-745.messagelabs.com!1671075998!159427!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8619 invoked from network); 15 Dec 2022 03:46:39 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-21.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 15 Dec 2022 03:46:39 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 9041410018D
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 03:46:38 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 84305100182
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 03:46:38 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 15 Dec 2022 03:46:36 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 15 Dec 2022 12:47:46 +0800
Message-ID: <1671079666-15971-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/setresuid04: Use SETRESUID instead of
 SAFE_SETRESUID to check 16bit syscall
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/setresuid/setresuid04.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
index 833aee91d..57b290f37 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid04.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
@@ -40,7 +40,7 @@ static void run(void)
 	pid_t pid;
 	int status;
 
-	SAFE_SETRESUID(-1, ltpuser->pw_uid, -1);
+	TST_EXP_PASS_SILENT(SETRESUID(-1, ltpuser->pw_uid, -1));
 	TST_EXP_FAIL2(open(TEMP_FILE, O_RDWR), EACCES);
 
 	pid = SAFE_FORK();
@@ -52,7 +52,7 @@ static void run(void)
 	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
 		tst_res(TFAIL, "child process exited with status: %d", status);
 
-	SAFE_SETRESUID(-1, 0, -1);
+	TST_EXP_PASS_SILENT(SETRESUID(-1, 0, -1));
 	TST_EXP_FD(open(TEMP_FILE, O_RDWR));
 	SAFE_CLOSE(TST_RET);
 }
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
