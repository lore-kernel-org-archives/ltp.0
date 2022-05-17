Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D75C433F5
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 12:20:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A9EA3CAA68
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 14:20:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9637D3CA60C
 for <ltp@lists.linux.it>; Tue, 17 May 2022 14:19:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8C146007B7
 for <ltp@lists.linux.it>; Tue, 17 May 2022 14:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652789992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InsoR6xzND9akkqKYdzjMhPTA8I5L9xJwZN13gDXp1c=;
 b=d84gr47/HxyD9asuHx0wiPQr6YJwv7nqjEIyorbfjkEHQWgJCPlKONYTWkeoIPp/+eJe4v
 im0BkpH0oNkiQGs9h96xX6HrGz7r/wVVfFfxIijjtJ+bfKcWOCEMvv7Yv1pyVUhoETvJmA
 U0dnF7mTxRKn080NU6CxG5E7g4IKbJM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-CLKG5P6HPQK96YMX6X0ehg-1; Tue, 17 May 2022 08:19:50 -0400
X-MC-Unique: CLKG5P6HPQK96YMX6X0ehg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 956C63979683
 for <ltp@lists.linux.it>; Tue, 17 May 2022 12:19:50 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C9CB14A569D
 for <ltp@lists.linux.it>; Tue, 17 May 2022 12:19:50 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 17 May 2022 14:19:44 +0200
Message-Id: <65a82dbc6ea54c5d02a1238f5fa26d19388c5d2a.1652789936.git.jstancek@redhat.com>
In-Reply-To: <f38ee2905aa8b765c243896fa326b5507919a446.1651061197.git.jstancek@redhat.com>
References: <f38ee2905aa8b765c243896fa326b5507919a446.1651061197.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_find_backing_dev: match mount point if
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ioctl_loop05 fails on btrfs, because tst_find_backing_dev doesn't find
major/minor returned by stat()

Per https://lwn.net/Articles/866582
  "btrfs allocates a separate device number (the usual major/minor pair)
  for each subvolume ... and call to on a file within a subvolume will
  return a device number that does not exist in files like mountinfo."

As fallback, if there's no major/minor match, use best match of mount path.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_device.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index d296f9118cde..b1af0f0146d4 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -506,6 +506,16 @@ unsigned long tst_dev_bytes_written(const char *dev)
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
@@ -514,6 +524,8 @@ void tst_find_backing_dev(const char *path, char *dev)
 	char *pre = NULL;
 	char *next = NULL;
 	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
+	unsigned int len, best_match_len = 0;
+	char mnt_point[PATH_MAX];
 
 	if (stat(path, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
@@ -524,17 +536,25 @@ void tst_find_backing_dev(const char *path, char *dev)
 	*dev = '\0';
 
 	while (fgets(line, sizeof(line), file)) {
-		if (sscanf(line, "%*d %*d %d:%d", &line_mjr, &line_mnr) != 2)
+		if (sscanf(line, "%*d %*d %d:%d %*s %s",
+			&line_mjr, &line_mnr, mnt_point) != 3)
 			continue;
 
+		pre = strstr(line, " - ");
+		pre = strtok_r(pre, " ", &next);
+		pre = strtok_r(NULL, " ", &next);
+		pre = strtok_r(NULL, " ", &next);
+
 		if (line_mjr == dev_major && line_mnr == dev_minor) {
-			pre = strstr(line, " - ");
-			pre = strtok_r(pre, " ", &next);
-			pre = strtok_r(NULL, " ", &next);
-			pre = strtok_r(NULL, " ", &next);
 			strcpy(dev, pre);
 			break;
 		}
+
+		len = count_match_len(path, mnt_point);
+		if (len > best_match_len) {
+			strcpy(dev, pre);
+			best_match_len = len;
+		}
 	}
 
 	SAFE_FCLOSE(NULL, file);
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
