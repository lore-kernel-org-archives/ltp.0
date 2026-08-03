Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED60C55182
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785770899; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=AP/u1nsuzNZWtxQCWTv/nUiu77YnP+Lzb1u/UV2Okro=;
 b=Eg/TNTyOnSwwssKPqRnsc0LCYgLxIofqTVe5cJROEOXquDWOf/b4xBW7iWEJY/A/yQZnr
 55rTnaobC97AcgwbsvEE34J/k/Hmgm8jUImSDcwH0zM7jm3zJh5H2AFFfpZZ4esrrulNF9w
 GkkPv+3LTKqQswGNt1sqcahk3vAXq5Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE26C3E74F9
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 17:28:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1B733E2EB2
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 17:27:58 +0200 (CEST)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com
 [IPv6:2607:f8b0:4864:20::547])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5AD70600350
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 17:27:58 +0200 (CEST)
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so5542a12.0
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785770877; x=1786375677; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YEot8Nw+3M7iLUzs58Qd4TA7d/QjVE16NvOsVFXVeQg=;
 b=E4n8lC+ynrjqhEZRV8gAqu+ennMmTRaDR9Kiy0lMHJ8sf/RAJFn3x/8Gu83AWfQBD3
 R5wMULEPi/8RZn1E1GGIPs6t5eJk9XZhzRpco4VqRcZl4+POiTXCuPjgLv5FuUaxQl+9
 FP+tWVM0+AoD9q7NzS2ixe7G248dJ6ZIPNfS8eYUhdcOUzlzK2BHVYvlcEOlxzo3G/4g
 UwG0anHVEUZmc9Vmyc+eYAhjYBSscWAvTpUzIDcVS7RRIPAAgkIBPqMpOXwUyk2KcQSF
 /VSk3sD4liAoXRI4b0dyHsNHFQNLEi2pp4sXWYkSnHXqROh1vgOy8AmJxLylagXq/K9k
 6UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785770877; x=1786375677;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YEot8Nw+3M7iLUzs58Qd4TA7d/QjVE16NvOsVFXVeQg=;
 b=pIuVw+STOb88Z8NyyplaD24YedpNdoFKo9aq6vZT142gDq9RBfj4pJWZJcwmKYCxH6
 TNXUDJ9JaHspbzNPqUQinNyamCxccZwtwrHMTFjBE66bgTbHPVwkzkxNzZRxah/+30VU
 TlZ5ZUmqc60PobHT+5jcpDCUQGjelexcVijkDJDZnMt6m/b+JvRnVMuf1IqHCfJrRit3
 sVCRHatHiPc7mxgD5DJ+29Q31nGb/IkKyEJgr2zREqSwnBeQygnAEALbf7Y0GWFZ4log
 A70JkLa3qRKI40/skUEMpTvJhW0R8NE0fygT6AqT9efD3EzwUd5Bosy5yEBvjIARnobi
 ulZw==
X-Gm-Message-State: AOJu0YxatInKMxWrZP5GFRR+YoN2lM1zbhsdhD7bW8fRgqL55p14F9hh
 BWRxfetqq5ZV1YGufC8KCX4rmRNfMx51i4hgEzJX4yq2hShUHQVVP1s16trsjJ7hMvlsNgLM+Mg
 HV+RqMQrToGpLHkWLDocvg4YVQLpwqwK5Y4E2oDBZtO7FSj5Di8IP9MGT+nAO4lUGceRkgATHIk
 Y87rsTaI0B6ECmVn9AV/d615Sz2A==
X-Received: from pgjz3.prod.google.com ([2002:a63:e543:0:b0:c92:dd1e:dc3c])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:938a:b0:3c3:b57b:645a
 with SMTP id adf61e73a8af0-3c92ae1d7c1mr9097268637.21.1785770876173; Mon, 03
 Aug 2026 08:27:56 -0700 (PDT)
Date: Mon,  3 Aug 2026 15:27:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260803152754.3991113-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Use exponential-backoff polling to wait for loop
 device nodes
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On systems where loop device node creation is asynchronous (such as Android
containers or systems with slow udev startup), calling stat() or open()
immediately after LOOP_CTL_GET_FREE can transiently fail because the
device file (e.g. /dev/loopX) has not been fully populated in time.

Introduce an exponential-backoff retry loop in both
tst_find_free_loopdev() and tst_attach_device() (starting at 1ms delay,
doubling each try, capped at 100ms) to wait for the device node to be
successfully populated.

This improves the robustness of loop device allocations on asynchronous
virtualized environments while minimizing unnecessary delays on responsive
systems.

Signed-off-by: Wake Liu <wakel@google.com>
---
 lib/tst_device.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 744173ffef..6e3c6fef21 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -82,7 +82,7 @@ static int set_dev_path(char *dev, char *path, size_t path_len)
 
 int tst_find_free_loopdev(char *path, size_t path_len)
 {
-	int ctl_fd, dev_fd, rc, i;
+	int ctl_fd, dev_fd, rc, i, path_set;
 	struct loop_info loopinfo;
 	char buf[PATH_MAX];
 
@@ -93,8 +93,20 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
 		close(ctl_fd);
 		if (rc >= 0) {
-			if (path && set_dev_loop_path(rc, path, path_len))
-				tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
+			if (path) {
+				unsigned int usec = 1000; /* start with 1ms */
+
+				for (i = 0; i < 50; i++) {
+					path_set = set_dev_loop_path(rc, path, path_len);
+					if (!path_set)
+						break;
+					usleep(usec);
+					if (usec < 100000) /* cap backoff at 100ms */
+						usec *= 2;
+				}
+				if (path_set)
+					tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
+			}
 			tst_resm(TINFO, "Found free device %d '%s'",
 				rc, path ?: "");
 			return rc;
@@ -155,13 +167,22 @@ int tst_attach_device(const char *dev, const char *file)
 {
 	int dev_fd, file_fd;
 	struct loop_info loopinfo;
+	int attach_tries = 20;
+	unsigned int usec = 1000; /* start with 1ms */
 
 	if (strlen(file) >= LO_NAME_SIZE) {
 		tst_brkm(TBROK, NULL, "Device name can't be longer than %u chars",
 			 LO_NAME_SIZE);
 	}
 
-	dev_fd = open(dev, O_RDWR);
+	while (attach_tries--) {
+		dev_fd = open(dev, O_RDWR);
+		if (dev_fd >= 0)
+			break;
+		usleep(usec);
+		if (usec < 100000) /* cap backoff at 100ms */
+			usec *= 2;
+	}
 	if (dev_fd < 0) {
 		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
 		return 1;
-- 
2.55.0.508.g3f0d502094-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
