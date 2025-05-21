Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6727C3DA6D
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 02:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747793849; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Yo7bA5/1gY7Ywt+mbN/2l9U1KvqhC6OIoBPkM7q/Fkg=;
 b=VwgYmlQn69IdsiEh2Bh9N4JG2znpjPPC9reRlh2nNT9Gr7QsLIm4/Dg+bUbmOsL+LbSoP
 GiHuV9GPrE80zxo87Hg2ND9++pS+ZQs1Go2mzRiLCnT1ArhaN3Fo/8fCsMDIiNLrUfJDT5h
 9GoxhRe1mK6+yZx2D8YGdn2oy9dKSKs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C8F73CC7AB
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 04:17:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BC693CC15D
 for <ltp@lists.linux.it>; Wed, 21 May 2025 04:17:05 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9BDF61A0239A
 for <ltp@lists.linux.it>; Wed, 21 May 2025 04:17:04 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so50072415e9.1
 for <ltp@lists.linux.it>; Tue, 20 May 2025 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747793823; x=1748398623; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CHgLkJolrW9q+1FNtl0c/IazgCDSG8DrqtJuzigFvU0=;
 b=H8tFZl6qrSemEn4KeEwtuPHZ3qsPEGFdT7ZAXanozD4EJYjXa51hhYRw+T1x1hz3HC
 j3weSYkqSkh9DF/pHlmOnoABIzVw3XM74QX249BsnDJEasMuKQCxpIxgZoQ92z4qUF+f
 dyyHG1a4FXm17GcJ7MVJblDiZ3IHKMigqwkBQ7uExMV/GiPmAWICXy+70oBkN71GuCGv
 QMr0dmgVTLiD5psmAMRKiWIumX13EslA58jkE+2DlDSAkmmqVutJhCj1OklZz8CMvNxN
 724BrJMQn1uU/tE4bp5ULg5/xqc5Y6UXVUh7GS86orWghk5IeDOWzF7Y8Zonvyl7zCe3
 gWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747793823; x=1748398623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CHgLkJolrW9q+1FNtl0c/IazgCDSG8DrqtJuzigFvU0=;
 b=vPtl3wFBRKgjylkLjwBU2bm0QpmbWi1qPQsxFSeBV7Bv2uRfU4jT5oE+xutMRdmQog
 vng5Cv5dIVpUIUwEsDJvnyjs/N7BLmd2MPSRS4w60tWpA9dQNrlxzwIOF4InvhT/7qUp
 CWzEgebQF9xiD4OO3BxnSiFT7IOtZpM//KxgwS6tG3rV+T9iif23TBFEVWmWMFiXFfLZ
 ODsmQC92bpGOKsoK5Gy0zzqLux6YaZ/+52GcIyEoU1fogfxNUCme9yjga+AN6dq+SuBy
 5TUcZM6mwrW5HoQMBO877Lg7dWIsGMOBAmmTbWjcEdQFnKs6+gqnonxbu2+wjj4vVxTR
 1/tw==
X-Gm-Message-State: AOJu0YxhflMSr04GAlM01890ENsqnALEDbe7Te3x9fIEJRkc81fprYiX
 mvssXNAVStNBgngLuORtY45Fhes1D49OgsDVwfoPXlLEX7kZdv4WVos5oqSk6pCqN06GiPGxBUg
 g1f8=
X-Gm-Gg: ASbGncuIlWFRk+K1SzfFHADtLQiOz6zRssg/fzK3j2ZWRTt6NfmmAQqQIOhrMj+FIro
 SFw9JcAkXZu6BdPYRfztvrP9Qg3RZlA9+kbjCBRLzHucUkEdycqqtSPTq7/iLnQB82sLft77Twl
 DzyBNPGWDp3Lsq7NR06IXgmojJ4d61Mn8OuTWq5QCiCexnMK962SN2p/hwsF0q2Gj7L079HRQM5
 MnxUDUpYLyagyiHKwywqxzPNGVIJOrUdfTtB1LwhTcz1UeDZJrtAIXBdCSsWh2XrDlVXvcVXGrM
 mmu9aebU9OdOoH0F3MYMt3mn6ypbzBzWhUquIhWK
X-Google-Smtp-Source: AGHT+IG1GECUMKmMmA1c0p2kbsE+kqsAkS+e69LyG1v3zs4UY34V9+mhBzgCZqUZjT5aLK49q7yL2g==
X-Received: by 2002:a5d:64ee:0:b0:3a0:8291:20d0 with SMTP id
 ffacd0b85a97d-3a35c83f19bmr17498426f8f.29.1747793823591; 
 Tue, 20 May 2025 19:17:03 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a986b38bsm8589270b3a.129.2025.05.20.19.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 19:17:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 21 May 2025 10:16:53 -0400
Message-ID: <20250521141655.3202240-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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

Fixs:1241
Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_tmpdir.c | 119 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 111 insertions(+), 8 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 6ed2367b9..7bd55022d 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -102,6 +102,7 @@ static char test_start_work_dir[PATH_MAX];
 extern futex_t *tst_futexes;
 
 static int rmobj(const char *obj, char **errmsg);
