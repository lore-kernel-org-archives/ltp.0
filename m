Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29B7C32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 10:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA7E63CA325
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 12:00:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 059973C2E42
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 12:00:32 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 169731400F93
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 12:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1661248831; i=@fujitsu.com;
 bh=29yUIeCpnuwLtBA7hvKMboabhgf9Iva2+HSJ054CYig=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=w+296d0iXXG1upY7+3mNdaVtWSvEaOlzxBmYpqIXlaL8/rDaEKYfDKlioEG73FrbA
 vy5KgUquPGFkLw0R+iWIay/V+aANJJeKyIYxKoUxC5eYlT/sxEiNuhUlq3/S89OCoW
 CKWqmCCkUVUMDvBzQhC83ZEyKDe1trWS3Q1yako+02hxtkEegfLf3mdkgLsEzRY9Hh
 f7tPrgjMVNTkMuoU/NGG6kGaYw2focaRhb/KBZFTJDvFDenE53FQE4B/9gHZchMuk/
 iMxiPdOXtAzdlxDiW4kmhI/rBnYQbtx34anSl9SVuXs1bWcRNuwdwM1iyUs8iI8KYn
 rXi61VBgzPn+g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsViZ8MxSdduKUu
 ywdp9ihYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa0br0ttMBVv4K040L2RvYHzH08XIxSEkcJZR
 YvrVJnYI5yCTxJlbx6CcvYwSa1esZupi5ORgE9CUeNa5gBnEFhGQkOhoeMsOYjMLqEssn/QLr
 EZYwFFiybI1bCA2i4CqxNRd3xlBbF4BD4mVRx6D9UoIKEhMefgezOYU8JRY+GgjmC0EVHP6xD
 NWiHpBiZMzn7BAzJeQOPjiBVSvosSljm9AMzmA7EqJG49TIcJqElfPbWKewCg4C0n3LCTdCxi
 ZVjFaJRVlpmeU5CZm5ugaGhjoGhqa6hrqGhkY6yVW6SbqpZbqlqcWl+ga6iWWF+ulFhfrFVfm
 Juek6OWllmxiBAZxSjHj6R2Mm/p+6h1ilORgUhLldahnSRbiS8pPqcxILM6ILyrNSS0+xCjDw
 aEkwSs8CSgnWJSanlqRlpkDjCiYtAQHj5II79FFQGne4oLE3OLMdIjUKUZFKXFelslACQGQRE
 ZpHlwbLIovMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmPQQyhSczrwRu+iugxUxAi4N2M4M
 sLklESEk1ME16MW3GPYVrZd45l2LXWCYlOsk3yBz9q/jw0rIiPcdbh3x3xDvkCx0Ibvr8Qfrr
 +rNKM790OiTOl0st4dlutyTr9MyLYe1Npwy91/J9PLiEw9475tOpxqSN2hlVdgyleSceCPr/K
 jW0apn4XTqaa+6+cFf+ayqldvffqJtbJcm4zYlSXeEad0nbSFVdVTTlPfPqVV/rfL6ujtbgd8
 +WXqJ6dL767ow69itp4XIOu66ufHJ+66xpG32WmK/cu0m7S1TyzprX+e94bn2b+XRv7vnwNE9
 3GSdPs5O5DUbl6s/ij53w3Kp+5qFEjrqSguzMyD2rps21/3AltF8/e1ot/4ltxxavldjyMvnH
 IxPL5UosxRmJhlrMRcWJAH6SBqRdAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-585.messagelabs.com!1661248830!49308!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12374 invoked from network); 23 Aug 2022 10:00:30 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-16.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 23 Aug 2022 10:00:30 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 26D3A1000C0
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:00:30 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1A5FD100078
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:00:30 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 23 Aug 2022 11:00:28 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 23 Aug 2022 19:01:17 +0800
Message-ID: <1661252479-2363-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1660813232-2378-3-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1660813232-2378-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] tst_safe_file_at: Add SAFE_FCHOWNAT macro
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_safe_file_at.h |  9 +++++++++
 lib/tst_safe_file_at.c     | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/tst_safe_file_at.h b/include/tst_safe_file_at.h
index 8df34227f..e253198e6 100644
--- a/include/tst_safe_file_at.h
+++ b/include/tst_safe_file_at.h
@@ -25,6 +25,10 @@
 #define SAFE_UNLINKAT(dirfd, path, flags)				\
 	safe_unlinkat(__FILE__, __LINE__, (dirfd), (path), (flags))
 
+#define SAFE_FCHOWNAT(dirfd, path, owner, group, flags)			\
+	safe_fchownat(__FILE__, __LINE__,				\
+			(dirfd), (path), (owner), (group), (flags))
+
 const char *tst_decode_fd(const int fd)
 			  __attribute__((warn_unused_result));
 
@@ -58,4 +62,9 @@ int safe_unlinkat(const char *const file, const int lineno,
 		  const int dirfd, const char *const path, const int flags)
 		  __attribute__ ((nonnull));
 
+int safe_fchownat(const char *const file, const int lineno,
+		  const int dirfd, const char *const path, uid_t owner,
+		  gid_t group, int flags)
+		  __attribute__ ((nonnull));
+
 #endif
diff --git a/lib/tst_safe_file_at.c b/lib/tst_safe_file_at.c
index ca8ef2f68..6370a68e5 100644
--- a/lib/tst_safe_file_at.c
+++ b/lib/tst_safe_file_at.c
@@ -195,3 +195,23 @@ int safe_unlinkat(const char *const file, const int lineno,
 
 	return rval;
 }
+
+int safe_fchownat(const char *const file, const int lineno,
+		  const int dirfd, const char *const path, uid_t owner, gid_t group, int flags)
+{
+	int rval;
+
+	rval = fchownat(dirfd, path, owner, group, flags);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "fchownat(%d<%s>, '%s', %d, %d, %d) failed", dirfd,
+			 tst_decode_fd(dirfd), path, owner, group, flags);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid fchownat(%d<%s>, '%s', %d, %d, %d) return value %d",
+			 dirfd, tst_decode_fd(dirfd), path, owner, group, flags, rval);
+	}
+
+	return rval;
+}
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
