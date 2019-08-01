From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  1 Aug 2019 11:26:10 +0200
Subject: [LTP] [RFC PATCH 3/9] syscalls/preadv01: Make use of guarded
 buffers.
In-Reply-To: <20190801092616.30553-1-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
Message-ID: <20190801092616.30553-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/preadv/preadv01.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 2452f216a..95431bc60 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -24,12 +24,8 @@
 #define CHUNK           64
 
 static int fd;
-static char buf[CHUNK];
 
-static struct iovec rd_iovec[] = {
-	{buf, CHUNK},
-	{NULL, 0},
-};
+static struct iovec *rd_iovec;
 
 static struct tcase {
 	int count;
@@ -111,4 +107,8 @@ static struct tst_test test = {
 	.test = verify_preadv,
 	.min_kver = "2.6.30",
 	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&rd_iovec, .iov_sizes = (int[]){CHUNK, 0, -1}},
+		{},
+	}
 };
-- 
2.21.0

