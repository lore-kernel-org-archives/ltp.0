Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75662C4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 21:24:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 153BF3CAD4A
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 22:24:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 112363CABB7
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 22:24:35 +0100 (CET)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E34B8600BA6
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 22:24:34 +0100 (CET)
Received: by mail-pf1-x44a.google.com with SMTP id
 e12-20020a62aa0c000000b0056c12c0aadeso9804078pff.21
 for <ltp@lists.linux.it>; Wed, 02 Nov 2022 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=O4+wY4HBSG6rcigF5thPcSZebDxoUigCpav586Yi43s=;
 b=iTYHw/Jbwzj8Pi7FOFa/huD5LG4CeVbsGHq9Yxdg3pQusti3F09elwjin/dwezkdXa
 ZMaR7Be/8wCS8uFw66LvJ57XzunMdgWsHLQBto3WeMFRmUWgiqpWPdyOTQNogD/Dw0nH
 BtyHvY4LHwM2gqwdQpjTKy28c9SREvj99filZU32vRL4Wd5XTQamdf80f2KzWNZUBIM+
 UAWqKIgb+7Ch05x8RpDfaGBMNWfrDB5PlDt5fGzJ2PCHDjNudI72PEmurmU5vN7Rcoah
 QZNkyDktRo3ogzlVG9jcsX+TLNlBCvcxH9zQ4jkiXI5dquCATzcGRdX45S1h4hSiG95L
 UgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O4+wY4HBSG6rcigF5thPcSZebDxoUigCpav586Yi43s=;
 b=p1acFoklILyXQ+YFSFaLykdbSGfV6lDWY4BjBC12lpOPRyjczjLkqIYO0tslilYddi
 4m1mgmEIPeUDyPSSzCnMtARE79ZFLxg5DeuNfnMG0X2cAxik42nLy+zhypxKfaSi2ahY
 aIeCDLXzNvGxRJtrmzkTtnDpGHcEXLaUHdtvtiz2GioNkYOeENXGATaxbLIHod14lWbo
 V7u5Jz+kWYYOivVvrJwvxNsx7VxTSJibgnl8QKXCS4MjndKAL6djdSeq4qipYCZUqJ3H
 gb2KYrnjZj/zP5H/gck1SYHiSmQcjhSFHQ5bwdv7C7rzflT8n5fYCfbuxLMVgXJ2ZSaq
 hR5w==
X-Gm-Message-State: ACrzQf0cNg2k1s5qnC6sjdUPNaVTF5iPLC3iPoGv5zqW7sgLCSuNhlBq
 WyrALuGUZgUMDOLtd4qEmkgV1qwhmUYO6FNj4RxjPDQtoXbEPze56nRsn6aecsvNbi2yT7DAT90
 gxKzfWLYcGIUI86Rn20fZPllm8D7SOjlNKZQCl5QoSlXWVMiYP7iSf4FP
X-Google-Smtp-Source: AMsMyM6H/4tMIQ8E0v0JxklNC4P4mvxNfnAMRyZKVZ1NyJl/A9XZwOn3zO/DIV3Vdcy0vkpdiHaULFNsVu0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:c8f:b0:56d:465d:9fd5 with SMTP id
 a15-20020a056a000c8f00b0056d465d9fd5mr20955965pfv.38.1667424272870; Wed, 02
 Nov 2022 14:24:32 -0700 (PDT)
Date: Wed,  2 Nov 2022 21:24:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102212427.2642267-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_tmpdir: add TST_GET_TMPDIR_ROOT() to get the
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
 doc/user-guide.txt                            |  1 +
 include/old/old_tmpdir.h                      |  5 +++
 include/tst_test.h                            |  5 +++
 lib/tst_cgroup.c                              | 10 +----
 lib/tst_supported_fs_types.c                  |  5 +--
 lib/tst_tmpdir.c                              | 38 +++++++++----------
 .../security/filecaps/filecaps_common.h       |  5 +--
 testcases/kernel/syscalls/getcwd/getcwd02.c   | 27 ++-----------
 8 files changed, 39 insertions(+), 57 deletions(-)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 656df3118..8f2418df0 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -39,6 +39,7 @@ For running LTP network tests see `testcases/network/README.md`.
                           `PATH="$PATH:$LTPROOT/testcases/bin"`
 | 'TMPDIR'              | Base directory for template directory (C: '.needs_tmpdir = 1'
                           and others, which imply it, shell: 'TST_NEEDS_TMPDIR=1').
+                          Must be an absolute path (default: '/tmp').
 | 'TST_NO_CLEANUP'      | Disable running test cleanup (defined in 'TST_CLEANUP').
 |==============================================================================
 
diff --git a/include/old/old_tmpdir.h b/include/old/old_tmpdir.h
index 9c61172fd..3e33bf043 100644
--- a/include/old/old_tmpdir.h
+++ b/include/old/old_tmpdir.h
@@ -45,6 +45,11 @@ void tst_rmdir(void);
  */
 char *tst_get_tmpdir(void);
 
+/*
+ * Returns path to the test temporary directory root (TMPDIR).
+ */
+const char *tst_get_tmpdir_root(void);
+
 /*
  * Returns 1 if temp directory was created.
  */
diff --git a/include/tst_test.h b/include/tst_test.h
index a69965b95..597c3b4a9 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -362,6 +362,11 @@ void tst_set_max_runtime(int max_runtime);
  */
 char *tst_get_tmpdir(void);
 
+/*
+ * Returns path to the test temporary directory root (TMPDIR).
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
index 6e38ae977..d1419a1a4 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -122,6 +122,21 @@ char *tst_get_tmpdir(void)
 	return ret;
 }
 
+const char *tst_get_tmpdir_root(void)
+{
+	const char *env_tmpdir = getenv("TMPDIR");
+
+	if (!env_tmpdir)
+		env_tmpdir = TEMPDIR;
+
+	if (env_tmpdir[0] != '/') {
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
@@ -245,31 +260,16 @@ static int rmobj(const char *obj, char **errmsg)
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
 
-- 
2.38.1.273.g43a17bfeac-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
