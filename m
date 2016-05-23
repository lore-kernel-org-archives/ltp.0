From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 May 2016 06:33:11 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] lib/tst_test.c: Run test in child process
In-Reply-To: <20160523100650.GB22559@rei.lan>
References: <20160519151746.GA2772@rei>
 <1671077356.4707701.1463736355683.JavaMail.zimbra@redhat.com>
 <20160523100650.GB22559@rei.lan>
Message-ID: <236642895.5211197.1463999591461.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 23 May, 2016 12:06:50 PM
> Subject: Re: [LTP] [RFC] [PATCH] lib/tst_test.c: Run test in child process
> 
> Hi!
> > > +#define MAX(a,b) ((a) > (b) ? (a) : (b))
> > > +
> > > +void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> > > +{
> > > +	int status;
> > > +	unsigned int timeout, timeout_per_run = 1;
> > 
> > 1s seems very low to me as default. ~18% of (mostly syscall) testcases
> > I run on s390 have duration >= 1 reported.
> 
> I just stuck 1s there without much thinking about it...
> 
> > If our goal is to not hang indefinitely, then even a timeout of 5 minutes
> > doesn't look as bad to me. And it also gives kernel time to report a
> > potential
> > soft lockup before we kill the test.
> 
> Having 5 minutes by default sounds too much to me since we have to
> multiply it by the number of iterations below, which would make it 50
> minutes for -i 10. I would be inclined to change it to 10s or something
> similar so that it does not grow indefinitly with the number of
> iterations.
> 
> Another soulution would be to restart the timer for each test iteration,
> we could stick to arbitrarily large timeout in that case. But then we
> would have to synchronize the parent and child process somehow.
> 
> Well we could make it so the child process sends a heartbeat signal
> after each iteration of test is done. And since we can call alarm() in
> the signal context, we can do that just with child sending SIGUSR1 to
> parent with parent SIGUSR1 handler doing just alarm(timeout); Then we
> can get rid of the timeout computation as well. What do you think about
> this?

The idea of simple heartbeat sounds good to me. I would like to keep
default timeout big, so that majority of testcases don't need to
override it and we can avoid patches bumping timeout by seconds,
because it ran on something slightly slower HW. 

Regards,
Jan

> 
> > > +
> > > +	tst_test = self;
> > > +	TCID = tst_test->tid;
> > > +
> > > +	do_setup(argc, argv);
> > > +
> > > +	if (tst_test->timeout)
> > > +		timeout_per_run = tst_test->timeout;
> > > +
> > > +	timeout = timeout_per_run * iterations;
> > > +
> > > +	if (duration > 0)
> > > +		timeout = MAX(timeout, duration + 2 * timeout_per_run);
> > > +
> > > +	tst_res(TINFO, "Timeout is %us", timeout);
> > > +
> > > +	SAFE_SIGNAL(SIGALRM, alarm_handler);
> > > +	alarm(timeout);
> > > +
> > > +	test_pid = fork();
> > 
> > Should we care about child processes too? We could make new process group
> > and then send signal to entire process group.
> 
> I'm planning of adding that support on the top of this later. And I'm
> also pondering a possibility to produce more structured logs as well.
> 
> > > +	if (test_pid < 0)
> > > +		tst_brk(TBROK | TERRNO, "fork()");
> > > +
> > > +	if (!test_pid)
> > > +		testrun();
> > > +
> > > +	SAFE_WAITPID(test_pid, &status, 0);
> 
> And it occured to me that we should disharm the alarm here. Since it may
> send a signal to a wrong process since the test pid was freed by the
> waitpid() above.
> 
> > >  	do_cleanup();
> > > +
> > > +	if (WIFEXITED(status) && WEXITSTATUS(status))
> > > +		exit(WEXITSTATUS(status));
> > > +
> > > +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
> > > +		tst_brk(TBROK, "Test killed! (timeout?)");
> > > +
> > > +	if (WIFSIGNALED(status))
> > > +		tst_brk(TBROK, "Test killed by %s!", tst_strsig(WTERMSIG(status)));
> > > +
> > >  	do_exit();
> > >  }
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
