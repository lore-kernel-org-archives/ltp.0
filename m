Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0E6ECE564
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 07:10:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A13F63C02D1
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 09:10:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1953A3C022D
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 09:10:32 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DEA411002030
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 09:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725952230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NwzQjwXmzTw5IgKqEazZVu7EXUqL9zhUZEFYXPoE1hc=;
 b=BlL5P/dXxLt+kXBHBhfpHzBTf/Jn52vwM8F+yP94M1kq7szBIb7BgarN1T7++biv+qv+nJ
 flxAXVjBC3oF+/pcqGCp+0z56gjkYHMmPjaDd2weQUgRttFtYPXqVr6zNqrCsxkhb0jAGC
 VBvuN1xzdLL9qZsNxIWIHV78LVe0Qyg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-tHHe0Zc7OTyATwJOfLjqWw-1; Tue,
 10 Sep 2024 03:10:28 -0400
X-MC-Unique: tHHe0Zc7OTyATwJOfLjqWw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40FCB193E8DB
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 07:10:27 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEF73300147D
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 07:10:25 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 10 Sep 2024 15:10:19 +0800
Message-ID: <20240910071019.551379-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tmpdir: rename tst_tmpdir_mkpath to tst_tmpdir_genpath
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

When I reviewed the rename15 patch I felt confused a while on
function like tst_tmpdir_mkpath (reminds me of: mkdir).

Because the name could be misleading since it suggests that a
file or directory is being created, when in fact it is simply
constructing a path inside a temporary directory without
actually creating any files.

To make the function's purpose clearer, the name should reflect
that it is only constructing or generating a path, not creating
any files or directories.

So I think either 'tst_tmpdir_genpath' or 'tst_tmpdir_buildpath'
would be concise and clear options.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_tmpdir.h                                | 4 ++--
 lib/newlib_tests/tst_device.c                       | 2 +-
 lib/tst_tmpdir.c                                    | 2 +-
 testcases/kernel/syscalls/faccessat/faccessat01.c   | 2 +-
 testcases/kernel/syscalls/faccessat2/faccessat201.c | 2 +-
 testcases/kernel/syscalls/fchmodat/fchmodat01.c     | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c      | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_loop02.c      | 4 ++--
 testcases/kernel/syscalls/ioctl/ioctl_loop05.c      | 2 +-
 testcases/kernel/syscalls/mount/mount06.c           | 8 ++++----
 testcases/kernel/syscalls/mount/mount07.c           | 6 +++---
 testcases/kernel/syscalls/pathconf/pathconf02.c     | 2 +-
 testcases/kernel/syscalls/readlinkat/readlinkat01.c | 2 +-
 testcases/kernel/syscalls/stat/stat04.c             | 4 ++--
 14 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/tst_tmpdir.h b/include/tst_tmpdir.h
index d25eeba02..85d708233 100644
--- a/include/tst_tmpdir.h
+++ b/include/tst_tmpdir.h
@@ -29,7 +29,7 @@ void tst_purge_dir(const char *path);
 char *tst_tmpdir_path(void);
 
 /**
- * tst_tmpdir_mkpath - Construct an absolute path pointing to a file inside tmpdir.
+ * tst_tmpdir_genpath - Construct an absolute path pointing to a file inside tmpdir.
  *
  * Constructs a path inside tmpdir i.e. adds a prefix pointing to the current
  * test tmpdir to the string build by the printf-like format.
@@ -41,7 +41,7 @@ char *tst_tmpdir_path(void);
  * of the test. If allocation fails the function calls tst_brk() and exits the
  * test.
  */
