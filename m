Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2E606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=WTuY2Nk1;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=W1emrZHw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793586197; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=y8foweaqiYIofE6i0aYRj45FLKVuIUz17vrE5xbGHWc=;
 b=WTuY2Nk1ucoasq8DDp3+UXiO0f6hBoFB+K7g+9isZ0mJoBO/SWO/rNsGh/UPQ/LnLZycM
 LxadgP8wIu2ia/UeAB5XQGP4L2k+P/pnilaYgWAt4k8YpwnTH0HyvCReJ+MaFi4+uI0AMVO
 41VGE2h7ALMJ1tS0JiIQhcgmWfiw+1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D2F33E5C72
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 03:23:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C16543E05A4
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:22:57 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A921614004F2
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:22:56 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so15746165e9.1
 for <ltp@lists.linux.it>; Sun, 01 Nov 2026 18:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793586176; x=1794190976; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rxVL0GRzESknNbpc76eyMi2CY9gImYzPpTHDVt6P4Ko=;
 b=W1emrZHw2mfFzaaKDw+yTMwUkhokMUPYh1SDA9Ba2JEMOxre5MWAkJmhN14xaqRM9v
 jYaeMyrROlDOPJdbqQNXNR5oUZqbVWbmyi9GpiIHNJ0iflH4Xdiiua+bnIU2BFlmEWxY
 mTQETUFec9fP6abAqQD9txX8863hQ0gH0cycexGsmCCdk+6JquNJw1WLL13VakinHWRm
 2GnjDYtEy0wc21VjUaVMzDsiaUoJkPNdvdbYN661sGyp4FlAVN0GUEr0yBN2vDKpHp+a
 ZtweOVAI99KHsrR5oIPbTXEBCyzhhz0fh7Ewske81RyVjF18YLCncjRXn2xBVsy6tzI2
 OAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793586176; x=1794190976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rxVL0GRzESknNbpc76eyMi2CY9gImYzPpTHDVt6P4Ko=;
 b=ZTc7LkPKtU/KOkNltjXfmkSIqERt2vD29WM5U5XeaY4fzzYyDnvBvr53aXkRt/dTmE
 eLJAV+joOEvQcYJfh0DIWrlFxNq9HThpxeYfX0VkWSnhvxRH2Ob9kIeA/DvTca6slyGZ
 rf7QL6z71ChUmpW9jkpdZJi/KT7kCpIm6KKDa3D8xK+3srFP7KMSglFOXIsR3rr2lFVe
 I2v/xPiG9SJuf7H+caO4Cs/2/szCXg1AEoBTGftTFaKw6mFRlNpEcqmEm84iMEEorN7s
 CEHpymJ4ZA596xrtKOkXiUuN2ap+tx1hi+Er8WKC+3ZULB0qFjTDZ43M5YQVgQ0HU06r
 YzOA==
X-Gm-Message-State: AFq9FYLM6bdCOAQ820upH4+Vutg1jXauC0zvMqDoCXfUBrW7g7anNdkG
 3meTgvQGrg+PmEThikN6/Xd1BQkGSPRJQkfN/tAAukY3y18M6YicNkH8rb1C4ON6zt4Rcr7Cqjm
 R3HA=
X-Gm-Gg: AYBFou2RJp+KgcU6DEy++WgC3DQTSM3YsFVeIBuy2LNIb3bQzAgLaUe1IhaerQ30cI/
 sNYvVmQ40A/N57ZR1DEEr+TkU3U44P4RJbZ2iuhvkoTOWNAJrX5H6i6cBPw0F0EVm8It7SyT2rF
 qHpf4HqjUW1KlZJ+Klb3qRiwp1T4ay0LnfnfdJYUKdpQRo6Neqloo/lPn/vGeGBqoqoISXtc8sr
 n5mpcShhVhmYxSG7t/xvj0XGaffo/TScE1qY1xj05ru2Yuc0qDnW39JN68UYBmkB7DriNZoUOJm
 XfShqLBdEJizcOGkRMGTHNKmgAOxIGyGZbq8ljiJAwaPxqAQJ3cWB0Uz/XcmpDBVuFmNaIOeTqD
 yKQ6oESxX9LWXYYN5aaauW7gY9+VRYllSkaOi4LN3vEKaNiq8YM8BYXKOvPgS8R7cgSYlRCCaTY
 KvoY5yHwj3gd0vrljuH297QB0SOfvpa78m8lbY60HjdEJkPSUh7JTqTDCTIq3TBqNCEe8+1zoZw
 T7YSDE5+jN70AYZz/luRXDUI93SWpkKFvCA6/Boco4PrSqZ3BtCzXNMzNSzJOPis4/XI8Xwe5cO
 Gvmd6TxtrAGPhWdgePM4rRw5sn+yTBej1mgVSvCRWaTMRlr1Swy5avA3LM7A7kDfJQ4rzOukyQ=
 =
X-Received: by 2002:a05:600c:c16d:b0:4a1:e00b:a0ea with SMTP id
 5b1f17b1804b1-4ac150b204fmr201862975e9.1.1793586175963; 
 Sun, 01 Nov 2026 18:22:55 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4aa80f04785sm311557405e9.4.2026.11.01.18.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 18:22:55 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  2 Nov 2026 02:22:39 +0000
Message-ID: <20261102022245.3922-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102022245.3922-1-wegao@suse.com>
References: <20261102022245.3922-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v18 1/3] lib: Add tst_attach_loopdev()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Calling tst_find_free_loopdev() followed by tst_attach_device() has
a race window where another process can claim the loop device before
LOOP_SET_FD is issued, causing attachment to fail with EBUSY.

