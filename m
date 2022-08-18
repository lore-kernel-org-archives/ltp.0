Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4167EC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 08:00:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83FF93CA225
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 10:00:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F13F93C144C
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 10:00:15 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1697960074C
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 10:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1660809613; i=@fujitsu.com;
 bh=GNKQA+Er3iHkzWs563K3a5OxPlbSGo69Wsb3RrjFgEo=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=ybCE5ACN44UNIxZeYjXT5CzkzXUzHJSLflRdl+M/xhc0CJSeLfDWzh2SFKFqC16T0
 6ZD2tldUWsbkN2xzvbwjPNeH5qz/4IBvrYJsJs4kNOFBtwv3tB3GSRZhuARD+uwN8c
 7bwIpyO9ZEz2C2B5PLFzExqxeGZk2EBVyBs98WAkLW870GFVqDQO9/2gcshzNeqN4q
 yCHPxoI+IH9dzsdUGiev9Pifk3cXRz5faQaOAbKZ7cmKJu8xC6Cf0nXkNi7vqyGDz8
 /A4JHuNtHH5cqgBqyDHOHZvN7v1hLZRMi61nW//b7HMlegmWEpPqpvqSOFyEL23rxf
 +xBzBO2Ydqrfw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRWlGSWpSXmKPExsViZ8ORqNv18W+
 Swb9eQ4vNe9axWKz4voPRovvRHlYHZo99v9exerzfd5XNY/Pp6gDmKNbMvKT8igTWjAu/LzMW
 dJpWnH/Ux9jAeEm7i5GLQ0hgC6PE6Y+TmSGc5UwSl1dtYOti5ARy9jBKrLmXCGKzCWhKPOtcw
 AxiiwhISHQ0vGUHsZkFQiT+X74PVi8s4C8xdcpdFhCbRUBVYuLBpawgNq+Ah8SWBU/AeiUEFC
 SmPHwPZHNwcAp4Snx7kQBiCgkkSax45g1RLShxcuYTFojpEhIHX7yA6lSUuNTxjRHCrpB4ffg
 SVFxN4uq5TcwTGAVnIWmfhaR9ASPTKkbbpKLM9IyS3MTMHF1DAwNdQ0NTIG2sa2RoppdYpZuo
 l1qqm5dfVJKha6iXWF6sl1pcrFdcmZuck6KXl1qyiREY7CnF6Td2MO7a90vvEKMkB5OSKO+pJ
 3+ThPiS8lMqMxKLM+KLSnNSiw8xynBwKEnwdn4AygkWpaanVqRl5gAjDyYtwcGjJMK7D6SVt7
 ggMbc4Mx0idYpRl2Pq7H/7mYVY8vLzUqXEeW1BZgiAFGWU5sGNgCWBS4yyUsK8jAwMDEI8Bal
 FuZklqPKvGMU5GJWEef+8A5rCk5lXArfpFdARTEBHHLv4G+SIkkSElFQDU/NW00a/XV/3GBbx
 dW9j3lWwfLWMzZqQ2opYox+zo9y8DnyKnnJpykrW4qkCl/RV37Y4Xze2rF0kVH7Kpr1ZcuYML
 e1Dkz364gwdW8M0BbJN3r8w+3hpjuDFuGXxE+5LMc4r9sh9sG35kW4mYT2H+d92+893e8Rbr+
 0xubvISSBCXpche8byebVXtt4sMbX97v+zpaN082HtF6+6yq8lnk/fub92fUbtqWsFEjMVfzi
 ePfzO80Be49rWsOOH75i2O53J/PX1scSjpxWrta8V9F8KNXO6Yb92xrL1/uLO93e9PWuz/b6V
 wpOFOa6cXqcuvmb9prh/0smsqMXMFTbbZ1mkexds/jj9NRdj4rVTAkosxRmJhlrMRcWJAHgem
 nN9AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-732.messagelabs.com!1660809610!56883!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4061 invoked from network); 18 Aug 2022 08:00:10 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-3.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Aug 2022 08:00:10 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id ED84F100199;
 Thu, 18 Aug 2022 09:00:09 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id D30AA100197;
 Thu, 18 Aug 2022 09:00:09 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 18 Aug 2022 09:00:06 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 18 Aug 2022 17:00:31 +0800
Message-ID: <1660813232-2378-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1660813232-2378-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <87fshwlh5t.fsf@suse.de>
 <1660813232-2378-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC v2 2/3] tst_cgroup: Add safe_cg_open and safe_cg_fchown
 functions
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

To avoid the problem that if the file only exists on a single V1 controller,
but if it exists on multiple controllers (e.g. any cgroup.* file) then we w
ill open multiple filesand only return the fd for the last of them, introduce
the common_cgroup_file function and add ctrl_name agrument.

The common_cgroup_file is used to detect whether this file can exists on
each controller. If the created cg is v2, we don't have this problem. If
the created cg is v1, then we need to use common_cgroup_file. Also need to
compare root cgroup ctrl whether equal to the ctrl_name agrument. So we
know that we are opening a correct controller cgroup* file instead of
last.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_cgroup.h |  38 +++++++++++++++
 lib/tst_cgroup.c     | 111 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 131 insertions(+), 18 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d06847cc6..e75d88254 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -82,6 +82,7 @@
 #define TST_CGROUP_H
 
 #include <sys/types.h>