-char *tst_tmpdir_mkpath(const char *fmt, ...)
+char *tst_tmpdir_genpath(const char *fmt, ...)
 	__attribute__((format(printf, 1, 2)));
 
 /*
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index ef69728f4..a450b284d 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -29,7 +29,7 @@ static void setup(void)
 {
 	int fd;
 
-	mntpoint = tst_tmpdir_mkpath("mnt");
+	mntpoint = tst_tmpdir_genpath("mnt");
 
 	fd = SAFE_OPEN(tst_device->dev, O_RDONLY);
 
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 5c63f7b3c..6ed2367b9 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -372,7 +372,7 @@ char *tst_tmpdir_path(void)
 	return tmpdir;
 }
 
-char *tst_tmpdir_mkpath(const char *fmt, ...)
+char *tst_tmpdir_genpath(const char *fmt, ...)
 {
 	size_t testdir_len, path_len;
 	va_list va, vac;
diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index d429cdd14..6be2b4bb7 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -55,7 +55,7 @@ static void verify_faccessat(unsigned int i)
 
 static void setup(void)
 {
-	abs_path = tst_tmpdir_mkpath(FILEPATH);
+	abs_path = tst_tmpdir_genpath(FILEPATH);
 
 	SAFE_MKDIR(TESTDIR, 0700);
 	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
diff --git a/testcases/kernel/syscalls/faccessat2/faccessat201.c b/testcases/kernel/syscalls/faccessat2/faccessat201.c
index bbe441b51..1be6e9aa0 100644
--- a/testcases/kernel/syscalls/faccessat2/faccessat201.c
+++ b/testcases/kernel/syscalls/faccessat2/faccessat201.c
@@ -56,7 +56,7 @@ static void verify_faccessat2(unsigned int i)
 
 static void setup(void)
 {
-	abs_path = tst_tmpdir_mkpath(RELPATH);
+	abs_path = tst_tmpdir_genpath(RELPATH);
 
 	SAFE_MKDIR(TESTDIR, 0777);
 	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 97ba31763..7ca65648f 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -60,7 +60,7 @@ static void verify_fchmodat(unsigned int i)
 
 static void setup(void)
 {
-	abs_path = tst_tmpdir_mkpath(FILEPATH);
+	abs_path = tst_tmpdir_genpath(FILEPATH);
 
 	SAFE_MKDIR(TESTDIR, 0700);
 	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index 2f0df3b27..e7b337e4a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -126,7 +126,7 @@ static void setup(void)
 	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
 	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);
 	sprintf(sys_loop_partpath, "/sys/block/loop%d/loop%dp1", dev_num, dev_num);
-	backing_file_path = tst_tmpdir_mkpath("test.img");
+	backing_file_path = tst_tmpdir_genpath("test.img");
 	sprintf(loop_partpath, "%sp1", dev_path);
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 }
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index fa193924a..dc983ac5f 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -121,8 +121,8 @@ static void setup(void)
 	tst_fill_file("test2.img", 0, 2048, 20);
 
 	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);
-	backing_file_path = tst_tmpdir_mkpath("test.img");
-	backing_file_change_path = tst_tmpdir_mkpath("test1.img");
+	backing_file_path = tst_tmpdir_genpath("test.img");
+	backing_file_change_path = tst_tmpdir_genpath("test1.img");
 	sprintf(loop_ro_path, "/sys/block/loop%d/ro", dev_num);
 
 	file_change_fd = SAFE_OPEN("test1.img", O_RDWR);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index 6f19280cc..184462464 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -125,7 +125,7 @@ static void setup(void)
 	 *   size of loop is bigger than the backing device's and the loop
 	 *   needn't transform transfer.
 	 */
-	backing_file_path = tst_tmpdir_mkpath("test.img");
+	backing_file_path = tst_tmpdir_genpath("test.img");
 	tst_find_backing_dev(backing_file_path, bd_path, sizeof(bd_path));
 	block_devfd = SAFE_OPEN(bd_path, O_RDWR);
 	SAFE_IOCTL(block_devfd, BLKSSZGET, &logical_block_size);
