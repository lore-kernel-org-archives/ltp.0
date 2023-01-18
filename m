Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15513C00A5A
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 03:46:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B48813CD97F
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 04:46:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0ED5C3CB49A
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 04:46:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 132921000463
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 04:46:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C35520AEB;
 Wed, 18 Jan 2023 03:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674013576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xiCY1u772AemZ9GXw5/uFIZL1kE5Mduxu33vTjAGg0=;
 b=H3PGvvGfWoHfobE7C2AZLX+Yeso8k329g0vmeJ2FOozrYdCV0JLt6H56RJyR04qpKfaoto
 9YXINnogN3Py+Fa8zfN4qIOKqfA1V1rvVZL0HLkiOQ41pCbbIxVwTCespOCTXl1/v/dYfF
 hWzbZHlQEdLNVt5NYiYxVjquMUC/u/E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 415C813444;
 Wed, 18 Jan 2023 03:46:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fp/iBodrx2O5GwAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 18 Jan 2023 03:46:15 +0000
To: ltp@lists.linux.it
Date: Tue, 17 Jan 2023 22:44:09 -0500
Message-Id: <20230118034409.23599-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230116111749.18865-1-wegao@suse.com>
References: <20230116111749.18865-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] readahead02.c: Fix check input fsize
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We run the test with a loop device it will fail with ENOSPC if we
pass -s bigger than the loop device, we should at least check if
the device is large enough in the test setup.The test should make
use of use tst_parse_filesize() so that we can pass sizes with
units e.g. -s 128M.

Signed-off-by: Wei Gao <wegao@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/readahead/readahead02.c   | 64 ++++++++++++-------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 7acf4bb18..4770f55e7 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -40,10 +40,10 @@ static char testfile[PATH_MAX] = "testfile";
 #define PROC_IO_FNAME "/proc/self/io"
 #define DEFAULT_FILESIZE (64 * 1024 * 1024)
 
-static size_t testfile_size = DEFAULT_FILESIZE;
+static long long testfile_size = DEFAULT_FILESIZE;
 static char *opt_fsizestr;
 static int pagesize;
-static unsigned long cached_max;
+static long long cached_max;
 static int ovl_mounted;
 static int readahead_length  = 4096;
 static char sys_bdi_ra_path[PATH_MAX];
@@ -51,12 +51,12 @@ static int orig_bdi_limit;
 
 static const char mntpoint[] = OVL_BASE_MNTPOINT;
 
-static int libc_readahead(int fd, off_t offset, size_t len)
+static int libc_readahead(int fd, off_t offset, long long len)
 {
 	return readahead(fd, offset, len);
 }
 
