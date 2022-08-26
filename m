Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0841ECAAA3
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 02:59:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E4CA3CA4A1
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 04:59:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EA473CA417
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 04:58:58 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38AB3200075
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 04:58:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1661482737; i=@fujitsu.com;
 bh=MY1oJWeBZPcy5uM//nA4q7Z5JW5Q/I0Xez4nrc4qEpc=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=QkHP3FQ/0rfzrCRssM3yk6PxwLcW0x2Ys4klsiAiWThHT0vjdVo6pHYatGtv95nqM
 DkchOMRN7zaqirNQd711Kp7jhp7C/Hn3ld0JzHnV9dcwf09Frsta45diYFM/NM4F2t
 OxfAOODnyDSyJV/QfJNqvTeskA4wjRTr/3aEfFLZ/62w1L6aHun92/l+Y2pLgSfNg/
 8jijfLDb0jc+Oz803P6p0+JY68G78knbW7Ua8YDgIXjht6uWdeQmxJG/2gUdPO7asV
 IZHA22j7Qu9JDk3+pQK7x/K7/wdRAdM48p4S6iR6jY/PuIPdoWSQQ8+6rLSI5UvIui
 aerW/5X1h/q3g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8ORqPvBjCP
 ZYPEGIYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePKth3sBdclKxYuXcvawLhKtIuRi0NI4Cyj
 RMP2S+xdjJxAzkEmiVnbdSESexklnvxZygaSYBPQlHjWuYAZxBYRkJDoaHgL1sAsoC6xfNIvJ
 hBbWCBQ4sPsZrB6FgFVieYXzxhBbF4BD4lPvyexgtgSAgoSUx6+B5vDKeApcWnvXjaIxUkSr3
 Z0MkPUC0qcnPmEBWK+hMTBFy+YIXoVJS51fAOayQFkV0rceJwKEVaTuHpuE/MERsFZSLpnIel
 ewMi0itEqqSgzPaMkNzEzR9fQwEDX0NBU11DXyMBYL7FKN1EvtVS3PLW4RNdQL7G8WC+1uFiv
 uDI3OSdFLy+1ZBMjMIRTihlP72Dc1PdT7xCjJAeTkiiv/jP2ZCG+pPyUyozE4oz4otKc1OJDj
 DIcHEoSvGomHMlCgkWp6akVaZk5wHiCSUtw8CiJ8EqLAqV5iwsSc4sz0yFSpxgVpcR5L5oCJQ
 RAEhmleXBtsBi+xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY9y7IFJ7MvBK46a+AFjMBLZb
 awA6yuCQRISXVwNS5ZMN9pT7NE3smNXQxHb3x7GKEwkPZFNb5jqJ2LoveSkXt+T2z1z61Peve
 ZBGRt1+/3cnyX/Aous1iyTfXhEcCJ0s9NTbmpGe1vY3rea69L92vZv+y/XfmasTOShDJnK9g3
 ZnjFfv/gaWscO7fGeEfbybevOR37eYFw33cH0s0r/H3PDvZeJ99q3pbatiCp/WVhwPfHNDv3L
 lQ+uvqO45N0s8bLvk8lbguYW2X4KEneCjfWfXF0XsOyQn23xVaGfcFvps4nzGlb+V6th3Oncr
 yHvf/7b3nHhZTHj97p+zBRUZmIVXed7ZcvM6TfuOuuAHfapbORaHhtzZGLEn5ulNm/SPvBXbL
 jnhxfSp/tUaJpTgj0VCLuag4EQCYQdCxXAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-587.messagelabs.com!1661482736!174556!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4762 invoked from network); 26 Aug 2022 02:58:56 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-4.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 26 Aug 2022 02:58:56 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id DD10D100197
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 03:58:55 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id CFA47100192
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 03:58:55 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 26 Aug 2022 03:58:54 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 26 Aug 2022 11:59:24 +0800
Message-ID: <1661486365-2361-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661486365-2361-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <871qt42tev.fsf@suse.de>
 <1661486365-2361-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/3] tst_cgroup: Add safe_cg_open and
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

safe_cg_open is used to open the sub controller's file ie cgroup.procs
and returns the opened fd number. The opened fd array is stored in
fds argument.

safe_cg_fchown is used to use fchownat to change file's uid and gid.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_cgroup.h | 21 +++++++++++++++++++++
 lib/tst_cgroup.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d06847cc6..db959380f 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -89,6 +89,9 @@ enum tst_cg_ver {
 	TST_CG_V2 = 2,
 };
 
+/* This value is equal to ROOTS_MAX in tst_cgroup.c. */
+#define TST_CG_ROOTS_MAX 32
+
 /* Used to specify CGroup hierarchy configuration options, allowing a
  * test to request a particular CGroup structure.
  */
@@ -201,6 +204,24 @@ void safe_cg_printf(const char *const file, const int lineno,
 			const char *const fmt, ...)
 			__attribute__ ((format (printf, 5, 6), nonnull));
 
+#define SAFE_CG_OPEN(cg, file_name, flags, fds)			\
+	safe_cg_open(__FILE__, __LINE__, (cg), (file_name), (flags), (fds))
+
+int safe_cg_open(const char *const file, const int lineno,
+			const struct tst_cg_group *const cg,
+			const char *const file_name,
+			int flags, int *fds)
+			__attribute__ ((nonnull));
+
+#define SAFE_CG_FCHOWN(cg, file_name, owner, group)		\
+	safe_cg_fchown(__FILE__, __LINE__, (cg), (file_name), (owner), (group))
+
+void safe_cg_fchown(const char *const file, const int lineno,
+			const struct tst_cg_group *const cg,
+			const char *const file_name,
+			uid_t owner, gid_t group)
+			__attribute__ ((nonnull));
+
 #define SAFE_CG_SCANF(cg, file_name, fmt, ...)			\
 	safe_cg_scanf(__FILE__, __LINE__,				\
 			  (cg), (file_name), (fmt), __VA_ARGS__)
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 1da3f0a5d..6c015e4f8 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -1326,6 +1326,47 @@ void safe_cg_printf(const char *const file, const int lineno,
 	}
 }
 
+int safe_cg_open(const char *const file, const int lineno,
+		      const struct tst_cg_group *cg,
+		      const char *const file_name, int flags, int *fds)
+{
+	const struct cgroup_file *const cfile =
+		cgroup_file_find(file, lineno, file_name);
+	struct cgroup_dir *const *dir;
+	const char *alias;
+	int i = 0;
+
+	for_each_dir(cg, cfile->ctrl_indx, dir) {
+		alias = cgroup_file_alias(cfile, *dir);
+		if (!alias)
+			continue;
+
+		fds[i++] = safe_openat(file, lineno, (*dir)->dir_fd, alias, flags);
+	}
+
+	return i;
+}
+
+void safe_cg_fchown(const char *const file, const int lineno,
+			const struct tst_cg_group *cg,
+			const char *const file_name,
+			uid_t owner, gid_t group)
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
+
 void safe_cg_scanf(const char *const file, const int lineno,
 		       const struct tst_cg_group *const cg,
 		       const char *const file_name,
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
