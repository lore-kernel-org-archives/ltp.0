Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E9CECAAA2
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 02:59:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32AE03CA4A0
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 04:59:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C71CA3C8CA7
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 04:58:55 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 130A0600701
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 04:58:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1661482733; i=@fujitsu.com;
 bh=P6LMdMVfD5/3mSdmkiUTMgOii5TeQaHsnCC0u1CAkeI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=PAJV0o1vo99lzI0eVtMBvAUwppyagSS40VrI5g6CXx2dir6P7dAQ+YDRL+dLt1yDD
 zBjSSPpCV4vXlyqAnf+8x+KeRqYM0xLF0bKWB4oKZyNVhAGlWq0XzMC5rWLenZH99F
 gLKi35kIBV/BnKIZpkjBsQU5K5Wy/aMU7B2P9WS929X2zXC/WI/pgIYCWl4RVovuf9
 ySXpwN7AIxZWurZ7H22UD30MOE29sgXeZcoB28cNFEoOAAG5j3foGy927qvxaOZkFF
 +24DCTm43y0q+ZJN4KuQsUGXlFm8PbObFlETXf42/67IeP21IVlfSE08UZnHcN7jWx
 PxFqJDLblel3Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsViZ8MxSfeNGUe
 ywdf7ihYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bba7NZC17zVzQv38rewLiQt4uRi0NI4Cyj
 xP9dbYwQzkEmieX9p1khnL2MEh+uL2TpYuTkYBPQlHjWuYAZxBYRkJDoaHjLDmIzC6hLLJ/0i
 wnEFhZwlLi2ciFYDYuAqkRLSxdYL6+Ah8Sq6/MZQWwJAQWJKQ/fg9VwAtWcX3sXbI6QgIrE3x
 /boeoFJU7OfMICMV9C4uCLF8wQvYoSlzq+Ac3hALIrJW48ToUIq0lcPbeJeQKj4Cwk3bOQdC9
 gZFrFaJVUlJmeUZKbmJmja2hgoGtoaKpromtkbKmXWKWbqJdaqlueWlyia6iXWF6sl1pcrFdc
 mZuck6KXl1qyiREYxCnFLO93MDb1/dQ7xCjJwaQkyqv/jD1ZiC8pP6UyI7E4I76oNCe1+BCjD
 AeHkgSvmglHspBgUWp6akVaZg4womDSEhw8SiK80qJAad7igsTc4sx0iNQpRkUpcd6LpkAJAZ
 BERmkeXBssii8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEua9CzKFJzOvBG76K6DFTECLpTa
 wgywuSURISTUwedgb38t/l/Iy+sqhHxIb/ae29f2bu8OMSeaM90H39fzT1mnlN1563yD9viVg
 Gc9yCw57DpVHjy04/99vrfQxS596LeL4M+8XXH+1ql+n9HyxudsxPeHlPLYXk22VVWr/z9W8L
 nZ7/R7Xk/5Xak1m/5n/P+X94dtLfK/y2eiwNWUzzm1pDX1xZF/811Un9qfztB2q/y7eHvO+d6
 XidAa12isvV5fuYf4XFqHWdsvQUu7Zoe9taaxFWxVt9NxU2mO6Gi9vaBadYFW84Mtb5tQK7aL
 orEmzWVUFDGQNpqXpLDrOy/EzYcca6Znv/wil7P1dKLi/i09on96ZvilJGnFtnKvYKuVYjpw+
 vlBMY/kjJZbijERDLeai4kQAASGUKF0DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-587.messagelabs.com!1661482732!47538!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29897 invoked from network); 26 Aug 2022 02:58:52 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-5.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 26 Aug 2022 02:58:52 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 2F0421000CC
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 03:58:52 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 22BB81000C1
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 03:58:52 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 26 Aug 2022 03:58:50 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 26 Aug 2022 11:59:23 +0800
Message-ID: <1661486365-2361-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <871qt42tev.fsf@suse.de>
References: <871qt42tev.fsf@suse.de>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] tst_safe_file_at: Add SAFE_FCHOWNAT macro
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

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
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
