Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QrVnj-00044g-PE
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 13:59:59 +0000
Date: Thu, 11 Aug 2011 16:03:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110811140358.GA16435@saboteur.suse.cz>
References: <120e211c585b71f27c1bfc13d48e0f535b3201d5.1312279518.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <120e211c585b71f27c1bfc13d48e0f535b3201d5.1312279518.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] mm/ksm05: new testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> +int main(int argc, char *argv[])
> +{
> +	int lc, status;
> +	long ps;
> +	char *msg;
> +	pid_t pid;
> +	void *ptr;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> +
> +	ps = sysconf(_SC_PAGESIZE);
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +
> +		switch (pid = fork()) {
> +		case -1:
> +			tst_brkm(TBROK|TERRNO, cleanup, "fork");
> +		case 0:
> +			if (posix_memalign(&ptr, ps, ps) < 0)
> +				tst_brkm(TBROK|TERRNO, cleanup,
> +						"posix_memalign");
> +			if (madvise(ptr, ps, MADV_MERGEABLE) < 0)
> +				tst_brkm(TBROK|TERRNO, cleanup, "madvise");
> +			*(char *)NULL = 0; /* SIGSEGV occurs, expected. */
> +			exit(0);
> +		default:
> +			break;
> +		}
> +		if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +	}
> +
> +	tst_resm(TPASS, "still alive.");
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void sighandler(int sig)
> +{
> +	if (sig == SIGSEGV)
> +		tst_exit();
> +	else
> +		tst_resm(TFAIL, "sighandler received invalid signal:%d", sig);
> +}

I'm little worried about the tst_xxx interface used in signal handlers
as it is not signal-async-safe and may fail (in strange circumstances).

But this is in child process, right? So you could call _exit() and check
the return value in parent.

Also the return value from tst_resm() would end up as return value from
child and wouldn't propagate to parent if I'm not mistaken.

> +void setup(void)
> +{
> +	int fd;
> +	char buf[BUFSIZ], s[BUFSIZ];
> +
> +	tst_require_root(NULL);
> +
> +	if (tst_kvercmp(2, 6, 32) < 0)
> +		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required.");
> +
> +	tst_sig(FORK, sighandler, cleanup);
> +	TEST_PAUSE;
> +
> +	/* save original /sys/kernel/mm/ksm/run value */
> +	snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, "run");

No need for the snprintf() The PATH_KSM is static string so you can just
write these strings alongside as open(PATH_KSM "run", O_RDONLY);

> +	fd = open(buf, O_RDONLY);
> +	if (fd == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "open");
> +	if (read(fd, s, 1) != 1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "read");
> +	close(fd);
> +	is_running = atoi(s);
> +
> +	/* echo 1 > /sys/kernel/mm/ksm/run */
> +	if (is_running != 1) {
> +		fd = open(buf, O_WRONLY);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open");
> +		if (write(fd, "1", 1) != 1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "write");
> +		close(fd);
> +	}
> +}
> +
> +void cleanup(void)
> +{
> +	int fd;
> +	char buf[BUFSIZ], s[BUFSIZ];
> +
> +	/* restore /sys/kernel/mm/ksm/run value */
> +	if (is_running != 1) {
> +		snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, "run");
> +		snprintf(s, BUFSIZ, "%d", is_running);
> +		fd = open(buf, O_WRONLY);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open");
> +		if (write(fd, s, 1) != 1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "write");
> +		close(fd);
> +	}
> +
> +	TEST_CLEANUP;

Perhaps a function write_ksm_run(int val) should be better than
duplicating the code.

> +}
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "no MADV_MERGEABLE found.");
> +}
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