+#include <stdbool.h>
 
 /* CGroups Kernel API version */
 enum tst_cg_ver {
@@ -89,6 +90,25 @@ enum tst_cg_ver {
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
 /* Used to specify CGroup hierarchy configuration options, allowing a
  * test to request a particular CGroup structure.
  */
@@ -188,6 +208,24 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
 			 char *const out, const size_t len)
 			 __attribute__ ((nonnull));
 
+#define SAFE_CG_OPEN(cg, file_name, ctrl_indx, flags)		\
+	safe_cg_open(__FILE__, __LINE__,				\
+			(cg), (file_name), (ctrl_indx), (flags))
+
+int safe_cg_open(const char *const file, const int lineno,
+		    const struct tst_cg_group *const cg,
+		    const char *const file_name,
+		    enum cgroup_ctrl_indx ctrl_indx, int flags);
+
+#define SAFE_CG_FCHOWN(cg, file_name, ctrl_indx, owner, group)	\
+	safe_cg_fchown(__FILE__, __LINE__,				\
+			   (cg), (file_name), (ctrl_indx), (owner), (group))
+
+void safe_cg_fchown(const char *const file, const int lineno,
+		    const struct tst_cg_group *const cg,
+		    const char *const file_name,
+		    enum cgroup_ctrl_indx ctrl_indx, uid_t owner, gid_t group);
+
 #define SAFE_CG_PRINTF(cg, file_name, fmt, ...)			\
 	safe_cg_printf(__FILE__, __LINE__,				\
 			   (cg), (file_name), (fmt), __VA_ARGS__)
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 1cfd79243..946b945f0 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -77,24 +77,6 @@ struct cgroup_root {
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
 #define CTRLS_MAX CTRL_DEBUG
 
 /* At most we can have one cgroup V1 tree for each controller and one
@@ -1192,6 +1174,25 @@ static const char *cgroup_file_alias(const struct cgroup_file *const cfile,
 	return cfile->file_name_v1;
 }
 
+__attribute__ ((nonnull, warn_unused_result))
+static bool common_cgroup_file(const char *alias,
+			       const struct cgroup_dir *const dir)
+{
+	int i;
+
+	if (dir->dir_root->ver != TST_CG_V1) {
+		for (i = 0; cgroup_ctrl_files[i].file_name; i++)
+			if (!strcmp(cgroup_ctrl_files[i].file_name, alias))
+				return true;
+	} else {
+		for (i = 0; cgroup_ctrl_files[i].file_name_v1; i++)
+			if (!strcmp(cgroup_ctrl_files[i].file_name_v1, alias))
+				return true;
+	}
+
+	return false;
+}
+
 int safe_cg_has(const char *const file, const int lineno,
 		    const struct tst_cg_group *cg,
 		    const char *const file_name)
@@ -1297,6 +1298,80 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
 	return read_ret;
 }
 
+int safe_cg_open(const char *const file, const int lineno,
+			const struct tst_cg_group *cg,
+			const char *const file_name,
+			enum cgroup_ctrl_indx ctrl_indx, int flags)
+{
+	const struct cgroup_file *const cfile =
+		cgroup_file_find(file, lineno, file_name);
+	struct cgroup_dir *const *dir;
+	const char *alias;
+	int fd, dismatch_ctrl = 0;
+
+	for_each_dir(cg, cfile->ctrl_indx, dir) {
+		alias = cgroup_file_alias(cfile, *dir);
+		if (!alias)
+			continue;
+
+		/*
+		 * For the file that exists on multiple v1 controllers (e.g. any cgroup.* file)
+		 * we need to ensure the v1 controller is belong to the specified controller.
+		 */
+		if ((*dir)->dir_root->ver == TST_CG_V1 && common_cgroup_file(alias, *dir)) {
+			if ((*dir)->ctrl_field == (uint32_t)1 << ctrl_indx) {
+				fd = safe_openat(file, lineno, (*dir)->dir_fd, alias, flags);
+				return fd;
+			}
+			dismatch_ctrl = (*dir)->ctrl_field;
+		} else {
+			fd = safe_openat(file, lineno, (*dir)->dir_fd, alias, flags);
+			return fd;
+		}
+	}
+
+	tst_brk_(file, lineno, TBROK, "%s is not in correct v1 controller expected %d but got %d",
+					file_name, 1 << ctrl_indx, dismatch_ctrl);
+	return -1;
+}
+
+void safe_cg_fchown(const char *const file, const int lineno,
+			const struct tst_cg_group *cg,
+			const char *const file_name,
+			enum cgroup_ctrl_indx ctrl_indx,
+			uid_t owner, gid_t group)
+{
+	const struct cgroup_file *const cfile =
+		cgroup_file_find(file, lineno, file_name);
+	struct cgroup_dir *const *dir;
+	const char *alias;
+	int dismatch_ctrl = 0;
+
+	for_each_dir(cg, cfile->ctrl_indx, dir) {
+		alias = cgroup_file_alias(cfile, *dir);
+		if (!alias)
+			continue;
+
+		/*
+		 * For the file that exists on multiple v1 controllers (e.g. any cgroup.* file)
+		 * we need to ensure the v1 controller is belong to the specified controller.
+		 */
+		if ((*dir)->dir_root->ver == TST_CG_V1 && common_cgroup_file(alias, *dir)) {
+			if ((*dir)->ctrl_field == (uint32_t)1 << ctrl_indx) {
+				safe_fchownat(file, lineno, (*dir)->dir_fd, alias, owner, group, 0);
+				return;
+			}
+			dismatch_ctrl = (*dir)->ctrl_field;
+		} else {
+			safe_fchownat(file, lineno, (*dir)->dir_fd, alias, owner, group, 0);
+			return;
+		}
+	}
+
+	tst_brk_(file, lineno, TBROK, "%s is not in correct v1 controller expected %d but got %d",
+					file_name, 1 << ctrl_indx, dismatch_ctrl);
+}
+
 void safe_cg_printf(const char *const file, const int lineno,
 			const struct tst_cg_group *cg,
 			const char *const file_name,
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
