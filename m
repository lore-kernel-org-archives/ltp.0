From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:14:03 +0000
Subject: [LTP] [PATCH V2 15/32] mincore01: Rename PAGESIZE to pagesize
In-Reply-To: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452302060-103643-15-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

PAGESIZE conflicts with system headers on musl

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/mincore/mincore01.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/mincore/mincore01.c b/testcases/kernel/syscalls/mincore/mincore01.c
index 97a3d95..fa426d1 100644
--- a/testcases/kernel/syscalls/mincore/mincore01.c
+++ b/testcases/kernel/syscalls/mincore/mincore01.c
@@ -45,7 +45,7 @@
 #include "test.h"
 #include "safe_macros.h"
 
-static int PAGESIZE;
+static int pagesize;
 static rlim_t STACK_LIMIT = 10485760;
 
 static void cleanup(void);
@@ -146,7 +146,7 @@ static void setup4(struct test_case_t *tc)
 	}
 
 	tc->addr = global_pointer;
-	tc->len = as_lim.rlim_cur - (rlim_t)global_pointer + PAGESIZE;
+	tc->len = as_lim.rlim_cur - (rlim_t)global_pointer + pagesize;
 	tc->vector = global_vec;
 
 	/*
@@ -161,7 +161,7 @@ static void setup(void)
 	char *buf;
 	int fd;
 
-	PAGESIZE = getpagesize();
+	pagesize = getpagesize();
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -170,7 +170,7 @@ static void setup(void)
 	TEST_PAUSE;
 
 	/* global_pointer will point to a mmapped area of global_len bytes */
-	global_len = PAGESIZE * 2;
+	global_len = pagesize * 2;
 
 	buf = SAFE_MALLOC(cleanup, global_len);
 	memset(buf, 42, global_len);
@@ -186,7 +186,7 @@ static void setup(void)
 				   PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
 	global_vec = SAFE_MALLOC(cleanup,
-				 (global_len + PAGESIZE - 1) / PAGESIZE);
+				 (global_len + pagesize - 1) / pagesize);
 
 	SAFE_CLOSE(cleanup, fd);
 }
-- 
2.7.0

