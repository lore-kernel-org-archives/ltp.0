From: Martin Doucha <mdoucha@suse.cz>
Date: Wed,  5 May 2021 17:38:47 +0200
Subject: [LTP] [PATCH 2/2] syscalls/inotify06: Raise inotify instance limit
 in /proc
In-Reply-To: <20210505153847.6106-1-mdoucha@suse.cz>
References: <20210505153847.6106-1-mdoucha@suse.cz>
Message-ID: <20210505153847.6106-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

inotify_init() sometimes fails with EMFILE because there are too many
partially closed instances waiting for garbage collection. Bump the limit
in /proc/sys/fs/inotify/max_user_instances for the duration of the test.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

I thought about only reading the procfile and calling yield() after every
proc_limit/2 iterations to wait for garbage collection but I'm afraid that
it might reduce the likelihood of triggering the bug. Since I currently have
no system where I could reproduce the race, I've decided to play it safe and
bump the /proc limit.

 testcases/kernel/syscalls/inotify/inotify06.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index f39ab46a1..68813769b 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -38,8 +38,11 @@
 /* Number of files to test (must be > 1) */
 #define FILES 5
 
+#define PROCFILE "/proc/sys/fs/inotify/max_user_instances"
+
 static char names[FILES][PATH_MAX];
 static pid_t pid;
+static int old_proc_limit;
 
 static void setup(void)
 {
@@ -47,6 +50,11 @@ static void setup(void)
 
 	for (i = 0; i < FILES; i++)
 		sprintf(names[i], "fname_%d", i);
+
+	SAFE_FILE_SCANF(PROCFILE, "%d", &old_proc_limit);
+
+	if (old_proc_limit >= 0 && old_proc_limit < TEARDOWNS)
+		SAFE_FILE_PRINTF(PROCFILE, "%d", TEARDOWNS + 128);
 }
 
 static void verify_inotify(void)
@@ -95,10 +103,13 @@ static void cleanup(void)
 		SAFE_KILL(pid, SIGKILL);
 		SAFE_WAIT(NULL);
 	}
+
+	SAFE_FILE_PRINTF(PROCFILE, "%d", old_proc_limit);
 }
 
 static struct tst_test test = {
 	.timeout = 600,
+	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.setup = setup,
-- 
2.31.1

