Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEEBC32774
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 10:00:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 783B33CA313
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 12:00:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C97B33CA31F
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 12:00:38 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 12ECA1A006AF
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 12:00:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1661248836; i=@fujitsu.com;
 bh=o93l3NBdOINVo7SJGewwHjutlmxspj88NOAr5lKc/zY=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=mfDN19EKSwL9vb4GnCe5GAu/3mFU89SSD2MfRp6zqicvKbSPtc3PGXMTZhNHiIFfb
 jiEEBv74AJNJB/V3ZbXsbrhJWmMsNJPFTQRrtGdQdZVb4shxM8KwP4q99ww32HL1aB
 X+7WqfneNNF6BQv28Jaosn/YtOEPrQ5/c+YB5rUqn413FMjw4TDhKPmp43w6E1rmPW
 srTHEkzRewRUjnnAZ1YofjuOar1e1RyyooFvQGu+uEperfBaBXIjhQKa6gssKh7EBH
 lqECwmH5L5TGue7RtUZIrZRIXGk8ppHvH2q5U8+716CzeLz3in459SLMCcl/QNyFNf
 DYgG2nmv1XLuw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRWlGSWpSXmKPExsViZ8ORpOu8lCX
 ZYOsKI4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNWP54yamgomKFSsnvWRqYNwl3cXIxSEkcIpR
 onvLNDYIZx+TxPvdj1khnL2MEnsn3gTKcHKwCWhKPOtcwAxiiwhISHQ0vGUHsZkF1CWWT/rF1
 MXIwSEsECix7kgMSJhFQFVizt1PYGFeAQ+J5xcDQcISAgoSUx6+B5vCKeApMbnnJDvEqjZGif
 OtE8ASvAKCEidnPmGBGC8hcfDFC2aIZkWJSx3fGEFmSghUStx4nAoRVpO4em4T8wRGwVlIumc
 h6V7AyLSK0SKpKDM9oyQ3MTNH19DAQNfQ0FTXUNdIL7FKN1EvtVS3PLW4RNdQL7G8WC+1uFiv
 uDI3OSdFLy+1ZBMjMHxTihmZdjAu6/upd4hRkoNJSZTXoZ4lWYgvKT+lMiOxOCO+qDQntfgQo
 wwHh5IEr/AkoJxgUWp6akVaZg4wlmDSEhw8SiK8RxcBpXmLCxJzizPTIVKnGBWlxHlZJgMlBE
 ASGaV5cG2w+L3EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZj3EMgUnsy8Erjpr4AWMwEtDtr
 NDLK4JBEhJdXAxONfpme6Rmmiq67mZIGy4C4He9+sgL8yPZfkDm91u7Zw/o36hy/sug+F5Ciy
 RL/6N3Xi/M/TZkslfP14NSag3cLG7Ope0XQT082pLuwt3tnadtLBGfdkJjJ7MK0w2bPRkO+p0
 g2RG4EWjvIRL3esYRAP3bmE72Gg6cQn0z/EFNpUJU1al1YtO8H7zMsIbxX59QE7GyfPdWsI1/
 j2b8Jm1g6R4+nhHUZP539UbmbPMpi9o6vrKf/sa0d3rmVPNDL7E1JqqhxvKbGAN/TSqu8LxWW
 Ed7iXztpSPOflNPW3DjGd59UnOpilbZmxiuHujsyPaw1rSmat/C71PzRo9Y9zsZEH7m91sl26
 nnEDuzOLEktxRqKhFnNRcSIARCg5/FoDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-591.messagelabs.com!1661248835!396637!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26638 invoked from network); 23 Aug 2022 10:00:35 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-5.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 23 Aug 2022 10:00:35 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 6EDD11AB
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:00:35 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 6310B1A3
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:00:35 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 23 Aug 2022 11:00:33 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 23 Aug 2022 19:01:18 +0800
Message-ID: <1661252479-2363-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661252479-2363-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1660813232-2378-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <1661252479-2363-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] tst_cgroup: Add safe_cg_open and
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
and returns the opened fd number. The opened fd array is stored in
fds argument.

safe_cg_fchown is used to use fchownat to change file's uid and gid.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_cgroup.h | 44 +++++++++++++++++++++++++++++
 lib/tst_cgroup.c     | 66 +++++++++++++++++++++++++++-----------------
 2 files changed, 85 insertions(+), 25 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d06847cc6..70c5b3fd4 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -89,6 +89,32 @@ enum tst_cg_ver {
 	TST_CG_V2 = 2,
 };
 
+/* Controller sub-systems */
+enum cgroup_ctrl_indx {
+	CTRL_MEMORY = 1,
+	CTRL_CPU,
+	CTRL_CPUSET,
+	CTRL_IO,
+	CTRL_PIDS,
+	CTRL_HUGETLB,
+	CTRL_CPUACCT,
+	CTRL_DEVICES,
+	CTRL_FREEZER,
+	CTRL_NETCLS,
+	CTRL_NETPRIO,
+	CTRL_BLKIO,
+	CTRL_MISC,
+	CTRL_PERFEVENT,
+	CTRL_DEBUG
+};
+
+#define CTRLS_MAX CTRL_DEBUG
+
+/* At most we can have one cgroup V1 tree for each controller and one
+ * (empty) v2 tree.
+ */
+#define ROOTS_MAX (CTRLS_MAX + 1)
+
 /* Used to specify CGroup hierarchy configuration options, allowing a
  * test to request a particular CGroup structure.
  */
@@ -201,6 +227,24 @@ void safe_cg_printf(const char *const file, const int lineno,
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
index 1cfd79243..3d9568efe 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -77,31 +77,6 @@ struct cgroup_root {
 	int no_cpuset_prefix:1;
 };
 
-/* Controller sub-systems */
-enum cgroup_ctrl_indx {
-	CTRL_MEMORY = 1,
-	CTRL_CPU,
-	CTRL_CPUSET,
-	CTRL_IO,
-	CTRL_PIDS,
-	CTRL_HUGETLB,
-	CTRL_CPUACCT,
-	CTRL_DEVICES,
-	CTRL_FREEZER,
-	CTRL_NETCLS,
-	CTRL_NETPRIO,
-	CTRL_BLKIO,
-	CTRL_MISC,
-	CTRL_PERFEVENT,
-	CTRL_DEBUG
-};
-#define CTRLS_MAX CTRL_DEBUG
-
-/* At most we can have one cgroup V1 tree for each controller and one
- * (empty) v2 tree.
- */
-#define ROOTS_MAX (CTRLS_MAX + 1)
-
 /* Describes a controller file or knob
  *
  * The primary purpose of this is to map V2 names to V1
@@ -1320,6 +1295,47 @@ void safe_cg_printf(const char *const file, const int lineno,
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
