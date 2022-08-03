Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD35CC19F28
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 09:19:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 335DB3C9230
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 11:19:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2F6D3C0294
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 11:19:10 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 970F61000A49
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 11:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1659518348; i=@fujitsu.com;
 bh=29yUIeCpnuwLtBA7hvKMboabhgf9Iva2+HSJ054CYig=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=BNloeuswBHvwtpZ1NSKx4MCDhsfOvM1QgMifd6Gz+PH3h4t9M5gvijsG08UOlQ1xP
 T0KmZtYbIE7V4VugC+5S4MuU3zlbMRVTEdMsVAKhL1ZjIVno/Jvcle6gc6Lb+O0qBM
 0PbZyrn32HKxflSOpZPDVCqj608cJJzA7j1r9mllWqPAjGmQIkunJZrLDS0K6zFEMk
 HwjJgauoP2FYHfqVqhS2kCb/BWWkDYoAERcRTAdcSnSICft5N1Xh07Gd0b1yJlIP9P
 XIzAqInyjGKNxaqtDn/5VknLlCI9o+uo0/LpyvEABwRey73ZFyJzAZD5XElg9ztHuJ
 6P0JASBtdzHNQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRWlGSWpSXmKPExsViZ8MxSbfb9lW
 SwfonFhab96xjsVjxfQejRfejPawOzB77fq9j9Xi/7yqbx+bT1QHMUayZeUn5FQmsGa1LbzMV
 bOGvONG8kL2B8R1PFyMXh5DAFkaJGzO+s0M4y5kkNt98zgLh7GaUaPvbw9rFyMnBJqAp8axzA
 TOILSIgIdHR8JYdxGYWCJF4N3k9C4gtLOAocaLxFCOIzSKgIvF09VqwXl4BD4lJU+6D1UgIKE
 hMefieGSIuKHFy5hMWiDkSEgdfvGCGqFGUuNTxjRHCrpB4ffgSVFxN4uq5TcwTGPlnIWmfhaR
 9ASPTKkbrpKLM9IyS3MTMHF1DAwNdQ0NTXWMLXUMTA73EKt1EvdRS3fLU4hJdI73E8mK91OJi
 veLK3OScFL281JJNjMDwTSlW69nBeGLVT71DjJIcTEqivGfMXyUJ8SXlp1RmJBZnxBeV5qQWH
 2KU4eBQkuAtsAbKCRalpqdWpGXmAGMJJi3BwaMkwvvdCijNW1yQmFucmQ6ROsWoKCXOO9sGKC
 EAksgozYNrg8XvJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvCdAtvNk5pXATX8FtJgJaLE
 O1wuQxSWJCCmpBibO6ksiEpe//X3IuNqt8r7jVTvptSJdm+tffvPdI8VoVJ+2+sev0EmNza/m
 NS8t57/becjUxObM1F1T4u7sfHd4Tbn5oYcSp/alrGn+mcm3Yxbbo1WBCQn/DuveC113r3LTl
 c06ERVLhe8cWv4pefs6701ZmkU1bzLerJBT3zz3+7c/7+VdpbQUv6cXP7mpaSAXe81XmuXZO/
 4Wjx9Pqhmk/jas67NbLNQpsuOs4/nQ7G+8mq2MazbItVz+IOrwNJl/5Z6/O7MLTh03m9SSNEv
 qYeTmQyns/3/tKr/AY+FkE6GhejvsTkhVh9qVKv76I76vVRwLSk895d9tIm0Z9jbjgH6V54LK
 x4+PaAsbafMpsRRnJBpqMRcVJwIAxyMzuloDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-565.messagelabs.com!1659518347!379781!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12384 invoked from network); 3 Aug 2022 09:19:07 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-10.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Aug 2022 09:19:07 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 974331000E9;
 Wed,  3 Aug 2022 10:19:07 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 88C291000CE;
 Wed,  3 Aug 2022 10:19:07 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 3 Aug 2022 10:19:05 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 3 Aug 2022 18:19:39 +0800
Message-ID: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/3] tst_safe_file_at: Add SAFE_FCHOWNAT macro
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
