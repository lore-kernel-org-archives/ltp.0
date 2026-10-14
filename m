Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11131CC6B2A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791970601; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=yhgwfJ3BiXz5J6EqvziI2KytHj74QpupOv8R6LZFfGk=;
 b=dn7xQ7iJaTd7dtwt8ymZqs5YlXlM6CgM33BwemZMQmmPtIAg0dnqC/nBuYZQXfQmcVW8M
 x2qObPGQxL3gQHsJ82zZ+HsaV0DbffWIVYOS13DYVrwB4rWK9QEmjY3i7B+ojUWq6Nsnbzu
 dKlFqAbS0+4spfw/ScBHwIhZWK4pYJQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55A203E6A44
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:36:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44B503E6A3D
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 11:36:23 +0200 (CEST)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com
 [IPv6:2607:f8b0:4864:20::1048])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9AEE4600A18
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 11:36:22 +0200 (CEST)
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-3a8041a532eso188045a91.3
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791970581; x=1792575381; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ZRYuUBMp0i3iCRg7RhtvkbGLeTyOFvpdD0zwYGNUTM=;
 b=aY+C2ajIR5X9ynamT08AWP2D5kXOjHS8++BPeIXh488iBOxYS+9HMWqzYHCVxBJcM/
 cI9nS8ikIR9LZc0+gBSg6CpNWSbcdb5WTJrBsX/dQxzQMowbZqSKuCO7Ow5UKF+/S+dS
 FaVIFTpYQB3ahHXhnceuZ6V9XwiefARsPvg1QxfdEl6UeSDIiZDV+pc3+mIOgOMhXXOM
 C0FW1yDKrhQsmC7zno5ObbRQIy6OXXvKn2RPALEUFpBvI908s+HXz+jbP4cJ94bLLzXF
 qfV8IE94IC1n8VI3LsCFO31WD5ka9s/weLe+//ydVXPW/GjHYuSF2Ar6BNGqNhkpks3z
 63PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970581; x=1792575381;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6ZRYuUBMp0i3iCRg7RhtvkbGLeTyOFvpdD0zwYGNUTM=;
 b=qW0CMzu6XrTKjx8U851fHUzb75xbSh43iMWkJbzWWOCyha7rZSpr+ZfZk6UDK1x7W4
 Yd0Y4D4ZITbXgfEoqNVdPQcuzpnr4Q4/ZxUzUOirgkhF/gMhSwX/HG9/AXWCY9jnZcij
 UlYO0LCgFDpNMSQcxZLRpNyrIg3KeNF/CINvOyWH6z8ulXPyg5+BU8QAj86g3set7p+T
 vIFkvKRme6vE/W2mFj99WryzGTaTVp0o5Qh0m55CHJlJrWUuOVCzgbu+t9Y4CWjJbjBl
 3X/uGqfwXeamg/LqMrtzD/VK5L3Bj5+nDy3uJx4t0xebrR00tVjL7Hl141fkWvvwJ38Q
 AzCg==
X-Gm-Message-State: AFq9FYJHxRxCSDLRSGPGcNr8GrojPMsKV2eNMmXjs1d0hw8OeR1DVXG1
 tzQ/I+7X0LFVOIyFmlED0GBj4wJLnhvKbTkVvtEwvBfTrIJigH4VQZBVC7ihwgYQXsi+o8JGLiU
 ijBNs3Sz64B8FihISwh85g7vDQm5BEW66FJVMK3nWnTwIHDbVjoC0blaJjXQXjggYoScQnQRIMP
 K6g7ap2ipOhgB9DdMHPbkIe9Xqag==
X-Received: from pjbkh21.prod.google.com ([2002:a17:90b:34d5:b0:3ac:20d5:5e0c])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:384a:b0:3a8:bb56:f1ef
 with SMTP id 98e67ed59e1d1-3ab3a2902a2mr13235559a91.2.1791970580596; Wed, 14
 Oct 2026 02:36:20 -0700 (PDT)
Date: Wed, 14 Oct 2026 09:36:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014093618.1475191-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] swapon04: Report TCONF when SELinux denies loop
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

A kernel version check would not help, since that commit has been
backported to v6.12.25, and older kernels pass the test when the
policy does not get in the way. Instead, read the first sector of the
loop device in setup() and report TCONF if it fails with EIO while
SELinux is enforcing. On the 6.1 kernel above, ext2, ext3 and ext4
are now skipped, while tmpfs, whose files the kernel domain is
allowed to access, still passes.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/swapon/swapon04.c | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/testcases/kernel/syscalls/swapon/swapon04.c b/testcases/kernel/syscalls/swapon/swapon04.c
index de95849e3..839752dd4 100644
--- a/testcases/kernel/syscalls/swapon/swapon04.c
+++ b/testcases/kernel/syscalls/swapon/swapon04.c
@@ -84,6 +84,33 @@ static struct tcase {
 	},
 };
 
+/*
+ * Kernels without commit f2fed441c69b ("loop: stop using
+ * vfs_iter_{read,write} for buffered I/O") access the backing file through
+ * vfs_iter_{read,write}(), which run LSM permission checks with the
+ * credentials of the loop worker kernel thread. Strict SELinux policies,
+ * such as Android's, do not allow the kernel to access the unlabeled files
+ * on the freshly formatted test filesystem, so any I/O on the loop device
+ * fails with EIO.
+ */
+static void check_loop_io(void)
+{
+	char buf[512];
+	int fd;
+
+	fd = SAFE_OPEN(loop_dev, O_RDONLY);
+	TEST(read(fd, buf, sizeof(buf)));
+	SAFE_CLOSE(fd);
+
+	if (TST_RET == (long)sizeof(buf))
+		return;
+
+	if (TST_RET == -1 && TST_ERR == EIO && tst_selinux_enforcing())
+		tst_brk(TCONF | TTERRNO, "I/O on %s is likely denied by SELinux", loop_dev);
+
+	tst_brk(TBROK | TTERRNO, "read(%s) returned %ld", loop_dev, TST_RET);
+}
+
 static void setup(void)
 {
 	char discard_path[PATH_MAX];
@@ -114,6 +141,8 @@ static void setup(void)
 		tst_brk(TBROK, "Failed to attach %s to %s", loop_dev, BACKING_FILE);
 	loop_attached = 1;
 
+	check_loop_io();
+
 	snprintf(discard_path, sizeof(discard_path),
 		 "/sys/block/loop%d/queue/discard_max_bytes", loop_dev_id);
 	if (FILE_SCANF(discard_path, "%lu", &discard_max_bytes) != 0 || discard_max_bytes == 0) {
-- 
2.56.0.385.gd3acb90ef8-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
