Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624D5C3DA7F
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 06:38:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3128E3D219A
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 08:38:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2D833D1D10
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 08:37:51 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB9541000357
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 08:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723703868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GeXavfVKWNlgiqt4n+80Lx4Td9wOOaIAqtmUuPGHv5Q=;
 b=jROGUs6/896t7xGbVzE6j+mVgEDFeaJUWnIJ8UtOE21bxowRerG6By4r9z5fK0KMmQK8cT
 6ida4EupMqfDjaY8Ros2yNBu0R8GcVrR37TigkwdZ1H7WTJUXhxl1Asmpy9lvqn6dbpcEM
 sjhlkZkGQGEbBjXY/MaHJ77QQnuBhqs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-LxUqC48PNJmt34yUvBeAOg-1; Thu,
 15 Aug 2024 02:37:44 -0400
X-MC-Unique: LxUqC48PNJmt34yUvBeAOg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF5301955D48; Thu, 15 Aug 2024 06:37:42 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.12])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A00519560AA; Thu, 15 Aug 2024 06:37:40 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 15 Aug 2024 08:37:10 +0200
Message-ID: <99d43982e2469b1423701b6772677173b5a53429.1723703723.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: make tst_detach_device_by_fd() also close dev_fd
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
Cc: liwan@redhat.com, gulam.mohamed@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since commit 18048c1af783 ("loop: Fix a race between loop detach and loop open")
detach operation is deferred to the last close of the device.

Make tst_detach_device_by_fd() also close dev_fd, and leave it up to
caller to re-open it for further use.

Reported-by: Gulam Mohamed <gulam.mohamed@oracle.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_device.h                           |  4 +++-
 lib/tst_device.c                               | 10 ++++++++--
 testcases/kernel/syscalls/ioctl/ioctl09.c      |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_loop02.c |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_loop04.c |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_loop06.c |  5 ++++-
 testcases/kernel/syscalls/ioctl/ioctl_loop07.c |  2 ++
 8 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 391fb4e568f1..2597fb4e235e 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -67,7 +67,9 @@ int tst_attach_device(const char *dev_path, const char *file_path);
 uint64_t tst_get_device_size(const char *dev_path);
 
 /*
- * Detaches a file from a loop device fd.
+ * Detaches a file from a loop device fd. @dev_fd needs to be the
+ * last descriptor opened. Call to this function will close it,
+ * it is up to caller to open it again for further usage.
  *
  * @dev_path Path to the loop device e.g. /dev/loop0
  * @dev_fd a open fd for the loop device
diff --git a/lib/tst_device.c b/lib/tst_device.c
index d659b54cfdee..723f6ca06375 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -243,17 +243,23 @@ int tst_detach_device_by_fd(const char *dev, int dev_fd)
 
 	/* keep trying to clear LOOPDEV until we get ENXIO, a quick succession
 	 * of attach/detach might not give udev enough time to complete
+	 *
+	 * Since 18048c1af783 ("loop: Fix a race between loop detach and loop open")
+	 * device is detached only after last close.
 	 */
 	for (i = 0; i < 40; i++) {
 		ret = ioctl(dev_fd, LOOP_CLR_FD, 0);
 
-		if (ret && (errno == ENXIO))
+		if (ret && (errno == ENXIO)) {
+			SAFE_CLOSE(NULL, dev_fd);
 			return 0;
+		}
 
 		if (ret && (errno != EBUSY)) {
 			tst_resm(TWARN,
 				 "ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
 				 dev, tst_strerrno(errno));
+			SAFE_CLOSE(NULL, dev_fd);
 			return 1;
 		}
 
@@ -262,6 +268,7 @@ int tst_detach_device_by_fd(const char *dev, int dev_fd)
 
 	tst_resm(TWARN,
 		"ioctl(%s, LOOP_CLR_FD, 0) no ENXIO for too long", dev);
+	SAFE_CLOSE(NULL, dev_fd);
 	return 1;
 }
 
@@ -276,7 +283,6 @@ int tst_detach_device(const char *dev)
 	}
 
 	ret = tst_detach_device_by_fd(dev, dev_fd);
-	close(dev_fd);
 	return ret;
 }
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index ca682ee9ad71..9c79210864b8 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -88,6 +88,7 @@ static void verify_ioctl(void)
 	check_partition(2, true);
 
 	tst_detach_device_by_fd(dev_path, dev_fd);
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 	attach_flag = 0;
 }
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index a4d191a2e982..2f0df3b27972 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -93,6 +93,7 @@ static void verify_ioctl_loop(void)
 	check_loop_value(0, LO_FLAGS_PARTSCAN, 0);
 
 	tst_detach_device_by_fd(dev_path, dev_fd);
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 	attach_flag = 0;
 }
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index 380fd10069ab..fa193924a448 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -103,6 +103,7 @@ static void verify_ioctl_loop(unsigned int n)
 
 	SAFE_CLOSE(file_fd);
 	tst_detach_device_by_fd(dev_path, dev_fd);
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 	attach_flag = 0;
 }
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
index 5b7506ea44df..f1021cc77d7b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
@@ -63,6 +63,7 @@ static void verify_ioctl_loop(void)
 
 	SAFE_CLOSE(file_fd);
 	tst_detach_device_by_fd(dev_path, dev_fd);
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 	unlink("test.img");
 	attach_flag = 0;
 }
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 64800b4ee44b..317f693a0458 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -57,8 +57,10 @@ static void verify_ioctl_loop(unsigned int n)
 
 	if (TST_RET == 0) {
 		tst_res(TFAIL, "Set block size succeed unexpectedly");
-		if (tcases[n].ioctl_flag == LOOP_CONFIGURE)
+		if (tcases[n].ioctl_flag == LOOP_CONFIGURE) {
 			tst_detach_device_by_fd(dev_path, dev_fd);
+			dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+		}
 		return;
 	}
 	if (TST_ERR == EINVAL)
@@ -87,6 +89,7 @@ static void run(unsigned int n)
 	}
 	if (attach_flag) {
 		tst_detach_device_by_fd(dev_path, dev_fd);
+		dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 		attach_flag = 0;
 	}
 	loopconfig.block_size = *(tc->setvalue);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
index d44f36212f5b..68db79558fb4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
@@ -73,6 +73,7 @@ static void verify_ioctl_loop(unsigned int n)
 	/*Reset*/
 	if (tc->ioctl_flag == LOOP_CONFIGURE) {
 		tst_detach_device_by_fd(dev_path, dev_fd);
+		dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 	} else {
 		loopinfo.lo_sizelimit = 0;
 		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
@@ -101,6 +102,7 @@ static void run(unsigned int n)
 	}
 	if (attach_flag) {
 		tst_detach_device_by_fd(dev_path, dev_fd);
+		dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 		attach_flag = 0;
 	}
 	loopconfig.info.lo_sizelimit = tc->set_sizelimit;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
