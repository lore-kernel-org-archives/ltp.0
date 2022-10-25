Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10797C04A95
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 15:00:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 914133CA38E
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 16:59:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3093B3C9FB1
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 16:59:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 101A0140054D
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 16:59:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 46D511F9BF;
 Tue, 25 Oct 2022 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1666709987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edt3Ul1FUbrhZAx4cvlHS9qKcX1TnwYK2FGECA2MEC0=;
 b=m49BIMCNZ2DqmeMx9WbTlJmjPaGe6ie8XDu0kkgG9EW8uEBvfp5O07CD9i3z2/LapbY+vr
 0aAn8jRhQrY/mKWVk1oQapBDC1qJ+KUXr0lHyJNWDy01QHdmEmuGmqLWyZs2uxqsWNdled
 40SJIhqTvfa0aTJ0Yn+1GCjRIBzjfeA=
Received: from g78.suse.de (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id D2D4F2C141;
 Tue, 25 Oct 2022 14:59:46 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 25 Oct 2022 15:59:10 +0100
Message-Id: <20221025145910.19565-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <Y1eoJpgzrOWuX5Op@lab.hqhome163.com>
References: <Y1eoJpgzrOWuX5Op@lab.hqhome163.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

mountinfo doesn't always contain the correct device name. For example
/dev/root may be displayed, but not exist in devtmpfs[1].

The unevent file in sysfs is another way of finding the device name
from the major and minor numbers. Possibly it always displays the
proper device name.

One caveat is the sysfs can be disabled, so this commit does not
remove the mountinfo method altogether, but leaves it as a fallback.

Alessandro Carminati originally sent two patches[1] which added the
uevent file method as a fallback. However it seems like the better
method.

[1]: https://lore.kernel.org/ltp/Y0023HcAOlhfAcJw@lab.hqhome163.com/

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Alessandro Carminati <alessandro.carminati@gmail.com>
Reported-by: Alessandro Carminati <alessandro.carminati@gmail.com>
---

Alessandro, it seems you tried to edit the last patch by hand? In any
case it did not apply and I ended up making some other changes. So I
took the liberty of submitting a new patch.

Thanks,
Richard.

 lib/tst_device.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8419b80c3..676903fff 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -526,14 +526,30 @@ void tst_find_backing_dev(const char *path, char *dev)
 	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
 	unsigned int len, best_match_len = 1;
 	char mnt_point[PATH_MAX];
+	char uevent_path[PATH_MAX];
+	char dev_name[NAME_MAX];
 
 	if (stat(path, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
 
+	*dev = '\0';
 	dev_major = major(buf.st_dev);
 	dev_minor = minor(buf.st_dev);
+
+	sprintf(uevent_path,
+		"/sys/dev/block/%d:%d/uevent", dev_major, dev_minor);
+
+	if (!access(uevent_path, R_OK)) {
+		FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s", dev_name);
+
+		if (dev_name[0])
+			sprintf(dev, "/dev/%s", dev_name);
+	}
+
+	if (!stat(dev, &buf))
+		goto out;
+
 	file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
-	*dev = '\0';
 
 	while (fgets(line, sizeof(line), file)) {
 		if (sscanf(line, "%*d %*d %d:%d %*s %s",
@@ -564,7 +580,7 @@ void tst_find_backing_dev(const char *path, char *dev)
 
 	if (stat(dev, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
-
+out:
 	if (S_ISBLK(buf.st_mode) != 1)
 		tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
 }
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
