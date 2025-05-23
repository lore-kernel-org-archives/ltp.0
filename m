Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FECC54ED0
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747991421; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Ufy6FY882RUDlko6uidOGUy6YXYEc4AYWR19Y6Ak3xU=;
 b=Yo8760tDA0GDmTsE0fuZVDw+zOwPRFuwNMZNO8Zz81+pduubG653fdC/Bcu3JzBucFyjw
 8FAi2DBcQ9UqzsU+RnQ4/QVXANBwlVdKb+9AElUxtYmriCF7sK87KWXeph8l8vsoTOjS3xD
 cAHsTDihy4CKf3E3qYbjdslralnesvI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7890B3CC8DE
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 11:10:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1839C3CC8C0
 for <ltp@lists.linux.it>; Fri, 23 May 2025 11:09:58 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 88F7D1400B70
 for <ltp@lists.linux.it>; Fri, 23 May 2025 11:09:57 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a367ec7840so4250881f8f.2
 for <ltp@lists.linux.it>; Fri, 23 May 2025 02:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747991397; x=1748596197; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xk1+65sKSefIZwYV2pzwep/x7jTNd601InXlNsj+xEs=;
 b=Rg9ItP7STUwBNRWTPgisQpOnJtM+u1crUWdTV0cZNc18t8wNBCFMXE0g68EtR/DIpv
 J8Dlod7xRqFVbAannLeCZAPgV136jl+Fn1GflDrgC1S7U+yD8paGXa+XqTD0qQRnERaS
 uxxMpRw9KooIO6guZI4FrUGNlUR6ZD+GeXG7XeaFBhH84qhTjnGGatd/86yFyJCZKJJ2
 iFudhJM8e7G5b7K2nep8SB7caUa5Ke7YbHyrnj08d9hk7vWdE9LRr2Q3dCa2D1JyjvdI
 mSmPAAqilwVtv49nzM/44Vivt2PMso+VtAcsDuAd1md9jXWe1h/mFcZjbo+so+F0oyyk
 7KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747991397; x=1748596197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xk1+65sKSefIZwYV2pzwep/x7jTNd601InXlNsj+xEs=;
 b=mjAs991L3JVNki9ikJlQ5sUs5DWi/u5qVLt28SbDbzEIRERIDJnwUyVza08mXNkMDl
 6RtJjUh9KlIEBJuBL8Y6FviCN8lf062BISTwD67oTWbL7vY2bwuPqXxqvTQKVEx2FZYv
 tNV+YfszzI0WFiNA9QwsoDT/n97+t6nqBJgbNlkE7ELG8nxlVCUTVgLCcEfGu4niPKCv
 gWweUS0TVeg9ynvfOQMEWimsBTrKARYdhdYaapGXy4AQLw68TpoEZV07Mhh7ljm5cNhY
 8pvSLQAI/tFdpKdaKLVHZXLGfQ7gH7hvy7l0/l3ZonvgkmoSmxgEjaL8mcKZnmhhl1Vo
 rTsg==
X-Gm-Message-State: AOJu0Yyqdo1QYWRcSgy5ieSLzUMt/nVNRQnjnO5vhZ6lXJqZNSqGKciB
 AZ3JS3RxWv0mNIlYIMyP01sqAbcyQ+kMQZ8q+P609KQtyO5v1wGraaCv0oecsKY3kL1PQNlCtzy
 EE2I=
X-Gm-Gg: ASbGncsZjULpPvyjB4Hms1Wj+jlYjuyF1JGdWp3bYWJcdm2w84r4MZy5+ISBcaaiRTr
 DjRvg3FeoPd/zNfbCN/7+zDvCBcYg0TcvPirR13GZnOr9bYZI7ktfjjaMgPKe+CD0nTy9K3+n5n
 yL/d9dUJLKDBBwHjOXGYZOXpCpepyNuol8C1nJu2CfP2FImauZjrL+5uCTfTc59Z/unuLt3lShe
 d/68qgf/IT8upoDZzz/PeHUD7rPhn7/PW30p7vbLumHmeub3lHVuOrIfWYjeLYw+e7AitTT92hM
 P8bniFPDc7RL25VgoRiTq67njVEAPsbvLakT3JV0
X-Google-Smtp-Source: AGHT+IFNWgYDmZgywvblqHHVPnuNVDK4UMDTZ4MGPFYMy7KhSP9WScMN1hNUi3RqXfA4ZrCFZ+xt1w==
X-Received: by 2002:a5d:5f88:0:b0:3a3:7255:dfd0 with SMTP id
 ffacd0b85a97d-3a37255e0a5mr17207452f8f.17.1747991396631; 
 Fri, 23 May 2025 02:09:56 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30f365e545asm6866243a91.31.2025.05.23.02.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 02:09:56 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 23 May 2025 17:09:44 -0400
Message-ID: <20250523210950.1019560-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521141655.3202240-1-wegao@suse.com>
References: <20250521141655.3202240-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
 lib/tst_tmpdir.c | 122 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 44 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 6ed2367b9..bcb9534c5 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -101,7 +101,7 @@ static char test_start_work_dir[PATH_MAX];
 /* lib/tst_checkpoint.c */
 extern futex_t *tst_futexes;
 
