Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A10CC4332F
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 10:45:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71C283CBD24
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 11:45:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D82223CBD79
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:45:01 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9D2F600642
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:45:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671014700; i=@fujitsu.com;
 bh=kYrY1cWKp770jjWeWG5pUO82MswMyWYpSyKWYMGL8jc=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=GOcZvVJNleUDamxvXvmpWV6SlFnfEgjYhLSAkFB1n3mWrMizjlmCOgQRA7coy+LSs
 vY41o+YZBur2Ye/SQGLUdV2cofKmsSEAgqjRD59G+JrV9TcfzDgJ+dlPFu0A66dlWf
 M1UEfZYwvt7nT5Fep4FQGXCJ6ngi30E4OW34tskPzA5khPIBlIBl7p+XTgCbvokoIi
 tNEWmdyy1RnwHYnak3Gv+ywDqurMpmetFiu2t8XAxqo0e89KLkdc0VnTbPFOewvXPR
 Oqfk7JQgCPDSeXSllMfh4JR6j74gau0nA7g0pCMaIqqmZoKn/akHnUcnHkZX3uOQHY
 OrPSgfnR7TIug==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRWlGSWpSXmKPExsViZ8MxSVd75cx
 kg5Xv1SxWfN/B6MDose/3OtYAxijWzLyk/IoE1oztTXPZCl5yV1yYe4+1gfEDZxcjJ4eQwFlG
 iRuPA7sYuYDsA0wSWz+sY4FI7GGU+PhRDsRmE9CUeNa5gBnEFhGQkOhoeMsOYjMLqEssn/SLC
 cQWFtCS2HW8l7WLkYODRUBV4kBbMUiYV8BDoqXvEdhICQEFiSkP34ON4RTwlNh8ah0TxCoPiQ
 3/vrFB1AtKnJz5hAVivITEwRcvmCF6FSUudXxjhLArJGbNamOCsNUkrp7bxDyBUXAWkvZZSNo
 XMDKtYjQtTi0qSy3SNdJLKspMzyjJTczM0Uus0k3USy3VLU8tLtE11EssL9ZLLS7WK67MTc5J
 0ctLLdnECAzblGKW2TsYe5b+0TvEKMnBpCTKa1Q3I1mILyk/pTIjsTgjvqg0J7X4EKMMB4eSB
 O+fpTOThQSLUtNTK9Iyc4AxBJOW4OBREuG9Mh0ozVtckJhbnJkOkTrFqCglzrtgOVBCACSRUZ
 oH1waL20uMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHnvg2znycwrgZv+CmgxE9DiqJdTQRa
 XJCKkpBqY3Nb6irzbItUZ2/W81URzxY8tFm+sey8+PbKh3XQv36bK5+0XHQ+1KrZzvvy48Ij6
 M99ZS9bUtky6kuSW+ynISU2jIVLvlkj4a/4fXSsVt76yrcuOzHCTTD5hcWBBVonRx/SLS4N2/
 Qk23nK2xHa2zOU1IT+/zylkrTp20f2bo+fro7uYV5sWZhrf1n7xQqvALzhjeq+dpvgDU+aSIP
 UO0Vc1Z2+d2RNWJ+52wvi00Edh0ZI9bBc0/nocOM374ulhB4672zxTp70NmW9yIO1h6aFWUza
 drMzZh2+WVB+dyhkV/G4Z//ml2y9Oy2Ep4e5J96x+O8Vr54Jnau+c2578zl3SlLzg8a1iDxY3
 G3FXJZbijERDLeai4kQAbxm6MlYDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-585.messagelabs.com!1671014699!95625!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9686 invoked from network); 14 Dec 2022 10:44:59 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-12.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Dec 2022 10:44:59 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 441A2100450
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 10:44:59 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 37ACC100441
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 10:44:59 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 14 Dec 2022 10:44:57 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 14 Dec 2022 19:45:03 +0800
Message-ID: <1671018303-2079-6-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671018303-2079-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1671018303-2079-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/6] doc/c-test-api.txt
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
