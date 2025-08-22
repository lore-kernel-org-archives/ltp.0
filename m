Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B835FCA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755847358; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ZAvPGz70DSZrCHgAw1B9z+A5BbWPF+e90teoqcGy6xE=;
 b=HJqORDJYfZSA42a+6/zXBq3U6gnPMitNjH/O3Ve3IdEWpxg2ZvSxQfG44iNFeezF0GcPa
 bogS5xU/JQazG20Z8ANuwIJHXfOdY3yrBuBfZH1NPJl4OSfR2JNDpORniwmWWRk8qa1TzSl
 cAJVT3ZfKvLmD2yg4oUG4jdTvtX4D4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 030D93CCE57
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 09:22:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE0D53CCCCC
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:22:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15046600096
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:22:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755847334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rxWEdTEw5wEl2bJN03zwRyoeoDKcjDqFErPkjWXWgJ0=;
 b=DLmI1L5b4VhFbVO/LVmqlx0dXNrBGPyx6GyeppNDbVo9N7528sYFddt+VBfLBgEKiwOTHF
 A+dX66vRyLWAQjJ3DJ2uJbPZJ9x8cE8Z7mxRXgMLG/49r8VFSOvGzbJa+GZ1pjgwZaf+iF
 Hm3yZKIbxFl1HeJBGHZsNjFHYKVAF0w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-uih0WkCVPHiSZZ42UK2V6g-1; Fri,
 22 Aug 2025 03:22:12 -0400
X-MC-Unique: uih0WkCVPHiSZZ42UK2V6g-1
X-Mimecast-MFC-AGG-ID: uih0WkCVPHiSZZ42UK2V6g_1755847331
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F15B180034F; Fri, 22 Aug 2025 07:22:11 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC4D0180047F; Fri, 22 Aug 2025 07:22:09 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 15:22:03 +0800
Message-ID: <20250822072204.2191382-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pJjutDGO6N4ULV20dfLLq5ZVodzsqpBnD2Md-FJFWVU_1755847331
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_device: refine tst_is_mounted()
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Refactor tst_is_mounted() to reuse tst_mount_has_opt() instead of
parsing /proc/mounts with strstr(). This makes the check more
accurate and consistent with tst_is_mounted_ro()/rw().

Also moved tst_is_mounted_at_tmpdir() below for consistency.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Wei Gao <wegao@suse.com>
---
 lib/tst_device.c | 79 +++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 44 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index b610cf14b..5b0498c03 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -429,50 +429,6 @@ int tst_umount(const char *path)
 	return -1;
 }
 
-int tst_is_mounted(const char *path)
-{
-	char line[PATH_MAX];
-	FILE *file;
-	int ret = 0;
-
-	file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
-
-	while (fgets(line, sizeof(line), file)) {
-		if (strstr(line, path) != NULL) {
-			ret = 1;
-			break;
-		}
-	}
-
-	SAFE_FCLOSE(NULL, file);
-
-	if (!ret)
-		tst_resm(TINFO, "No device is mounted at %s", path);
-
-	return ret;
-}
-
-int tst_is_mounted_at_tmpdir(const char *path)
-{
-	char cdir[PATH_MAX], mpath[PATH_MAX];
-	int ret;
-
-	if (!getcwd(cdir, PATH_MAX)) {
-		tst_resm(TWARN | TERRNO, "Failed to find current directory");
-		return 0;
-	}
-
-	ret = snprintf(mpath, PATH_MAX, "%s/%s", cdir, path);
-	if (ret < 0 || ret >= PATH_MAX) {
-		tst_resm(TWARN | TERRNO,
-			 "snprintf() should have returned %d instead of %d",
-			 PATH_MAX, ret);
-		return 0;
-	}
-
-	return tst_is_mounted(mpath);
-}
-
 static int tst_mount_has_opt(const char *path, const char *opt)
 {
 	char line[PATH_MAX];
@@ -496,6 +452,11 @@ static int tst_mount_has_opt(const char *path, const char *opt)
 		if (strcmp(mount_point, abspath) != 0)
 			continue;
 
+		if (!opt) {
+			ret = 1;
+			break;
+		}
+
 		char *tok = strtok(options, ",");
 		while (tok) {
 			if (strcmp(tok, opt) == 0) {
@@ -512,6 +473,15 @@ static int tst_mount_has_opt(const char *path, const char *opt)
 	return ret;
 }
 
+int tst_is_mounted(const char *path)
+{
+	int ret = tst_mount_has_opt(path, NULL);
+	if (!ret)
+		tst_resm(TINFO, "No device is mounted at %s", path);
+
+	return ret;
+}
+
 int tst_is_mounted_ro(const char *path)
 {
 	return tst_mount_has_opt(path, "ro");
@@ -522,6 +492,27 @@ int tst_is_mounted_rw(const char *path)
 	return tst_mount_has_opt(path, "rw");
 }
 
+int tst_is_mounted_at_tmpdir(const char *path)
+{
+	char cdir[PATH_MAX], mpath[PATH_MAX];
+	int ret;
+
+	if (!getcwd(cdir, PATH_MAX)) {
+		tst_resm(TWARN | TERRNO, "Failed to find current directory");
+		return 0;
+	}
+
+	ret = snprintf(mpath, PATH_MAX, "%s/%s", cdir, path);
+	if (ret < 0 || ret >= PATH_MAX) {
+		tst_resm(TWARN | TERRNO,
+			 "snprintf() should have returned %d instead of %d",
+			 PATH_MAX, ret);
+		return 0;
+	}
+
+	return tst_is_mounted(mpath);
+}
+
 static int find_stat_file(const char *dev, char *path, size_t path_len)
 {
 	const char *devname = strrchr(dev, '/') + 1;
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
