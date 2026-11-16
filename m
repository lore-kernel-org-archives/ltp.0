Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053BB606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=i4Sq6UkW;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=A0WVRvBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794819411; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+18lIZtKyvCGq4AppvtUMi9bWkMSx8Kpzc8DvvTPpRM=;
 b=i4Sq6UkW/XxcWHmU7hDZyP/747rhO8o/Gr3Sd52ifQExknGkvOJw0QYck4PNOdoP6+YW7
 lWS4QYURxqW3gUp6FN9LzKFvQOBPy2SO8WY6qAx+RNpnRavLXRL6K+L4qhEl0AtxNqlKaAl
 ag9bZoe4gt3IZbgYk47LGtgka/xSG3M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CEE23E941E
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 09:56:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B47A3E93FF
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 09:56:17 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B6F93140007E
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 09:56:16 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4919a880834so1505518f8f.0
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794819376; x=1795424176; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=95015WTvNjMSx9e+WqKw3fQwa3Iqq3gtf/VbZvQ3r+w=;
 b=A0WVRvBCaln5KcOEUPPrKMFva0MgCKiqPQAV99psVQlf31nPHRlLIkeDPopHXjZ1nI
 +pAHENhYZ/N24ZVy89nr1CRJ+/hj3xIcQsB//wnfxMixqXcgj/UEInwx3l7ZAO41aIVA
 IZOAp5Cmjnp2uJ0IlyVj0sIQVpNJSv3W67yYoKSUn3ZqhCKBzS+R1yQPSeMvqBGmQgPd
 yb5hsokcaE4lGjzF81kO9NV9c/Rf26jXJSmtnbsLAAtzIFE5bIlgQ8YgjIt5fyAimTK7
 XJSwfRpJdBEq6FHe4cMRhiir7kHmmpK/XqrqETyW7V9v0vp95RwQiqtn8EhHXmzcH8XC
 gyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794819376; x=1795424176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=95015WTvNjMSx9e+WqKw3fQwa3Iqq3gtf/VbZvQ3r+w=;
 b=fK+mu8CTx5qU+KFiKgUzhFm2vZ9zwTz5bHQeFi+u2oDX5T7e3Z0c2bFwbGNTg8ANUV
 ECcSrWor/iUru2reXcpJrNS4LV2xsIq9yYr/XDxjVfGRlwJXfnW+4R/Qa40yOeyz63+9
 Z3TTLuY1fEG+o8M1N0CfvlOs/rI31yhuhPAacVTdyM5rzlZ8IpNq9G8IqQZXy1VDfrYj
 OfsMGUCaipso+FpqozS+PFMLgmODXAckT3fZs1GSApWcPweOitHCUrxcL4/BSmvmO0Ee
 yu3mhwXpZqYmDy6uBNunbGzssR2cE3LQSkoPDU9qka3yzow6VwJhpELrRiUUL24Qe9+x
 XE5Q==
X-Gm-Message-State: APuU4Z8Numwzo0Q2LQlFPk0UvzdDJK6ue4zha4JnpqQw/m3/ZJjwwzzm
 cxBbHbby5ut4ZT4+jUfRS9g3YYKVAfFFCDlKDhHZGruNBeWty28k3Vt+JnsgPE02hgPmoVGEkCr
 +futhYtkA
X-Gm-Gg: AZFdTZcdtMzAe2WnSRzy9aXXV5/tDn9QROyy+1JT+yvLOmX4Z7a8ahLeF+B3PTkmQ4J
 4WjDMaT2606io6TAjVyorhLQ3SZEm4TDXviqgYjokhbDg2RTYF2pjsY18puNBlxDqTkukhZU2Vk
 Q+eWgBaT6+mc+Haz+vy01JqSLsJkZvG+kyf+QAI8VGZRy027+gjHDcTHBkqpDKWBW4fePCKeUY3
 WI8Dz3TJTVcjbljZQJSKi9wiaGsKmtDicTGMfKTAvmQ7wRfez3Ur768utorWaQHIkI7C4wOTD88
 zVsJ9SN9eTta0dlNwdky2MYamzoQrx/y6+f3KDyhkG5R9GoMq8NMho2oputu1LlcUpBQPH7ZbPf
 iD1pvPo0n9stAgXGLI5YIllk24G9M2ZBBaPOXi8JekCJOIERZQ9rqJPMBYCtbBLMJOQYqSjakoB
 2K3Cyd3mazRmtejTsPWIegzP9xxcxLt51EUF8Zrc/ACkFlHmQCz7SKMSNv41Ii8OtxOzj3K2MOi
 Wa6TkQeo3NcVYCYuv75khebnfWV09DLZdKv6u5ml98r3FNHa/7uUmtwc2SN7a2fVs4yVm20kR3f
 JimkV6BdHeHz2FkwHmxt71SjJDFpHn4vFdSTtChrlRXScfmBt9t+/0plMc+I7oYaeTSncbbYptI
 QM30nUQViPdf0vMsHkWJFUAC1vrbAulcbHw==
