Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0711CCCF2D6
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792416405; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bTg9LpFb5pzFgr9jeJ+/Ch/c6xxCF80sBMICJMxNh4A=;
 b=hOgavuxz+4/HGrHVV1jF+mAyg7emFwkLvK6jeDFoIfaBNmrX8rO9rRJVGjjSt7NvtFQzo
 K0S+tRWjCGIZmxvHrY+s/R1cT9ptmOSrNS7smpW5vHc8dMWqpRt6NeOpEY+VwRBNQ3lFiVr
 JSReB6E2pp7K7+Gr5O1Afz62uPcbxNc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D53DA3EA646
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 15:26:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6256E3E61E5
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 15:26:26 +0200 (CEST)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com
 [IPv6:2607:f8b0:4864:20::447])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B5F161400760
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 15:26:25 +0200 (CEST)
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-8a0592d4539so2153315b3a.3
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792416384; x=1793021184; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B0nAAWt98gukQ+wX0mPUKQNRXDHJR/Pd7VrL0eqUXHY=;
 b=YQmACw8ixLsXP183uheK5BWdcdBT0c/DMeK+llZBP4DmT+ld5NerQs1NYX2cGUhfxc
 4nZhqB+qbzaKTmuC9PJp9va7kktOyCNaYRjWE9NC5Jxwp+HTWWZA0hVKRR9lXKTQJgE1
 SKNxYSyJIykiXM8+H9q25FPj6jCDGiqufh4cm/xGRXbwiBDs9GthFRoyVhvS5hOQZsLE
 wCivSQwTSPRx+wAxDZdQj4B5FxJhbO5gs9FtOphxeRNCD1XTKs9msBpulF+9tP6exgJU
 qQdyENMTWPV3Vvk6nK3rjgc0PSyxxICFDVbfMcs62MGx2W9ax34vzi+UeN+rVlEqw77i
 LmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416384; x=1793021184;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B0nAAWt98gukQ+wX0mPUKQNRXDHJR/Pd7VrL0eqUXHY=;
 b=WUeKlYJzm3zlLaBuLW9HkQQd4BouS4r+fO6cOub3PdlHiuYljutSmJjNi3xd9hYAL6
 3RrF1thdiledSyTWkTPfaWl94akZrFj3f541yAyYMxyZfiJkDb/wAf/gP/rrl+zUcmjR
 QTQD1Wq3b84z91a6af9pzjebPVxIpdAiOqStoiOuwSCTniz1uxaFfvpRGQgEXqAVG7sf
 c21dMjmQ39Shx72DkfcdkGPxC44YslLtiHGt9SoS9Bqq8U0tCitiwnkJS6H1mr/ymF+c
 QKBQ2dQ8mJlsXOPQMR66KVAcT/+d5PAhBBOz5O3hfMgusUSYpYLg9IVLOAt7BO84trVx
 ywFA==
X-Gm-Message-State: AFq9FYJsEjfZE5nnsieVXQPS75Hqta/OEmLVZgRe9owUSWh3EKqe6U3p
 b04maHTVU4v2JkPCn5lzHIykZ7U0OrCFhs5Nl10LJTnZz+2x2jiSF2O9TxOo4n1cmKJ6d6BySFd
 BjGX3gHfpI4CX7u7kQ8FrXzVuZAxpMxvfU3oAHq2I/SpBVFbRvwPofVF3bBK9hN/QLq0YjucJMy
 N0KIymXMdEZXmacXcQaROcEwwQrw==
X-Received: from pgby5-n2.prod.google.com
 ([2002:a05:6a02:6505:20b0:cc7:bf05:917e])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f9e:b0:3e1:8563:2a2c
 with SMTP id adf61e73a8af0-3e22606ffb8mr6961782637.40.1792416383624; Mon, 19
 Oct 2026 06:26:23 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:26:21 +0000
