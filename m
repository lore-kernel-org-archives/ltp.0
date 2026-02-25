Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DCDF55438
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 01:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771984295; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/6Jik/cgDYRmlxAyBghQ1ZdFENm7JYR9LZoNp22ms70=;
 b=OzG7e18FbrsRfHQDX4OxeTg3vyBpb+JbiABgnAmLraoNvyKwveE5KcbKMS74KSSNGBzUp
 5MtMQMXdDHRCB7BNl1gP4pZ0rhYdD6Gsh5ORCDR1hr4MFIklkQ25vIxTEamVK32CArcBeBd
 mMTGSLXi7avYKjSOE3gtAY2bKHQmOIE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6897A3C53B4
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 02:51:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24D003C2F5B
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 02:51:11 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B703200B6D
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 02:51:11 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4833115090dso59714935e9.3
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 17:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771984270; x=1772589070; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pugJPp4YqWcO1dG0z6wiJ4Z4jzrWC+BW2MRm0uu9ofU=;
 b=IZ3/AZkmh0C9IcrH4wZ5TpHYM4ivXmvsCV4hBPWLePjzHV1fWExXup6mb45LEAjudY
 cVB7qDrGQ/+oAVOhpRYE7DH0RXjHSs5Nl+0HxaCgmdFvg+uSUzGRtiQSwtBxACiauBqc
 bQPsz+tLshzCPhn0P2RbowgDJWK3M4llwET069L8nEFCNJL5gPImyHHPGoztFKGccRl0
 X+eqHc5QsvpTYGfDZNUc5mcLx/XoeH8ck0sT9HPnN582acx3+fsHAkxtisdH6o/VWZPW
 IWn3S2eUoMgpE45nBoYRVBjbZofQqAGIKApQKk9zXofE7Gc7N6YpMRYSr7FPpxUxo1da
 2IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771984270; x=1772589070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pugJPp4YqWcO1dG0z6wiJ4Z4jzrWC+BW2MRm0uu9ofU=;
 b=VKcQSOnEjYJ8HDQ9DUZIBoPYBA16ztlhurPXR45rmt3UYyk5qOEEwQVBxIeU7s72gx
 LN9gplMTo6McUHC63A1BOK7owfZ2gwyzA5iAyIKALEUaYgJZRpUAiIsvaYEROOfwtHfx
 7WmGjJ/nkoHpmAqfnD6KWecNH/XaZzWepWfHVltU6/OY7PxHFBwecABM34on+rk1kebO
 tR8RLraKB+C1XpyCEGDQHs4ExI4J7BSfwi5GhCVjTfrsqB05mM025X6dH26bkYo/cAt6
 IMWaZLO28ypz/n3MX1+0DoK0DTfK6m2bFpyU8y0C3zuRP7h0K3uteSSQq4+mfNI92Zwi
 pNIw==
X-Gm-Message-State: AOJu0YwkVnGOJ2cQcHJOn0wVt/U1rmqHhrngEsWVfCAl5pTRCKqB37n0
 FiM6aXyoIxUhUAMcn7iY86FaImDsp72D4obyI37t+rl8kwB+mVq7PBWqDx9H9EGK8PE5h6F+mr3
 uYTg=
X-Gm-Gg: ATEYQzzgDYDQO+GvBlm6kd/eyeKIKiUMkUOG2LHB1VQYY6+8wpC/SpwO66pZIuusFxz
 t/fkprbF9cPmhs1cUI/RPsAl+aIPX16XMEKwBkS26A7WJIT9VM4nAZa5W7fPHUjKrPgPQQ2OQh5
 VWEg6SzkzpvdFjBtheXsJwM9t/53gwxFK4ngl145GJC9emSPrJD26N2XvJsiIK05IatsQWS7itR
 dBfOh77i0JOm6MqwidLmODZRIAcz5f+KHVbLspLnthPBmmts0VzxfCyw328A9b9jz8pOb2EPCgj
 0chkMZMN74VpPAwkqB/WSAjL7NWhsml5PhUi/eVzi0krhS7u2nalwJgZrAiGFegj+4EOI/35Ulw
 lqrKEcBQ/Nw7Stj5QAE1l309M5rSEI8WBLxqKcdFluoDYJhaAshCRGRSq+bNQpME419UBw1QcaQ
 hP4BATL41lb1Y=
