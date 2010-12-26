Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PWpd5-0004Rg-Po
	for ltp-list@lists.sourceforge.net; Sun, 26 Dec 2010 12:23:15 +0000
Date: Sun, 26 Dec 2010 13:38:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101226123817.GC5708@saboteur.suse.cz>
References: <192690881.24611.1292899687435.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1650367088.24614.1292899690275.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1650367088.24614.1292899690275.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v2 3/5] oom03: test OOM for memcg
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
> +#include <sys/mount.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include "test.h"
> +#include "usctest.h"
> +
> +char *TCID = "oom03";
> +int TST_TOTAL = 1;
> +extern int Tst_count;
> +
> +#define LENGTH		(3UL<<30)
> +#define NORMAL		1
> +#define MLOCK		2
> +#define KSM		3
> +#define PATH		"/dev/cgroup"
> +#define PATH_NEW	PATH "/1"
> +#define TESTMEM		(1UL<<30)
> +#define MB		(1UL<<20)
> +#define SYSFS_OVER	"/proc/sys/vm/overcommit_memory"
> +
> +static char overcommit[BUFSIZ];
> +
> +static void setup(void);
> +static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
> +static void oom(int testcase, int lite);
> +static void testoom(int lite);
> +static void alloc_mem(long int length, int testcase);
> +static void test_alloc(int testcase, int lite);
> +
> +int main(int argc, char *argv[])
> +{
> +	char *msg;
> +	int lc, fd;
> +	char buf[BUFSIZ], mem[BUFSIZ];
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
> +		snprintf(buf, BUFSIZ, "%s/memory.limit_in_bytes", PATH_NEW);
> +		fd = open(buf, O_WRONLY);
> +
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> +		sprintf(mem, "%ld", TESTMEM);
> +		if (write(fd, mem, strlen(mem)) != strlen(mem))
> +			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> +		close(fd);
> +
> +		snprintf(buf, BUFSIZ, "%s/tasks", PATH_NEW);
> +		fd = open(buf, O_WRONLY);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> +		snprintf(buf, BUFSIZ, "%d", getpid());
> +		if (write(fd, buf, strlen(buf)) != strlen(buf))
> +			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> +		close(fd);
> +		testoom(0);
> +
> +		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
> +			PATH_NEW);
> +		fd = open(buf, O_WRONLY);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> +		if (write(fd, mem, strlen(mem)) != strlen(mem))
> +			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> +		close(fd);
> +		testoom(1);
> +	}
> +	cleanup();
> +}

Here we could spare the snprintf() calls again.

> +void testoom(int lite)
> +{
> +	tst_resm(TINFO, "start normal OOM testing.");
> +	oom(NORMAL, lite);
> +
> +	tst_resm(TINFO, "start OOM testing for mlocked pages.");
> +	oom(MLOCK, lite);
> +
> +	tst_resm(TINFO, "start OOM testing for KSM pages.");
> +	oom(KSM, lite);
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
> +	if (mkdir(PATH, 0777) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
> +	if (mount("memcg", PATH, "cgroup", 0, "memory") == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "mount %s", PATH);
> +	if (mkdir(PATH_NEW, 0777) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", PATH_NEW);
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
> +	/* Move all processes in task to its parent memcg node. */
> +	snprintf(s, BUFSIZ, "%s/tasks", PATH);
> +	fd = open(s, O_WRONLY);
> +	if (fd == -1)
> +		tst_resm(TWARN|TERRNO, "open %s", s);
> +	snprintf(s_new, BUFSIZ, "%s/tasks", PATH_NEW);
> +
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
> +	if (rmdir(PATH_NEW) == -1)
> +		tst_resm(TWARN|TERRNO, "rmdir %s", PATH_NEW);
> +	if (umount(PATH) == -1)
> +		tst_resm(TWARN|TERRNO, "umount %s", PATH);
> +	if (rmdir(PATH) == -1)
> +		tst_resm(TWARN|TERRNO, "rmdir %s", PATH);
> +	
> +	TEST_CLEANUP;
> +	tst_exit();
> +}
> +
> +void alloc_mem(long int length, int testcase)
> +{
> +	void *s;
> +
> +	tst_resm(TINFO, "allocating %ld bytes.", length);
> +	s = mmap(NULL, length, PROT_READ|PROT_WRITE,
> +		MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +	if (s == MAP_FAILED) {
> +			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
> +	}

I would remove the curly brackets, as the rest of the code is omiting
them for one line code blocks.

> +	if (testcase == MLOCK && mlock(s, length) == -1)
> +		tst_brkm(TINFO|TERRNO, cleanup, "mlock");
> +	if (testcase == KSM
> +		&& madvise(s, length, MADV_MERGEABLE) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "madvise");
> +	memset(s, '\a', length);
> +}
> +
> +void test_alloc(int testcase, int lite)
> +{
> +	if (lite)
> +		alloc_mem(TESTMEM + MB, testcase);
> +	else
> +		while(1)
> +			alloc_mem(LENGTH, testcase);
> +}
> +
> +void oom(int testcase, int lite)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	switch(pid = fork()) {
> +	case -1:
> +		tst_brkm(TBROK|TERRNO, cleanup, "fork");
> +	case 0:
> +		test_alloc(testcase, lite);
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