diff --git a/testcases/kernel/syscalls/mount/mount06.c b/testcases/kernel/syscalls/mount/mount06.c
index 8028dc5ec..05d6fdf86 100644
--- a/testcases/kernel/syscalls/mount/mount06.c
+++ b/testcases/kernel/syscalls/mount/mount06.c
@@ -43,10 +43,10 @@ static void setup(void)
 	SAFE_MOUNT(tmppath, tmppath, "none", MS_BIND, NULL);
 	SAFE_MOUNT("none", tmppath, "none", MS_PRIVATE, NULL);
 
-	mntpoint_src = tst_tmpdir_mkpath(MNTPOINT_SRC);
-	mntpoint_dst = tst_tmpdir_mkpath(MNTPOINT_DST);
-	tstfiles_src = tst_tmpdir_mkpath("%s/testfile", MNTPOINT_SRC);
-	tstfiles_dst = tst_tmpdir_mkpath("%s/testfile", MNTPOINT_DST);
+	mntpoint_src = tst_tmpdir_genpath(MNTPOINT_SRC);
+	mntpoint_dst = tst_tmpdir_genpath(MNTPOINT_DST);
+	tstfiles_src = tst_tmpdir_genpath("%s/testfile", MNTPOINT_SRC);
+	tstfiles_dst = tst_tmpdir_genpath("%s/testfile", MNTPOINT_DST);
 
 	SAFE_MKDIR(mntpoint_dst, 0750);
 }
diff --git a/testcases/kernel/syscalls/mount/mount07.c b/testcases/kernel/syscalls/mount/mount07.c
index 495777067..8994d0f34 100644
--- a/testcases/kernel/syscalls/mount/mount07.c
+++ b/testcases/kernel/syscalls/mount/mount07.c
@@ -114,9 +114,9 @@ static void test_statfs(bool nosymfollow)
 
 static void setup(void)
 {
-	test_file = tst_tmpdir_mkpath("%s/test_file", MNTPOINT);
-	link_file = tst_tmpdir_mkpath("%s/link_file", MNTPOINT);
-	temp_link_file = tst_tmpdir_mkpath("%s/temp_link_file", MNTPOINT);
+	test_file = tst_tmpdir_genpath("%s/test_file", MNTPOINT);
+	link_file = tst_tmpdir_genpath("%s/link_file", MNTPOINT);
+	temp_link_file = tst_tmpdir_genpath("%s/temp_link_file", MNTPOINT);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/pathconf/pathconf02.c b/testcases/kernel/syscalls/pathconf/pathconf02.c
index 42b97dc93..a7af980ec 100644
--- a/testcases/kernel/syscalls/pathconf/pathconf02.c
+++ b/testcases/kernel/syscalls/pathconf/pathconf02.c
@@ -70,7 +70,7 @@ static void setup(void)
 
 	SAFE_TOUCH("testfile", 0777, NULL);
 
-	abs_path = tst_tmpdir_mkpath(FILEPATH);
+	abs_path = tst_tmpdir_genpath(FILEPATH);
 
 	SAFE_CHMOD(tst_tmpdir_path(), 0);
 
diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index cd78ba134..9f238ff0a 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -66,7 +66,7 @@ static void verify_readlinkat(unsigned int i)
 
 static void setup(void)
 {
-	abspath = tst_tmpdir_mkpath(TEST_SYMLINK);
+	abspath = tst_tmpdir_genpath(TEST_SYMLINK);
 
 	file_fd = SAFE_OPEN(TEST_FILE, O_CREAT, 0600);
 	SAFE_SYMLINK(TEST_FILE, TEST_SYMLINK);
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
index 04ddcd2d1..05ace606a 100644
--- a/testcases/kernel/syscalls/stat/stat04.c
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -49,8 +49,8 @@ static void setup(void)
 	int pagesize;
 	int fd;
 
-	file_path = tst_tmpdir_mkpath(FILENAME);
-	symb_path = tst_tmpdir_mkpath(SYMBNAME);
+	file_path = tst_tmpdir_genpath(FILENAME);
+	symb_path = tst_tmpdir_genpath(SYMBNAME);
 
 	/* change st_blksize / st_dev */
 	SAFE_STAT(".", &sb);
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
