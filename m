Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UUXO6-0002Sw-8q
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 07:11:38 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUXO3-0000ci-Fq
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 07:11:37 +0000
Date: Tue, 23 Apr 2013 03:11:24 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <381637140.1062476.1366701084940.JavaMail.root@redhat.com>
In-Reply-To: <51762EE5.4010805@cn.fujitsu.com>
References: <5b868b8363fdb792d3f39e130161e692a20748aa.1366610374.git.zliu@redhat.com>
	<51762EE5.4010805@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] lib/mem: removed read_file() and write_file()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Tuesday, April 23, 2013 2:49:09 PM
> Subject: Re: [LTP] [PATCH] lib/mem: removed read_file() and write_file()
> 
> On 04/23/2013 11:29 AM, Zhouping Liu wrote:
> > SAFE_FILE_SCANF() and SAFE_FILE_PRINTF() can completely displace
> > read_file() and write_file(), so removed them.
> > 
> > Signed-off-by: Zhouping Liu <zliu@redhat.com>
> > ---
> >  testcases/kernel/mem/cpuset/cpuset01.c             |  3 +-
> >  .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   | 11 +--
> >  testcases/kernel/mem/include/mem.h                 |  3 +-
> >  testcases/kernel/mem/lib/mem.c                     | 87
> >  +++++++---------------
> >  testcases/kernel/mem/oom/oom03.c                   | 11 ++-
> >  testcases/kernel/mem/oom/oom05.c                   |  6 +-
> >  6 files changed, 38 insertions(+), 83 deletions(-)
> > 
> > diff --git a/testcases/kernel/mem/cpuset/cpuset01.c
> > b/testcases/kernel/mem/cpuset/cpuset01.c
> > index 99fbb9c..abba489 100644
> > --- a/testcases/kernel/mem/cpuset/cpuset01.c
> > +++ b/testcases/kernel/mem/cpuset/cpuset01.c
> > @@ -100,8 +100,7 @@ static void testcpuset(void)
> >  	write_cpuset_files(CPATH_NEW, "cpus", buf);
> >  	read_cpuset_files(CPATH, "mems", mems);
> >  	write_cpuset_files(CPATH_NEW, "mems", mems);
> > -	snprintf(buf, BUFSIZ, "%d", getpid());
> > -	write_file(CPATH_NEW "/tasks", buf);
> > +	SAFE_FILE_PRINTF(cleanup, CPATH_NEW "/tasks", "%d", getpid());
> >  
> >  	switch (child = fork()) {
> >  	case -1:
> > diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
> > b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
> > index 3898618..8cf5cc6 100644
> > --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
> > +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
> > @@ -113,7 +113,6 @@ int main(int ac, char **av)
> >  void setup(void)
> >  {
> >  	long hpage_size;
> > -	char buf[BUFSIZ];
> >  
> >  	tst_require_root(NULL);
> >  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> > @@ -125,10 +124,8 @@ void setup(void)
> >  
> >  	shm_size = hpage_size;
> >  
> > -	read_file(PATH_SHMMNI, buf);
> > -	orig_shmmni = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
> > -	snprintf(buf, BUFSIZ, "%ld", hugepages / 2);
> > -	write_file(PATH_SHMMNI, buf);
> > +	SAFE_FILE_SCANF(NULL, PATH_SHMMNI, "%ld", &orig_shmmni);
> > +	SAFE_FILE_PRINTF(NULL, PATH_SHMMNI, "%ld", hugepages / 2);
> >  
> >  	/*
> >  	 * Use a while loop to create the maximum number of memory segments.
> > @@ -156,15 +153,13 @@ void setup(void)
> >  void cleanup(void)
> >  {
> >  	int i;
> > -	char buf[BUFSIZ];
> >  
> >  	TEST_CLEANUP;
> >  
> >  	for (i = 0; i < num_shms; i++)
> >  		rm_shm(shm_id_arr[i]);
> >  
> > -	snprintf(buf, BUFSIZ, "%ld", orig_shmmni);
> > -	write_file(PATH_SHMMNI, buf);
> > +	SAFE_FILE_PRINTF(NULL, PATH_SHMMNI, "%ld", orig_shmmni);
> >  	set_sys_tune("nr_hugepages", orig_hugepages, 0);
> >  
> >  	tst_rmdir();
> > diff --git a/testcases/kernel/mem/include/mem.h
> > b/testcases/kernel/mem/include/mem.h
> > index 9e96b31..551c73e 100644
> > --- a/testcases/kernel/mem/include/mem.h
> > +++ b/testcases/kernel/mem/include/mem.h
> > @@ -67,6 +67,7 @@ void ksm_usage(void);
> >  #define CPATH_NEW		CPATH "/1"
> >  #define MEMCG_PATH		"/dev/cgroup"
> >  #define MEMCG_PATH_NEW		MEMCG_PATH "/1"
> > +#define MEMCG_LIMIT		MEMCG_PATH_NEW "/memory.limit_in_bytes"
> >  #define MEMCG_SW_LIMIT		MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes"
> >  #if HAVE_SYS_EVENTFD_H
> >  #define PATH_OOMCTRL		MEMCG_PATH_NEW "/memory.oom_control"
> > @@ -85,8 +86,6 @@ int  path_exist(const char *path, ...);
> >  long read_meminfo(char *item);
> >  void set_sys_tune(char *sys_file, long tune, int check);
> >  long get_sys_tune(char *sys_file);
> > -void write_file(char *filename, char *buf);
> > -void read_file(char *filename, char *retbuf);
> >  void cleanup(void);
> >  void setup(void);
> >  
> > diff --git a/testcases/kernel/mem/lib/mem.c
> > b/testcases/kernel/mem/lib/mem.c
> > index da98552..bc86021 100644
> > --- a/testcases/kernel/mem/lib/mem.c
> > +++ b/testcases/kernel/mem/lib/mem.c
> > @@ -157,13 +157,11 @@ void testoom(int mempolicy, int lite)
> >  
> >  static void check(char *path, long int value)
> >  {
> > -	FILE *fp;
> > -	char buf[BUFSIZ], fullpath[BUFSIZ];
> > +	char fullpath[BUFSIZ];
> >  	long actual_val;
> >  
> >  	snprintf(fullpath, BUFSIZ, "%s%s", PATH_KSM, path);
> 
> Can this be snprintf(fullpath, BUFSIZ, PATH_KSM "%s", path);?

Yes, it can be changed as the above, updated it on v2.

> 
> 
> > -	read_file(fullpath, buf);
> > -	actual_val = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
> > +	SAFE_FILE_SCANF(cleanup, fullpath, "%ld", &actual_val);
> >  
> >  	tst_resm(TINFO, "%s is %ld.", path, actual_val);
> >  	if (actual_val != value)
> > @@ -172,7 +170,6 @@ static void check(char *path, long int value)
> >  
> >  static void wait_ksmd_done(void)
> >  {
> > -	char buf[BUFSIZ];
> >  	long pages_shared, pages_sharing, pages_volatile, pages_unshared;
> >  	long old_pages_shared = 0, old_pages_sharing = 0;
> >  	long old_pages_volatile = 0, old_pages_unshared = 0;
> > @@ -182,17 +179,17 @@ static void wait_ksmd_done(void)
> >  		sleep(10);
> >  		count++;
> >  
> > -		read_file(PATH_KSM "pages_shared", buf);
> > -		pages_shared = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
> > +		SAFE_FILE_SCANF(cleanup, PATH_KSM "pages_shared",
> > +				"%ld", &pages_shared);
> >  
> > -		read_file(PATH_KSM "pages_sharing", buf);
> > -		pages_sharing = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
> > +		SAFE_FILE_SCANF(cleanup, PATH_KSM "pages_sharing",
> > +				"%ld", &pages_sharing);
> >  
> > -		read_file(PATH_KSM "pages_volatile", buf);
> > -		pages_volatile = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
> > +		SAFE_FILE_SCANF(cleanup, PATH_KSM "pages_volatile",
> > +				"%ld", &pages_volatile);
> >  
> > -		read_file(PATH_KSM "pages_unshared", buf);
> > -		pages_unshared = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
> > +		SAFE_FILE_SCANF(cleanup, PATH_KSM "pages_unshared",
> > +				"%ld", &pages_unshared);
> >  
> >  		if (pages_shared != old_pages_shared ||
> >  		    pages_sharing != old_pages_sharing ||
> > @@ -254,13 +251,9 @@ static void verify(char **memory, char value, int
> > proc,
> >  
> >  void write_memcg(void)
> >  {
> > -	char buf[BUFSIZ], mem[BUFSIZ];
> > -
> > -	snprintf(mem, BUFSIZ, "%ld", TESTMEM);
> > -	write_file(MEMCG_PATH_NEW "/memory.limit_in_bytes", mem);
> > +	SAFE_FILE_PRINTF(NULL, MEMCG_LIMIT, "%ld", TESTMEM);
> >  
> > -	snprintf(buf, BUFSIZ, "%d", getpid());
> > -	write_file(MEMCG_PATH_NEW "/tasks", buf);
> > +	SAFE_FILE_PRINTF(NULL, MEMCG_PATH_NEW "/tasks", "%d", getpid());
> >  }
> >  
> >  static struct ksm_merge_data {
> > @@ -377,7 +370,6 @@ static void resume_ksm_children(int *child, int num)
> >  
> >  void create_same_memory(int size, int num, int unit)
> >  {
> > -	char buf[BUFSIZ];
> >  	int i, j, status, *child;
> >  	unsigned long ps, pages;
> >  	struct ksm_merge_data **ksm_data;
> > @@ -437,10 +429,10 @@ void create_same_memory(int size, int num, int unit)
> >  	stop_ksm_children(child, num);
> >  
> >  	tst_resm(TINFO, "KSM merging...");
> > -	write_file(PATH_KSM "run", "1");
> > -	snprintf(buf, BUFSIZ, "%ld", size * pages * num);
> > -	write_file(PATH_KSM "pages_to_scan", buf);
> > -	write_file(PATH_KSM "sleep_millisecs", "0");
> > +	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
> > +	SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
> > +			 size * pages *num);
> > +	SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
> >  
> >  	resume_ksm_children(child, num);
> >  	group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
> > @@ -460,13 +452,13 @@ void create_same_memory(int size, int num, int unit)
> >  	stop_ksm_children(child, num);
> >  
> >  	tst_resm(TINFO, "KSM unmerging...");
> > -	write_file(PATH_KSM "run", "2");
> > +	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "2");
> >  
> >  	resume_ksm_children(child, num);
> >  	group_check(2, 0, 0, 0, 0, 0, size * pages * num);
> >  
> >  	tst_resm(TINFO, "stop KSM.");
> > -	write_file(PATH_KSM "run", "0");
> > +	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "0");
> >  	group_check(0, 0, 0, 0, 0, 0, size * pages * num);
> >  
> >  	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
> > @@ -624,7 +616,6 @@ void test_transparent_hugepage(int nr_children, int
> > nr_thps,
> >  {
> >  	unsigned long hugepagesize, memfree;
> >  	int i, *pids, ret, status;
> > -	char path[BUFSIZ];
> >  
> >  	if (mempolicy)
> >  		set_global_mempolicy(mempolicy);
> > @@ -803,8 +794,7 @@ void write_cpusets(long nd)
> >  	gather_node_cpus(cpus, nd);
> >  	write_cpuset_files(CPATH_NEW, "cpus", cpus);
> >  
> > -	snprintf(buf, BUFSIZ, "%d", getpid());
> > -	write_file(CPATH_NEW "/tasks", buf);
> > +	SAFE_FILE_PRINTF(NULL, CPATH_NEW "/tasks", "%d", getpid());
> >  }
> >  
> >  void umount_mem(char *path, char *path_new)
> > @@ -932,13 +922,12 @@ long read_meminfo(char *item)
> >  void set_sys_tune(char *sys_file, long tune, int check)
> >  {
> >  	long val;
> > -	char buf[BUFSIZ], path[BUFSIZ];
> > +	char path[BUFSIZ];
> >  
> >  	tst_resm(TINFO, "set %s to %ld", sys_file, tune);
> >  
> >  	snprintf(path, BUFSIZ, "%s%s", PATH_SYSVM, sys_file);
> 
> ditto?
> 
> > -	snprintf(buf, BUFSIZ, "%ld", tune);
> > -	write_file(path, buf);
> > +	SAFE_FILE_PRINTF(NULL, path, "%ld", tune);
> >  
> >  	if (check) {
> >  		val = get_sys_tune(sys_file);
> > @@ -950,44 +939,20 @@ void set_sys_tune(char *sys_file, long tune, int
> > check)
> >  
> >  long get_sys_tune(char *sys_file)
> >  {
> > -	char buf[BUFSIZ], path[BUFSIZ];
> > +	char path[BUFSIZ];
> > +	long tune;
> >  
> >  	snprintf(path, BUFSIZ, "%s%s", PATH_SYSVM, sys_file);
> 
> ditto?
> 
> > -	read_file(path, buf);
> > -	return SAFE_STRTOL(cleanup, buf, LONG_MIN, LONG_MAX);
> > -}
> > -
> > -void write_file(char *filename, char *buf)
> > -{
> > -	int fd;
> > +	SAFE_FILE_SCANF(NULL, path, "%ld", &tune);
> >  
> > -	fd = open(filename, O_WRONLY);
> > -	if (fd == -1)
> > -		tst_brkm(TBROK | TERRNO, cleanup, "open %s", filename);
> > -	if (write(fd, buf, strlen(buf)) != strlen(buf))
> > -		tst_brkm(TBROK | TERRNO, cleanup, "write %s", filename);
> > -	close(fd);
> > -}
> > -
> > -void read_file(char *filename, char *retbuf)
> > -{
> > -	int fd;
> > -
> > -	fd = open(filename, O_RDONLY);
> > -	if (fd == -1)
> > -		tst_brkm(TBROK | TERRNO, cleanup, "open %s", filename);
> > -	if (read(fd, retbuf, BUFSIZ) < 0)
> > -		tst_brkm(TBROK | TERRNO, cleanup, "read %s", filename);
> > -	close(fd);
> > +	return tune;
> >  }
> >  
> >  void update_shm_size(size_t * shm_size)
> >  {
> > -	char buf[BUFSIZ];
> >  	size_t shmmax;
> >  
> > -	read_file(PATH_SHMMAX, buf);
> > -	shmmax = SAFE_STRTOUL(cleanup, buf, 0, ULONG_MAX);
> > +	SAFE_FILE_SCANF(cleanup, PATH_SHMMAX, "%ld", shmmax);
> 
> &shmmax?
>

it's an error, thank you for pointing it out, fixed it on v2.

Thanks,
Zhouping

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