Introduce tst_attach_loopdev() which finds an unused loop device and
attaches a backing file to it, retrying the lookup with exponential
backoff if the candidate device is claimed concurrently (EBUSY). In
addition, only populate the caller's device path buffer on successful
attachment, and clear it on failure to prevent accidental cleanup of
unattached devices.

Update tst_acquire_loop_device() to use tst_attach_loopdev().

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
v17->v18:
- New patch in v18.

 include/tst_device.h | 13 +++++++
 lib/tst_device.c     | 87 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 92 insertions(+), 8 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 0989e4501..2e7dadd59 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -110,6 +110,19 @@ int tst_find_free_loopdev(char *path, size_t path_len);
  */
 int tst_attach_device(const char *dev_path, const char *file_path);
 
+/**
+ * tst_attach_loopdev() - Find a free loop device and attach a file to it.
+ * @dev_path: If non-NULL, buffer filled with the attached loop device path.
+ * @dev_path_len: Size of @dev_path buffer.
+ * @file_path: Path to a file (e.g. disk.img).
+ *
+ * Finds an unused loop device and attaches @file_path to it, automatically
+ * retrying the lookup if the chosen device is claimed concurrently (EBUSY).
+ *
+ * Return: Zero on success, non-zero otherwise.
+ */
+int tst_attach_loopdev(char *dev_path, size_t dev_path_len, const char *file_path);
+
 /**
  * tst_get_device_size() - Get device size in megabytes.
  * @dev_path: Device path.
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 00304711b..199c14059 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -156,7 +156,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 	return -1;
 }
 
-int tst_attach_device(const char *dev, const char *file)
+static int attach_device(const char *dev, const char *file, int warn_on_ebusy)
 {
 	int dev_fd, file_fd;
 	struct loop_info loopinfo;
@@ -168,7 +168,8 @@ int tst_attach_device(const char *dev, const char *file)
 
 	dev_fd = TST_RETRY_FN_EXP_BACKOFF(open(dev, O_RDWR), TST_RETVAL_GE0, 1);
 	if (dev_fd < 0) {
-		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
+		if (warn_on_ebusy || errno != EBUSY)
+			tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
 		return 1;
 	}
 
@@ -180,10 +181,16 @@ int tst_attach_device(const char *dev, const char *file)
 	}
 
 	if (ioctl(dev_fd, LOOP_SET_FD, file_fd) < 0) {
+		int err = errno;
+
 		close(dev_fd);
 		close(file_fd);
-		tst_resm(TWARN | TERRNO, "ioctl(%s, LOOP_SET_FD, %s) failed",
-			 dev, file);
+		errno = err;
+
+		if (warn_on_ebusy || errno != EBUSY) {
+			tst_resm(TWARN | TERRNO, "ioctl(%s, LOOP_SET_FD, %s) failed",
+				 dev, file);
+		}
 		return 1;
 	}
 
@@ -207,6 +214,73 @@ int tst_attach_device(const char *dev, const char *file)
 	return 0;
 }
 
+int tst_attach_device(const char *dev, const char *file)
+{
+	return attach_device(dev, file, 1);
+}
+
+static int attach_loopdev(char *dev, size_t dev_len, const char *file)
+{
+	if (tst_find_free_loopdev(dev, dev_len) == -1)
+		return -1;
+
+	if (attach_device(dev, file, 0) == 0)
+		return 0;
+
+	if (errno == EBUSY)
+		return 1;
+
+	return -1;
+}
+
+int tst_attach_loopdev(char *dev_path, size_t dev_path_len, const char *file)
+{
+	char dev[PATH_MAX];
+	unsigned int delay = 1;
+	unsigned int max_delay = tst_multiply_timeout(1000000);
+	int ret, fd;
+
+	if (strlen(file) >= LO_NAME_SIZE) {
+		tst_brkm(TBROK, NULL, "Device name can't be longer than %u chars",
+			 LO_NAME_SIZE);
+	}
+
+	fd = open(file, O_RDWR);
+	if (fd < 0) {
+		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", file);
+		goto fail;
+	}
+	close(fd);
+
+	for (;;) {
+		ret = attach_loopdev(dev, sizeof(dev), file);
+		if (ret <= 0)
+			break;
+
+		if (delay < max_delay) {
+			usleep(delay);
+			delay *= 2;
+		} else {
+			ret = -1;
+			break;
+		}
+	}
+
+	if (ret == 0) {
+		if (dev_path && dev_path_len) {
+			strncpy(dev_path, dev, dev_path_len);
+			dev_path[dev_path_len - 1] = '\0';
+		}
+		return 0;
+	}
+
+fail:
+	if (dev_path && dev_path_len)
+		dev_path[0] = '\0';
+
+	return 1;
+}
+
 uint64_t tst_get_device_size(const char *dev_path)
 {
 	int fd;
@@ -390,10 +464,7 @@ const char *tst_acquire_loop_device(unsigned int size, const char *filename)
 		return NULL;
 	}
 
-	if (tst_find_free_loopdev(dev_path, sizeof(dev_path)) == -1)
-		return NULL;
-
-	if (tst_attach_device(dev_path, filename))
+	if (tst_attach_loopdev(dev_path, sizeof(dev_path), filename))
 		return NULL;
 
 	return dev_path;
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
