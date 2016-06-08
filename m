From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Jun 2016 08:59:01 -0400 (EDT)
Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
In-Reply-To: <20160608123056.GA26573@rei.lan>
References: <20160607115806.GA1740@rei.lan>
 <969277405.4512739.1465373864678.JavaMail.zimbra@redhat.com>
 <20160608123056.GA26573@rei.lan>
Message-ID: <1836941003.4597191.1465390741285.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 8 June, 2016 2:30:56 PM
> Subject: Re: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
> 
> Hi!
> > > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > > index b8ec246..eef54e4 100644
> > > --- a/lib/tst_test.c
> > > +++ b/lib/tst_test.c
> > > @@ -220,17 +220,19 @@ void tst_vres_(const char *file, const int lineno,
> > > int
> > > ttype,
> > >  void tst_vbrk_(const char *file, const int lineno, int ttype,
> > >                 const char *fmt, va_list va) __attribute__((noreturn));
> > >  
> > > -static void do_cleanup(void);
> > > +static void do_test_cleanup(void)
> > > +{
> > > +	if (tst_test->cleanup)
> > > +		tst_test->cleanup();
> > > +}
> > >  
> > >  void tst_vbrk_(const char *file, const int lineno, int ttype,
> > >                 const char *fmt, va_list va)
> > >  {
> > >  	print_result(file, lineno, ttype, fmt, va);
> > >  
> > > -	if (getpid() == main_pid) {
> > > -		do_cleanup();
> > > -		cleanup_ipc();
> > > -	}
> > > +	if (getpid() == main_pid)
> > > +		do_test_cleanup();
> > >  
> > 
> > Not directly related to this patch, but I noticed that we don't
> > seem to cleanup_ipc if we hit TBROK outside of main test pid.
> 
> The cleanup_ipc() is intended to be executed just before the main pid
> exits since it unlinks the shm file.

So, if we fail a SAFE macro somewhere in lib/tst_test.c,
I don't see we ever call cleanup_ipc().

tst_run_tcases
 SAFE_WAITPID(test_pid, &status, 0);
  tst_brkm
   tst_brkm_
    tst_brk_
     tst_vbrk_
      exit


> If child TBROKs it's catched in the
> check_child_status() in the parent, tst_brk() is called which will call
> the cleanup_ipc().

Not anymore. After this patch the only place that now calls
cleanup_ipc() is do_exit().

What I'm thinking is something like this on top of your patch:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index eef54e49bafb..1a0a9494af26 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -40,7 +40,7 @@ struct tst_test *tst_test;
 static char tmpdir_created;
 static int iterations = 1;
 static float duration = -1;
-static pid_t main_pid;
+static pid_t main_pid, lib_pid;
 
 struct results {
        int passed;
@@ -234,6 +234,9 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
        if (getpid() == main_pid)
                do_test_cleanup();
 
+       if (getpid() == lib_pid)
+               do_exit();
+
        exit(TTYPE_RESULT(ttype));
 }
 
@@ -673,6 +676,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
        int status;
        char *mul;
 
+       lib_pid = getpid();
        tst_test = self;
        TCID = tst_test->tid;
 


> 
> I guess that we may close and unmap the shm even in the children but
> wouldn't that happen anyway as the process exits?
> 
> > > +void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> > > +{
> > > +	int status;
> > > +	char *mul;
> > > +
> > > +	tst_test = self;
> > > +	TCID = tst_test->tid;
> > > +
> > > +	do_setup(argc, argv);
> > > +
> > > +	if (tst_test->timeout)
> > > +		timeout = tst_test->timeout;
> > 
> > Can you think of a testcase where we would want to disable timeout?
> 
> At the moment I do not remember a test that would need timeout to be
> turned off. And if we find that it's necessary we can always disable in
> case that tst_test->timeout < 0.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
