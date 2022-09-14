Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33AFECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 07:12:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DE493CABB7
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:12:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 515A83CABFA
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 09:11:50 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B005E10011DD
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 09:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1663139508; i=@fujitsu.com;
 bh=7p51pjpi7/W9Swb03fiqfQak5ptTVW7NVlxgv1RWusk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Z8j2eW+M52UqnjN0LdB3ARR/0s/jc8kyMHpgTy68LOzqBb/Z+bzpOrYPy4SFCI9MB
 /RtGgVFafP7FNtFODWzs2RO1VA9e+eO8RBqPce/O0y+1GEpt+kkr1N6DOoGSUWJihE
 bA98ogq0Nc+YN1sFAWfaheJCbx/CDDD0w6ab3JZ2E9E/nUKevnEh5EsilEgBRo4Tl2
 D2q3uAlOtoXVtgBrufXVIZ4sXpHv99Nf+qXjts3Itn0YA4svhgPpLbE2LdB0WMGGO2
 KNFbRm1XCQ6yVtw+whjpDAFOTvCkGkjRYsWn6cR0BnbqOUI2Kc8Zw4tXmdwfE1Tf0F
 kWQ0HxLGTVkKQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRWlGSWpSXmKPExsViZ8ORpLulTjH
 ZYMFSRovXhz8xWkx/cZTNYsX3HYwOzB6bVnWyeez7vY7V48yCI+wBzFGsmXlJ+RUJrBmvvz1n
 KdjJV3F4s1EDYy9PFyMXh5DARkaJzRPusUE4S5gk5vTsY+5i5ARy9jBKtP73ALHZBDQlnnUuA
 IuLCEhIdDS8ZQexmQUCJc4c62AFsYUFHCTWv3vJBGKzCKhKXHpyHizOK+Ah8fnLNrB6CQEFiS
 kP34PN4RTwlDj0dRrULg+JV6ffsUHUC0qcnPmEBWK+hMTBFy+YIXoVJS51fGOEsCskGqcfYoK
 w1SSuntvEPIFRcBaS9llI2hcwMq1itEwqykzPKMlNzMzRNTQw0DU0NNU10bU01kus0k3USy3V
 LU8tLtE11EssL9ZLLS7WK67MTc5J0ctLLdnECAz0lGKW2B2MW/t+6h1ilORgUhLl/fBVIVmIL
 yk/pTIjsTgjvqg0J7X4EKMMB4eSBO+OWsVkIcGi1PTUirTMHGDUwaQlOHiURHgn5QOleYsLEn
 OLM9MhUqcYFaXEeR9XAyUEQBIZpXlwbbBIv8QoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHc
 KyHaezLwSuOmvgBYzAS02spYHWVySiJCSamBa/TYtr2Frqt36JQcT1S5bVbJPfvF+Q1/8B1H5
 hjMfZjp3GWgaaCQb2D3uWrnz1ud1uavvxv4/zPsxVch/2ZynW6zaSqZf+tB9v0FmzcWdButmv
 f1XuSzpcuoGoQ2vfOb/SDpje9rohnU9S5bIJrt9v5MOzPrVK8j98/vUrHV3g3dWRZ/njr3zSX
 bdpoSw6rmFd++K2M0Mi3yp1PPvxpFJVyS1vtyWDy93erfrguPZh2dWeCj8ZPgwvyP4MsuGqOn
 P9bbuP1oRsYzhyj6x5aKGVTPndEf+NHXZMz8qxumBt6xv5GszjqSW41WGhx562FatSdS+1qZ4
 dGJTYHvTfMfPD/yqQtrf7PdOeFul/7XooxJLcUaioRZzUXEiANKZ+VFvAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-591.messagelabs.com!1663139507!235005!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22062 invoked from network); 14 Sep 2022 07:11:48 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-4.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Sep 2022 07:11:48 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 986EC1AD;
 Wed, 14 Sep 2022 08:11:47 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 8CF4F1AC;
 Wed, 14 Sep 2022 08:11:47 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 14 Sep 2022 08:11:45 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 14 Sep 2022 16:12:21 +0800
Message-ID: <1663143142-2283-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] tst_safe_file_at: Add SAFE_FSTATAT macro
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
Cc: brauner@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_safe_file_at.h |  7 +++++++
 lib/tst_safe_file_at.c     | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/tst_safe_file_at.h b/include/tst_safe_file_at.h
index e253198e6..082a5acd9 100644
--- a/include/tst_safe_file_at.h
+++ b/include/tst_safe_file_at.h
@@ -29,6 +29,9 @@
 	safe_fchownat(__FILE__, __LINE__,				\
 			(dirfd), (path), (owner), (group), (flags))
 
+#define SAFE_FSTATAT(dirfd, path, statbuf, flags)			\
+	safe_fstatat(__FILE__, __LINE__, (dirfd), (path), (statbuf), (flags))
+
 const char *tst_decode_fd(const int fd)
 			  __attribute__((warn_unused_result));
 
@@ -67,4 +70,8 @@ int safe_fchownat(const char *const file, const int lineno,
 		  gid_t group, int flags)
 		  __attribute__ ((nonnull));
 
+int safe_fstatat(const char *const file, const int lineno,
+		 const int dirfd, const char *const path, struct stat *statbuf,
+		 int flags)
+		 __attribute__ ((nonnull));
 #endif
diff --git a/lib/tst_safe_file_at.c b/lib/tst_safe_file_at.c
index 6370a68e5..f530dc349 100644
--- a/lib/tst_safe_file_at.c
+++ b/lib/tst_safe_file_at.c
@@ -215,3 +215,23 @@ int safe_fchownat(const char *const file, const int lineno,
 
 	return rval;
 }
+
+int safe_fstatat(const char *const file, const int lineno,
+		 const int dirfd, const char *const path, struct stat *statbuf, int flags)
+{
+	int rval;
+
+	rval = fstatat(dirfd, path, statbuf, flags);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "fstatat(%d<%s>, '%s', %p, %d) failed", dirfd,
+			 tst_decode_fd(dirfd), path, statbuf, flags);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid fstatat(%d<%s>, '%s', %p, %d) return value %d",
+			 dirfd, tst_decode_fd(dirfd), path, statbuf, flags, rval);
+	}
+
+	return rval;
+}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