In-Reply-To: <20261014093618.1475191-1-wakel@google.com>
Mime-Version: 1.0
References: <20261014093618.1475191-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261019132621.3943362-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] swapon04: Report TCONF when SELinux denies loop
 device I/O
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
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Kernels without commit f2fed441c69b ("loop: stop using
vfs_iter_{read,write} for buffered I/O") access the loop backing file
through vfs_iter_{read,write}(), which run the LSM file permission
checks with the credentials of the loop worker kernel thread.

swapon04 backs the loop device with a file on the freshly formatted
test filesystem. That file has no SELinux label, and strict policies
such as Android's do not allow the kernel domain to access unlabeled
files. Every I/O on the loop device then fails with EIO and the test
breaks on the first mkswap call:

  tst_cmd.c:114: TBROK: 'mkswap' exited with a non-zero code 1

  avc: denied { read } for comm="kworker/u8:0" dev="loop52" ino=12
    scontext=u:r:kernel:s0 tcontext=u:object_r:unlabeled:s0
    tclass=file permissive=0

This is a policy restriction rather than a swap bug, and it does not
depend on how LTP is built: running the system's losetup and mkswap
on such a file fails the same way. The test passes on the same 6.1
kernel once SELinux is switched to permissive mode, and on a 6.18
kernel in enforcing mode.

The commit was merged in v6.15, so v6.15 and newer are not affected.
On older kernels the version alone does not tell whether the test can
run: the commit has been backported to stable kernels such as v6.12.25
and v6.14.4, and kernels without it still pass the test unless the
policy gets in the way.

So on kernels older than v6.15 with SELinux in enforcing mode, read
the first sector of the loop device in setup() and report TCONF if it
fails with EIO. On the 6.1 kernel above, ext2, ext3 and ext4 are now
skipped, while tmpfs, whose files the kernel domain is allowed to
access, still passes.

Signed-off-by: Wake Liu <wakel@google.com>
---
Changes in v2:
- Return early on v6.15 and newer and when SELinux is not enforcing,
  so the loop device is only probed where the denial can happen
  (Cyril).
- Mention v6.15 and the stable backports in the comment and the
  commit message.

v1: https://lore.kernel.org/ltp/20261014093618.1475191-1-wakel@google.com/

 testcases/kernel/syscalls/swapon/swapon04.c | 35 +++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/testcases/kernel/syscalls/swapon/swapon04.c b/testcases/kernel/syscalls/swapon/swapon04.c
index de95849e3..5f5206d87 100644
--- a/testcases/kernel/syscalls/swapon/swapon04.c
+++ b/testcases/kernel/syscalls/swapon/swapon04.c
@@ -84,6 +84,39 @@ static struct tcase {
 	},
 };
 
+/*
+ * Kernels without commit f2fed441c69b ("loop: stop using
+ * vfs_iter_{read,write} for buffered I/O"), merged in v6.15, access the
+ * backing file through vfs_iter_{read,write}(), which run LSM permission
+ * checks with the credentials of the loop worker kernel thread. Strict
+ * SELinux policies, such as Android's, do not allow the kernel to access
+ * the unlabeled files on the freshly formatted test filesystem, so any I/O
+ * on the loop device fails with EIO.
+ *
+ * The commit has been backported to some stable kernels (e.g. v6.12.25),
+ * so on older kernels the loop device has to be probed.
+ */
+static void check_loop_io(void)
+{
+	char buf[512];
+	int fd;
+
+	if (tst_kvercmp(6, 15, 0) >= 0 || !tst_selinux_enforcing())
+		return;
+
+	fd = SAFE_OPEN(loop_dev, O_RDONLY);
+	TEST(read(fd, buf, sizeof(buf)));
+	SAFE_CLOSE(fd);
+
+	if (TST_RET == (long)sizeof(buf))
+		return;
+
+	if (TST_RET == -1 && TST_ERR == EIO)
+		tst_brk(TCONF | TTERRNO, "I/O on %s is likely denied by SELinux", loop_dev);
+
+	tst_brk(TBROK | TTERRNO, "read(%s) returned %ld", loop_dev, TST_RET);
+}
+
 static void setup(void)
 {
 	char discard_path[PATH_MAX];
@@ -114,6 +147,8 @@ static void setup(void)
 		tst_brk(TBROK, "Failed to attach %s to %s", loop_dev, BACKING_FILE);
 	loop_attached = 1;
 
+	check_loop_io();
+
 	snprintf(discard_path, sizeof(discard_path),
 		 "/sys/block/loop%d/queue/discard_max_bytes", loop_dev_id);
 	if (FILE_SCANF(discard_path, "%lu", &discard_max_bytes) != 0 || discard_max_bytes == 0) {
-- 
2.56.0.176.g3575e65682-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
