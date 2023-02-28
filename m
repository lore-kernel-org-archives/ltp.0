Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF73C64EC7
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 08:45:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F9993CBA27
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 09:45:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 261053CAFFE
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 09:44:59 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 336031400437
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 09:44:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1677573897; i=@fujitsu.com;
 bh=VGdNr+4ewTRo+wwgatazLjHshLHQNS9acfJLszGbNKU=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=p9EfjN+MAu/dRcaI6IOmN4gIXy/F0G6UZBPtjbMCp8AQ/oTrsgX7GGKl9Vn03m/o+
 Q/J7plc9laIQ3C57nhGDZQUss55TC/rR7O1SlLqMplMZzZQeH2qIGmYQf+/YqQOUqN
 1e0XoFN04YwRDi0gUu8DXv1yDzir3hKezE8f+AuNQTfl1rU8xNHJeqxa21WFZh4Zwq
 iuQ6b8TctLVQgkXKTwOY3AMynT+O4oleQJiIVEI3ehtaEOiFui0irIo0fMlW/y8dAG
 dUYDrqrEcUYXFyA++dPfpv18VlYqAotu7EUsqV2+CnWB/7YITIs+XPb67QfPudbZwJ
 PNZ4bAaxaBDAw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRWlGSWpSXmKPExsViZ8ORqMux/2+
 ywc+pKhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bJbceZCxZzViy6c5e5gfELexcjF4eQwFlG
 iWunXjBDOAeZJJr+XWLsYuQEcvYxSqz8qwdiswloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6x
 QRiCwv4SJw4ex8sziKgKjHp8h4wm1fAQ+LIXIheCQEFiSkP3zNDxAUlTs58wgIxR0Li4IsXUD
 VKEm2tV1gh7EqJ1g+/WCBsNYmr5zYxT2Dkn4WkfRaS9gWMTKsYTYtTi8pSi3SN9JKKMtMzSnI
 TM3P0Eqt0E/VSS3XLU4tLgDKJ5cV6qcXFesWVuck5KXp5qSWbGIGhmFKs2r+DcW3vX71DjJIc
 TEqivL35f5OF+JLyUyozEosz4otKc1KLDzHKcHAoSfAK7QHKCRalpqdWpGXmAOMCJi3BwaMkw
 muzGyjNW1yQmFucmQ6ROsWoKCXO+xikTwAkkVGaB9cGi8VLjLJSwryMDAwMQjwFqUW5mSWo8q
 8YxTkYlYR5U7YBTeHJzCuBm/4KaDET0OKGa39AFpckIqSkGpjK1veWGe8RsfY+Yie213exTov
 +ylxeTnEG3++7J3N+TxO49kxFbbq1iPLC13KmC/+7n+wQEZ/L33JExa1FeOrmx1ZqF3o4o3/n
 f1V6lnloauhXxUlR7cbtnvN21Qfsu62z7m/xxKnF/RKzktwuOXS1/zg88/mclbe6iw/v2RuU7
 lNT2xa1ttd3Skg34xVfvfuBT3NPabRwz+P7fHnfXn+XzKMaO+/WbknhF01ft8RljV/ftOZqw2
 23P3G6pEbn6xUZzbx+vGTtl4MH+V8w/ZjlfprPSHN+avCJ50uSc1vl7LWSVrNVTBMzd03uqLp
 bXyvZ3ba39cXuft5dJk+lExd/3rP+CYOM+3Pf/8LWqUosxRmJhlrMRcWJAF7ANqtAAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-548.messagelabs.com!1677573896!331937!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.103.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7496 invoked from network); 28 Feb 2023 08:44:56 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-4.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 28 Feb 2023 08:44:56 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 4A49C100194
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 08:44:56 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 3DBB4100182
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 08:44:56 +0000 (GMT)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 28 Feb 2023 08:44:54 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 28 Feb 2023 16:44:24 +0800
Message-ID: <1677573864-5319-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] containers/utsname04: don't use TST_EXP_EQ_LI for
 tst_clone
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

For old kernel that doesn't support clone3, tst_clone returns
-2 instead of -1. So we can't use TST_EXP_EQ_LI api.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/containers/utsname/utsname04.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/utsname/utsname04.c b/testcases/kernel/containers/utsname/utsname04.c
index e8d636d0d..1adc4542c 100644
--- a/testcases/kernel/containers/utsname/utsname04.c
+++ b/testcases/kernel/containers/utsname/utsname04.c
@@ -22,6 +22,7 @@ static void run(void)
 {
 	const struct tst_clone_args cargs = { CLONE_NEWUTS, SIGCHLD };
 	struct passwd *pw;
+	pid_t pid;
 
 	tst_res(TINFO, "Dropping root privileges");
 
@@ -29,7 +30,11 @@ static void run(void)
 	SAFE_SETRESUID(pw->pw_uid, pw->pw_uid, pw->pw_uid);
 
 	if (!str_op || !strcmp(str_op, "clone")) {
-		TST_EXP_EQ_LI(tst_clone(&cargs), -1);
+		pid = tst_clone(&cargs);
+		if (pid == -1 || pid == -2)
+			tst_res(TPASS, "clone() returns an expected value %d", pid);
+		else
+			tst_res(TFAIL, "clone() returns an unexpected value %d", pid);
 		TST_EXP_PASS(errno == EPERM);
 	} else {
 		if (!SAFE_FORK()) {
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
