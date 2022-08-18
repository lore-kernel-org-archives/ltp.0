Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D821C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 08:00:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EBB23CA1B9
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 10:00:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B22B43C954D
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 09:59:52 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AEAC6600257
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 09:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1660809590; i=@fujitsu.com;
 bh=vj2D7sOcBvDHNDPJq5r7hYN0iN69CIQIZgMahLtvK4k=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=O0+mvkPZxU6lbI/xfKmh/j85HVni0uhd/sYz2zCRqm1ykWf059brBKG0gFC95nnf5
 0Jdn8m5zLQvopLgzZXl5/3mrWpgIamTDiGnO/k5wN6pzY++RUttQ40onBKtsO2UZ70
 T1t2Hqfa9A8OKbwGdYKXiTsTDT+ObxH+J6SVxYn61SWB5RwooYDtY5OKXoHb2XW+Nr
 Nk3zBfGdz1zqUPz4UOD5gI6C7A49TrI0OT/iC5R5HccpO8IjtPh4Vg86+2EReEmcit
 wJOY5a7T+ZutbY5aGCHGOsCT1uvaraasSr8oYWnZExFaNbDSehFB8NBmqTBVbsSB5h
 RzWHKcmxHPWfw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRWlGSWpSXmKPExsViZ8OxWbfs498
 kgztX5S0271nHYrHi+w5Gi+5He1gdmD32/V7H6vF+31U2j82nqwOYo1gz85LyKxJYM7b/nMhW
 sIW/Yv2dc8wNjO94uhg5OYQENjJKfJiX2sXIBWQvZpJourCNFSKxh1Fi6lwPEJtNQFPiWecCZ
 hBbREBCoqPhLTuIzSwQIvH/8n02EFtYwF7iyrx9LCA2i4CqRMv8x2D1vAIeEvfnTQWrkRBQkJ
 jy8D1YnBOoZs7lI1C7VCRWX2yBqheUODnzCQvEfAmJgy9eMEP0Kkpc6vjGCGFXSLw+fAkqriZ
 x9dwm5gmMgrOQtM9C0r6AkWkVo1VSUWZ6RkluYmaOrqGBga6hoamusbGuuYleYpVuol5qqW55
 anGJrpFeYnmxXmpxsV5xZW5yTopeXmrJJkZgoKcUK3rtYHy14qfeIUZJDiYlUd5TT/4mCfEl5
 adUZiQWZ8QXleakFh9ilOHgUJLg7fwAlBMsSk1PrUjLzAFGHUxagoNHSYR3H0grb3FBYm5xZj
 pE6hSjopQ4ry1InwBIIqM0D64NFumXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnz/nkHNIU
 nM68EbvoroMVMQIuPXfwNsrgkESEl1cAUZqbrzbB+y07jSXyyk2TCj21h+iNbKjbh8Kf4mB1h
 F35PSuOUEf9nYb/hPlvyxKmn7i4297WIW72IM75rmjzD2zdbipSKGqMOxWnFXRIQlQj8+eCvz
 aO3S93NQjsaesr3zG0KqGy7s+xf/+wVnhI5rlufP0sVSRYqNF6uvF3d6IJXKY+ga9Ve/7ATC7
 df17INbe4+8H3/52cvfBUumq8MsJzwsXqd0d0ww8NHhP/pLnjxd8/eFhW+1qP67FddpVxsufx
 dN3/1bNyqvLKQRyfv4Z35O7mtN+dIuf8IvN0YOF9Y/pzlZInPM/79n/mGvS7lxuvXP/dXrzGd
 q+e/vdx2vU6U26SbT4yZtyww5FJSYinOSDTUYi4qTgQACYu2gW8DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-571.messagelabs.com!1660809590!53030!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28687 invoked from network); 18 Aug 2022 07:59:50 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-11.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Aug 2022 07:59:50 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 2BDF014C;
 Thu, 18 Aug 2022 08:59:50 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 1F34B7B;
 Thu, 18 Aug 2022 08:59:50 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 18 Aug 2022 08:59:47 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 18 Aug 2022 17:00:30 +0800
Message-ID: <1660813232-2378-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <87fshwlh5t.fsf@suse.de>
References: <87fshwlh5t.fsf@suse.de>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC v2 1/3] tst_safe_file_at: Add SAFE_FCHOWNAT macro
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
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
