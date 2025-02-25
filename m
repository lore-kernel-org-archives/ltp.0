Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED26C021B6
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 11:45:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD4853C9B53
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 12:45:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D53133C9B21
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 12:45:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13FBF6688BD
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 12:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740483902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FKzajwLxKs46WPhQoovSWeL+CDN6sEGD/DCv6fSUf8=;
 b=Q/05BL/chINcPxLFlO1soBvmqrq7k67yKOihuhwZOeR4qeCom0T429bV7iHQFzcwoz4Gv4
 VOG0/FXD7dayBUikWqiOTiRGz/yU1lVUZPVVmewlSdYoWPlwnvOwzEqIZ4O7JbWHIC5w8z
 ZOhxeN9QqpNAsg/CEFMXA7kQrD/a9ac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-Bi7D_j2eNz6xLd4EoYwtwQ-1; Tue,
 25 Feb 2025 06:45:00 -0500
X-MC-Unique: Bi7D_j2eNz6xLd4EoYwtwQ-1
X-Mimecast-MFC-AGG-ID: Bi7D_j2eNz6xLd4EoYwtwQ_1740483899
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 901D31800873
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 11:44:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.85])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A661B19560AA
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 11:44:58 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 25 Feb 2025 12:39:04 +0100
Message-ID: <76a95636d3519b759cca00fc6883957f9b8e50ef.1740482145.git.jstancek@redhat.com>
In-Reply-To: <Z7yTEEf-BR3qnpz9@yuki.lan>
References: <Z7yTEEf-BR3qnpz9@yuki.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jSH5sKR8071TscmVuzbkHhEZ3HlJ4doOfuU6ZK9dH_A_1740483899
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] provide separate functions for getting start and
 end fs timestamps
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

Tests using tst_get_fs_timestamp() rarely fail with recent kernels,
for example (after 6.13-rc1):
  tst_test.c:1833: TINFO: === Testing on ext4 ===
  tst_test.c:1170: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
  mke2fs 1.47.2 (1-Jan-2025)
  tst_test.c:1182: TINFO: Mounting /dev/loop0 to /tmp/LTP_uti42UpHj/mntpoint fstyp=ext4 flags=0
  utime03.c:74: TPASS: utime(TEMP_FILE, NULL) passed
  utime03.c:80: TFAIL: utime() did not set expected atime, mintime: 1738291930, maxtime: 1738291930, st_atime: 1738291931
  utime03.c:85: TFAIL: utime() did not set expected mtime, mintime: 1738291930, maxtime: 1738291930, st_mtime: 1738291931

Since 4e40eff0b573 ("fs: add infrastructure for multigrain timestamps"),
filesystem can use more precise clock to update the inode.

Provide two versions of the function, for collecting start and end
timestamp, where latter one uses more precise clock.

Old function is renamed to tst_clock_get_timestamp() and used as
a helper function.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_clocks.h                          | 21 +++++++++++++++++--
 lib/tst_clocks.c                              | 20 ++++++++++++++----
 .../kernel/syscalls/ipc/msgrcv/msgrcv01.c     |  4 ++--
 .../kernel/syscalls/ipc/msgsnd/msgsnd01.c     |  4 ++--
 .../kernel/syscalls/ipc/shmctl/shmctl01.c     |  4 ++--
 testcases/kernel/syscalls/utime/utime01.c     |  6 +++---
 testcases/kernel/syscalls/utime/utime02.c     |  6 +++---
 testcases/kernel/syscalls/utime/utime03.c     |  4 ++--
 8 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/include/tst_clocks.h b/include/tst_clocks.h
index 06d2d03bef33..8b7f33d4f387 100644
--- a/include/tst_clocks.h
+++ b/include/tst_clocks.h
@@ -20,15 +20,32 @@ int tst_clock_settime(clockid_t clk_id, struct timespec *ts);
  */
 const char *tst_clock_name(clockid_t clk_id);
 
+/*
+ * Returns timestamp (seconds passed) for the specified clock.
+ * TBROKs on error.
+ */
+time_t tst_clock_get_timestamp(clockid_t clk_id);
+
 /*
  * Returns current system time for file/IPC operations, which may slightly lag
- * behind time() return values.
+ * behind time() return values. Meant to be used as lower bound in atime/mtime
+ * checks.
  *
  * The reason for this is that the time() syscall reads the nanosecond timer at
  * the time of the call and adds it to the kernel current time, because of that
  * accumulation may cause it jump one second ahead compared to the kernel time
  * stamp that is used for IPC and filesystems.
  */
-time_t tst_get_fs_timestamp(void);
+time_t tst_fs_timestamp_start(void);
+
+/*
+ * Returns current system time for file/IPC operation, using clock
+ * which has higher precision. Meant to be used as higher bound in atime/mtime
+ * checks.
+ *
+ * The reason for separate start/end functions is to cover features like
+ * multigrain timestamps, which update atime/mtime using more precise clock.
+ */
+time_t tst_fs_timestamp_end(void);
 
 #endif /* TST_CLOCKS__ */
diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 29f4b420c373..fba4a4f7ba51 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -144,15 +144,27 @@ const char *tst_clock_name(clockid_t clk_id)
 	}
 }
 
