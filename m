Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0166CCD18A
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 11:26:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F10683CE3CB
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 13:26:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFBCE3C0F15
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 13:26:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BCA8B140045A
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 13:26:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C61233737
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759836390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XGUPYjOlWobFr5QsuUjcIPNKeMT/pO/iZVDjC0Qxjq0=;
 b=tWK6KMxD9fl185pQgqbNd3MHi4E0GaGfAXekplhfi+9fyN8DceHXFqbe4WKjyegM7S7vcp
 kvjrrEwF6w+vBzYNZ/8JjZmnp+btXWHNjdQYTpnkjweHpxxvh4v+M+FEHGd2LrkN4FIfyK
 NgYrHdRhkuL+Oam62ahL5L9rpqC42+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759836390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XGUPYjOlWobFr5QsuUjcIPNKeMT/pO/iZVDjC0Qxjq0=;
 b=qm8Bz3CXeLkbbWNLPvlP2Z3q3+x8Tk5vSxkI+yDIZU4mwNVKlhzU0smGbPhDpN3hY9vcrv
 L9CCLyhy42IplSCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759836389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XGUPYjOlWobFr5QsuUjcIPNKeMT/pO/iZVDjC0Qxjq0=;
 b=E8KDDu3aPRHZK1NNJ/L1Z0SzphV2YtpUkM9l+zuPiQ4Q3kV+5DJ6ljBl6/Co4sAeZ//1bg
 X5gJ7EyIyGfy2C6odbZEjjXw0UcydUtYFg+0uXAXNPerGt5m19mlTyW9wMsZebOJLbctZh
 u8hJ9dPOuZIYVvFySVBlp9ieLwyrUB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759836389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XGUPYjOlWobFr5QsuUjcIPNKeMT/pO/iZVDjC0Qxjq0=;
 b=A+MLQyVF1+LCmE9sH4aDeGrv8JyqynltVDwfR6gQJnR539+99hG7z1K+ipNMDBPMzFtlEl
 UTZWsCZdLglJ2GCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D8CF13693
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 11:26:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id om3tCeX45GjwdgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 07 Oct 2025 11:26:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  7 Oct 2025 13:27:19 +0200
Message-ID: <20251007112719.13289-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_detach_device_by_fd() set dev_fd to -1
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

Apparently I tend to forget that tst_detach_device_by_fd() closes the
file descriptor. This change makes it more obvious by chaning the fd to
a pointer and also sets the dev_fd to -1, which matches the SAFE_CLOSE()
behavior.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_device.h                          |  4 ++--
 lib/tst_device.c                              | 21 ++++++++++---------
 testcases/kernel/syscalls/ioctl/ioctl09.c     |  2 +-
 .../kernel/syscalls/ioctl/ioctl_loop01.c      |  6 +++---
 .../kernel/syscalls/ioctl/ioctl_loop02.c      |  2 +-
 .../kernel/syscalls/ioctl/ioctl_loop04.c      |  2 +-
 .../kernel/syscalls/ioctl/ioctl_loop06.c      |  4 ++--
 .../kernel/syscalls/ioctl/ioctl_loop07.c      |  4 ++--
 8 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 898335b16..252942f8b 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -77,10 +77,10 @@ uint64_t tst_get_device_size(const char *dev_path);
  * it is up to caller to open it again for further usage.
  *
  * @dev_path Path to the loop device e.g. /dev/loop0
- * @dev_fd a open fd for the loop device
+ * @dev_fd An open fd for the loop device, set to -1 after the completion.
  * @return Zero on succes, non-zero otherwise.
  */
-int tst_detach_device_by_fd(const char *dev_path, int dev_fd);
+int tst_detach_device_by_fd(const char *dev_path, int *dev_fd);
 
 /*
  * Detaches a file from a loop device.
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 2364df052..6ae914720 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -239,9 +239,9 @@ uint64_t tst_get_device_size(const char *dev_path)
 	return size/1024/1024;
 }
 
-int tst_detach_device_by_fd(const char *dev, int dev_fd)
+int tst_detach_device_by_fd(const char *dev, int *dev_fd)
 {
-	int ret, i;
+	int ret, i, retval = 1;
 
 	/* keep trying to clear LOOPDEV until we get ENXIO, a quick succession
 	 * of attach/detach might not give udev enough time to complete
@@ -250,19 +250,18 @@ int tst_detach_device_by_fd(const char *dev, int dev_fd)
 	 * device is detached only after last close.
 	 */
 	for (i = 0; i < 40; i++) {
-		ret = ioctl(dev_fd, LOOP_CLR_FD, 0);
+		ret = ioctl(*dev_fd, LOOP_CLR_FD, 0);
 
 		if (ret && (errno == ENXIO)) {
-			SAFE_CLOSE(NULL, dev_fd);
-			return 0;
+			retval = 0;
+			goto exit;
 		}
 
 		if (ret && (errno != EBUSY)) {
 			tst_resm(TWARN,
 				 "ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
 				 dev, tst_strerrno(errno));
-			SAFE_CLOSE(NULL, dev_fd);
-			return 1;
+			goto exit;
 		}
 
 		usleep(50000);
@@ -270,8 +269,10 @@ int tst_detach_device_by_fd(const char *dev, int dev_fd)
 
 	tst_resm(TWARN,
 		"ioctl(%s, LOOP_CLR_FD, 0) no ENXIO for too long", dev);
-	SAFE_CLOSE(NULL, dev_fd);
-	return 1;
+exit:
+	SAFE_CLOSE(NULL, *dev_fd);
+	*dev_fd = -1;
+	return retval;
 }
 
 int tst_detach_device(const char *dev)