X-Received: by 2002:a05:600c:314a:b0:483:6bb1:117 with SMTP id
 5b1f17b1804b1-483a9603cd2mr206147755e9.32.1771984270257; 
 Tue, 24 Feb 2026 17:51:10 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-483bedcf177sm5486495e9.15.2026.02.24.17.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 17:51:09 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 25 Feb 2026 01:50:29 +0000
Message-ID: <20260225015044.19233-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125044057.20922-1-wegao@suse.com>
References: <20251125044057.20922-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Using sprintf without length checking in tst_tmpdir may lead to buffer overflow.
So in this patch use openat() instead of open().

Fixes: https://github.com/linux-test-project/ltp/issues/1241
Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_tmpdir.c | 88 ++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 48 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index b9924d85d..9b024a74e 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -101,7 +101,7 @@ static char test_start_work_dir[PATH_MAX];
 /* lib/tst_checkpoint.c */
 extern futex_t *tst_futexes;
 
-static int rmobj(const char *obj, char **errmsg);
+static int rmobjat(int dir_fd, const char *obj, char **errmsg);
 
 int tst_tmpdir_created(void)
 {
@@ -144,34 +144,37 @@ const char *tst_get_startwd(void)
 	return test_start_work_dir;
 }
 
-static int purge_dir(const char *path, char **errptr)
+static int purge_dirat(int dir_fd, const char *path, char **errptr)
 {
 	int ret_val = 0;
 	DIR *dir;
 	struct dirent *dir_ent;
-	char dirobj[PATH_MAX];
 	static char err_msg[PATH_MAX + 1280];
+	int subdir_fd;
 
-	/* Do NOT perform the request if the directory is "/" */
-	if (!strcmp(path, "/")) {
+	errno = 0;
+
+	/* Open the subdirectory using openat */
+	subdir_fd = openat(dir_fd, path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+	if (subdir_fd < 0) {
 		if (errptr) {
-			strcpy(err_msg, "Cannot purge system root directory");
+			snprintf(err_msg, sizeof(err_msg),
+				 "Cannot open subdirectory %s (via fd %d); errno=%d: %s",
+				 path, dir_fd, errno, tst_strerrno(errno));
 			*errptr = err_msg;
 		}
-
 		return -1;
 	}
 
-	errno = 0;
-
-	/* Open the directory to get access to what is in it */
-	if (!(dir = opendir(path))) {
+	dir = fdopendir(subdir_fd);
+	if (!dir) {
 		if (errptr) {
-			sprintf(err_msg,
-				"Cannot open directory %s; errno=%d: %s",
-				path, errno, tst_strerrno(errno));
+			snprintf(err_msg, sizeof(err_msg),
+				 "Cannot open directory stream for %s (via fd %d); errno=%d: %s",
+				 path, dir_fd, errno, tst_strerrno(errno));
 			*errptr = err_msg;
 		}
+		close(subdir_fd);
 		return -1;
 	}
 
@@ -183,8 +186,7 @@ static int purge_dir(const char *path, char **errptr)
 			continue;
 
 		/* Recursively remove the current entry */
-		sprintf(dirobj, "%s/%s", path, dir_ent->d_name);
-		if (rmobj(dirobj, errptr) != 0)
+		if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0)
 			ret_val = -1;
 	}
 
@@ -192,63 +194,53 @@ static int purge_dir(const char *path, char **errptr)
 	return ret_val;
 }
 
-static int rmobj(const char *obj, char **errmsg)
+static int rmobjat(int dir_fd, const char *obj, char **errmsg)
 {
 	int ret_val = 0;
 	struct stat statbuf;
 	static char err_msg[PATH_MAX + 1280];
 	int fd;
 
-	fd = open(obj, O_DIRECTORY | O_NOFOLLOW);
+	fd = openat(dir_fd, obj, O_DIRECTORY | O_NOFOLLOW);
 	if (fd >= 0) {
 		close(fd);
-		ret_val = purge_dir(obj, errmsg);
+		ret_val = purge_dirat(dir_fd, obj, errmsg);
 
 		/* If there were problems removing an entry, don't attempt to
 		   remove the directory itself */
 		if (ret_val == -1)
 			return -1;
 
+		int flags = AT_REMOVEDIR;
+
 		/* Get the link count, now that all the entries have been removed */
-		if (lstat(obj, &statbuf) < 0) {
+		if (fstatat(dir_fd, obj, &statbuf, AT_SYMLINK_NOFOLLOW) < 0) {
 			if (errmsg != NULL) {
-				sprintf(err_msg,
-					"lstat(%s) failed; errno=%d: %s", obj,
+				snprintf(err_msg, sizeof(err_msg),
+					"fstatat(%s) failed; errno=%d: %s", obj,
 					errno, tst_strerrno(errno));
 				*errmsg = err_msg;
 			}
 			return -1;
 		}
 
-		/* Remove the directory itself */
-		if (statbuf.st_nlink >= 3) {
-			/* The directory is linked; unlink() must be used */
-			if (unlink(obj) < 0) {
-				if (errmsg != NULL) {
-					sprintf(err_msg,
-						"unlink(%s) failed; errno=%d: %s",
-						obj, errno, tst_strerrno(errno));
-					*errmsg = err_msg;
-				}
-				return -1;
-			}
-		} else {
-			/* The directory is not linked; remove() can be used */
-			if (remove(obj) < 0) {
-				if (errmsg != NULL) {
-					sprintf(err_msg,
+		if (statbuf.st_nlink >= 3)
+			flags = 0;
+
+		if (unlinkat(dir_fd, obj, flags) < 0) {
+			if (errmsg != NULL) {
+				snprintf(err_msg, sizeof(err_msg),
 						"remove(%s) failed; errno=%d: %s",
 						obj, errno, tst_strerrno(errno));
-					*errmsg = err_msg;
-				}
-				return -1;
+				*errmsg = err_msg;
 			}
+			return -1;
 		}
 	} else {
-		if (unlink(obj) < 0) {
+		if (unlinkat(dir_fd, obj, 0) < 0) {
 			if (errmsg != NULL) {
-				sprintf(err_msg,
-					"unlink(%s) failed; errno=%d: %s", obj,
+				snprintf(err_msg, sizeof(err_msg),
+					"unlinkat(%s) failed; errno=%d: %s", obj,
 					errno, tst_strerrno(errno));
 				*errmsg = err_msg;
 			}
@@ -305,7 +297,7 @@ void tst_tmpdir(void)
 		tst_resm(TERRNO, "%s: chdir(%s) failed", __func__, TESTDIR);
 
 		/* Try to remove the directory */
-		if (rmobj(TESTDIR, &errmsg) == -1) {
+		if (rmobjat(AT_FDCWD, TESTDIR, &errmsg) == -1) {
 			tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
 				 __func__, TESTDIR, errmsg);
 		}
@@ -343,7 +335,7 @@ void tst_rmdir(void)
 	/*
 	 * Attempt to remove the "TESTDIR" directory, using rmobj().
 	 */
-	if (rmobj(TESTDIR, &errmsg) == -1) {
+	if (rmobjat(AT_FDCWD, TESTDIR, &errmsg) == -1) {
 		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
 			 __func__, TESTDIR, errmsg);
 	}
@@ -353,7 +345,7 @@ void tst_purge_dir(const char *path)
 {
 	char *err;
 
-	if (purge_dir(path, &err))
+	if (purge_dirat(AT_FDCWD, path, &err))
 		tst_brkm(TBROK, NULL, "%s: %s", __func__, err);
 }
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
