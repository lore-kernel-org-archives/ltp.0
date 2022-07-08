Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE576C433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 07:33:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94F7B3CA417
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 09:33:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEF1A3C0646
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 09:33:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C9CD0601A14
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 09:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657265614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DSCshRjYLVJQScIyWr+9tTLqaCGVOCZ+wHrb4t2Hcvc=;
 b=KgYcsAzNXBZoqjIcO4QdzOPojwaoHoxN2qTV+VsAe4G4xLFJWLsIYSCMAZKnGitaWF+BMK
 Fu3NA9fwpiUXWeq74mBan2s7weFjrbFaci3OGIh7qPuhW0qg6Qu4xCejfZMDBFWUtQNzGA
 wZuQM+dX89pVup2vWsXZ7rCioVwBMys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-QBuAynQnOgCRmPzStm1c6A-1; Fri, 08 Jul 2022 03:33:26 -0400
X-MC-Unique: QBuAynQnOgCRmPzStm1c6A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F1AA101A595
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 07:33:26 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.22.34.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EBE21415117
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 07:33:26 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  8 Jul 2022 09:33:20 +0200
Message-Id: <b30a6712179ead9c8a5556d82a4ac386904c9b4d.1657265564.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_find_backing_dev: fix logic in matching mount
 point
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

If backing dev is btrfs root device, then starting best_match_len
from 1 creates an issue, because root (/) is never matched.
Also we should check that entire mount point string is present in
path we are matching against.

In case there's error also dump /proc/self/mountinfo before tst_brk.

This fixes test with following partition layout (TMPDIR is on /):
  # cat /proc/self/mountinfo  | grep btrfs
  59 1 0:29 /root / rw,relatime shared:1 - btrfs /dev/dasda2 rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=257,subvol=/root
  93 59 0:29 /home /home rw,relatime shared:47 - btrfs /dev/dasda2 rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=256,subvol=/home

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_device.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index c34cbe6d1f56..414bf0eea816 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -506,12 +506,17 @@ unsigned long tst_dev_bytes_written(const char *dev)
 	return dev_bytes_written;
 }
 
-static int count_match_len(const char *first, const char *second)
+static int str_starts_with(const char *str, const char *prefix)
 {
 	int len = 0;
 
-	while (*first && *first++ == *second++)
+	while (*prefix) {
+		if (!*str)
+			return 0;
+		if (*str++ != *prefix++)
+			return 0;
 		len++;
+	}
 
 	return len;
 }
@@ -524,7 +529,7 @@ void tst_find_backing_dev(const char *path, char *dev)
 	char *pre = NULL;
 	char *next = NULL;
 	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
-	unsigned int len, best_match_len = 1;
+	unsigned int len, best_match_len = 0;
 	char mnt_point[PATH_MAX];
 
 	if (stat(path, &buf) < 0)
@@ -550,7 +555,7 @@ void tst_find_backing_dev(const char *path, char *dev)
 			break;
 		}
 
-		len = count_match_len(path, mnt_point);
+		len = str_starts_with(path, mnt_point);
 		if (len > best_match_len) {
 			strcpy(dev, pre);
 			best_match_len = len;
@@ -559,8 +564,10 @@ void tst_find_backing_dev(const char *path, char *dev)
 
 	SAFE_FCLOSE(NULL, file);
 
-	if (!*dev)
+	if (!*dev) {
+		tst_system("cat /proc/self/mountinfo");
 		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
+	}
 
 	if (stat(dev, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
