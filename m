From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 22 Jun 2021 12:35:13 +0100
Subject: [LTP] [PATCH 7/8] crash02: Save actual child PID instead of
 uninitialized variable
In-Reply-To: <20210622113514.22284-1-rpalethorpe@suse.com>
References: <20210622113514.22284-1-rpalethorpe@suse.com>
Message-ID: <20210622113514.22284-8-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/misc/crash/crash02.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
index e46c2aa66..66f308b70 100644
--- a/testcases/misc/crash/crash02.c
+++ b/testcases/misc/crash/crash02.c
@@ -197,9 +197,8 @@ void monitor_fcn(int sig)
 void badboy_fork(void)
 {
 	int status, pid;
-	pid_t child;
-	child = fork();
-	badboy_pid = status;
+	pid_t child = fork();
+
 	switch (child) {
 	case -1:
 		perror("fork");
@@ -211,6 +210,7 @@ void badboy_fork(void)
 #endif
 		exit(0);
 	default:
+		badboy_pid = child;
 		if (verbose_level > 3)
 			printf("badboy pid = %d\n", badboy_pid);
 
-- 
2.31.1