X-Received: by 2002:a05:6000:4213:b0:493:e0db:b519 with SMTP id
 ffacd0b85a97d-49c6e4a3997mr20097005f8f.6.1794819376066; 
 Mon, 16 Nov 2026 00:56:16 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-49c5d03b104sm21662011f8f.6.2026.11.16.00.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:56:15 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 16 Nov 2026 08:56:04 +0000
Message-ID: <20261116085612.20171-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116085612.20171-1-wegao@suse.com>
References: <20261116085612.20171-1-wegao@suse.com>
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
Subject: [LTP] [PATCH v19 1/3] lib: Add tst_attach_loopdev()
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
backoff if the candidate device is claimed concurrently (EBUSY).
The function returns a newly allocated string containing the device
path on success, or NULL on failure. Also introduce the
SAFE_ATTACH_LOOPDEV() helper macro.

Update tst_acquire_loop_device() to use tst_attach_loopdev().

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_device.h | 26 ++++++++++++++
 lib/tst_device.c     | 82 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 0989e4501..4e2e14b89 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -110,6 +110,32 @@ int tst_find_free_loopdev(char *path, size_t path_len);
  */
 int tst_attach_device(const char *dev_path, const char *file_path);
 
+/**
+ * tst_attach_loopdev() - Find a free loop device and attach a file to it.
+ * @file_path: Path to a file (e.g. disk.img).
+ *
+ * Finds an unused loop device and attaches @file_path to it, automatically
+ * retrying the lookup if the chosen device is claimed concurrently (EBUSY).
+ *
+ * Return: Newly allocated string containing the device path on success,
+ *         or NULL on failure. Caller is responsible for free()-ing the string.
+ */
+char *tst_attach_loopdev(const char *file_path);
+
+/**
+ * safe_attach_loopdev() - Safe wrapper for tst_attach_loopdev().
+ * @file: Source file where called.
+ * @lineno: Line number where called.
+ * @file_path: Path to a file (e.g. disk.img).
+ *
+ * Return: Newly allocated string containing the device path. Calls tst_brk()
+ *         on failure. Caller is responsible for free()-ing the string.
+ */
+char *safe_attach_loopdev(const char *file, const int lineno, const char *file_path);
+
+#define SAFE_ATTACH_LOOPDEV(file_path) \
+	safe_attach_loopdev(__FILE__, __LINE__, (file_path))
+
 /**
  * tst_get_device_size() - Get device size in megabytes.
  * @dev_path: Device path.
diff --git a/lib/tst_device.c b/lib/tst_device.c
index bf77c9ded..c751e576f 100644
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
 
@@ -207,6 +214,64 @@ int tst_attach_device(const char *dev, const char *file)
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
+char *tst_attach_loopdev(const char *file)
+{
+	char dev[PATH_MAX];
+	unsigned int delay = 1;
+	unsigned int max_delay = tst_multiply_timeout(1000000);
+	int ret;
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
+	if (ret == 0)
+		return strdup(dev);
+
+	return NULL;
+}
+
+char *safe_attach_loopdev(const char *file, const int lineno, const char *file_path)
+{
+	char *dev = tst_attach_loopdev(file_path);
+
+	if (!dev) {
+		tst_brkm_(file, lineno, TBROK, NULL,
+			  "Failed to attach %s to loop device", file_path);
+	}
+
+	return dev;
+}
+
 uint64_t tst_get_device_size(const char *dev_path)
 {
 	int fd;
@@ -386,17 +451,20 @@ int tst_dev_sync(int fd)
 const char *tst_acquire_loop_device(unsigned int size, const char *filename)
 {
 	unsigned int acq_dev_size = size ? size : DEV_SIZE_MB;
+	char *dev;
 
 	if (tst_prealloc_file(filename, 1024 * 1024, acq_dev_size)) {
 		tst_resm(TWARN | TERRNO, "Failed to create %s", filename);
 		return NULL;
 	}
 
-	if (tst_find_free_loopdev(dev_path, sizeof(dev_path)) == -1)
+	dev = tst_attach_loopdev(filename);
+	if (!dev)
 		return NULL;
 
-	if (tst_attach_device(dev_path, filename))
-		return NULL;
+	strncpy(dev_path, dev, sizeof(dev_path) - 1);
+	dev_path[sizeof(dev_path) - 1] = '\0';
+	free(dev);
 
 	return dev_path;
 }
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
