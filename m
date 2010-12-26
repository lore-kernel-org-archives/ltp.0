Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PWpSD-0004EP-Ex
	for ltp-list@lists.sourceforge.net; Sun, 26 Dec 2010 12:12:01 +0000
Date: Sun, 26 Dec 2010 13:27:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101226122704.GB5708@saboteur.suse.cz>
References: <1256633228.24598.1292899638530.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1662204911.24601.1292899641904.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1662204911.24601.1292899641904.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v2 2/5] oom02: test OOM for NUMA using mempolicy
 and cpuset
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +#define SYSFS_OVER		"/proc/sys/vm/overcommit_memory"
> +#define MAXNODES		512
> +#define CPATH			"/dev/cpuset"
> +#define CPATH_NEW		CPATH "/1"
> +#define _PATH_SYS_SYSTEM	"/sys/devices/system"

Names starting with underscore are kind of reserved for system
libraries.

> +#define LENGTH			(3UL<<30)
> +#define NORMAL			1
> +#define MLOCK			2
> +#define KSM			3
> +
> +static char overcommit[BUFSIZ];
> +
> +static void setup(void);
> +static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
> +static void oom(int testcase, int mempolicy);
> +static long count_numa(void);
> +static int path_exist(const char *path, ...);
> +static void testoom(int mempolicy);
> +static void gather_cpus(char *cpus);
> +
> +int main(int argc, char *argv[])
> +{
> +	char *msg;
> +	int lc, fd;
> +	unsigned long nnodes = 1;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != (char *)NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);

Useless cast.

