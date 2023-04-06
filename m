Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F13C76196
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 05:40:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63EDD3CC724
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 07:40:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B6003C00D1
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:40:41 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C11CE600293
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 07:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680759639; i=@fujitsu.com;
 bh=1zDDHoHRWZ52YpOYo2y4lpFGnJPl+f5zhyE+0mnRdj8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=TwxOYJYomGoW7uW9sMWcBc52YrmpdFtV+nTe0N81AVJqMMC3A1vUk4YSaEjIW3Avf
 NepKc/0WkXydattW2uLm08uHNeG+ustztol41y1Y9gGLJvO1ZEx04IMMr20QMYGHUA
 STnF9SqTzJ6bDjE7X2f2fNEadiTBL9vZMigPkOKekiQWUZLXbYuZaP+anXqbm1Evdk
 Wbmxvc2qIl4sBIoKrWj36lnn36IXod/akebs8M6DqAOiuyq6Ocw5phN7mOZbVqIcwn
 OWaGD+pe6H1GiOs+L5m24Kmu4ooSNhptmT3H6ID8pqK8ns30Jw6GD2sdKKTAfqG0p0
 PWAhGYRob5srQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRWlGSWpSXmKPExsViZ8ORqBsWrZd
 icKHBxGLtnj/MFiu+72B0YPLYtKqTzWPf73WsAUxRrJl5SfkVCawZrbcPsBW8YqvYtmIZcwPj
 M9YuRi4OIYEtjBIt87dCOcuZJNb/PM0I4exhlHi/7hmQw8nBJqAp8axzATOILSIgIdHR8JYdx
 GYWsJO4s7gJLC4s4CVxsu8kmM0ioAJU844JxOYV8JA4s/wFC4gtIaAgMeXhe7AaTgETiVPtd8
 FqhASMJT7f+csKUS8ocXLmExaI+RISB1+8YIboVZJoa73CCmFXSDROP8QEYatJXD23iXkCo+A
 sJO2zkLQvYGRaxWhWnFpUllqka6GXVJSZnlGSm5iZo5dYpZuol1qqm5dfVJKha6iXWF6sl1pc
 rFdcmZuck6KXl1qyiREY0inFyT92MO7q+6t3iFGSg0lJlHeuik6KEF9SfkplRmJxRnxRaU5q8
 SFGGQ4OJQneXVF6KUKCRanpqRVpmTnA+IJJS3DwKInwLvQDSvMWFyTmFmemQ6ROMSpKifNagv
 QJgCQySvPg2mAxfYlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO+JSKApPJl5JXDTXwEtZgJ
 abOuvA7K4JBEhJdXAlF1xctnPVb++rn0utnbXW4Mvr08yyccZCf3pmCwYFh9f9Yvj8gL1otN7
 r83vWVW3sH+zXuOx53p2LOIvPco+XHy+9pbj3JUMc+KKe1/Ur+wxnit8v2DasUsNy58YHrU5q
 ZG/0aNk8eWt9yt8Nkeas+546M2bdmvTzC+LPFmcTurdfVd3/bz0peBzS4+a/I0tX9Ty6djDlv
 0LliWmnTzrcvXz2lkuu/cVqhgzibc8jjB8snnOnMPeBlGb7hkEPVh63tVAJ1BdT8N21e7eL57
 3F93elOVTy2cfx3zzFsuuSdvaZpr2qMkf9Y3ND5q+ePUeo/XRL6+diPXgerh+91UDF7Ec3wTt
 i0cDPZ77392yws1SiaU4I9FQi7moOBEAfs8mrWQDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-728.messagelabs.com!1680759638!1188272!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 530 invoked from network); 6 Apr 2023 05:40:38 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-9.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Apr 2023 05:40:38 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 496FC10019C;
 Thu,  6 Apr 2023 06:40:38 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 3CDDB10019A;
 Thu,  6 Apr 2023 06:40:38 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 6 Apr 2023 06:40:36 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 6 Apr 2023 13:40:19 +0800
Message-ID: <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20230404215918.GA1893@sol.localdomain>
References: <20230404215918.GA1893@sol.localdomain>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] lapi/stat.h: Add STATX_DIOALIGN related
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
