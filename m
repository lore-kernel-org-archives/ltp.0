From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jun 2016 14:30:56 +0200
Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
In-Reply-To: <969277405.4512739.1465373864678.JavaMail.zimbra@redhat.com>
References: <20160607115806.GA1740@rei.lan>
 <969277405.4512739.1465373864678.JavaMail.zimbra@redhat.com>
Message-ID: <20160608123056.GA26573@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index b8ec246..eef54e4 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -220,17 +220,19 @@ void tst_vres_(const char *file, const int lineno, int
> > ttype,
> >  void tst_vbrk_(const char *file, const int lineno, int ttype,
> >                 const char *fmt, va_list va) __attribute__((noreturn));
> >  
> > -static void do_cleanup(void);
> > +static void do_test_cleanup(void)
> > +{
> > +	if (tst_test->cleanup)
> > +		tst_test->cleanup();
> > +}
> >  
> >  void tst_vbrk_(const char *file, const int lineno, int ttype,
> >                 const char *fmt, va_list va)
> >  {
> >  	print_result(file, lineno, ttype, fmt, va);
> >  
> > -	if (getpid() == main_pid) {
> > -		do_cleanup();
> > -		cleanup_ipc();
> > -	}
> > +	if (getpid() == main_pid)
> > +		do_test_cleanup();
> >  
> 
> Not directly related to this patch, but I noticed that we don't
> seem to cleanup_ipc if we hit TBROK outside of main test pid.

The cleanup_ipc() is intended to be executed just before the main pid
exits since it unlinks the shm file. If child TBROKs it's catched in the
check_child_status() in the parent, tst_brk() is called which will call
the cleanup_ipc().

I guess that we may close and unmap the shm even in the children but
wouldn't that happen anyway as the process exits?

> > +void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> > +{
> > +	int status;
> > +	char *mul;
> > +
> > +	tst_test = self;
> > +	TCID = tst_test->tid;
> > +
> > +	do_setup(argc, argv);
> > +
> > +	if (tst_test->timeout)
> > +		timeout = tst_test->timeout;
> 
> Can you think of a testcase where we would want to disable timeout?

At the moment I do not remember a test that would need timeout to be
turned off. And if we find that it's necessary we can always disable in
case that tst_test->timeout < 0.

-- 
Cyril Hrubis
chrubis@suse.cz
