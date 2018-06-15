From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Fri, 15 Jun 2018 18:39:55 +0800
Subject: [LTP] [PATCH v3] change type of variable to fix compile warning
Message-ID: <20180615103955.14757-1-sunlw.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Change the type of variable from int to unsigned intto fix complie
warning: "comparison between signed and unsigned integer expressions [-Wsign-compare]"

Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 testcases/kernel/containers/pidns/pidns17.c               | 3 ++-
 testcases/kernel/controllers/memcg/control/mem_process.c  | 2 +-
 testcases/kernel/fs/fsx-linux/fsx-linux.c                 | 3 ++-
 testcases/kernel/io/disktest/childmain.c                  | 2 +-
 testcases/kernel/io/disktest/main.c                       | 2 +-
 testcases/kernel/mem/mmapstress/mmapstress05.c            | 2 +-
 testcases/kernel/syscalls/cma/process_vm_readv03.c        | 2 +-
 testcases/kernel/syscalls/dup2/dup204.c                   | 2 +-
 testcases/kernel/syscalls/fadvise/posix_fadvise01.c       | 2 +-
 testcases/kernel/syscalls/fadvise/posix_fadvise03.c       | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl01.c                 | 4 ++--
 testcases/kernel/syscalls/fork/fork04.c                   | 4 ++--
 testcases/kernel/syscalls/ftruncate/ftruncate03.c         | 3 ++-
 testcases/kernel/syscalls/getdents/getdents01.c           | 8 ++++----
 testcases/kernel/syscalls/getxattr/getxattr01.c           | 4 ++--
 testcases/kernel/syscalls/mmap/mmap001.c                  | 3 ++-
 testcases/kernel/syscalls/move_pages/move_pages_support.c | 2 +-
 testcases/kernel/syscalls/msync/msync01.c                 | 2 +-
 testcases/kernel/syscalls/msync/msync02.c                 | 2 +-
 .../kernel/syscalls/remap_file_pages/remap_file_pages01.c | 2 +-
 .../kernel/syscalls/remap_file_pages/remap_file_pages02.c | 2 +-
 testcases/kernel/syscalls/symlink/symlink01.c             | 4 ++--
 testcases/network/sockets/ltpClient.c                     | 6 ++++--
 testcases/network/stress/ns-tools/ns-mcast_join.c         | 2 +-
 utils/benchmark/ebizzy-0.3/ebizzy.c                       | 8 ++++----
 25 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index 79f112a55..69d967c37 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -58,7 +58,8 @@ int child_fn(void *);
  */
 int child_fn(void *arg)
 {
-	int children[10], exit_val, i, status;
+	int children[10], exit_val, status;
+	unsigned i;
 	pid_t pid, ppid;
 
 	/* Set process id and parent pid */
diff --git a/testcases/kernel/controllers/memcg/control/mem_process.c b/testcases/kernel/controllers/memcg/control/mem_process.c
index 899467fe3..9544f0262 100644
--- a/testcases/kernel/controllers/memcg/control/mem_process.c
+++ b/testcases/kernel/controllers/memcg/control/mem_process.c
@@ -74,7 +74,7 @@ void process_options(int argc, char **argv)
  */
 void touch_memory(char *p)
 {
-	int i;
+	unsigned int i;
 	int pagesize = getpagesize();
 
 	for (i = 0; i < memsize; i += pagesize)
diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 02f3eb827..82391dd6c 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -1112,7 +1112,8 @@ int getnum(char *s, char **e)
 
 int main(int argc, char **argv)
 {
-	int i, style, ch;
+	int style, ch;
+	unsigned i;
 	char *endp;
 	int dirpath = 0;
 
diff --git a/testcases/kernel/io/disktest/childmain.c b/testcases/kernel/io/disktest/childmain.c
index 41cd271c3..e566551c4 100644
--- a/testcases/kernel/io/disktest/childmain.c
+++ b/testcases/kernel/io/disktest/childmain.c
@@ -545,7 +545,7 @@ void complete_io(test_env_t * env, const child_args_t * args,
 		 const action_t target)
 {
 	unsigned char *wbitmap = (unsigned char *)env->shared_mem + BMP_OFFSET;
-	int i = 0;
+	unsigned int i;
 
 	if (target.oper == WRITER) {
 		(env->hbeat_stats.wbytes) += target.trsiz * BLK_SIZE;
diff --git a/testcases/kernel/io/disktest/main.c b/testcases/kernel/io/disktest/main.c
index c372b04c5..53bfe9add 100644
--- a/testcases/kernel/io/disktest/main.c
+++ b/testcases/kernel/io/disktest/main.c
@@ -147,7 +147,7 @@ void linear_read_write_test(test_ll_t * test)
 
 unsigned long init_data(test_ll_t * test, unsigned char **data_buffer_unaligned)
 {
-	int i;
+	unsigned int i;
 	OFF_T *pVal1;
 
 	unsigned long data_buffer_size;
diff --git a/testcases/kernel/mem/mmapstress/mmapstress05.c b/testcases/kernel/mem/mmapstress/mmapstress05.c
index a8e6a44a3..e579413b7 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress05.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress05.c
@@ -107,7 +107,7 @@ int main(int argc, char *argv[])
 	caddr_t mmapaddr;
 	char *buf;
 	time_t t;
-	int i;
+	unsigned int i;
 	struct sigaction sa;
 
 	if (!argc) {
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 8b8dfc316..a49a5d728 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -189,7 +189,7 @@ static long *fetch_remote_addrs(void)
 
 static void child_invoke(int *bufsz_arr)
 {
-	int i, j, count, nr_error;
+	unsigned int i, j, count, nr_error;
 	unsigned char expect, actual;
 	long *addrs;
 	struct iovec local[NUM_LOCAL_VECS], *remote;
diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index c864f9866..158af4d2b 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -117,7 +117,7 @@ void setup(void)
 
 void cleanup(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(fd); i++) {
 		close(fd[i]);
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index c12f0563c..7d82ca282 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -79,7 +79,7 @@ int TST_TOTAL = defined_advise_total;
 int main(int ac, char **av)
 {
 	int lc;
-	int i;
+	unsigned int i;
 
 	/* Check this system has fadvise64 system which is used
 	   in posix_fadvise. */
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index 4aa3a8cd1..7d2701d65 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -103,7 +103,7 @@ int advise_limit = 32;
    Return 0 if not. */
 static int is_defined_advise(int advise)
 {
-	int i;
+	unsigned int i;
 	for (i = 0; i < defined_advise_total; i++) {
 		if (defined_advise[i] == advise)
 			return 1;
diff --git a/testcases/kernel/syscalls/fcntl/fcntl01.c b/testcases/kernel/syscalls/fcntl/fcntl01.c
index 8d20be25e..1d765bbdc 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl01.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl01.c
@@ -46,8 +46,8 @@ int main(int ac, char **av)
 	int flags;
 	char fname[40];
 	int fd[10], fd2[10];
-	int mypid, i;
-	int lc;
+	int mypid, lc;
+	unsigned int i;
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
diff --git a/testcases/kernel/syscalls/fork/fork04.c b/testcases/kernel/syscalls/fork/fork04.c
index 208636c6b..6a9d38fd4 100644
--- a/testcases/kernel/syscalls/fork/fork04.c
+++ b/testcases/kernel/syscalls/fork/fork04.c
@@ -138,7 +138,7 @@ static void child_environment(void)
 {
 
 	int fildes;
-	int index;
+	unsigned int index;
 	char msg[MAX_LINE_LENGTH];
 	char *var;
 
@@ -238,7 +238,7 @@ void parent_environment(void)
 	int fildes;
 	char tmp_line[MAX_LINE_LENGTH];
 	char parent_value[MAX_LINE_LENGTH];
-	int index;
+	unsigned int index;
 	int ret;
 	char *var;
 
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate03.c b/testcases/kernel/syscalls/ftruncate/ftruncate03.c
index bb4dd1efa..a88c3063a 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate03.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate03.c
@@ -59,7 +59,8 @@ int TST_TOTAL = 3;
 
 int main(void)
 {
-	int wjh_ret = -1, wjh_f = -1, count = 0;
+	int wjh_ret = -1, wjh_f = -1;
+    unsigned int count = 0;
 	//used for the 2nd test
 	//make str > trunc_size characters long
 	char str[] = "THIS IS JAYS TEST FILE DATA";
diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index 3962d960b..0911cfd08 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -167,7 +167,7 @@ int main(int ac, char **av)
 
 static void reset_flags(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(testcases); i++)
 		testcases[i].found = 0;
@@ -175,7 +175,7 @@ static void reset_flags(void)
 
 static void check_flags(void)
 {
-	int i, err = 0;
+	unsigned int i, err = 0;
 
 	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
 		if (!testcases[i].found) {
@@ -192,7 +192,7 @@ static void check_flags(void)
 
 static void set_flag(const char *name)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
 		if (!strcmp(name, testcases[i].name)) {
@@ -206,7 +206,7 @@ static void set_flag(const char *name)
 
 static void setup(void)
 {
-	int i;
+	unsigned int i;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
index be410a536..66b32bd6a 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr01.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -99,7 +99,7 @@ int TST_TOTAL = sizeof(tc) / sizeof(tc[0]) + 1;
 int main(int argc, char *argv[])
 {
 	int lc;
-	int i;
+	unsigned int i;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 
@@ -135,7 +135,7 @@ int main(int argc, char *argv[])
 static void setup(void)
 {
 	int fd;
-	int i;
+	unsigned int i;
 
 	tst_require_root();
 
diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
index 59a923f0f..01916be32 100644
--- a/testcases/kernel/syscalls/mmap/mmap001.c
+++ b/testcases/kernel/syscalls/mmap/mmap001.c
@@ -81,8 +81,9 @@ option_t options[] = {
 int main(int argc, char *argv[])
 {
 	char *array;
-	int i, lc;
+	int lc;
 	int fd;
+	unsigned int i;
 	unsigned int pages, memsize;
 
 	tst_parse_opts(argc, argv, options, help);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index 610f570d0..77dfd07f2 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -62,7 +62,7 @@ void free_pages(void **pages, unsigned int num)
  */
 int alloc_pages_on_nodes(void **pages, unsigned int num, int *nodes)
 {
-	int i;
+	unsigned int i;
 #ifdef HAVE_NUMA_V2
 	size_t onepage = get_page_size();
 #endif
diff --git a/testcases/kernel/syscalls/msync/msync01.c b/testcases/kernel/syscalls/msync/msync01.c
index 565d5fe7c..872d42492 100644
--- a/testcases/kernel/syscalls/msync/msync01.c
+++ b/testcases/kernel/syscalls/msync/msync01.c
@@ -153,7 +153,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	int c_total = 0, nwrite = 0;	/* no. of bytes to be written */
+	unsigned int c_total = 0, nwrite = 0;	/* no. of bytes to be written */
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/msync/msync02.c b/testcases/kernel/syscalls/msync/msync02.c
index 243ceb06e..0065e8bff 100644
--- a/testcases/kernel/syscalls/msync/msync02.c
+++ b/testcases/kernel/syscalls/msync/msync02.c
@@ -106,7 +106,7 @@ int main(int ac, char **av)
 
 void setup(void)
 {
-	int c_total = 0, nwrite = 0;	/* no. of bytes to be written */
+	unsigned int c_total = 0, nwrite = 0;	/* no. of bytes to be written */
 	char tst_buf[BUF_SIZE];
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
index 86496c1d1..38f54214a 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
@@ -147,7 +147,7 @@ int main(int ac, char **av)
 static void test_nonlinear(int fd)
 {
 	char *data = NULL;
-	int i, j, repeat = 2;
+	unsigned int i, j, repeat = 2;
 
 	for (i = 0; i < cache_pages; i++) {
 		char *page = cache_contents + i * page_sz;
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
index 62b0966f2..d772f70b3 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
@@ -263,7 +263,7 @@ int setup04(int test)
  */
 void setup(void)
 {
-	int i, j;
+	unsigned int i, j;
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/symlink/symlink01.c b/testcases/kernel/syscalls/symlink/symlink01.c
index 03a51a5cb..d9e8aafe2 100644
--- a/testcases/kernel/syscalls/symlink/symlink01.c
+++ b/testcases/kernel/syscalls/symlink/symlink01.c
@@ -584,7 +584,7 @@ int main(int argc, char *argv[])
  ***********************************************************************/
 struct tcses *get_tcs_info(char *ptr)
 {
-	int ctr;
+	unsigned int ctr;
 	struct tcses *tcs_ptr;
 
 #if ALL
@@ -1875,7 +1875,7 @@ void cleanup(void)
 
 void help(void)
 {
-	int ind;
+	unsigned int ind;
 
 	printf("   -T id  Determines which tests cases to execute:\n");
 
diff --git a/testcases/network/sockets/ltpClient.c b/testcases/network/sockets/ltpClient.c
index 2981737d9..4fe1160f3 100644
--- a/testcases/network/sockets/ltpClient.c
+++ b/testcases/network/sockets/ltpClient.c
@@ -484,7 +484,8 @@ void ping_network(struct sockaddr_in *rawAddr, int pid)
 {
 
 	const int value = TIMETOLIVE;
-	int i, rawSocket, count = 1;
+	int rawSocket, count = 1;
+	unsigned int i;
 
 	struct packet rawPacket;
 
@@ -562,7 +563,8 @@ void ltp_traceroute(struct sockaddr_in *rawTraceAddr, char *hostName, int pid)
 
 	const int flag = TRUE;
 	int TimeToLive = 0;
-	int i, rawTraceSocket, count = 1;
+	int rawTraceSocket, count = 1;
+	unsigned int i;
 	socklen_t length;
 	struct packet rawTracePacket;
 	unsigned char tracePacket[PACKET_LEN];
diff --git a/testcases/network/stress/ns-tools/ns-mcast_join.c b/testcases/network/stress/ns-tools/ns-mcast_join.c
index b673955db..a5289d117 100644
--- a/testcases/network/stress/ns-tools/ns-mcast_join.c
+++ b/testcases/network/stress/ns-tools/ns-mcast_join.c
@@ -293,7 +293,7 @@ void join_group(void)
 	int *sock_array;	/* socket descriptor array */
 	size_t num_sock;	/* number of the socket */
 	char maddr[ADDR_STR_MAXSIZE];	/* multicast address in string */
-	int idx;
+	unsigned int idx;
 	struct addrinfo *maddr_info;
 	struct group_req *grp_info;
 	struct group_filter *gsf;
diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index 5bb8eff56..8a433e8e1 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -228,7 +228,7 @@ static void read_options(int argc, char *argv[])
 
 static void touch_mem(char *dest, size_t size)
 {
-	int i;
+	unsigned int i;
 	if (touch_pages) {
 		for (i = 0; i < size; i += page_size)
 			*(dest + i) = 0xff;
@@ -279,7 +279,7 @@ static void my_memcpy(void *dest, void *src, size_t len)
 {
 	char *d = (char *)dest;
 	char *s = (char *)src;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < len; i++)
 		d[i] = s[i];
@@ -288,7 +288,7 @@ static void my_memcpy(void *dest, void *src, size_t len)
 
 static void allocate(void)
 {
-	int i;
+	unsigned int i;
 
 	mem = alloc_mem(chunks * sizeof(record_t *));
 
@@ -313,7 +313,7 @@ static void allocate(void)
 
 static void write_pattern(void)
 {
-	int i, j;
+	unsigned int i, j;
 
 	for (i = 0; i < chunks; i++) {
 		for (j = 0; j < chunk_size / record_size; j++)
-- 
2.17.1



