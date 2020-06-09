From: Li Wang <liwang@redhat.com>
Date: Tue,  9 Jun 2020 17:51:01 +0800
Subject: [LTP] [PATCH v4 3/4] mem: remove the old cgroup API
In-Reply-To: <20200609095102.21153-1-liwang@redhat.com>
References: <20200609095102.21153-1-liwang@redhat.com>
Message-ID: <20200609095102.21153-3-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/include/mem.h |  18 +----
 testcases/kernel/mem/lib/mem.c     | 108 -----------------------------
 2 files changed, 1 insertion(+), 125 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index c5dca1d9b..42b12a230 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -60,24 +60,8 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages);
 void check_hugepage(void);
 void write_memcg(void);
 
-/* cpuset/memcg */
-
-#define CPATH			"/dev/cpuset"
-#define CPATH_NEW		CPATH "/1"
-#define MEMCG_PATH		"/dev/cgroup"
-#define MEMCG_PATH_NEW		MEMCG_PATH "/1"
-#define MEMCG_LIMIT		MEMCG_PATH_NEW "/memory.limit_in_bytes"
-#define MEMCG_SW_LIMIT		MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes"
-#if HAVE_SYS_EVENTFD_H
-#define PATH_OOMCTRL		MEMCG_PATH_NEW "/memory.oom_control"
-#define PATH_EVTCTRL		MEMCG_PATH_NEW "/cgroup.event_control"
-#endif
-
-void read_cpuset_files(char *prefix, char *filename, char *retbuf);
-void write_cpuset_files(char *prefix, char *filename, char *buf);
+/* cpuset/memcg - include/tst_cgroup.h */
 void write_cpusets(const char *cgroup_dir, long nd);
-void mount_mem(char *name, char *fs, char *options, char *path, char *path_new);
-void umount_mem(char *path, char *path_new);
 
 /* shared */
 unsigned int get_a_numa_node(void);
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 50bee39cb..2de3f83a6 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -312,13 +312,6 @@ void check_hugepage(void)
 		tst_brk(TCONF, "Huge page is not supported.");
 }
 
-void write_memcg(void)
-{
-	SAFE_FILE_PRINTF(MEMCG_LIMIT, "%ld", TESTMEM);
-
-	SAFE_FILE_PRINTF(MEMCG_PATH_NEW "/tasks", "%d", getpid());
-}
-
 struct ksm_merge_data {
 	char data;
 	unsigned int mergeable_size;
@@ -603,7 +596,6 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 /* THP */
 
 /* cpuset/memcg */
-
 static void gather_node_cpus(char *cpus, long nd)
 {
 	int ncpus = 0;
@@ -637,55 +629,6 @@ static void gather_node_cpus(char *cpus, long nd)
 	cpus[strlen(cpus) - 1] = '\0';
 }
 
-void read_cpuset_files(char *prefix, char *filename, char *retbuf)
-{
-	int fd;
-	char path[BUFSIZ];
-
-	/*
-	 * try either '/dev/cpuset/XXXX' or '/dev/cpuset/cpuset.XXXX'
-	 * please see Documentation/cgroups/cpusets.txt from kernel src
-	 * for details
-	 */
-	snprintf(path, BUFSIZ, "%s/%s", prefix, filename);
-	fd = open(path, O_RDONLY);
-	if (fd == -1) {
-		if (errno == ENOENT) {
-			snprintf(path, BUFSIZ, "%s/cpuset.%s",
-				 prefix, filename);
-			fd = SAFE_OPEN(path, O_RDONLY);
-		} else
-			tst_brk(TBROK | TERRNO, "open %s", path);
-	}
-	if (read(fd, retbuf, BUFSIZ) < 0)
-		tst_brk(TBROK | TERRNO, "read %s", path);
-	close(fd);
-}
-
-void write_cpuset_files(char *prefix, char *filename, char *buf)
-{
-	int fd;
-	char path[BUFSIZ];
-
-	/*
-	 * try either '/dev/cpuset/XXXX' or '/dev/cpuset/cpuset.XXXX'
-	 * please see Documentation/cgroups/cpusets.txt from kernel src
-	 * for details
-	 */
-	snprintf(path, BUFSIZ, "%s/%s", prefix, filename);
-	fd = open(path, O_WRONLY);
-	if (fd == -1) {
-		if (errno == ENOENT) {
-			snprintf(path, BUFSIZ, "%s/cpuset.%s",
-				 prefix, filename);
-			fd = SAFE_OPEN(path, O_WRONLY);
-		} else
-			tst_brk(TBROK | TERRNO, "open %s", path);
-	}
-	SAFE_WRITE(1, fd, buf, strlen(buf));
-	close(fd);
-}
-
 void write_cpusets(const char *cgroup_dir, long nd)
 {
 	char buf[BUFSIZ];
@@ -709,57 +652,6 @@ void write_cpusets(const char *cgroup_dir, long nd)
 	}
 }
 
-void umount_mem(char *path, char *path_new)
-{
-	FILE *fp;
-	int fd;
-	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
-
-	/* Move all processes in task to its parent node. */
-	sprintf(s, "%s/tasks", path);
-	fd = open(s, O_WRONLY);
-	if (fd == -1)
-		tst_res(TWARN | TERRNO, "open %s", s);
-
-	snprintf(s_new, BUFSIZ, "%s/tasks", path_new);
-	fp = fopen(s_new, "r");
-	if (fp == NULL)
-		tst_res(TWARN | TERRNO, "fopen %s", s_new);
-	if ((fd != -1) && (fp != NULL)) {
-		while (fgets(value, BUFSIZ, fp) != NULL)
-			if (write(fd, value, strlen(value) - 1)
-			    != (ssize_t)strlen(value) - 1)
-				tst_res(TWARN | TERRNO, "write %s", s);
-	}
-	if (fd != -1)
-		close(fd);
-	if (fp != NULL)
-		fclose(fp);
-	if (rmdir(path_new) == -1)
-		tst_res(TWARN | TERRNO, "rmdir %s", path_new);
-	if (umount(path) == -1)
-		tst_res(TWARN | TERRNO, "umount %s", path);
-	if (rmdir(path) == -1)
-		tst_res(TWARN | TERRNO, "rmdir %s", path);
-}
-
-void mount_mem(char *name, char *fs, char *options, char *path, char *path_new)
-{
-	SAFE_MKDIR(path, 0777);
-	if (mount(name, path, fs, 0, options) == -1) {
-		if (errno == ENODEV) {
-			if (rmdir(path) == -1)
-				tst_res(TWARN | TERRNO, "rmdir %s failed",
-					 path);
-			tst_brk(TCONF,
-				 "file system %s is not configured in kernel",
-				 fs);
-		}
-		tst_brk(TBROK | TERRNO, "mount %s", path);
-	}
-	SAFE_MKDIR(path_new, 0777);
-}
-
 /* shared */
 
 /* Warning: *DO NOT* use this function in child */
-- 
2.21.1