> +#ifdef __i386__
> +	tst_brkm(TCONF, tst_exit,
> +		"test is not designed for 32-bit system.");
> +#endif /* __i386__ */
> +
> +	nnodes = count_numa();
> +	if (count_numa() == 1)
> +		tst_brkm(TCONF, tst_exit, "required a NUMA system.");
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +		fd = open(SYSFS_OVER, O_WRONLY);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open");
> +		if (write(fd, "1", 1) != 1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "write");
> +		close(fd);
> +
> +		tst_resm(TINFO, "process mempolicy.");
> +		testoom(1);
> +
> +		tst_resm(TINFO, "process cpuset.");
> +		testoom(0);
> +	}
> +	cleanup();
> +}
> +
> +void testoom(int mempolicy)
> +{
> +	int fd;
> +	char buf[BUFSIZ] = "";
> +	char cpus[BUFSIZ] = "";
> +
> +	if (!mempolicy) {
> +		gather_cpus(cpus);
> +		tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
> +
> +		snprintf(buf, BUFSIZ, "%s/cpuset.mems", CPATH_NEW);
> +		fd = open(buf, O_WRONLY);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> +		if (write(fd, "1", 1) != 1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> +		close(fd);
> +
> +		snprintf(buf, BUFSIZ, "%s/cpuset.cpus", CPATH_NEW);
> +
> +		fd = open(buf, O_WRONLY);

Static C strings could be concatenated just by writing them alongside.
So here we could just do open(CPATH_NEW "/cpuset.cpus", O_WRONLY); and
spare the snprintf() call.

> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> +		if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
> +			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> +		close(fd);
> +
> +		snprintf(buf, BUFSIZ, "%s/tasks", CPATH);
> +		fd = open(buf, O_WRONLY);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> +		snprintf(buf, BUFSIZ, "%d", getpid());
> +		if (write(fd, buf, strlen(buf)) != strlen(buf))
> +			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> +		close(fd);
> +	}
> +	tst_resm(TINFO, "start normal OOM testing.");
> +	oom(NORMAL, mempolicy);
> +
> +	tst_resm(TINFO, "start OOM testing for mlocked pages.");
> +	oom(MLOCK, mempolicy);
> +
> +	tst_resm(TINFO, "start OOM testing for KSM pages.");
> +	oom(KSM, mempolicy);
> +}
> +
> +void setup(void)
> +{
> +	int fd;
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	TEST_PAUSE;
> +
> +	fd = open(SYSFS_OVER, O_RDONLY);
> +	if (fd == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "open");
> +	if (read(fd, &overcommit, 1) != 1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "read");
> +	close(fd);
> +
> +	if (mkdir(CPATH, 0777) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", CPATH);
> +	if (mount("cpuset", CPATH, "cpuset", 0, NULL) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "mount %s", CPATH);
> +	if (mkdir(CPATH_NEW, 0777) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", CPATH_NEW);
> +}
> +
> +void cleanup(void)
> +{
> +	FILE *fp;
> +	int fd;
> +	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
> +
> +	fd = open(SYSFS_OVER, O_WRONLY);
> +	if (fd == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "open");
> +	if (write(fd, &overcommit, 1) != 1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "write");
> +	close(fd);
> +
> +	/* Move all processes in task to its parent cpuset node. */
> +	snprintf(s, BUFSIZ, "%s/tasks", CPATH);

Here as well.

> +	fd = open(s, O_WRONLY);
> +	if (fd == -1)
> +		tst_resm(TWARN|TERRNO, "open %s", s);
> +	snprintf(s_new, BUFSIZ, "%s/tasks", CPATH_NEW);

And here.

> +	fp = fopen(s_new, "r");
> +	if (fp == NULL)
> +		tst_resm(TWARN|TERRNO, "fopen %s", s_new);
> +	if ((fd != -1) && (fp != NULL)) {
> +		while (fgets(value, BUFSIZ, fp) != NULL)
> +			if (write(fd, value, strlen(value) - 1)
> +				!= strlen(value) - 1)
> +				tst_resm(TWARN|TERRNO, "write %s", s);
> +	}
> +	if (fd != -1)
> +		close(fd);
> +	if (fp != NULL)
> +		fclose(fp);
> +	if (rmdir(CPATH_NEW) == -1)
> +		tst_resm(TWARN|TERRNO, "rmdir %s", CPATH_NEW);
> +	if (umount(CPATH) == -1)
> +		tst_resm(TWARN|TERRNO, "umount %s", CPATH);
> +	if (rmdir(CPATH) == -1)
> +		tst_resm(TWARN|TERRNO, "rmdir %s", CPATH);
> +
> +	TEST_CLEANUP;
> +	tst_exit();
> +}
> +
> +void oom(int testcase, int mempolicy)
> +{
> +	pid_t pid;
> +	int status;
> +	void *s;
> +	unsigned long nmask = 2;
> +
> +	switch(pid = fork()) {
> +	case -1:
> +		tst_brkm(TBROK|TERRNO, cleanup, "fork");
> +	case 0:
> +		if (mempolicy)
> +			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
> +				tst_brkm(TBROK|TERRNO, cleanup,
> +					"set_mempolicy");
> +		while(1) {
> +			s = mmap(NULL, LENGTH, PROT_READ|PROT_WRITE,
> +				MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +			if (s == MAP_FAILED)
> +				tst_brkm(TBROK|TERRNO, cleanup, "mmap");
> +			if (testcase == MLOCK && mlock(s, LENGTH) == -1)
> +				tst_brkm(TINFO|TERRNO, cleanup, "mlock");
> +			if (testcase == KSM
> +				&& madvise(s, LENGTH, MADV_MERGEABLE) == -1)
> +				tst_brkm(TBROK|TERRNO, cleanup, "madvise");
> +			memset(s, '\a', LENGTH);
> +		}
> +		exit(0);
> +	default:
> +		break;
> +	}
> +	tst_resm(TINFO, "expected victim is %d.", pid);
> +	if (waitpid(-1, &status, 0) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +
> +	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
> +		tst_resm(TFAIL, "the victim unexpectedly failed: %d", status);
> +}
> +
> +long count_numa(void)
> +{
> +	int nnodes = 0;
> +
> +	while(path_exist(_PATH_SYS_SYSTEM "/node/node%d", nnodes))
> +		nnodes++;
> +
> +	return nnodes;
> +}
> +
> +int path_exist(const char *path, ...)
> +{
> +	va_list ap;
> +	char pathbuf[PATH_MAX];
> +
> +	va_start(ap, path);
> +	vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
> +	va_end(ap);
> +
> +	return access(pathbuf, F_OK) == 0;
> +}
> +
> +void gather_cpus(char *cpus)
> +{
> +	int ncpus = 0;
> +	int i;
> +	char buf[BUFSIZ];
> +
> +	while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
> +		ncpus++;
> +
> +	for (i = 0; i < ncpus; i++)
> +		if (path_exist(_PATH_SYS_SYSTEM "/node/node1/cpu%d", i)) {
> +			sprintf(buf, "%d,", i);
> +			strcat(cpus, buf);
> +		}
> +	/* Remove the trailing comma. */
> +	cpus[strlen(cpus) - 1] = '\0';
> +}
> +
> +#else /* no NUMA */
> +int main(void) {
> +	tst_resm(TCONF, "no NUMA development packages installed.");
> +	tst_exit();
> +}
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
