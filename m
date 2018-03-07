From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Mar 2018 16:32:39 +0100
Subject: [LTP] [PATCH v5 3/3] Add regression test for CVE-2017-17053
In-Reply-To: <20180307150605.dvskocudtzu2im3j@linux.suse.de>
References: <20180307080519.15066-1-mmoese@suse.de>
 <20180307080519.15066-4-mmoese@suse.de> <20180307141445.GA2607@rei>
 <20180307150605.dvskocudtzu2im3j@linux.suse.de>
Message-ID: <20180307153239.GA13485@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +static int try_pthread_create(pthread_t *thread_id, const pthread_attr_t *attr,
> > > +			      void *(*thread_fn)(void *), void *arg)
> > > +{
> > > +	int rval;
> > > +
> > > +	errno = 0;
> > > +	rval = pthread_create(thread_id, attr, thread_fn, arg);
> > > +
> > > +	if (rval && errno != EAGAIN && errno != EWOULDBLOCK) {
> > 
> > Unlike the rest of the UNIX API the pthread_* functions returns errno
> > directly, hence this should be:
> > 
> > if (rval && rval != EAGAIN && rval != EWOULDBLOCK)
> > 
> Ok, that sounds reasonable. I'll change that. 

FYI using errno with phread_* functions is plain wrong as this code would
behave randomly since the value of errno here would be set by the last
failing call.

> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static int try_fork(void)
> > > +{
> > > +	pid_t pid;
> > > +
> > > +	fflush(stdout);
> > 
> > We should really do something about this as well. First of all the
> > test library apparently flushes wrong stream apparently, but that is my
> > mistake.
> > 
> > Secondly we should not hardcode which streem to flush here in the test.
> > 
> > I guess that best solution would be adding tst_flush(void) to the test
> > library because the read_all test from ritchie needs that one as well. I
> > can push that change myself or you can send a patch, your choice :-).
> > 
> I can send a patch. Should this only flush stdout, or also stderr?

The test library writes everything into stderr, see fputs() at the end
of the print_result(). Hence we should at least flush stderr. Flushing
stdout as well would not harm, it should be empty unless the test
wrote anything there.

> > > +	pid = fork();
> > > +	errno = 0;
> > 
> > There is no reason to zero the errno here.
> > 
> Well, this is obviously not only without reason but plain wrong. It
> has to be the other way round. But I think it must be zeroed before 
> fork().

The errno is set on failure, so if we got -1 from fork() it has been set
in glibc to something meaningful. I do not see a reason to reset it
before fork().

There are a few calls that do not have a well defined return value that
represents a failure and because of that  errno has to be reset before
we call them (for example the strto* functions) but these quire rare.

> > > +	struct user_desc desc = { .entry_number = 8191 };
> > > +
> > > +	install_sighandler();
> > > +	syscall(__NR_modify_ldt, 1, &desc, sizeof(desc));
> > > +
> > > +	for (;;) {
> > > +		if (shm->do_exit)
> > > +			exit(0);
> > > +		else if (shm->segfaulted)
> > > +			exit(-1);
> > 
> > Is there a reason to pass a different value to exit() here?
> > 
> > We does not seem to use it in the run() function anyways.
> > 
> I think we should use it. I'll add WEXITSTATUS(status) the check 
> if the test passed. 

We do check the shm->segfaulted there so there is no need to propagate
it in the exit value as well...

> > > +void run(void)
> > > +{
> > > +	int status;
> > > +	pid_t pid;
> > > +
> > > +	shm->do_exit = 0;
> > > +	shm->segfaulted = 0;
> > > +	pid = try_fork();
> > > +
> > > +	if (pid == 0) {
> > > +		run_test();
> > > +	} else if (pid > 0) {
> > > +		usleep(EXEC_USEC);
> > > +		shm->do_exit = 1;
> > > +	} else {
> > > +		tst_brk(TCONF, "cannot fork new process");
> > > +	}
> > 
> > Hmm, isn't it safe to call SAFE_FORK() here? The system shouldn't be
> > memory starved at the point we start the test or am I mistaken?
> > 
> It does not really make a difference. Used it just to have it more homogeneous
> throughout the file. Changing it to SAFE_FORK() should not matter.

Well the test-writing-guidelines says that we should use SAFE_MACROS()
whenever possible. In this case it adds a bit of confusion since the
reader of the code would wonder why SAFE_FORK() is not used.

Also the tst_brk() message doesn't have the TERRNO flag, so if the fork
has failed here you would have no idea why when looking at the logs.

So please let's keep the error messages consistent and use raw fork()
only when we have to.

> > > +	SAFE_WAIT(&status);
> > > +
> > > +	if (WIFEXITED(status) && (shm->segfaulted == 0) && !tst_taint_check())
> > > +		tst_res(TPASS, "kernel survived");
> > > +	else
> > > +		tst_res(TFAIL, "kernel is vulnerable");
> > > +}
> > > +
> > > +static struct tst_test test = {
> > > +	.forks_child = 1,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.test_all = run,
> > > +};
> > > -- 
> > > 2.13.6
> > > 
> > > 
> > > -- 
> > > Mailing list info: https://lists.linux.it/listinfo/ltp
> > 
> > -- 
> > Cyril Hrubis
> > chrubis@suse.cz
> 
> Michael
> -- 
> SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)

-- 
Cyril Hrubis
chrubis@suse.cz