@@ -284,7 +285,7 @@ int tst_detach_device(const char *dev)
 		return 1;
 	}
 
-	ret = tst_detach_device_by_fd(dev, dev_fd);
+	ret = tst_detach_device_by_fd(dev, &dev_fd);
 	return ret;
 }
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index f86355f2c..262d6fcab 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -76,7 +76,7 @@ static void verify_ioctl(void)
 	check_partition(1, true);
 	check_partition(2, true);
 
-	tst_detach_device_by_fd(dev_path, dev_fd);
+	tst_detach_device_by_fd(dev_path, &dev_fd);
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 	attach_flag = 0;
 }
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index cb1b506d2..4ecc93b1e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -99,13 +99,14 @@ static void verify_ioctl_loop(void)
 	TST_ASSERT_INT(autoclear_path, 0);
 	TST_ASSERT_STR(backing_path, backing_file_path);
 
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+
 	check_loop_value(SET_FLAGS, GET_FLAGS, 1);
 
 	tst_res(TINFO, "Test flag can be clear");
 	check_loop_value(0, LO_FLAGS_PARTSCAN, 0);
 
-	tst_detach_device_by_fd(dev_path, dev_fd);
-	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	tst_detach_device_by_fd(dev_path, &dev_fd);
 
 	attach_flag = 0;
 }
@@ -122,7 +123,6 @@ static void setup(void)
 	sprintf(sys_loop_partpath, "/sys/block/loop%d/loop%dp1", dev_num, dev_num);
 	backing_file_path = tst_tmpdir_genpath("test.img");
 	sprintf(loop_partpath, "%sp1", dev_path);
-	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index 6026af1e2..10776d0b6 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -100,7 +100,7 @@ static void verify_ioctl_loop(unsigned int n)
 	}
 
 	SAFE_CLOSE(file_fd);
-	tst_detach_device_by_fd(dev_path, dev_fd);
+	tst_detach_device_by_fd(dev_path, &dev_fd);
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 	attach_flag = 0;
 }
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
index 839648f26..59f9de643 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
@@ -60,7 +60,7 @@ static void verify_ioctl_loop(void)
 	TST_ASSERT_INT(sys_loop_sizepath, NEW_SIZE/512);
 
 	SAFE_CLOSE(file_fd);
-	tst_detach_device_by_fd(dev_path, dev_fd);
+	tst_detach_device_by_fd(dev_path, &dev_fd);
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 	unlink("test.img");
 	attach_flag = 0;
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 35e9e79e9..0a9618d00 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -58,7 +58,7 @@ static void verify_ioctl_loop(unsigned int n)
 	if (TST_RET == 0) {
 		tst_res(TFAIL, "Set block size succeed unexpectedly");
 		if (tcases[n].ioctl_flag == LOOP_CONFIGURE) {
-			tst_detach_device_by_fd(dev_path, dev_fd);
+			tst_detach_device_by_fd(dev_path, &dev_fd);
 			dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 		}
 		return;
@@ -88,7 +88,7 @@ static void run(unsigned int n)
 		return;
 	}
 	if (attach_flag) {
-		tst_detach_device_by_fd(dev_path, dev_fd);
+		tst_detach_device_by_fd(dev_path, &dev_fd);
 		dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 		attach_flag = 0;
 	}
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
index be136fe0d..0e05b2021 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
@@ -70,7 +70,7 @@ static void verify_ioctl_loop(unsigned int n)
 				loopinfoget.lo_sizelimit, tc->set_sizelimit);
 	/*Reset*/
 	if (tc->ioctl_flag == LOOP_CONFIGURE) {
-		tst_detach_device_by_fd(dev_path, dev_fd);
+		tst_detach_device_by_fd(dev_path, &dev_fd);
 		dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 	} else {
 		loopinfo.lo_sizelimit = 0;
@@ -99,7 +99,7 @@ static void run(unsigned int n)
 		return;
 	}
 	if (attach_flag) {
-		tst_detach_device_by_fd(dev_path, dev_fd);
+		tst_detach_device_by_fd(dev_path, &dev_fd);
 		dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 		attach_flag = 0;
 	}
-- 
2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
