Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F43CC4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 04:02:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF5293CBCDF
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 05:02:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 676433CBCEE
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:01:28 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C1581A009B4
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:01:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671163286; i=@fujitsu.com;
 bh=kYrY1cWKp770jjWeWG5pUO82MswMyWYpSyKWYMGL8jc=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=yRTdv4voi2Hivpj4Hy1n3HQNUsbXTfj8vFZi/NhcykVh90eVG+/jcMvmdg9RGptB1
 JnK6ccF09P2qKsbJX85Tq7Qr05wUP8eZoj4B3TuUL4daevVAVlRiCP0lOKHgQCdo74
 9upfMBV1c0S/4QXG4lgS9OyOCpfqhB9M7zkeHaZYJLhgSdS70qC6lnt+syHcqGhcO6
 EBUtapkWOvPltGf9uutIUNUO4X4GX6g4A5fqKp+mMkpVgJ8Fu+LLS7Xf2P1yJBNldQ
 297c4f8m/kuXHW8OSNempupfHaUENMacmUtfK7C5Zkj1QGYFwQdTVF9OPUHjvrilOV
 3+g39KT1v/AZQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRWlGSWpSXmKPExsViZ8ORqDvt7ex
 kgy3vWSxWfN/B6MDose/3OtYAxijWzLyk/IoE1oztTXPZCl5yV1yYe4+1gfEDZxcjJ4eQwFlG
 ifUnqiDsA0wSn5dndDFyAdl7GCWW9TxlB0mwCWhKPOtcwAxiiwhISHQ0vAWLMwuoSyyf9IsJx
 BYW0JK4vLKJEcRmEVCVmH9gJ1gNr4CHxLPri1lAbAkBBYkpD98DzeHg4BTwlHh8zBnEFAIqef
 evHqJaUOLkzCcsENMlJA6+eMEM0akocanjGyOEXSExa1YbE4StJnH13CbmCYyCs5C0z0LSvoC
 RaRWjWXFqUVlqka6RgV5SUWZ6RkluYmaOXmKVbqJeaqlueWpxia6RXmJ5sV5qcbFecWVuck6K
 Xl5qySZGYNimFKtf3MHYueyP3iFGSQ4mJVFe/eWzk4X4kvJTKjMSizPii0pzUosPMcpwcChJ8
 Fa+BsoJFqWmp1akZeYAYwgmLcHBoyTCu+UCUJq3uCAxtzgzHSJ1ilFRSpx35SughABIIqM0D6
 4NFreXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzXngJNIUnM68EbvoroMVMQItl7s0EWVy
 SiJCSamDy+sDEJVLPMtG65pZ+DJOap8dJua7+o929B1cnX1NYeSzssMMSXlPWgIajhqntr2/e
 KFft/PF76wyTSbIG2sunHhZv3774g0hdzfx2RsmtjSZ7Pm2uDYz/3m/ge3SH2saPa5wnbax9n
 nCtWvy14MNEnwj2Xaqc959827aPgUnpr9qNS1rXBHIrMrLytNNYuxcHWbItFQ/58vFyzZyvZf
 ICgXuvXmDdvm2q7/1C2U5ZS7uTeV/UbjY1+3i0/tt/uyHntMUvgd3NVubHHybaXLbYfOt6dPu
 y1eXNm0wy+S0ufTNk94nf4Lm20m5RzucbR79V7C73sb6zhPEve016CT/3QeELbCy2E87OXP0h
 IFSJpTgj0VCLuag4EQAuSI0eVgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-548.messagelabs.com!1671163285!29810!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28433 invoked from network); 16 Dec 2022 04:01:26 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-2.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Dec 2022 04:01:26 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C6744100194
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:01:25 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id BAD08100191
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:01:25 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 16 Dec 2022 04:01:24 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 16 Dec 2022 13:02:03 +0800
Message-ID: <1671166923-2173-7-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 7/7] doc/c-test-api.txt
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

Update min_kver usage. Also inotify04 has removed tst_kvercmp2,
so remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/c-test-api.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index e6d121dce..f4da9ff41 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -559,7 +559,8 @@ static struct tst_test test = {
 Testcases for newly added kernel functionality require kernel newer than a
 certain version to run. All you need to skip a test on older kernels is to
 set the '.min_kver' string in the 'struct tst_test' to a minimal required
-kernel version, e.g. '.min_kver = "2.6.30"'.
+kernel version, e.g. '.min_kver = "3.10.0"'. For ltp, the oldest supported
+kernel version is 3.0, so we don't add this check for old kernel ie 2.6.32.
 
 For more complicated operations such as skipping a test for a certain range
 of kernel versions, following functions could be used:
@@ -585,8 +586,7 @@ positive means that it's newer.
 
 The second function 'tst_kvercmp2()' allows for specifying per-vendor table of
 kernel versions as vendors typically backport fixes to their kernels and the
-test may be relevant even if the kernel version does not suggests so. See
-'testcases/kernel/syscalls/inotify/inotify04.c' for example usage.
+test may be relevant even if the kernel version does not suggests so.
 
 WARNING: The shell 'tst_kvercmp' maps the result into unsigned integer - the
          process exit value.
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
