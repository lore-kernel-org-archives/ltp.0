From: Michael Moese <mmoese@suse.de>
Date: Wed, 7 Mar 2018 16:06:05 +0100
Subject: [LTP] [PATCH v5 3/3] Add regression test for CVE-2017-17053
In-Reply-To: <20180307141445.GA2607@rei>
References: <20180307080519.15066-1-mmoese@suse.de>
 <20180307080519.15066-4-mmoese@suse.de> <20180307141445.GA2607@rei>
Message-ID: <20180307150605.dvskocudtzu2im3j@linux.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

On Wed, Mar 07, 2018 at 03:14:45PM +0100, Cyril Hrubis wrote:
> Hi!
> > +static int try_pthread_create(pthread_t *thread_id, const pthread_attr_t *attr,
> > +			      void *(*thread_fn)(void *), void *arg)
> > +{
> > +	int rval;
> > +
> > +	errno = 0;
> > +	rval = pthread_create(thread_id, attr, thread_fn, arg);
> > +
> > +	if (rval && errno != EAGAIN && errno != EWOULDBLOCK) {
> 
> Unlike the rest of the UNIX API the pthread_* functions returns errno
> directly, hence this should be:
> 
> if (rval && rval != EAGAIN && rval != EWOULDBLOCK)
> 
Ok, that sounds reasonable. I'll change that. 

> > +		tst_brk(TBROK, "pthread_create(%p,%p,%p,%p) failed: %s",
> > +			thread_id, attr, thread_fn, arg, tst_strerrno(rval));
> > +		return rval;
> 
> We will never reach this return, remember the tst_brk() exits the test.
>
Ok, removing the return.

> > +	}
> > +	return 0;
> > +}
> > +
> > +static int try_fork(void)
> > +{
> > +	pid_t pid;
> > +
> > +	fflush(stdout);
> 
> We should really do something about this as well. First of all the
> test library apparently flushes wrong stream apparently, but that is my
> mistake.
> 
> Secondly we should not hardcode which streem to flush here in the test.
> 
> I guess that best solution would be adding tst_flush(void) to the test
> library because the read_all test from ritchie needs that one as well. I
> can push that change myself or you can send a patch, your choice :-).
> 
I can send a patch. Should this only flush stdout, or also stderr?

> > +	pid = fork();
> > +	errno = 0;
> 
> There is no reason to zero the errno here.
> 
Well, this is obviously not only without reason but plain wrong. It
has to be the other way round. But I think it must be zeroed before 
fork().

> > +	if (pid < 0 && errno != EAGAIN && errno == EWOULDBLOCK)
> > +		tst_brk(TBROK | TERRNO, "fork() failed");
> > +	return pid;
> > +}
> > +
> > +
> > +
> > +struct shm_data {
> > +	sig_atomic_t do_exit;
> > +	sig_atomic_t segfaulted;
> > +};
> > +static struct shm_data *shm;
> 
> We are changin it from signal handler so it should be volatile as well.
> 
> > +static void handler(int sig)
> > +{
> > +	(void)(sig);
> 
> No need for the braces around sig here.
> 
> > +	shm->segfaulted = 1;
> > +}
> > +
> > +static void install_sighandler(void)
> > +{
> > +	struct sigaction sa;
> > +
> > +	sa.sa_flags = SA_SIGINFO;
> > +	sigemptyset(&sa.sa_mask);
> > +	sa.sa_handler = handler;
> > +
> > +	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> > +
> > +	shm = SAFE_MMAP(NULL, sizeof(struct shm_data),
> > +			PROT_READ | PROT_WRITE,
> > +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	SAFE_MUNMAP(shm, sizeof(struct shm_data));
> > +}
> > +
> > +static void *fork_thread(void *arg)
> > +{
> > +	try_fork();
> > +	return arg;
> > +}
> > +
> > +void run_test(void)
> > +{
> > +	struct user_desc desc = { .entry_number = 8191 };
> > +
> > +	install_sighandler();
> > +	syscall(__NR_modify_ldt, 1, &desc, sizeof(desc));
> > +
> > +	for (;;) {
> > +		if (shm->do_exit)
> > +			exit(0);
> > +		else if (shm->segfaulted)
> > +			exit(-1);
> 
> Is there a reason to pass a different value to exit() here?
> 
> We does not seem to use it in the run() function anyways.
> 
I think we should use it. I'll add WEXITSTATUS(status) the check 
if the test passed. 

> Also passing -1 to exit() is questionable choice since the actual value
> reported to the parent is masked with 0xff hence we will end up with 255
> in the parent (because of two complement representation of -1).
>
I'll change 0 and -1 to EXIT_SUCCESS and EXIT_FAILURE. In the end, we 
don't care for more.
 
> > +		if (try_fork() == 0) {
> > +			pthread_t t;
> > +
> > +			srand(getpid());
> > +			errno = 0;
> 
> There is no need to zero the errno here.
> 
True.
> > +			if (try_pthread_create(&t, NULL, fork_thread, NULL) != 0)
> > +				tst_brk(TCONF, "cannot create threads");
> 
> See above, we will never call the tst_brk() here.
> 
> > +			usleep(rand() % 10000);
> > +			syscall(__NR_exit_group, 0);
> > +		}
> > +	}
> > +}
> > +
> > +void run(void)
> > +{
> > +	int status;
> > +	pid_t pid;
> > +
> > +	shm->do_exit = 0;
> > +	shm->segfaulted = 0;
> > +	pid = try_fork();
> > +
> > +	if (pid == 0) {
> > +		run_test();
> > +	} else if (pid > 0) {
> > +		usleep(EXEC_USEC);
> > +		shm->do_exit = 1;
> > +	} else {
> > +		tst_brk(TCONF, "cannot fork new process");
> > +	}
> 
> Hmm, isn't it safe to call SAFE_FORK() here? The system shouldn't be
> memory starved at the point we start the test or am I mistaken?
> 
It does not really make a difference. Used it just to have it more homogeneous
throughout the file. Changing it to SAFE_FORK() should not matter.

> > +	SAFE_WAIT(&status);
> > +
> > +	if (WIFEXITED(status) && (shm->segfaulted == 0) && !tst_taint_check())
> > +		tst_res(TPASS, "kernel survived");
> > +	else
> > +		tst_res(TFAIL, "kernel is vulnerable");
> > +}
> > +
> > +static struct tst_test test = {
> > +	.forks_child = 1,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = run,
> > +};
> > -- 
> > 2.13.6
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Michael
-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