-static int fadvise_willneed(int fd, off_t offset, size_t len)
+static int fadvise_willneed(int fd, off_t offset, long long len)
 {
 	/* Should have the same effect as readahead() syscall */
 	errno = posix_fadvise(fd, offset, len, POSIX_FADV_WILLNEED);
@@ -69,7 +69,7 @@ static struct tcase {
 	int use_overlay;
 	int use_fadvise;
 	/* Use either readahead() syscall or POSIX_FADV_WILLNEED */
-	int (*readahead)(int fd, off_t offset, size_t len);
+	int (*readahead)(int fd, off_t offset, long long len);
 } tcases[] = {
 	{ "readahead on file", 0, 0, libc_readahead },
 	{ "readahead on overlayfs file", 1, 0, libc_readahead },
@@ -121,11 +121,11 @@ static void create_testfile(int use_overlay)
 {
 	int fd;
 	char *tmp;
-	size_t i;
+	long long i;
 
 	sprintf(testfile, "%s/testfile",
 		use_overlay ? OVL_MNT : OVL_BASE_MNTPOINT);
-	tst_res(TINFO, "creating test file of size: %zu", testfile_size);
+	tst_res(TINFO, "creating test file of size: %lli", testfile_size);
 	tmp = SAFE_MALLOC(pagesize);
 
 	/* round to page size */
@@ -151,12 +151,12 @@ static void create_testfile(int use_overlay)
  * @cached: returns cached kB from /proc/meminfo
  */
 static int read_testfile(struct tcase *tc, int do_readahead,
-			 const char *fname, size_t fsize,
-			 unsigned long *read_bytes, long long *usec,
-			 unsigned long *cached)
+			 const char *fname, long long fsize,
+			 long long *read_bytes, long long *usec,
+			 long long *cached)
 {
 	int fd;
-	size_t i = 0;
+	long long i = 0;
 	long read_bytes_start;
 	unsigned char *p, tmp;
 	off_t offset = 0;
@@ -173,8 +173,8 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 
 			i++;
 			offset += readahead_length;
-		} while ((size_t)offset < fsize);
-		tst_res(TINFO, "readahead calls made: %zu", i);
+		} while ((long long)offset < fsize);
+		tst_res(TINFO, "readahead calls made: %lli", i);
 		*cached = get_cached_size();
 
 		/* offset of file shouldn't change after readahead */
@@ -214,9 +214,9 @@ static int read_testfile(struct tcase *tc, int do_readahead,
 
 static void test_readahead(unsigned int n)
 {
-	unsigned long read_bytes, read_bytes_ra;
+	long long read_bytes, read_bytes_ra;
 	long long usec, usec_ra;
-	unsigned long cached_high, cached_low, cached, cached_ra;
+	long long cached_high, cached_low, cached, cached_ra;
 	int ret;
 	struct tcase *tc = &tcases[n];
 
@@ -286,8 +286,8 @@ static void test_readahead(unsigned int n)
 	tst_res(TINFO, "read_testfile(0) took: %lli usec", usec);
 	tst_res(TINFO, "read_testfile(1) took: %lli usec", usec_ra);
 	if (has_file(PROC_IO_FNAME, 0)) {
-		tst_res(TINFO, "read_testfile(0) read: %ld bytes", read_bytes);
-		tst_res(TINFO, "read_testfile(1) read: %ld bytes",
+		tst_res(TINFO, "read_testfile(0) read: %lli bytes", read_bytes);
+		tst_res(TINFO, "read_testfile(1) read: %lli bytes",
 			read_bytes_ra);
 		/* actual number of read bytes depends on total RAM */
 		if (read_bytes_ra < read_bytes)
@@ -299,9 +299,9 @@ static void test_readahead(unsigned int n)
 			" unable to determine read bytes during test");
 	}
 
-	tst_res(TINFO, "cache can hold at least: %ld kB", cached_max);
-	tst_res(TINFO, "read_testfile(0) used cache: %ld kB", cached);
-	tst_res(TINFO, "read_testfile(1) used cache: %ld kB", cached_ra);
+	tst_res(TINFO, "cache can hold at least: %lli kB", cached_max);
+	tst_res(TINFO, "read_testfile(0) used cache: %lli kB", cached);
+	tst_res(TINFO, "read_testfile(1) used cache: %lli kB", cached_ra);
 
 	if (cached_max * 1024 >= testfile_size) {
 		/*
@@ -366,11 +366,28 @@ static void setup_readahead_length(void)
 
 static void setup(void)
 {
-	if (opt_fsizestr) {
-		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
-		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
+	/*
+	 * Acutaly dev size will reduced after create filesystem, for example
+	 * system set default dev size is 300M but acutal dev size is 280M
+	 * "df -h" example resulst in case dev size = 300M:
+	 * /dev/loop1      280M  272M     0 100% /tmp/LTP_reaNP2ElW/mntpoint
+	 * Around 7% space loss so we use dev_szie * 0.9 as dev real usage size
+	 * Test case will create two files within dev so we need div 2 to get
+	 * max file size
+	 */
+
+	long long fsize_max = tst_device->size * 0.9 / 2 * 1024 * 1024;
+
+	/* At least two pagesize for test case */
+	pagesize = getpagesize();
+	long long fsize_min = pagesize * 2;
+
+	if (tst_parse_filesize(opt_fsizestr, &testfile_size, fsize_min, fsize_max)) {
+		tst_brk(TBROK, "invalid input filesize '%s'", opt_fsizestr);
 	}
 
+	tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
+
 	if (access(PROC_IO_FNAME, F_OK))
 		tst_brk(TCONF, "Requires " PROC_IO_FNAME);
 
@@ -380,7 +397,6 @@ static void setup(void)
 	/* check if readahead is supported */
 	tst_syscall(__NR_readahead, 0, 0, 0);
 
-	pagesize = getpagesize();
 
 	setup_readahead_length();
 	tst_res(TINFO, "readahead length: %d", readahead_length);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
