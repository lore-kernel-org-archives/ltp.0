Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16661C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 05:40:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346B461131
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 05:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 346B461131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1237B3C73FA
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 07:40:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ACB43C5970
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 07:40:04 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E3A4614011A4
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 07:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1632289201; i=@fujitsu.com;
 bh=0QT6AkkJ2qFRPIZxTok8x+foQCmy/hfyLob7pb5sIXM=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=wtLOOr1AWJywEwhJTFm1rsowywYbYr2rnEgvv9mCY31i1+GdQG7mm5obwplRCrB4p
 p15q9T/Ms+IzgYVpg0fB8+TjSU7y/LEKlfbTOjbES5sjB16LLRQAuj868nmQunUBjy
 AaD9XWVf+g8P6SGLhs61kpPSMi9Z21FbAuZqkqk+mwH7ddJmo8eGZGhb3Nsf2r10N8
 GnbiP/qqyZSa0VZBlgzaOAI5pgALUENmFJuWR+ifPimRojgKPjnwY0fhobyRg/YDYq
 YqZXgWNaa1rDV6wcOzWerr9hcYDarpC7xXsamDp6RzX/gbMrAIezEPXltoAnqSzrRp
 0UaaqQTB1lenA==
Received: from [100.112.199.201] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 57/D3-21482-1B1CA416;
 Wed, 22 Sep 2021 05:40:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRWlGSWpSXmKPExsViZ8MRqrvxoFe
 iwe9lzBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8anhvesBQ8EKzZtfsrSwHiYr4uRi0NIoIVJ
 4urURUwQzh5Gif3XbzB3MXJysAloSjzrXABmiwhISHQ0vGUHsZkF1CWWT/rFBGILC6RJ3Jh4m
 BXEZhFQldjyfAZYnFfAQ2Ll4ftgtoSAgsSUh++ZIeKCEidnPmGBmCMhcfDFC2aIGkWJSx3fGC
 HsColZs9qYJjDyzkLSMgtJywJGplWMFklFmekZJbmJmTm6hgYGuoaGRrqGlma6RoYmeolVukl
 6qaW65anFJbqGeonlxXrFlbnJOSl6eaklmxiBAZZScOTaDsYDrz/oHWKU5GBSEuV11/ZKFOJL
 yk+pzEgszogvKs1JLT7EKMPBoSTBe3Y/UE6wKDU9tSItMwcY7DBpCQ4eJRFegV1Aad7igsTc4
 sx0iNQpRl2OnUfnLWIWYsnLz0uVEuctOQBUJABSlFGaBzcCFnmXGGWlhHkZGRgYhHgKUotyM0
 tQ5V8xinMwKgnzvt0HNIUnM68EbtMroCOYgI7gX+kBckRJIkJKqoFJ4IR+rPz7Z6IbbeKfRMh
 clP0yN75/p9S3o+Ym1imJooqlfMtmnP2bYvrvh+bK262NzVc3CL5StZ/0+GDdVc+GboUlPbbu
 f3/3bwv7sCG8vOC4whSd699YT9erV82M3fRa4nlvnfDu1G4Fl6fhRzT4+h7f8Wxbb2ebIy5yX
 u2V19THwrz1byyFdkSt+2Jr+H+z8oONO0zcvNQ13xrWHP1x8tW6nUp1ryc/k52dcFwm2Xvd+W
 2ZTJfs7vPzxputnri1k+W3rrVXA+eHdQaX2iYxKnI/K51xa0LU1tRLm5X1PhWmeLA/O/fiUWE
 S9y/h7c1LAkOU2poj5v07tzlm94/IJ8v/TvRaZ+28pk88bMpaJZbijERDLeai4kQAQ2yKoDcD
 AAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-291.messagelabs.com!1632289200!126450!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15072 invoked from network); 22 Sep 2021 05:40:01 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
 by server-3.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Sep 2021 05:40:01 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 18M5dthC005296
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 06:40:00 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 22 Sep 2021 06:39:53 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 22 Sep 2021 13:39:40 +0800
Message-ID: <1632289182-2191-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/3] syscalls/dup202: Also check mode whethter
 change when calling chmod after dup2
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

Since the two file descriptors refer to the same open file description, they should
share the file status. So change mode for file after creat, then check whether oldfd
mode equals newfd mode.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup202.c | 30 +++++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index 94bedcf18..c50b56ba0 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -8,10 +8,14 @@
  * [Description]
  *
  * Test whether the access mode are the same for both file descriptors.
+ * Style: creat mode, dup2, [change mode], check mode
  *
- * - 0: read only ? "0444"
- * - 1: write only ? "0222"
- * - 2: read/write ? "0666"
+ * - 0: read only, dup2, null, read only ? "0444"
+ * - 1: write only, dup2, null, write only ? "0222"
+ * - 2: read/write, dup2, null, read/write ? "0666"
+ * - 3: read/write/execute, dup2, read only, read only ? "0444"
+ * - 4: read/write/execute, dup2, write only, write only ? "0222"
+ * - 5: read/write/execute, dup2, read/write, read/write ? "0666"
  */
 
 #include <errno.h>
@@ -29,10 +33,15 @@ static int duprdo = 10, dupwro = 20, duprdwr = 30;
 static struct tcase {
 	int *nfd;
 	mode_t mode;
+	/* 0 - set mode before dup2, 1 - change mode after dup2 */
+	int flag;
 } tcases[] = {
-	{&duprdo, 0444},
-	{&dupwro, 0222},
-	{&duprdwr, 0666},
+	{&duprdo, 0444, 0},
+	{&dupwro, 0222, 0},
+	{&duprdwr, 0666, 0},
+	{&duprdo, 0444, 1},
+	{&dupwro, 0222, 1},
+	{&duprdwr, 0666, 1},
 };
 
 static void setup(void)
@@ -52,7 +61,10 @@ static void run(unsigned int i)
 	struct stat oldbuf, newbuf;
 	struct tcase *tc = tcases + i;
 
-	ofd = SAFE_CREAT(testfile, tc->mode);
+	if (tc->flag)
+		ofd = SAFE_CREAT(testfile, 0777);
+	else
+		ofd = SAFE_CREAT(testfile, tc->mode);
 	nfd = *tc->nfd;
 
 	TEST(dup2(ofd, nfd));
@@ -60,6 +72,10 @@ static void run(unsigned int i)
 		tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
 		goto free;
 	}
+	if (tc->flag) {
+		SAFE_CHMOD(testfile, tc->mode);
+		tst_res(TINFO, "original mode 0777, new mode 0%o after chmod", tc->mode);
+	}
 
 	SAFE_FSTAT(ofd, &oldbuf);
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
