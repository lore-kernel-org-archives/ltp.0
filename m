Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE3ACFD364
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 04:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764045685; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=us/L8OPSKrsx47hjdEhMhdy4Pyd8NFSaIWmK8uKplvM=;
 b=VC93i1ZyL8urUVwYzRVuAhH5mGEb/X7fBKSSPn2357vqmJX2jAidJevIvKSFBd26M44Hb
 mD0DoxRCQxYn6rYk5Sk7l+iwfx0L5otDUdS+3kZzuZyRK5+h88XF2v36GdNPLmtgRSft+7X
 e3Jc4RozHO4yoaCT5rSGy71xDrO0k4w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 461643CAEFD
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 05:41:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 928BC3C56DC
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 05:41:05 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D1061A003C4
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 05:41:04 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so2498174f8f.3
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 20:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1764045664; x=1764650464; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyh8TOEbXzqmLu1EQPC+0dmwThCmc85uwYc1ihlRBgs=;
 b=Iy0ig4zGsEut6huBo+Dq507IAmy6jxtq5nf8ofJ0u3aMmLNoFsex6mAWWpmUY0lgUf
 xavQj4O+PS7yjBXzJzVOsVKs113/ypcY2RTmXWAR9/xhJ8GrSzFbLZM7hsMrManiOqyq
 WIw39QrlkkKL6bCsmZ/3Bgj7b1UxBRRspeP0l2gJFCsHwqmE42V6k203btHFgEwuYtaX
 8MbsB9kHPRWJUNTE6rSvleq8by7p1kSnCIEqXmK+WOYvZ7uGInEo1sbGIBT/Cj90ToRp
 +Qb2faZd4KLVF1k5p6Wq956J6DC6QnxgVXC2ZdHh75qSQxoF+YJdC+UAExoFlaQMT7A0
 wQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764045664; x=1764650464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oyh8TOEbXzqmLu1EQPC+0dmwThCmc85uwYc1ihlRBgs=;
 b=ir3c34j6yaKxnMRA/5y8VzhJx12+whIQazm0hmlZvrmf+xeYRNTjxV72dDTllQu2tm
 s6ADpA/LkSzGlQ4fmPPeK8fF7ZzP/D7UKEd0CNSb8P3ytdmWDTwp++IoRRYnwbBsu9m+
 XHNgsl+S7ebPWaLO63afu3xPAoAouUFRLbN3L1GjUZU4O+lHxhvfGTxnSJKv67NvRnoZ
 SuMRRIPqGk9aPqmXnxDyzA++LU66YWKm7fm/Xoe2Oo1mL+rbX0JOWhs71ctSNw58B6Wv
 qK93QSnBTC6Oim8AOGmNMritrZfsJWaOHkV34IHK8Wg4VR2a/FG3oaWD1lIhSmsmd76j
 Vx+A==
X-Gm-Message-State: AOJu0YxNlJn1UuenWVclkFFGNGhuKNDQrWzX1VPJnHOYi51fCqvO6xac
 K9O1XgnAZMSwdr2UK9fjfHE7FPFIrIIY8R/S14vUoMfX0UO7HJ1YMoJp29gtXj7zfT2ZW2B3ZbW
 oZ84=
X-Gm-Gg: ASbGnct6W3wmeQqu4hb/VItEB912lkFY7nTjJ/jTk2TGXZI5XP4ZyKdEpbv1ljg95dh
 CmiUvEZpcMv1vTmJsFnIMHzrdhzasW1gq/+e1U3K6tCwDmwPBvhP5TtRJrzkn/RA3vMlspSDtQH
 mnM6mmTH0SV73Q7pJTCZpIa1oFMBY35UjPNtnJuita6Cj8orSu6mlQkz5Zd0q7JaciqlM7wkM+M
 TbDrR/3tO6OQn94Y2cQ3XNRzmOi0h6BEtkbZdH7aUxMstIzVWg9T9CTiSzkcrDJm7AYxI+7NDrw
 iHSwK1YqPyci7V49M8gC+GuZ3jzkndIoC9RhHAtjsQ1tLvGLQt/N3bgjV/n57dxAGnKqinxnwON
 E4y6FZVttDoSHL2CHmR0ZUsA1QCvWsq0Iq3KRqTauR/I5uK7agnZ/iryEPc6qTJ/1TqzDo3nrOP
 U=
X-Google-Smtp-Source: AGHT+IHOx7sqIJFInlgl78OlLu6ahUqkMqCexeHj9znsHUw3DNvBTkM+rTQ+QQ2NfB0V/YJ/f8mMDw==
X-Received: by 2002:a5d:5d10:0:b0:42b:496e:517c with SMTP id
 ffacd0b85a97d-42cc1ac9146mr14472617f8f.13.1764045663742; 
 Mon, 24 Nov 2025 20:41:03 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cbd764dbesm28525020f8f.27.2025.11.24.20.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 20:41:03 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 25 Nov 2025 04:40:42 +0000
Message-ID: <20251125044057.20922-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523210950.1019560-1-wegao@suse.com>
References: <20250523210950.1019560-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_tmpdir.c | 84 ++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 6ed2367b9..89b216df9 100644
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
 
@@ -192,25 +194,27 @@ static int purge_dir(const char *path, char **errptr)
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
 				sprintf(err_msg,
 					"lstat(%s) failed; errno=%d: %s", obj,
@@ -220,35 +224,23 @@ static int rmobj(const char *obj, char **errmsg)
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
