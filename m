Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19888C7EE22
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 09:14:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB15B3CB542
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 11:14:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D5663CD6F4
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:14:32 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E19FB60074C
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1683623670; i=@fujitsu.com;
 bh=2/TtUfau967R3qXLC9FtFB8vBO/Kmo76uqIvpNeVLTA=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
 b=ubiXpHyOrsPaqCuzOr31zJaInhKxwr8ETLGwrbUnA0CuXxYC/MVzZChIPJLimmtGJ
 T6lrC4gB5se5AVq0bI9+TtNS8XzF87DVCUtg+5uiDObijQ9grdtRmz4NH4onhOnbVs
 Rf5gRdAUI0dYlxQIzHqOQ2uFfk7kNI+4ramYpl3Nwz8g61dHVg9x/oIdfP3kUmY0Z2
 JVGdBMUIvCekDc4nbLQNkbGGsuvYYHDGad8fsJdT9rMO1qWQd7mNFGvASl0G27Y/Mo
 rPhshXetGeslXphafyBrg439EvoEtzWCLYnCaZwC8ABKq+DkPh1OIw+JZLjM+aUBIM
 lkuBjTuVLPwHQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRWlGSWpSXmKPExsViZ8ORpPuVLyr
 FYPkNNYu1e/4wW6z4voPRgclj06pONo99v9exBjBFsWbmJeVXJLBm7F91mrngFVvFq0NNrA2M
 z1i7GLk4hAQ2Mkq8a7rMDuFMY5JY/uEMUxcjJwebgKbEs84FzCC2iICYxPUNr1hBbGYBW4mXx
 7cygtjCAl4S66d/AathEVCVaLzWyg5i8wp4Slyc9hVsjoSAgsSUh+/BajiB6ue2vQCzhYBq3n
 RNYoWoUZO4em4T8wRGngWMDKsYzYpTi8pSi3QNDfSSijLTM0pyEzNz9BKrdBP1Ukt1y1OLS3S
 N9BLLi/VSi4v1iitzk3NS9PJSSzYxAgMlpVjt5Q7G5bv+6h1ilORgUhLl7doXmSLEl5SfUpmR
 WJwRX1Sak1p8iFGGg0NJgvcBT1SKkGBRanpqRVpmDjBoYdISHDxKIrwnWIDSvMUFibnFmekQq
 VOMilLivOW8QAkBkERGaR5cGyxSLjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5p0IMoUnM6
 8EbvoroMVMQIv9L4eDLC5JREhJNTAV23BUTr3mvrHH9+vfrRcPTpnYzXNgs1/x2u8bt3aIfgq
 0ebdKOuqe7xfVYt2sn4/yAw5fk1/UdSTiiP+T6F2yC65cUlH4+bXvdYGPeN1e7++LszV3Be05
 t1j5lFvCNobrzuf/GQhN2mNy+PdmP/v5L95PbxVdfv5WocOvbN/o2B6m09Nq/G7Wht36w6yeb
 8CyXPxL1PkzuUk2sR03at/JKmUnrpI9sbAmuZHNt9Z8RancGWYZqVWhUa9V10c+/WMoylP7uy
 jB0F9615Q7oocqlBW3bvKXlz503tb28PHejsWr61K+JM2dKnaIKezu1NN7PhhmyH4xtzy56bA
 308azUuLbVP5K2WkevOLaEFyhxFKckWioxVxUnAgAmvx/NQ8DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-571.messagelabs.com!1683623669!17775!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1468 invoked from network); 9 May 2023 09:14:29 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-4.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 May 2023 09:14:29 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 5BAFD1B4;
 Tue,  9 May 2023 10:14:29 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 084BD7B;
 Tue,  9 May 2023 10:14:27 +0100 (BST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  9 May 2023 17:14:03 +0800
Message-Id: <1683623648-22778-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/7] lapi/stat.h: Add STATX_DIOALIGN related
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
MIME-Version: 1.0
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
index 590ccd111..6ed4b6637 100644
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
+	uint64_t	__spare3[12];
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
