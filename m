From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 30 Sep 2020 15:50:08 +0100
Subject: [LTP] [PATCH 2/3] io_pgetevents{01,02}: Handle no AIO support
In-Reply-To: <20200930145009.16260-1-rpalethorpe@suse.com>
References: <20200930145009.16260-1-rpalethorpe@suse.com>
Message-ID: <20200930145009.16260-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c | 8 +++++---
 testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
index 2a1aad8d9..a0b56d814 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
@@ -51,9 +51,11 @@ static void run(void)
 	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT, 0644);
 	io_prep_pwrite(&cb, fd, data, 4096, 0);
 
-	ret = io_setup(1, &ctx);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "io_setup() failed");
+	TEST(io_setup(1, &ctx));
+	if (TST_RET == -ENOSYS)
+		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
+	if (TST_RET < 0)
+		tst_brk(TBROK | TRERRNO, "io_setup() failed");
 
 	ret = io_submit(ctx, 1, cbs);
 	if (ret != 1)
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
index 28afdb4a0..af71e17fe 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
@@ -65,9 +65,11 @@ static void setup(void)
 	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT, 0644);
 	io_prep_pwrite(&cb, fd, data, 4096, 0);
 
-	ret = io_setup(1, &ctx);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "io_setup() failed");
+	TEST(io_setup(1, &ctx));
+	if (TST_RET == -ENOSYS)
+		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
+	if (TST_RET < 0)
+		tst_brk(TBROK | TRERRNO, "io_setup() failed");
 
 	ctx_initialized = 1;
 
-- 
2.28.0

