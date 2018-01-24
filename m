From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:03 +0100
Subject: [LTP] [PATCH 10/19] fix old style function definitions in
	libcpuset.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-11-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 .../controllers/cpuset/cpuset_lib/libcpuset.c      | 34 +++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
index 9b67e37c9..a5f5deea8 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
@@ -231,7 +231,7 @@ static enum {
 	check_ok
 } check_state = check_notdone;
 
-static int check()
+static int check(void)
 {
 	if (check_state == check_notdone) {
 		struct stat statbuf;
@@ -576,7 +576,7 @@ static int s2nbits(const char *s)
 	return strlen(s) * 32 / 9;
 }
 
-static void update_mask_sizes()
+static void update_mask_sizes(void)
 {
 	FILE *fp = NULL;
 	char *buf = NULL;
@@ -609,7 +609,7 @@ done:
 }
 
 /* Allocate a new struct cpuset */
-struct cpuset *cpuset_alloc()
+struct cpuset *cpuset_alloc(void)
 {
 	struct cpuset *cp = NULL;
 	int nbits;
@@ -648,7 +648,7 @@ void cpuset_free(struct cpuset *cp)
 }
 
 /* Number of bits in a CPU bitmask on current system */
-int cpuset_cpus_nbits()
+int cpuset_cpus_nbits(void)
 {
 	if (cpumask_sz == 0)
 		update_mask_sizes();
@@ -656,7 +656,7 @@ int cpuset_cpus_nbits()
 }
 
 /* Number of bits in a Memory bitmask on current system */
-int cpuset_mems_nbits()
+int cpuset_mems_nbits(void)
 {
 	if (nodemask_sz == 0)
 		update_mask_sizes();
@@ -1195,7 +1195,7 @@ static struct cpunodemap {
  *	available below /sys/devices/system.
  */
 
-static void rebuild_map()
+static void rebuild_map(void)
 {
 	char buf[PATH_MAX];
 	DIR *dir1, *dir2;
@@ -1239,7 +1239,7 @@ static void rebuild_map()
  *	Reload the cpunodemap[] array from the file.
  */
 
-static void load_map()
+static void load_map(void)
 {
 	char buf[SMALL_BUFSZ];	/* buffer 1 line of mapfile */
 	FILE *mapfp;		/* File stream on mapfile */
@@ -1274,7 +1274,7 @@ static void load_map()
  *	Write cpunodemap[] out to mapfile.
  */
 
-static void store_map()
+static void store_map(void)
 {
 	char buf[PATH_MAX];
 	int fd = -1;
@@ -1320,7 +1320,7 @@ err:
  * On error, return -1 with errno set and no lock held.
  */
 
-static int get_map()
+static int get_map(void)
 {
 	time_t file_mtime;
 
@@ -1349,7 +1349,7 @@ err:
 	return -1;
 }
 
-static void put_map()
+static void put_map(void)
 {
 	funlockfile(stdin);
 }
@@ -1513,7 +1513,7 @@ err:
 	return -1;
 }
 
-static void build_distmap()
+static void build_distmap(void)
 {
 	static int tried_before = 0;
 	int ncpus = cpuset_cpus_nbits();
@@ -1627,7 +1627,7 @@ err:
 	free(dists);
 }
 
-static void build_distmap_sn()
+static void build_distmap_sn(void)
 {
 	int ncpus = cpuset_cpus_nbits();
 	int nmems = cpuset_mems_nbits();
@@ -1840,7 +1840,7 @@ err:
  * open to close, the first time called.
  */
 
-static int get_siblings()
+static int get_siblings(void)
 {
 	static int siblings;
 	char buf[32];		/* big enough for one 'siblings' line */
@@ -2230,7 +2230,7 @@ int cpuset_cpusetofpid(struct cpuset *cp, pid_t pid)
 }
 
 /* [optional] Return mountpoint of cpuset filesystem */
-const char *cpuset_mountpoint()
+const char *cpuset_mountpoint(void)
 {
 	if (check() < 0) {
 		switch (errno) {
@@ -3683,7 +3683,7 @@ int cpuset_pin(int relcpu)
 }
 
 /* Return number CPUs in current tasks cpuset */
-int cpuset_size()
+int cpuset_size(void)
 {
 	struct cpuset_placement *plc1 = NULL, *plc2 = NULL;
 	int r;
@@ -3707,7 +3707,7 @@ int cpuset_size()
 }
 
 /* Return relative CPU number, within current cpuset, last executed on */
-int cpuset_where()
+int cpuset_where(void)
 {
 	struct cpuset_placement *plc1 = NULL, *plc2 = NULL;
 	int r;
@@ -3731,7 +3731,7 @@ int cpuset_where()
 }
 
 /* Undo cpuset_pin - let current task have the run of all CPUs in its cpuset */
-int cpuset_unpin()
+int cpuset_unpin(void)
 {
 	struct bitmask *cpus = NULL, *mems = NULL;
 	int r = -1;
-- 
2.13.6

