Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2426C6FD1D
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 08:23:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2EAC3CC9C6
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 10:23:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50CF93C0123
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 10:23:09 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0425B20022C
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 10:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680164588; i=@fujitsu.com;
 bh=1zDDHoHRWZ52YpOYo2y4lpFGnJPl+f5zhyE+0mnRdj8=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=O6JTVoG5kxo05sJYtHctI7qVPHbgU1aagMTID3mucslnrHRLvH8wIcR/9Lyv6WfMW
 9HKjDZsA3Ag3ooQW+B/MhXxspJcUEXulvP8x4XRkRdSJaHGGoi2habVVGg7jGKh6e0
 cELzxaemN9xWWDSXiC8G/F8QPTm9elnL1Akj9fSD1HKB5pl1sQ25uzJzXuhkX0a8F0
 RPfnJSfAe+oxOl4jt6Tmv1uWJGAqC90Be/c0TOYYB8jpL0e8zbHvi4//jPvI7K+GaH
 4jgm0YFEiNgL4yh2JSxAv7LOfIxfhC5NGTfibofgGPTVroWbodA+KtUFflNvJkKT5Y
 XuOUFcx//kDLA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRWlGSWpSXmKPExsViZ8OxWfe1m2q
 KwbqXChZr9/xhtljxfQejA5PHplWdbB77fq9jDWCKYs3MS8qvSGDNaL19gK3gFVvFthXLmBsY
 n7F2MXJxCAlsZJTo33ydHcJZzCTx6txeZghnL6PEjvudTF2MnBxsApoSzzoXMIPYIgISEh0Nb
 9lBbGYBO4k7i5vA4sIC7hINrxaA1bMIqEp8uDKTDcTmFfCUWHXxGQuILSGgIDHl4XtmiLigxM
 mZT1gg5khIHHzxghmiRkmirfUKK4RdIdE4/RAThK0mcfXcJuYJjPyzkLTPQtK+gJFpFaN5cWp
 RWWqRrqGpXlJRZnpGSW5iZo5eYpVuol5qqW5eflFJhq6hXmJ5sV5qcbFecWVuck6KXl5qySZG
 YJCmFKfI7WC80vdX7xCjJAeTkihvJadqihBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3k0uQDnBo
 tT01Iq0zBxgxMCkJTh4lER4VZyA0rzFBYm5xZnpEKlTjIpS4rz9rkAJAZBERmkeXBssSi8xyk
 oJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuY1AtnOk5lXAjf9FdBiJqDFx1JVQBaXJCKkpBqY+l6
 UKldP2PpwEvOx1/uff/nwjmP20zf+7NXBx6ssWfOK7t48qfjjy9cOAfnnQdKGu32kPzmW3T0k
 3CJu92eC7Q7lSRFe67hzv2/tTi+Oyf3fcPMls9iGzbf8rrw5uv+IYsUZxilsGq1Pzdaz7DJje
 LttbqpW7AWWTc/Ub9qJr41981f+wvnsxqR1LCr/tm3sfXa6d0roO46XE7veLVn4KrQuS6bhhU
 Jl2c5HDRa/knb/TVb3DlnzemeO3gXejW9vfQk4EBSeK9D7ZQEDw9b7Z78mRppeeBscnPE27jL
 nrbs/l9W9fa1yZu5Veb1zYi/FeDVitjrv25Bly+e3RZ3B9166SuzejVX+efPzRGZ5flZiKc5I
 NNRiLipOBACHT7qOTQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-732.messagelabs.com!1680164587!447728!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22817 invoked from network); 30 Mar 2023 08:23:07 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-16.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 30 Mar 2023 08:23:07 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id EF08515B;
 Thu, 30 Mar 2023 09:23:06 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id E2C3D7B;
 Thu, 30 Mar 2023 09:23:06 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 30 Mar 2023 09:23:04 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 30 Mar 2023 16:22:47 +0800
Message-ID: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lapi/stat.h: Add STATX_DIOALIGN related definition
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

Also add missing stx_mnt_id.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/stat.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index ce1f2b678..c2db8a589 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -97,7 +97,11 @@ struct statx {
 	uint32_t	stx_dev_major;
 	uint32_t	stx_dev_minor;
 	/* 0x90 */
-	uint64_t	__spare2[14];
+	uint64_t	stx_mnt_id;
+	uint32_t	stx_dio_mem_align;
+	uint32_t	stx_dio_offset_align;
+	/* 0xa0 */
+	uint64_t	__spare1[12];
 	/* 0x100 */
 };
 #endif
@@ -180,6 +184,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_MNT_ID		0x00001000U
 #endif
 
+#ifndef STATX_DIOALIGN
+# define STATX_DIOALIGN		0x00002000U
+#endif
+
 #ifndef STATX_ALL
 # define STATX_ALL		0x00000fffU
 #endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
