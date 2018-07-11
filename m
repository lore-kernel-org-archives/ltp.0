From: Alistair Strachan <astrachan@google.com>
Date: Wed, 11 Jul 2018 09:49:24 -0700
Subject: [LTP] [PATCH] cpuset_lib: Replace index() with strchr()
In-Reply-To: <20180703091057.pfvdfxelb2u6cewi@dell5510>
References: <20180703091057.pfvdfxelb2u6cewi@dell5510>
Message-ID: <20180711164925.65342-1-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The index() function was removed in POSIX.2008. It is not implemented by
Android's bionic C library for 64-bit platforms.

Use the more portable strchr() function from C89.

Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c b/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
index c2a60b683..575a61bcd 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
@@ -59,7 +59,7 @@ static int get_cpu_baseinfo(void)
 	/* get cpuinfo */
 	while (fgets(buf, sizeof(buf), fp) != NULL) {
 		istr = strtok_r(buf, "\t", &saveptr);
-		valstr = index(saveptr, ':');
+		valstr = strchr(saveptr, ':');
 		if (valstr == NULL)
 			continue;
 		valstr++;
