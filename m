Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1572EC76196
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 10:45:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFBE73CD053
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 12:45:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BCF33C010A
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 12:44:55 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF3912000D2
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 12:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680518692; i=@fujitsu.com;
 bh=1zDDHoHRWZ52YpOYo2y4lpFGnJPl+f5zhyE+0mnRdj8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=I8SXCIBFtMgNg0M44Y5u7owUpZPY7snjoRInBECaZeMIKZLhlrkmc6a3qtacXurKR
 hBb9xQIITp0LBqQImskvm1QP14V103rlQVekOJVbXecWu5zZp4Eh5oA7U2+vu9QRuc
 J43vIBa3/Er0t1LUEyOflw0TkmbTkhfbz2hlH0dCUK1M/tlCGmZ8dy1igkFX9q+jpL
 bnD0/x51xQT/0HvhtfYR57+ZI8m3BfX8KKJ40ex9iR6f5Tw9exfjfJKZxzUFDmt9cq
 PnpPYH8IzAgnJ1IzlqH/9KWdyCYeInq7T/ipUR5wrbz9zzLdpiIXc0fzPo5joK5DHJ
 179kiveM2cWXQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRWlGSWpSXmKPExsViZ8ORpKuyTiv
 F4OJpYYu1e/4wW6z4voPRgclj06pONo99v9exBjBFsWbmJeVXJLBmtN4+wFbwiq1i24plzA2M
 z1i7GLk4hAQ2Mkp8ebacHcJZwiQx9dUGJghnD6PEi4lrGLsYOTnYBDQlnnUuYAaxRQQkJDoa3
 rKD2MwCdhJ3FjeBxYUFvCTW7v8LZrMIqEj0bm9nA7F5BTwk+qY+ZwKxJQQUJKY8fA9WwylgL/
 Gg6SJYXAhozvcTnUwQ9YISJ2c+YYGYLyFx8MULZoheJYm21iusEHaFROP0Q1Az1SSuntvEPIF
 RcBaS9llI2hcwMq1iNCtOLSpLLdI1NNNLKspMzyjJTczM0Uus0k3USy3VLU8tLtE11EssL9ZL
 LS7WK67MTc5J0ctLLdnECAzplGLmlzsYT/T91TvEKMnBpCTKu3aNVooQX1J+SmVGYnFGfFFpT
 mrxIUYZDg4lCV5LkJxgUWp6akVaZg4wvmDSEhw8SiK8l5YApXmLCxJzizPTIVKnGBWlxHk91w
 IlBEASGaV5cG2wmL7EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZh3D8h2nsy8Erjpr4AWMwE
 tbo3SAFlckoiQkmpgqrk31XDN/TjGdFamM2pfZTa3/og4GvL1iHJ3xytu+1VaJl+exsj57N+Q
 xKXo2lq2er1AxlG1nV/dDPkvdXjPerfy09yns2uuXr4n9E75/0yV2dmvDIM1SqvtXl5yqtrN/
 ql2nfyyDeKNcUHXin7EPlsVybfy+NXzlrUK7S/tUu593Md8PW1BLn91hXDEnvii157bj/7MsL
 55b66HMWNZul9kWeXMfeaLMzb9OCQvYMfu4b/9oehM1SO/Lp1+uihO9V5RAfPif34VpvbKMdc
 els6y9tmi66sr4ROweq24ePh6o8mn6vRWqvdMKZqwV2TiLi7//RPfx0RxMU1PKb2qfX6RxJXD
 Dgtl19RJcBc3KrEUZyQaajEXFScCANJyWWFkAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-585.messagelabs.com!1680518692!299946!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21616 invoked from network); 3 Apr 2023 10:44:52 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-9.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Apr 2023 10:44:52 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id E4D031D0;
 Mon,  3 Apr 2023 11:44:51 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id D97171B0;
 Mon,  3 Apr 2023 11:44:51 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 3 Apr 2023 11:44:50 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 3 Apr 2023 18:44:33 +0800
Message-ID: <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
References: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] lapi/stat.h: Add STATX_DIOALIGN related
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
