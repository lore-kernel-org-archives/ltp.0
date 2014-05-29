Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wq2fL-0003kF-Ox
	for ltp-list@lists.sourceforge.net; Thu, 29 May 2014 15:54:51 +0000
Date: Thu, 29 May 2014 17:54:33 +0200
From: chrubis@suse.cz
Message-ID: <20140529155433.GA13355@rei>
References: <1399552111-7367-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399552111-7367-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3] direct_io/dma_thread_diotest7.c: cleanup and
 add it to run default
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This test will create 100 files(every is 12MB), so the total needed free space is
> 1200MB at least. If the current test temporary directory do not satisfy this
> requirement, wo need to specify a big block device by running runltp with -z option.
> If satisfied, we also need to check whether filesystem, which current test temporary
> directory is in, supports the O_DIRECT flag. If not supported, we will also need to
> have tests in a big block device specified by users.
> 
> Rename runtest/test_dma_thread_diotest7 to runtest/dma_thread_diotest and
> split tests in runtest/dma_thread_diotest into separate testcases, keep one entry
> per test in runtest/dma_thread_diotest. And remove test_dma_thread_diotest7.sh,
> which is useless now.

I've simplified the file creation a bit, changed the worker thread to
exit on first corruption (like the previous code did) and pushed,
thanks. See the full diff bellow.

The tests fail for me for non-zero aligment on ext4, both original and
update version fails the same. So there is either bug in ext4 or in the
test.


diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest7.c b/testcases/kernel/io/direct_io/dma_thread_diotest7.c
index 77e67a2..73a10ec 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest7.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest7.c
@@ -111,6 +111,7 @@
 #define READSIZE	(1024*1024)
 
 #define MNT_POINT	"mntpoint"
+#define FILE_BASEPATH   MNT_POINT "/_dma_thread_test_%.04d.tmp"
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
 #define FILECOUNT	100
@@ -128,7 +129,6 @@ static void cleanup(void);
 static void help(void);
 
 static unsigned char *buffer;
-static char basefilename[128];
 
 static char *align_str;
 static int align;
@@ -197,6 +197,7 @@ static void *worker_thread(void *arg)
 
 			printf("\n");
 			tst_result = 1;
+			return NULL;
 		}
 	}
 
@@ -207,6 +208,8 @@ static void *fork_thread(void *arg)
 {
 	pid_t pid;
 
+	(void) arg;
+
 	while (!done) {
 		pid = tst_fork();
 		if (pid == 0) {
@@ -226,7 +229,7 @@ static void *fork_thread(void *arg)
 int main(int argc, char *argv[])
 {
 	int i, lc;
-	char *msg;
+	const char *msg;
 
 	workers = sysconf(_SC_NPROCESSORS_ONLN);
 	msg = parse_opts(argc, argv, options, help);
@@ -256,7 +259,7 @@ static void dma_thread_diotest_verify(void)
 	tst_result = 0;
 
 	for (n = 1; n <= FILECOUNT; n++) {
-		sprintf(filename, basefilename, n);
+		snprintf(filename, sizeof(filename), FILE_BASEPATH, n);
 		for (j = 0; j < workers; j++) {
 			worker[j].fd = SAFE_OPEN(cleanup, filename,
 						 O_RDONLY | O_DIRECT);
@@ -385,6 +388,8 @@ static void setup(void)
 		SAFE_CLOSE(NULL, fd);
 	}
 
+	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+
 	/*
 	 * verify whether the current directory has enough free space,
 	 * if it is not satisfied, we will use the LTP_BIG_DEV, which
@@ -399,15 +404,11 @@ static void setup(void)
 			tst_mkfs(NULL, device, "ext3", NULL);
 		}
 
-		SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
 		if (mount(device, MNT_POINT, "ext3", 0, NULL) < 0) {
 			tst_brkm(TBROK | TERRNO, NULL,
 				 "mount device:%s failed", device);
 		}
 		mount_flag = 1;
-		strcpy(basefilename, "mntpoint/_dma_thread_test_%.04d.tmp");
-	} else {
-		strcpy(basefilename, "_dma_thread_test_%.04d.tmp");
 	}
 
 	worker = SAFE_MALLOC(cleanup, workers * sizeof(worker_t));
@@ -416,7 +417,7 @@ static void setup(void)
 		worker[j].worker_number = j;
 
 	for (n = 1; n <= FILECOUNT; n++) {
-		sprintf(filename, basefilename, n);
+		snprintf(filename, sizeof(filename), FILE_BASEPATH, n);
 
 		if (tst_fill_file(filename, n, FILESIZE, 1)) {
 			tst_brkm(TBROK, cleanup, "failed to create file: %s",

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
