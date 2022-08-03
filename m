Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4105C19F28
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 09:19:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FAD13C920E
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 11:19:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAD233C9354
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 11:19:18 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DB389600A57
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 11:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1659518356; i=@fujitsu.com;
 bh=XIQJgqhgtgp25V9sr/mpFoe7S3WVst40JgInlg0wq78=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=w+TaA75XrP26uOmhQq0FUBqgnz14dd0X2h4B2ChuM564UuepWkdQd0cEFpzJVZ78B
 cdSJbNVSHdzukj5NdO7/1cCrVZdmVIexJSsLUanN98Y5OjCn77J+QxmqghOnGPzF6g
 M1fv5Ms+Bl85Aaa50vqz8J4VtbfHujJ9Plb7N/JAhqZ6ZmaaioP7rOTKZ+rjtGgRZG
 lOBjAbgkTDjVmlOoTrR9jSkguUUyXGae1ex6Fg6xpEvtQFbnrf3+YydnRAJXdL6KXw
 X7n9LWklQUYGn0xHK/+Q8ytTGzgo3p/TO8TDAekuaFmdRGqv0MLNpA4zDUhyiiyxLZ
 afEh6WAH+YuQg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRWlGSWpSXmKPExsViZ8ORqDvF9lW
 SQdtTSYvNe9axWKz4voPRovvRHlYHZo99v9exerzfd5XNY/Pp6gDmKNbMvKT8igTWjFvLpjAX
 XBCt+Ph0GlMDY7dQFyMnh5DAFkaJI5PYuhi5gOzlTBIbnvayQzi7GSV6Fk5mB6liE9CUeNa5g
 BnEFhGQkOhoeAsWZxYIkXg3eT0LiC0sECixYOIMNhCbRUBF4vPit0xdjBwcvAIeEn17xEDCEg
 IKElMevgcbwyngKfFrxltmiCM8JE7OmcgIYvMKCEqcnPmEBWK8hMTBFy+YIXoVJS51fGOEsCs
 kXh++BBVXk7h6bhPzBEbBWUjaZyFpX8DItIrRKqkoMz2jJDcxM0fX0MBA19DQVNcEyDLUS6zS
 TdRLLdUtTy0u0QVyy4v1UouL9Yorc5NzUvTyUks2MQIDPaWYJXUHY1/fT71DjJIcTEqivGfMX
 yUJ8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuAtsAbKCRalpqdWpGXmAKMOJi3BwaMkwvvdCijNW1
 yQmFucmQ6ROsWoKCXOO9sGKCEAksgozYNrg0X6JUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjEr
 CvCdAtvNk5pXATX8FtJgJaLEO1wuQxSWJCCmpBian4o5IMdPG9W2bNrRttIoW77y+qPhdjKeH
 bLlhZ81xIbMnflXccRveVcseasi48WdjdnDalK0zzE+vOOtlZcw2KWx+Y0vJkTWxrdcv511sn
 hqW8Crt2pLTQZa7vjbcXXruW6iZ8gG+v/d0J7bsn8HyNvzCBNZTzZ1pt1gexZc+kHty+sbcJU
 snTJvE/Zepctf1mliWn04tGXxdju+n3lkZ7bdHtK54mlyLi4/YsnI/x7enjWVNpOeteWQy1ew
 AU9/XHQy+c1v7mkuWvr/vfb2x/2qu0GWhNK+Kv8+8nn/yk9mV/7RFPcND6eXVZ0sepdjHhIq6
 xBsdOXPlaWZvnYHvn8iOuJNH7ny990ipw0aJpTgj0VCLuag4EQC6PggNbwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-587.messagelabs.com!1659518356!198886!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6733 invoked from network); 3 Aug 2022 09:19:16 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-11.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Aug 2022 09:19:16 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 01F36100190;
 Wed,  3 Aug 2022 10:19:16 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id E9994100043;
 Wed,  3 Aug 2022 10:19:15 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 3 Aug 2022 10:19:13 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 3 Aug 2022 18:19:40 +0800
Message-ID: <1659521981-2241-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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

safe_cg_open is used to open the sub control's file ie cgroup.procs
and returns the fd.

safe_cg_fchown is used to use fchownat to change file's uid and gid.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_cgroup.h | 15 +++++++++++++++
 lib/tst_cgroup.c     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d06847cc6..292c9baa4 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -188,6 +188,21 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
 			 char *const out, const size_t len)
 			 __attribute__ ((nonnull));
 
+#define SAFE_CG_OPEN(cg, file_name, flags)			\
+	safe_cg_open(__FILE__, __LINE__, (cg), (file_name), (flags))
+
+int safe_cg_open(const char *const file, const int lineno,
+		 const struct tst_cg_group *const cg,
+		 const char *const file_name, int flags);
+
+#define SAFE_CG_FCHOWN(cg, file_name, owner, group)		\
+	safe_cg_fchown(__FILE__, __LINE__,			\
+			   (cg), (file_name), (owner), (group))
+
+void safe_cg_fchown(const char *const file, const int lineno,
+		    const struct tst_cg_group *const cg,
+		    const char *const file_name, uid_t owner, gid_t group);
+
 #define SAFE_CG_PRINTF(cg, file_name, fmt, ...)			\
 	safe_cg_printf(__FILE__, __LINE__,				\
 			   (cg), (file_name), (fmt), __VA_ARGS__)
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 1cfd79243..dedc0f65b 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -1297,6 +1297,45 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
 	return read_ret;
 }
 
+int safe_cg_open(const char *const file, const int lineno,
+			const struct tst_cg_group *cg,
+			const char *const file_name, int flags)
+{
+	const struct cgroup_file *const cfile =
+		cgroup_file_find(file, lineno, file_name);
+	struct cgroup_dir *const *dir;
+	const char *alias;
+	int fd;
+
+	for_each_dir(cg, cfile->ctrl_indx, dir) {
+		alias = cgroup_file_alias(cfile, *dir);
+		if (!alias)
+			continue;
+
+		fd = safe_openat(file, lineno, (*dir)->dir_fd, alias, flags);
+	}
+
+	return fd;
+}
+
+void safe_cg_fchown(const char *const file, const int lineno,
+			const struct tst_cg_group *cg,
+			const char *const file_name, uid_t owner, gid_t group)
+{
+	const struct cgroup_file *const cfile =
+		cgroup_file_find(file, lineno, file_name);
+	struct cgroup_dir *const *dir;
+	const char *alias;
+
+	for_each_dir(cg, cfile->ctrl_indx, dir) {
+		alias = cgroup_file_alias(cfile, *dir);
+		if (!alias)
+			continue;
+
+		safe_fchownat(file, lineno, (*dir)->dir_fd, alias, owner, group, 0);
+	}
+}
+
 void safe_cg_printf(const char *const file, const int lineno,
 			const struct tst_cg_group *cg,
 			const char *const file_name,
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
