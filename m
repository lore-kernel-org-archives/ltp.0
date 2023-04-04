Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CF0C77B60
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 07:31:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D36FC3CA252
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 09:31:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BC2A3C2297
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 09:30:53 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 14EE31A00801
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 09:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680593451; i=@fujitsu.com;
 bh=1zDDHoHRWZ52YpOYo2y4lpFGnJPl+f5zhyE+0mnRdj8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=GDRA9n9b71HM0BjKnjr/VdtMAuJkQkrsW51kvkytaZ6XS4O1yDKVEWU/0sNC0d49b
 vy0Mwz5GAwV8bvXITD2SPLKx8zHeOQfQHSb581o1SlBabKOyqL8EdurQzK+h3hobek
 VeVKUycbJmg+xGVscuvPuzUt3nHGgRSrokKtT7g9SQ0mj39wD2h607G60LHdYPX0SP
 dBCLPT5ApVgyyj2MjYSRn0cIX0ypgv8+EgEzllTqTlWnejSZi9j/jfXQOxEXb/AV9G
 MgGpm6fhb8eh3D/cva/uRK0qvi3IbldR8DMyIZg/0LDTXzWaOn+OxIN6kyaLnWHnqx
 hqARQAJzP+86Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8ORpKt1STv
 FYMNMNYu1e/4wW6z4voPRgclj06pONo99v9exBjBFsWbmJeVXJLBmtN4+wFbwiq1i24plzA2M
 z1i7GLk4hAQ2Mkrc/XWUEcJZwiTRebeXGcLZwyjxYMFyti5GTg42AU2JZ50LmEFsEQEJiY6Gt
 +wgNrOAncSdxU1gcWEBL4lpT08zgdgsAioS3Yv3g9m8Ap4SP+8sZAGxJQQUJKY8fA9Wzwk0s6
 OnhRHEFhLQkFjee4ERol5Q4uTMJywQ8yUkDr54wQzRqyTR1nqFFcKukGicfogJwlaTuHpuE/M
 ERsFZSNpnIWlfwMi0itG0OLWoLLVI10QvqSgzPaMkNzEzRy+xSjdRL7VUtzy1uETXUC+xvFgv
 tbhYr7gyNzknRS8vtWQTIzCgU4pZ3+5g/N/7V+8QoyQHk5Io76ON2ilCfEn5KZUZicUZ8UWlO
 anFhxhlODiUJHgzzwPlBItS01Mr0jJzgNEFk5bg4FES4f17DijNW1yQmFucmQ6ROsWoKCXOu/
 ECUEIAJJFRmgfXBovoS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeV3OAE3hycwrgZv+Cmg
 xE9Di1igNkMUliQgpqQYmz/XHVy8Qu5haeinD6c2X2OgtRbIWugpH246wzlyw7QLX3bMnAyqi
 89gsLHvSTiz0vzqntiLk6uq9j9TNqoR1spvVDy6RNJWonnl3Z+e03QbcnDov3v97xivSd2fJk
 xr1jufeebyiO3768uv5hS/R77poIb5jtaD3wqcfLPx+6Fal1WQ2VL1OP9RUGmL6rGTfOaXpUw
 WdfJ9xsGsukBVyaDBRYpx9Itn1usj8CXWda3M3n7+sZZYSohIt6eZYy3biSZb9rgWHdHSMva+
 ZWDa4bqzbsD9zTsBEiYtHF8Uttb5pWjq94eF1hfMaF+edZbti+Nb3T9uDNat+eebO9vnvLbmh
 SHIrTzvnSRWj2RpKLMUZiYZazEXFiQAq9JLcYwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-585.messagelabs.com!1680593450!378462!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 741 invoked from network); 4 Apr 2023 07:30:50 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-17.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Apr 2023 07:30:50 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 38D2A1B0;
 Tue,  4 Apr 2023 08:30:50 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 2DB821AF;
 Tue,  4 Apr 2023 08:30:50 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 4 Apr 2023 08:30:48 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Apr 2023 15:30:27 +0800
Message-ID: <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <ZCsHKmFrUdBw3xEw@gmail.com>
References: <ZCsHKmFrUdBw3xEw@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] lapi/stat.h: Add STATX_DIOALIGN related
 definition
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
