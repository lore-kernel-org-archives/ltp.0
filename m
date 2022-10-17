Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C116C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 11:10:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 531C23CAFD1
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 13:10:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D1873CAFC3
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 13:09:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9426F60047F
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 13:09:57 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id a26so24070250ejc.4
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QM9KJohxcxqiRIkBW+GT3SMbWrmzYoa19OC5P56R4zY=;
 b=GbN5A/YQdR85aNps3MRTUAt+CR3ddjev9qKTRQuThFqwXi4uO4756vUSO5LwIbmcOK
 UFk5zibeIBbDONxEWiaqylnQlTQPZ7RvJql8yh0FrNUrOJsFiDLNreM0Ke6YH19XpZoe
 Ld6STeu65slwMCsUfXpNnwMVV9D5oUYN/9d5OaJz3r2xPfLsejfaTkJPat/KxdqQwx+Y
 61iPDpTN0SIUBxgMNbuYmtwCOVMeH4qYbukog46/uMxesftSy7Exs4pRwzbwbtUinuFz
 jdjCxympdw782q/5J5jfMkulob4YrZfk4tlABHtZzOsRaQSgMhPeDkv4ZRamnyp+VDLe
 iXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QM9KJohxcxqiRIkBW+GT3SMbWrmzYoa19OC5P56R4zY=;
 b=0N0E2uiR/JXm0I2gfoplv5V21F+hUee9fCMNLSD9ecsMzK5KTGqLq4GSrH/yv6Nwoy
 SODB22uAGiWs9IYxENII1FDzIJYm0A4AxvTtrNC7spIVldGOPmG/aua2jYTqMujOeN1P
 UTwwGcFWx2SdOehUXnGRtMHTJy74LDNiF5sEPsQOpKX1OI8j8z4spV2l486VYjxfNlNK
 ctiKTheaaUw4ReHXqNhGnCiiA77uouaBMdo7aqs6D5e/ifDMKh6Q6BlKzLERAHC/MjdU
 Iil3BaqsBE/QwHmD/gzb6YYTco2p9nBboZF+TtN/m5Wrrcuu9I0DV3vR+X7gwMFuBeES
 R6Zw==
X-Gm-Message-State: ACrzQf0p2oWgTuGzIRUYPDPyLGJimSCAtUD3bZVQHhwE1EIwkqx9V6pQ
 Jh5eNZbCEGcd0OxP4J7HX0LE8pcqcdk=
X-Google-Smtp-Source: AMsMyM5DcHyv04BZlMW6KUaY5CEB7GmcL6P9qoHOexCxP0EuF/bYW8vW7bWNprKDujklqqZI4ncESQ==
X-Received: by 2002:a17:907:75dc:b0:78b:339:63c7 with SMTP id
 jl28-20020a17090775dc00b0078b033963c7mr8359370ejc.480.1666004996742; 
 Mon, 17 Oct 2022 04:09:56 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a170906288300b007826c0a05ecsm5766535ejd.209.2022.10.17.04.09.55
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 04:09:56 -0700 (PDT)
Date: Mon, 17 Oct 2022 11:05:00 +0000
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Message-ID: <Y0023HcAOlhfAcJw@lab.hqhome163.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix tst_find_backing_dev when no initramfs
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

mount_root() is the kernel function responsible for mounting the primary
rootfs.
A dynamic there, prevents the /dev/root device node in the not yet mounted
files system. For this reason, in the embedded system that starts without
an initramfs, or however a proper initscript, the /dev/root device appears
into the mount table in the / line.
The test tries to open this /dev/root and fails with a warning.
This patch aims to fix this situation.

Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>

typo fixes
---
 lib/tst_device.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8419b80c3..c3427eb31 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -526,6 +526,8 @@ void tst_find_backing_dev(const char *path, char *dev)
 	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
 	unsigned int len, best_match_len = 1;
 	char mnt_point[PATH_MAX];
+	char tmpbuf1[PATH_MAX];
+	char tmpbuf2[PATH_MAX];
 
 	if (stat(path, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
@@ -562,6 +564,24 @@ void tst_find_backing_dev(const char *path, char *dev)
 	if (!*dev)
 		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
 
+	if (stat(dev, &buf) < 0) {
+		if (strcmp("/dev/root", dev) != 0) {
+			tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
+		} else {
+			sprintf(tmpbuf1, "/sys/dev/block/%d:%d/uevent", dev_major, dev_minor);
+			file = SAFE_FOPEN(NULL, tmpbuf1, "r");
+			while (fgets(line, sizeof(line), file)) {
+				if (sscanf(line, "%[^=]=%s", tmpbuf1, tmpbuf2) != 2)
+					continue;
+				if (strcmp("DEVNAME", tmpbuf1) == 0) {
+					sprintf(dev, "/dev/%s", tmpbuf2);
+					break;
+				}
+			}
+			SAFE_FCLOSE(NULL, file);
+		}
+	}
+
 	if (stat(dev, &buf) < 0)
 		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