-static int rmobj(const char *obj, char **errmsg);
+static int rmobjat(int dir_fd, const char *obj, char **errmsg);
 
 int tst_tmpdir_created(void)
 {
@@ -149,8 +149,8 @@ static int purge_dir(const char *path, char **errptr)
 	int ret_val = 0;
 	DIR *dir;
 	struct dirent *dir_ent;
-	char dirobj[PATH_MAX];
 	static char err_msg[PATH_MAX + 1280];
+	int dir_fd = -1;
 
 	/* Do NOT perform the request if the directory is "/" */
 	if (!strcmp(path, "/")) {
@@ -167,7 +167,7 @@ static int purge_dir(const char *path, char **errptr)
 	/* Open the directory to get access to what is in it */
 	if (!(dir = opendir(path))) {
 		if (errptr) {
-			sprintf(err_msg,
+			snprintf(err_msg, sizeof(err_msg),
 				"Cannot open directory %s; errno=%d: %s",
 				path, errno, tst_strerrno(errno));
 			*errptr = err_msg;
@@ -175,6 +175,68 @@ static int purge_dir(const char *path, char **errptr)
 		return -1;
 	}
 
+	dir_fd = dirfd(dir);
+	if (dir_fd == -1) {
+		closedir(dir);
+		if (errptr) {
+			snprintf(err_msg, sizeof(err_msg),
+				"Cannot get file descriptor for directory %s; errno=%d: %s",
+				path, errno, tst_strerrno(errno));
+			*errptr = err_msg;
+		}
+		return -1;
+	}
+
+	/* Loop through the entries in the directory, removing each one */
+	for (dir_ent = readdir(dir); dir_ent; dir_ent = readdir(dir)) {
+		/* Don't remove "." or ".." */
+		if (!strcmp(dir_ent->d_name, ".")
+		    || !strcmp(dir_ent->d_name, ".."))
+			continue;
+
+		/* Recursively remove the current entry */
+		if (rmobjat(dir_fd, dir_ent->d_name, errptr) != 0)
+			ret_val = -1;
+	}
+
+	closedir(dir);
+	return ret_val;
+}
+
+static int purge_dirat(int dir_fd, const char *path, char **errptr)
+{
+	int ret_val = 0;
+	DIR *dir;
+	struct dirent *dir_ent;
+	static char err_msg[PATH_MAX + 1280];
+	int subdir_fd;
+
+	errno = 0;
+
+	/* Open the subdirectory using openat */
+	subdir_fd = openat(dir_fd, path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+	if (subdir_fd < 0) {
+		if (errptr) {
+			snprintf(err_msg, sizeof(err_msg),
+				 "Cannot open subdirectory %s (via fd %d); errno=%d: %s",
+				 path, dir_fd, errno, tst_strerrno(errno));
+			*errptr = err_msg;
+		}
+		return -1;
+	}
+
+	dir = fdopendir(subdir_fd);
+	if (!dir) {
+		if (errptr) {
+			snprintf(err_msg, sizeof(err_msg),
+				 "Cannot open directory stream for %s (via fd %d); errno=%d: %s",
+				 path, dir_fd, errno, tst_strerrno(errno));
+			*errptr = err_msg;
+		}
+		close(subdir_fd);
+		return -1;
+	}
+
 	/* Loop through the entries in the directory, removing each one */
 	for (dir_ent = readdir(dir); dir_ent; dir_ent = readdir(dir)) {
 		/* Don't remove "." or ".." */
@@ -183,8 +245,7 @@ static int purge_dir(const char *path, char **errptr)
 			continue;
 
 		/* Recursively remove the current entry */
-		sprintf(dirobj, "%s/%s", path, dir_ent->d_name);
-		if (rmobj(dirobj, errptr) != 0)
+		if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0)
 			ret_val = -1;
 	}
 
@@ -192,63 +253,36 @@ static int purge_dir(const char *path, char **errptr)
 	return ret_val;
 }
 
-static int rmobj(const char *obj, char **errmsg)
+static int rmobjat(int dir_fd, const char *obj, char **errmsg)
 {
 	int ret_val = 0;
-	struct stat statbuf;
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
 
-		/* Get the link count, now that all the entries have been removed */
-		if (lstat(obj, &statbuf) < 0) {
+		if (unlinkat(dir_fd, obj, AT_REMOVEDIR) < 0) {
 			if (errmsg != NULL) {
-				sprintf(err_msg,
-					"lstat(%s) failed; errno=%d: %s", obj,
-					errno, tst_strerrno(errno));
-				*errmsg = err_msg;
-			}
-			return -1;
-		}
-
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
@@ -305,7 +339,7 @@ void tst_tmpdir(void)
 		tst_resm(TERRNO, "%s: chdir(%s) failed", __func__, TESTDIR);
 
 		/* Try to remove the directory */
-		if (rmobj(TESTDIR, &errmsg) == -1) {
+		if (rmobjat(0, TESTDIR, &errmsg) == -1) {
 			tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
 				 __func__, TESTDIR, errmsg);
 		}
@@ -343,7 +377,7 @@ void tst_rmdir(void)
 	/*
 	 * Attempt to remove the "TESTDIR" directory, using rmobj().
 	 */
-	if (rmobj(TESTDIR, &errmsg) == -1) {
+	if (rmobjat(0, TESTDIR, &errmsg) == -1) {
 		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
 			 __func__, TESTDIR, errmsg);
 	}
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
