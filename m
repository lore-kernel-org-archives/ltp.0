Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593EAECAAA1
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 00:09:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD0AB3CAC41
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 01:09:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC4DA3CA115
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 01:08:46 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C942C600477
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 01:08:45 +0100 (CET)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-348608c1cd3so116134927b3.10
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 17:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h9zMf/tbUEcv6FrRIDeufVReO+3UHiEE8gaCcIoUNZk=;
 b=oeg0CBXqUlvXpebhR0owiKCAlcESqNZ9ZdHLQfndgxvoF2k72ACFfBtDO0f0lbkG8Q
 Pr9GnczPTcYFTZaErAtNk1LadsCgFMoWFM9DshXCLIvbUlPRpBXQbdysVRHi+bS15Vzw
 YVF8VN1Py54R2sYnjwZeiyqRD4i6C7i5IzHKSieUToeEhoN0nFfTfedqy2fpQZSf/knk
 RpPs7CdufXY0p/IuziWkMHacaSX/tQorjvkg6uTeMxyhunAf9pbi68thK3FBRX68ubZr
 UMzWdZJSPZs74GNLQYtz0m1vecMK+yt5flnFnKf9Ojq4jhTHnlg+37Cuy5nG9o/qffV+
 A61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h9zMf/tbUEcv6FrRIDeufVReO+3UHiEE8gaCcIoUNZk=;
 b=LRhC5HksK+lXKIbY+1CRea2Jur+flS53cXD6r5ngslehCMbIR/Oq3VyHoR4FsLfCGG
 qyeJ9z1Wt6f34piIh6T+7wp0KZMNZd7r+e1gZCdw1aHC36HBsJrXIYfrlYHhbDM3Fjtn
 r+Kp/gI5wCpdGyjFvbc2fUq6Qbrhtnl5jkECWmWHukOuJT6pHsduKgqHsB1EBW5eW+yw
 bci0y95bXezcuvjiQ8Xsw47fohNJGtH0bfrC3duSThxDc0OKuIqvHrHHzHEonxEhxnZ8
 8whE6iUzFaALrM3jEIwql4L9N6y57NJ24Dn0DaglY+p63arFkGgzRI0mbmR3RFxvXUCb
 Vw/A==
X-Gm-Message-State: ACrzQf2tuDvRnEADa5N4B4T4wzxIbxkwYL735r6VTBJFaJXC4sPKr0wz
 wPQMmJT3eu3HzSy+HKpO7iC5w2SOioyLy9ayysXOl7NfqvZQ0ybGQyt/NL+EcO3VGTw3PEOSLD2
 AoLc5U+7fhsFqSlNF6TRJhyfjH9Ure7fMl8oYMR4ykJzB54n8F+CjBD1w
X-Google-Smtp-Source: AMsMyM7biKg3JweIuBVLGWGUKOQrpFllFFjJ2a5CBteEL0aFGYb4+CgOjW2TXZAGSzDaZLCTdDJbWnubV4g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr16521447ybu.310.1667261324315; Mon, 31
 Oct 2022 17:08:44 -0700 (PDT)
Date: Tue,  1 Nov 2022 00:08:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221101000841.1207999-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] tst_tmpdir: add TST_GET_TMPDIR_ROOT() to get the
 TMPDIR env var
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/old/old_tmpdir.h                      |  5 +++
 include/tst_test.h                            |  5 +++
 lib/tst_cgroup.c                              | 10 +----
 lib/tst_supported_fs_types.c                  |  5 +--
 lib/tst_tmpdir.c                              | 45 +++++++++++--------
 .../security/filecaps/filecaps_common.h       |  5 +--
 testcases/kernel/syscalls/getcwd/getcwd02.c   | 27 ++---------
 .../open_posix_testsuite/include/tempfile.h   | 10 +----
 8 files changed, 47 insertions(+), 65 deletions(-)

diff --git a/include/old/old_tmpdir.h b/include/old/old_tmpdir.h
index 9c61172fd..b1cf79344 100644
--- a/include/old/old_tmpdir.h
+++ b/include/old/old_tmpdir.h
@@ -45,6 +45,11 @@ void tst_rmdir(void);
  */
 char *tst_get_tmpdir(void);
 
