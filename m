Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5978C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 12:09:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 451903CA68B
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 14:09:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 652FA3C8977
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:09:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 597AD1400B94
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:09:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651061341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9W1n5a5pr4Iy3dJ/4gP3NijMUgbcFuFXR+NCwFSIYrI=;
 b=Q0t+JHbwl0Un2jtLnFbEQgB+vmoTCRY/tO9GCF4knBnfhXOh9fSkuH4T58JvES/wEjrgeO
 ExQIxJB+Lf7TdxfuPHw0srDOPBCNV+77J2dm8D7Jy/Nj4tYYWPF7K1y2rA7JaX5Rn+6Hlf
 TMVXjo0tuZfraRfKtFNwD5EwIuW538k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-fOvO4l2tMFSKFb4LyQ78zw-1; Wed, 27 Apr 2022 08:09:00 -0400
X-MC-Unique: fOvO4l2tMFSKFb4LyQ78zw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C9292A5955B;
 Wed, 27 Apr 2022 12:08:59 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8546F40CF8FD;
 Wed, 27 Apr 2022 12:08:58 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 27 Apr 2022 14:08:45 +0200
Message-Id: <f38ee2905aa8b765c243896fa326b5507919a446.1651061197.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_find_backing_dev: match mount point if
 major/minor can't be found
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
Cc: liwan@redhat.com, xuyang2018.jy@cn.fujitsu.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test fails on btrfs, because tst_find_backing_dev doesn't find
major/minor returned by stat()

Per https://lwn.net/Articles/866582
"btrfs allocates a separate device number (the usual major/minor pair)
for each subvolume ... and call to on a file within a subvolume will
return a device number that does not exist in files like mountinfo."

As fallback, if major/minor can't be found, use best match of mount path.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_device.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index d296f9118cde..e560ec97460b 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -506,14 +506,22 @@ unsigned long tst_dev_bytes_written(const char *dev)
 	return dev_bytes_written;
 }
 
+static int count_match_len(const char *first, const char *second)
+{
+	int len = 0;
+
+	while (*first && *first++ == *second++)
+		len++;
+
+	return len;
+}
+
 void tst_find_backing_dev(const char *path, char *dev)
 {
 	struct stat buf;
 	FILE *file;
-	char line[PATH_MAX];
-	char *pre = NULL;
-	char *next = NULL;
-	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
+	char line[PATH_MAX], mnt_point[PATH_MAX], mnt_source[PATH_MAX];
+	unsigned int dev_major, dev_minor, line_mjr, line_mnr, best_match_len = 0;
 
 	if (stat(path, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
@@ -524,17 +532,20 @@ void tst_find_backing_dev(const char *path, char *dev)
 	*dev = '\0';
 
 	while (fgets(line, sizeof(line), file)) {
-		if (sscanf(line, "%*d %*d %d:%d", &line_mjr, &line_mnr) != 2)
+		if (sscanf(line, "%*d %*d %d:%d %*s %s %*s %*s %*s %*s %s",
+			&line_mjr, &line_mnr, mnt_point, mnt_source) != 4)
 			continue;
 
 		if (line_mjr == dev_major && line_mnr == dev_minor) {
-			pre = strstr(line, " - ");
-			pre = strtok_r(pre, " ", &next);
-			pre = strtok_r(NULL, " ", &next);
-			pre = strtok_r(NULL, " ", &next);
-			strcpy(dev, pre);
+			strcpy(dev, mnt_source);
 			break;
 		}
+
+		unsigned int len = count_match_len(path, mnt_point);
+		if (len > best_match_len) {
+			strcpy(dev, mnt_source);
+			best_match_len = len;
+		}
 	}
 
 	SAFE_FCLOSE(NULL, file);
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
