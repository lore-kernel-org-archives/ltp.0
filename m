From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Apr 2018 16:51:40 +0200
Subject: [LTP] [COMMITTED] [PATCH 2/2] preadv03,
	pwritev03: Fix test on 32bit archs.
In-Reply-To: <20180416145140.10547-1-chrubis@suse.cz>
References: <20180416145140.10547-1-chrubis@suse.cz>
Message-ID: <20180416145140.10547-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase fails on 32bit archs as well as when LTP is compilted with
-m32 and that is because the parameter for the BLKSSZGET ioctl() is int
and not long and sizeof(int) != sizeof(long) on 32bit archs on Linux.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/preadv/preadv03.c   | 23 +++++++++++++++++------
 testcases/kernel/syscalls/pwritev/pwritev03.c | 23 +++++++++++++++++------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index 3ccd37e3b..2f23ff31f 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -37,7 +37,8 @@
 #define FNAME	MNTPOINT"/file"
 
 static int fd;
-static long blksz, org_off;
+static off_t blk_off, zero_off;
+static ssize_t blksz;
 static char *pop_buf;
 
 static struct iovec rd_iovec[] = {
@@ -51,9 +52,9 @@ static struct tcase {
 	ssize_t *size;
 	char content;
 } tcases[] = {
-	{1, &org_off, &blksz, 0x61},
-	{2, &org_off, &blksz, 0x61},
-	{1, &blksz, &blksz, 0x62},
+	{1, &zero_off, &blksz, 0x61},
+	{2, &zero_off, &blksz, 0x61},
+	{1, &blk_off, &blksz, 0x62},
 };
 
 static void verify_direct_preadv(unsigned int n)
@@ -101,10 +102,20 @@ static void verify_direct_preadv(unsigned int n)
 
 static void setup(void)
 {
-	int dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
-	SAFE_IOCTL(dev_fd, BLKSSZGET, &blksz);
+	int dev_fd, ret;
+
+	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
+	SAFE_IOCTL(dev_fd, BLKSSZGET, &ret);
 	SAFE_CLOSE(dev_fd);
 
+	if (ret <= 0)
+		tst_brk(TBROK, "BLKSSZGET returned invalid block size %i", ret);
+
+	tst_res(TINFO, "Using block size %i", ret);
+
+	blksz = ret;
+	blk_off = ret;
+
 	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT | O_DIRECT, 0644);
 
 	pop_buf = SAFE_MEMALIGN(blksz, blksz);
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index 9a5a2640b..a2ad01fb1 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -39,7 +39,8 @@
 
 static char *initbuf, *preadbuf;
 static int fd;
-static long blksz, org_off;
+static off_t blk_off, zero_off;
+static ssize_t blksz;
 
 static struct iovec wr_iovec[] = {
 	{NULL, 0},
@@ -51,9 +52,9 @@ static struct tcase {
 	off_t *offset;
 	ssize_t *size;
 } tcases[] = {
-	{1, &org_off, &blksz},
-	{2, &org_off, &blksz},
-	{1, &blksz, &blksz},
+	{1, &zero_off, &blksz},
+	{2, &zero_off, &blksz},
+	{1, &blk_off, &blksz},
 };
 
 static void verify_direct_pwritev(unsigned int n)
@@ -100,10 +101,20 @@ static void verify_direct_pwritev(unsigned int n)
 
 static void setup(void)
 {
-	int dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
-	SAFE_IOCTL(dev_fd, BLKSSZGET, &blksz);
+	int dev_fd, ret;
+	
+	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
+	SAFE_IOCTL(dev_fd, BLKSSZGET, &ret);
 	SAFE_CLOSE(dev_fd);
 
+	if (ret <= 0)
+		tst_brk(TBROK, "BLKSSZGET returned invalid block size %i", ret);
+
+	tst_res(TINFO, "Using block size %i", ret);
+
+	blksz = ret;
+	blk_off = ret;
+
 	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT | O_DIRECT, 0644);
 
 	initbuf = SAFE_MEMALIGN(blksz, blksz * 2);
-- 
2.13.6

