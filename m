Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XWhR1-0002uw-VA
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 07:56:24 +0000
Date: Wed, 24 Sep 2014 09:56:05 +0200
From: chrubis@suse.cz
Message-ID: <20140924075604.GB10825@rei>
References: <1409047170-18251-1-git-send-email-mmarhefk@redhat.com>
	<1409319967-12730-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409319967-12730-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v2] containers: added mountns/mountns03.c
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	check_newns();	/* from mountns_helper.h */

Please remove this comment.

> +	tst_tmpdir();
> +	SAFE_MKDIR(cleanup, DIRA, 0777);
> +	SAFE_MKDIR(cleanup, DIRB, 0777);
> +	SAFE_MKDIR(cleanup, DIRC, 0777);
> +	SAFE_MKDIR(cleanup, DIRD, 0777);
> +	SAFE_TOUCH(cleanup, DIRA"/A", 0, NULL);
> +	SAFE_TOUCH(cleanup, DIRB"/B", 0, NULL);
> +	SAFE_TOUCH(cleanup, DIRC"/C", 0, NULL);
> +	SAFE_TOUCH(cleanup, DIRD"/D", 0, NULL);
> +}
> +
> +int child_func(void *arg)
> +{
> +	char buf;
> +
> +	/* bind mounts DIRA to DIRB making contents of DIRA visible
> +	 * in DIRB */
> +	if (mount(DIRA, DIRB, "none", MS_BIND, NULL) == -1) {
> +		perror("mount");
> +		write(pipefd1[1], "1", 1);
> +		return 1;
> +	}
> +
> +	/* makes mount DIRB a slave of DIRA (all slave mounts have
> +	 * a master mount which is a shared mount) */
> +	if (mount("none", DIRB, "none", MS_SLAVE, NULL) == -1) {
> +		perror("mount");
> +		umount(DIRB);
> +		write(pipefd1[1], "1", 1);
> +		return 1;
> +	}
> +
> +	/* bind mounts DIRC to DIRA making contents of DIRC visible
> +	 * in DIRA */
> +	if (mount(DIRC, DIRA, "none", MS_BIND, NULL) == -1) {
> +		perror("mount");
> +		umount(DIRB);
> +		write(pipefd1[1], "1", 1);
> +		return 1;
> +	}
> +
> +	/* as DIRB is a slave of DIRA, previous mount (DIRC to DIRA)
> +	 * should be also propageted into DIRB */
> +	if (access(DIRB"/C", F_OK) != -1)
> +		tst_resm(TPASS, "propagation to slave mount passed");
> +	else
> +		tst_resm(TFAIL, "propagation to slave mount failed");
> +
> +	/* bind mounts DIRD to DIRB making contents of DIRD visible
> +	 * in DIRB (should not propagate to DIRA as DIRB is its slave) */
> +	if (mount(DIRD, DIRB, "none", MS_BIND, NULL) == -1) {
> +		perror("mount");
> +		umount(DIRA);
> +		umount(DIRB);
> +		write(pipefd1[1], "1", 1);
> +		return 1;
> +	}
> +
> +	/* tells parent to stop waiting and continue */
> +	write(pipefd1[1], "0", 1);
> +
> +	/* waits for parent approval to terminate */
> +	read(pipefd2[0], &buf, 1);

We have a child-parent synchronization functions in the LTP test
library. Have look at include/tst_checkpoint.h and
lib/tests/tst_checkpoint* and make use of it.

In short these two statements would became:

TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
TST_CHECKPOINT_CHILD_WAIT(&checkpoint);

And you would have to declare checkpoint structure and initialize the
checkpoint in setup with:

struct tst_checkpoint checkpoint;

...

static void setup(void)
{
	...
	TST_CHECKPOINT_INIT(&checkpoint);
	...
}

The difference between doing write() and checkpoint interfaces is that
checkpoint checks return values from write(), suppport timeouts, etc.

> +	umount(DIRB);
> +	umount(DIRA);
> +	umount(DIRB);
> +	return 0;
> +}
> +
> +static void test(void)
> +{
> +	int status, pass;
> +	char buf;
> +
> +	/* creates a pipe for synchronization between parent and child */
> +	SAFE_PIPE(cleanup, pipefd1);
> +	SAFE_PIPE(cleanup, pipefd2);
> +
> +	/* unshares the mount ns */
> +	if (unshare(CLONE_NEWNS) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
> +	/* makes sure parent mounts/umounts have no effect on a real system */
> +	SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
> +
> +	/* bind mounts DIRA to itself */
> +	SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
> +	/* bind mounts DIRB to itself */
> +	SAFE_MOUNT(cleanup, DIRB, DIRB, "none", MS_BIND, NULL);
> +
> +	/* makes mount DIRA shared */
> +	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_SHARED, NULL);
> +	/* makes mount DIRB shared */
> +	SAFE_MOUNT(cleanup, "none", DIRB, "none", MS_SHARED, NULL);
> +
> +	if (do_clone_tests(CLONE_NEWNS, child_func, NULL, NULL, NULL) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
> +
> +	/* waits for child bind mount */
> +	SAFE_READ(cleanup, 0, pipefd1[0], &buf, 1);

Here you should do TST_CHECKPOINT_PARENT_WAIT(cleanup, &checkpoint);

> +	/* checks that mount in slave (DIRB) doesn't propagate to shared
> +	 * mount (DIRA) */
> +	if (access(DIRA"/D", F_OK) == -1)
> +		pass = 1;
> +	else
> +		pass = 0;
> +
> +	/* tells child to terminate (if no error occured in child) */
> +	SAFE_WRITE(cleanup, 0, pipefd2[1], "0", 1);

Here you should do TST_CHECKPOINT_SIGNAL_CHILD(cleanup, &checkpoint);

> +	SAFE_WAIT(cleanup, &status);
> +
> +	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> +		tst_brkm(TBROK, cleanup, "child failed");
> +
> +	if (WIFSIGNALED(status)) {
> +		tst_resm(TFAIL, "child was killed with signal %s",
> +			 tst_strsig(WTERMSIG(status)));
> +		return;
> +	}
> +
> +	close(pipefd1[0]);
> +	close(pipefd1[1]);
> +	close(pipefd2[0]);
> +	close(pipefd2[1]);
> +	SAFE_UMOUNT(cleanup, DIRA);
> +	SAFE_UMOUNT(cleanup, DIRB);
> +
> +	if (pass)
> +		tst_resm(TPASS, "propagation from slave mount passed");
> +	else
> +		tst_resm(TFAIL, "propagation form slave mount failed");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *msg;
> +	int lc;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++)
> +		test();
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +#else /* MS_SHARED && MS_PRIVATE && MS_REC && MS_SLAVE */

Have we settled if we should go with ifdefs or with defining the
constatns in include/lapi/?

I remeber that we disscussed it in one of the latter patches.

> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "needed mountflags are not defined");
> +}
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