+/*
+ * Returns path to the test temporary directory root.
+ */
+const char *tst_get_tmpdir_root(void);
+
 /*
  * Returns 1 if temp directory was created.
  */
diff --git a/include/tst_test.h b/include/tst_test.h
index a69965b95..26a5ec752 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -362,6 +362,11 @@ void tst_set_max_runtime(int max_runtime);
  */
 char *tst_get_tmpdir(void);
 
+/*
+ * Returns path to the test temporary directory root.
+ */
+const char *tst_get_tmpdir_root(void);
+
 /*
  * Validates exit status of child processes
  */
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 6642d6be4..50699bc63 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -645,10 +645,7 @@ static void cgroup_mount_v2(void)
 {
 	int ret;
 	char mnt_path[PATH_MAX];
-	const char *tmpdir = getenv("TMPDIR");
-
-	if (!tmpdir)
-		tmpdir = "/tmp";
+	const char *tmpdir = tst_get_tmpdir_root();
 
 	sprintf(mnt_path, "%s/%s%s",
 		tmpdir, cgroup_mount_ltp_prefix, cgroup_v2_ltp_mount);
@@ -698,10 +695,7 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
 {
 	char mnt_path[PATH_MAX];
 	int made_dir = 0;
-	const char *tmpdir = getenv("TMPDIR");
-
-	if (!tmpdir)
-		tmpdir = "/tmp";
+	const char *tmpdir = tst_get_tmpdir_root();
 
 	if (ctrl->ctrl_indx == CTRL_BLKIO && controllers[CTRL_IO].ctrl_root) {
 		tst_res(TCONF,
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 7781f94c3..d4911fa3b 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -74,14 +74,11 @@ int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist)
 static enum tst_fs_impl has_kernel_support(const char *fs_type)
 {
 	static int fuse_supported = -1;
-	const char *tmpdir = getenv("TMPDIR");
+	const char *tmpdir = tst_get_tmpdir_root();
 	char buf[128];
 	char template[PATH_MAX];
 	int ret;
 
-	if (!tmpdir)
-		tmpdir = "/tmp";
-
 	snprintf(template, sizeof(template), "%s/mountXXXXXX", tmpdir);
 	if (!mkdtemp(template))
 		tst_brk(TBROK | TERRNO, "mkdtemp(%s) failed", template);
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 6e38ae977..9c90f481a 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -122,6 +122,28 @@ char *tst_get_tmpdir(void)
 	return ret;
 }
 
+const char *tst_get_tmpdir_root(void)
+{
+	char *c;
+	const char *env_tmpdir = getenv("TMPDIR");
+
+	if (!env_tmpdir)
+		env_tmpdir = TEMPDIR;
+
+	c = strchr(env_tmpdir, '/');
+	/*
+	 * We force environment variable TMPDIR to be an absolute pathname,
+	 * which does not make much sense, but it will greatly simplify code in
+	 * tst_rmdir().
+	 */
+	if (c != env_tmpdir) {
+		tst_brkm(TBROK, NULL, "You must specify an absolute "
+				"pathname for environment variable TMPDIR");
+		return NULL;
+	}
+	return env_tmpdir;
+}
+
 const char *tst_get_startwd(void)
 {
 	return test_start_work_dir;
@@ -245,31 +267,16 @@ static int rmobj(const char *obj, char **errmsg)
 void tst_tmpdir(void)
 {
 	char template[PATH_MAX];
-	char *env_tmpdir;
-	char *errmsg, *c;
+	const char *env_tmpdir;
+	char *errmsg;
 
 	/*
 	 * Create a template for the temporary directory.  Use the
 	 * environment variable TMPDIR if it is available, otherwise
 	 * use our default TEMPDIR.
 	 */
-	env_tmpdir = getenv("TMPDIR");
-	if (env_tmpdir) {
-		c = strchr(env_tmpdir, '/');
-		/*
-		 * Now we force environment variable TMPDIR to be an absolute
-		 * pathname, which dose not make much sense, but it will
-		 * greatly simplify code in tst_rmdir().
-		 */
-		if (c != env_tmpdir) {
-			tst_brkm(TBROK, NULL, "You must specify an absolute "
-				 "pathname for environment variable TMPDIR");
-			return;
-		}
-		snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", env_tmpdir, TCID);
-	} else {
-		snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", TEMPDIR, TCID);
-	}
+	env_tmpdir = tst_get_tmpdir_root();
+	snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", env_tmpdir, TCID);
 
 	/* Make the temporary directory in one shot using mkdtemp. */
 	if (mkdtemp(template) == NULL) {
diff --git a/testcases/kernel/security/filecaps/filecaps_common.h b/testcases/kernel/security/filecaps/filecaps_common.h
index 920f6ac6a..0f011868e 100644
--- a/testcases/kernel/security/filecaps/filecaps_common.h
+++ b/testcases/kernel/security/filecaps/filecaps_common.h
@@ -1,5 +1,6 @@
 #include <limits.h>
 #include <stdlib.h>
+#include <old_tmpdir.h>
 
 static char *fifofile;
 
@@ -9,10 +10,8 @@ static const char *get_caps_fifo(void)
 		fifofile = getenv("FIFOFILE");
 
 		if (!fifofile) {
-			const char *tmpdir = getenv("TMPDIR");
+			const char *tmpdir = tst_get_tmpdir_root();
 
-			if (!tmpdir)
-				tmpdir = "/tmp";
 			fifofile = malloc(PATH_MAX);
 			snprintf(fifofile, PATH_MAX, "%s/caps_fifo", tmpdir);
 		}
diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index e843a4896..cb111a698 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -42,28 +42,6 @@ static int dir_exists(const char *dirpath)
 	return 0;
 }
 
-static const char *get_tmpdir_path(void)
-{
-	char *tmpdir = "/tmp";
-
-	if (dir_exists(tmpdir))
-		goto done;
-
-	/* fallback to $TMPDIR */
-	tmpdir = getenv("TMPDIR");
-	if (!tmpdir)
-		tst_brk(TBROK | TERRNO, "Failed to get $TMPDIR");
-
-	if (tmpdir[0] != '/')
-		tst_brk(TBROK, "$TMPDIR must be an absolute path");
-
-	if (!dir_exists(tmpdir))
-		tst_brk(TBROK | TERRNO, "TMPDIR '%s' doesn't exist", tmpdir);
-
-done:
-	return tmpdir;
-}
-
 static void verify_getcwd(unsigned int n)
 {
 	struct t_case *tc = &tcases[n];
@@ -92,7 +70,10 @@ end:
 
 static void setup(void)
 {
-	const char *tmpdir = get_tmpdir_path();
+	const char *tmpdir = tst_get_tmpdir_root();
+
+	if (!dir_exists(tmpdir))
+		tst_brk(TBROK | TERRNO, "TMPDIR '%s' doesn't exist", tmpdir);
 
 	SAFE_CHDIR(tmpdir);
 
diff --git a/testcases/open_posix_testsuite/include/tempfile.h b/testcases/open_posix_testsuite/include/tempfile.h
index 0fd27cee3..63e179baf 100644
--- a/testcases/open_posix_testsuite/include/tempfile.h
+++ b/testcases/open_posix_testsuite/include/tempfile.h
@@ -6,14 +6,8 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <limits.h>
+#include <old_tmpdir.h>
 
 #define PTS_GET_TMP_FILENAME(target, prefix) \
     snprintf(target, sizeof(target), \
-    "%s/" prefix "_pid-%d", pts_get_tmpdir(), getpid());
-
-static inline const char *pts_get_tmpdir(void)
-{
-    const char *tmpdir_env;
-    tmpdir_env = getenv("TMPDIR");
-    return tmpdir_env ? tmpdir_env : "/tmp";
-}
+    "%s/" prefix "_pid-%d", tst_get_tmpdir_root(), getpid());
-- 
2.38.1.273.g43a17bfeac-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
