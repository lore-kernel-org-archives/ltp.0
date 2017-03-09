From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Mar 2017 16:13:05 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/6] syscalls/gettimeofday02: Default to
	10s run.
In-Reply-To: <20170309151308.17512-1-chrubis@suse.cz>
References: <20170309151308.17512-1-chrubis@suse.cz>
Message-ID: <20170309151308.17512-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running the test for 10s should be more than enough.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/gettimeofday/gettimeofday02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index 5c2d5a9..0ff001a 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -40,7 +40,7 @@
 
 static volatile sig_atomic_t done;
 static char *str_rtime;
-static int rtime = 30;
+static int rtime = 10;
 
 static struct tst_option options[] = {
 	{"T:", &str_rtime, "-T len   Test iteration runtime in seconds"},
-- 
2.10.2