-time_t tst_get_fs_timestamp(void)
+time_t tst_clock_get_timestamp(clockid_t clk_id)
 {
 	struct timespec ts;
 	int ret;
 
-	ret = tst_clock_gettime(CLOCK_REALTIME_COARSE, &ts);
+	ret = tst_clock_gettime(clk_id, &ts);
 
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "clock_gettime(CLOCK_REALTIME_COARSE)");
+	if (ret < 0) {
+		tst_brk(TBROK | TERRNO, "clock_gettime(%s)",
+			tst_clock_name(clk_id));
+	}
 
 	return ts.tv_sec;
 }
+
+time_t tst_fs_timestamp_start(void)
+{
+	return tst_clock_get_timestamp(CLOCK_REALTIME_COARSE);
+}
+
+time_t tst_fs_timestamp_end(void)
+{
+	return tst_clock_get_timestamp(CLOCK_REALTIME);
+}
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
index 9df20a61e38e..58bfd27716a2 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
@@ -26,13 +26,13 @@ static void verify_msgrcv(void)
 
 	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
 
-	before_rcv = tst_get_fs_timestamp();
+	before_rcv = tst_fs_timestamp_start();
 	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgrcv failed");
 		return;
 	}
-	after_rcv = tst_get_fs_timestamp();
+	after_rcv = tst_fs_timestamp_end();
 
 	if (strcmp(rcv_buf.mtext, snd_buf.mtext) == 0)
 		tst_res(TPASS, "message received(%s) = message sent(%s)",
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index 60936be8a355..6d92f3dece11 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -30,13 +30,13 @@ static void verify_msgsnd(void)
 	struct msqid_ds qs_buf;
 	time_t before_snd, after_snd;
 
-	before_snd = tst_get_fs_timestamp();
+	before_snd = tst_fs_timestamp_start();
 	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgsnd() failed");
 		return;
 	}
-	after_snd = tst_get_fs_timestamp();
+	after_snd = tst_fs_timestamp_end();
 
 	SAFE_MSGCTL(queue_id, IPC_STAT, &qs_buf);
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index 1eec0798930f..e86cd71031af 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -242,9 +242,9 @@ static int get_shm_idx_from_id(int shm_id)
 
 static void setup(void)
 {
-	ctime_min = tst_get_fs_timestamp();
+	ctime_min = tst_fs_timestamp_start();
 	shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
-	ctime_max = tst_get_fs_timestamp();
+	ctime_max = tst_fs_timestamp_end();
 
 	shm_idx = get_shm_idx_from_id(shm_id);
 
diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index 2a74f8952d64..9e985ec3761d 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -31,7 +31,7 @@ static void run(void)
 	struct stat stat_buf;
 	time_t pre_time, post_time;
 
-	utbuf.modtime = tst_get_fs_timestamp() - 5;
+	utbuf.modtime = tst_fs_timestamp_start() - 5;
 	utbuf.actime = utbuf.modtime + 1;
 	TST_EXP_PASS_SILENT(utime(TEMP_FILE, &utbuf));
 	SAFE_STAT(TEMP_FILE, &stat_buf);
@@ -39,11 +39,11 @@ static void run(void)
 	TST_EXP_EQ_LI(stat_buf.st_atime, utbuf.actime);
 	TST_EXP_EQ_LI(stat_buf.st_mtime, utbuf.modtime);
 
-	pre_time = tst_get_fs_timestamp();
+	pre_time = tst_fs_timestamp_start();
 	TST_EXP_PASS(utime(TEMP_FILE, NULL), "utime(%s, NULL)", TEMP_FILE);
 	if (!TST_PASS)
 		return;
-	post_time = tst_get_fs_timestamp();
+	post_time = tst_fs_timestamp_end();
 	SAFE_STAT(TEMP_FILE, &stat_buf);
 
 	if (stat_buf.st_mtime < pre_time || stat_buf.st_mtime > post_time)
diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index 52185d839e65..5ed83298796d 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -48,7 +48,7 @@ static void run(void)
 	struct stat stat_buf;
 	time_t pre_time, post_time;
 
-	utbuf.modtime = tst_get_fs_timestamp() - 5;
+	utbuf.modtime = tst_fs_timestamp_start() - 5;
 	utbuf.actime = utbuf.modtime + 1;
 	TST_EXP_PASS_SILENT(utime(TEMP_FILE, &utbuf));
 	SAFE_STAT(TEMP_FILE, &stat_buf);
@@ -56,11 +56,11 @@ static void run(void)
 	TST_EXP_EQ_LI(stat_buf.st_atime, utbuf.actime);
 	TST_EXP_EQ_LI(stat_buf.st_mtime, utbuf.modtime);
 
-	pre_time = tst_get_fs_timestamp();
+	pre_time = tst_fs_timestamp_start();
 	TST_EXP_PASS(utime(TEMP_FILE, NULL), "utime(%s, NULL)", TEMP_FILE);
 	if (!TST_PASS)
 		return;
-	post_time = tst_get_fs_timestamp();
+	post_time = tst_fs_timestamp_end();
 	SAFE_STAT(TEMP_FILE, &stat_buf);
 
 	if (stat_buf.st_mtime < pre_time || stat_buf.st_mtime > post_time)
diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 564e1de3dd77..aa0dcef250c8 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -68,9 +68,9 @@ static void run(void)
 	}
 
 	SAFE_SETEUID(user_uid);
-	mintime = tst_get_fs_timestamp();
+	mintime = tst_fs_timestamp_start();
 	TST_EXP_PASS(utime(TEMP_FILE, NULL));
-	maxtime = tst_get_fs_timestamp();
+	maxtime = tst_fs_timestamp_end();
 	SAFE_SETEUID(root_uid);
 	SAFE_STAT(TEMP_FILE, &statbuf);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
