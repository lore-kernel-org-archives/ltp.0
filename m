From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Mar 2020 00:24:26 +0100
Subject: [LTP] [PATCH V2 2/2] syscalls/clone3: New tests
In-Reply-To: <20200319151956.3rwix5oint6cmt4f@vireshk-i7>
References: <cover.1584618969.git.viresh.kumar@linaro.org>
 <c64b9c05053d500a95cc920e332fa229085217b6.1584618969.git.viresh.kumar@linaro.org>
 <20200319230111.GC29386@yuki.lan>
 <20200319151956.3rwix5oint6cmt4f@vireshk-i7>
Message-ID: <20200319232426.GD29386@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +static void child_rx_signal(int sig, siginfo_t *info, void *ucontext)
> > > +{
> > > +	if (info) {
> > > +		int n = info->si_value.sival_int;
> > > +
> > > +		if (sig == CHILD_SIGNAL)
> > > +			tst_res(TPASS, "clone3() passed: Child received correct signal (index %d)", n);
> > > +		else
> > > +			tst_res(TFAIL, "clone3() failed: Child received incorrect signal (index %d)", n);
> > > +	} else {
> > > +		tst_res(TFAIL, "clone3() failed: Invalid info");
> > > +	}
> > > +}
> > 
> > Calling tst_res() is not safe from a signal handler context.
> > 
> > So what we should do here is store the sig and info->si_value.sival_int
> > to a global variables and check them the do_child function instead.
> > 
> > And the same applies for the parent handler as well.
> 
> Lemme start by excepting that I am bad with userspace programming and
> I mostly do kernel stuff :(

You are doing a great job :-).

> With clone, parent and child process don't space address space and so
> the variables aren't shared. I tried the CLONE_VM thing but with the
> first write, the program gets killed. Not sure how to fix that.

Huh? All that we have to is to move the code from the child_rx_signal()
to the do_child() here, the child would setup a handler and call
pause(), then it checks if correct values have been stored to a global
varibles. And the same for the parent, the point is that we should do a
minimal amount of work in the handler itself.

The problem here is that tst_res() writes to std streams, that have
locks, so if we happen to get a signal while something writes there as
well, we deadlock. Also printf()-like functions may call malloc, which
has locks and may deadlock in the same way. It's unlikely that it will
ever happen in this test, but that does not excuse us...

> > > +static void setup(void)
> > > +{
> > > +	clone3_supported_by_kernel();
> > > +
> > > +	psig_action = SAFE_MALLOC(sizeof(*psig_action));
> > > +	memset(psig_action, 0, sizeof(*psig_action));
> > > +	psig_action->sa_sigaction = parent_rx_signal;
> > > +	psig_action->sa_flags = SA_SIGINFO;
> > > +
> > > +	csig_action = SAFE_MALLOC(sizeof(*csig_action));
> > > +	memset(csig_action, 0, sizeof(*csig_action));
> > > +	csig_action->sa_sigaction = child_rx_signal;
> > > +	csig_action->sa_flags = SA_SIGINFO;
> > 
> > There is no need to allocate these, we can just define them as a static
> > global variables with:
> > 
> > static struct sigaction psig_action = {
> > 	.sa_sigaction = parent_rx_signal,
> > 	.sa_flags = SA_SIGINFO,
> > };
> 
> I thought about that but then followed what pidfd_send_signal() did.
> 
> > > +static struct clone_args *valid_args, *invalid_args;
> > > +unsigned long stack;
> > > +static int *invalid_address;
> > > +
> > > +static struct tcase {
> > > +	const char *name;
> > > +	struct clone_args **args;
> > > +	size_t size;
> > > +	uint64_t flags;
> > > +	int **pidfd;
> > > +	int **child_tid;
> > > +	int **parent_tid;
> > > +	int exit_signal;
> > > +	unsigned long stack;
> > > +	unsigned long stack_size;
> > > +	unsigned long tls;
> > > +	int exp_errno;
> > > +} tcases[] = {
> > > +	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EFAULT},
> > > +	{"zero size", &valid_args, 0, 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> > > +	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> > > +	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EFAULT},
> > > +	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> > > +	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> > > +	{"fs-newns", &valid_args, sizeof(*valid_args), CLONE_FS | CLONE_NEWNS, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> > > +	{"invalid pidfd", &valid_args, sizeof(*valid_args), CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, &invalid_address, NULL, NULL, SIGCHLD, 0, 0, 0, EFAULT},
> > > +	{"invalid childtid", &valid_args, sizeof(*valid_args), CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, NULL, &invalid_address, NULL, SIGCHLD, 0, 0, 0, EFAULT},
> > > +	{"invalid parenttid", &valid_args, sizeof(*valid_args), CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, NULL, NULL, &invalid_address, SIGCHLD, 0, 0, 0, EFAULT},
> > > +	{"invalid signal", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, CSIGNAL + 1, 0, 0, 0, EINVAL},
> > > +	{"zero-stack-size", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, (unsigned long)&stack, 0, 0, EINVAL},
> > > +	{"invalid-stack", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, 0, 4, 0, EINVAL},
> > > +};
> > > +
> > > +static void setup(void)
> > > +{
> > > +	clone3_supported_by_kernel();
> > > +
> > > +	invalid_address = tst_get_bad_addr(NULL);
> > > +}
> > > +
> > > +static void run(unsigned int n)
> > > +{
> > > +	struct tcase *tc = &tcases[n];
> > > +	struct clone_args *args = *tc->args;
> > > +
> > > +	if (args) {
> > > +		args->flags = tc->flags;
> > > +		if (tc->pidfd)
> > > +			args->pidfd = (uint64_t)(*tc->pidfd);
> > > +		if (tc->child_tid)
> > > +			args->child_tid = (uint64_t)(*tc->child_tid);
> > > +		if (tc->parent_tid)
> > > +			args->parent_tid = (uint64_t)(*tc->parent_tid);
> > > +		args->exit_signal = tc->exit_signal;
> > > +		args->stack = tc->stack;
> > > +		args->stack_size = tc->stack_size;
> > > +		args->tls = tc->tls;
> > > +	}
> > 
> > Isn't this wrong now that invalid_args != NULL?
> > 
> > Shouldn't this rather be if (args == valid_args) ?
> 
> invalid_args is still NULL, invalid_address isn't though.

Ah, my bad. I wonder if we should set the invalid_args to the result of
tst_get_bad_address() as well, just for a consistency.

-- 
Cyril Hrubis
chrubis@suse.cz