+static int rmobjat(int dir_fd, const char *obj, char **errmsg);
 
 int tst_tmpdir_created(void)
 {
@@ -149,8 +150,8 @@ static int purge_dir(const char *path, char **errptr)
 	int ret_val = 0;
 	DIR *dir;
 	struct dirent *dir_ent;
-	char dirobj[PATH_MAX];
 	static char err_msg[PATH_MAX + 1280];
+	int dir_fd = -1;
 
 	/* Do NOT perform the request if the directory is "/" */
 	if (!strcmp(path, "/")) {
@@ -167,7 +168,7 @@ static int purge_dir(const char *path, char **errptr)
 	/* Open the directory to get access to what is in it */
 	if (!(dir = opendir(path))) {
 		if (errptr) {
-			sprintf(err_msg,
+			snprintf(err_msg, sizeof(err_msg),
 				"Cannot open directory %s; errno=%d: %s",
 				path, errno, tst_strerrno(errno));
 			*errptr = err_msg;
@@ -175,6 +176,18 @@ static int purge_dir(const char *path, char **errptr)
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
 	/* Loop through the entries in the directory, removing each one */
 	for (dir_ent = readdir(dir); dir_ent; dir_ent = readdir(dir)) {
 		/* Don't remove "." or ".." */
@@ -183,8 +196,57 @@ static int purge_dir(const char *path, char **errptr)
 			continue;
 
 		/* Recursively remove the current entry */
-		sprintf(dirobj, "%s/%s", path, dir_ent->d_name);
-		if (rmobj(dirobj, errptr) != 0)
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
+	/* Loop through the entries in the directory, removing each one */
+	for (dir_ent = readdir(dir); dir_ent; dir_ent = readdir(dir)) {
+		/* Don't remove "." or ".." */
+		if (!strcmp(dir_ent->d_name, ".")
+		    || !strcmp(dir_ent->d_name, ".."))
+			continue;
+
+		/* Recursively remove the current entry */
+		if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0)
 			ret_val = -1;
 	}
 
@@ -212,7 +274,7 @@ static int rmobj(const char *obj, char **errmsg)
 		/* Get the link count, now that all the entries have been removed */
 		if (lstat(obj, &statbuf) < 0) {
 			if (errmsg != NULL) {
-				sprintf(err_msg,
+				snprintf(err_msg, sizeof(err_msg),
 					"lstat(%s) failed; errno=%d: %s", obj,
 					errno, tst_strerrno(errno));
 				*errmsg = err_msg;
@@ -225,7 +287,7 @@ static int rmobj(const char *obj, char **errmsg)
 			/* The directory is linked; unlink() must be used */
 			if (unlink(obj) < 0) {
 				if (errmsg != NULL) {
-					sprintf(err_msg,
+					snprintf(err_msg, sizeof(err_msg),
 						"unlink(%s) failed; errno=%d: %s",
 						obj, errno, tst_strerrno(errno));
 					*errmsg = err_msg;
@@ -236,7 +298,7 @@ static int rmobj(const char *obj, char **errmsg)
 			/* The directory is not linked; remove() can be used */
 			if (remove(obj) < 0) {
 				if (errmsg != NULL) {
-					sprintf(err_msg,
+					snprintf(err_msg, sizeof(err_msg),
 						"remove(%s) failed; errno=%d: %s",
 						obj, errno, tst_strerrno(errno));
 					*errmsg = err_msg;
@@ -247,7 +309,7 @@ static int rmobj(const char *obj, char **errmsg)
 	} else {
 		if (unlink(obj) < 0) {
 			if (errmsg != NULL) {
-				sprintf(err_msg,
+				snprintf(err_msg, sizeof(err_msg),
 					"unlink(%s) failed; errno=%d: %s", obj,
 					errno, tst_strerrno(errno));
 				*errmsg = err_msg;
@@ -259,6 +321,47 @@ static int rmobj(const char *obj, char **errmsg)
 	return 0;
 }
 
+static int rmobjat(int dir_fd, const char *obj, char **errmsg)
+{
+	int ret_val = 0;
+	struct stat statbuf;
+	static char err_msg[PATH_MAX + 1280];
+	int fd;
+
+	fd = openat(dir_fd, obj, O_DIRECTORY | O_NOFOLLOW);
+	if (fd >= 0) {
+		close(fd);
+		ret_val = purge_dirat(dir_fd, obj, errmsg);
+
+		/* If there were problems removing an entry, don't attempt to
+		   remove the directory itself */
+		if (ret_val == -1)
+			return -1;
+
+		if (unlinkat(dir_fd, obj, AT_REMOVEDIR) < 0) {
+			if (errmsg != NULL) {
+				snprintf(err_msg, sizeof(err_msg),
+						"remove(%s) failed; errno=%d: %s",
+						obj, errno, tst_strerrno(errno));
+				*errmsg = err_msg;
+			}
+			return -1;
+		}
+	} else {
+		if (unlinkat(dir_fd, obj, 0) < 0) {
+			if (errmsg != NULL) {
+				snprintf(err_msg, sizeof(err_msg),
+					"unlinkat(%s) failed; errno=%d: %s", obj,
+					errno, tst_strerrno(errno));
+				*errmsg = err_msg;
+			}
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 void tst_tmpdir(void)
 {
 	char template[PATH_MAX];
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
