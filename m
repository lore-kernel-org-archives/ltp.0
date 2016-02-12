From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Feb 2016 18:53:09 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan> <20160208180211.GE9844@rei>
 <20160209164352.GC11823@rei.lan> <20160209165703.GA5441@rei.lan>
 <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
 <20160210114134.GA10106@rei.lan> <20160211160313.GA22877@rei.lan>
 <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
Message-ID: <20160212175308.GA30723@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I was thinking about mapping a piece of shared memory for "struct results",
> then we wouldn't have to worry about how/when child terminates and how
> big buffer for resutls we need.

I did so as well, but then you need a temporary directory and backing
file and futexes/atomic operations to coordinate access to it. But we
would need the mutexes/atomic operations for threads as well...

> And if it was always there, it is one less parameter (forks_child) user
> needs to provide.

I've added it since it will serve another purpose as well. If we want to
do tst_sig() automatically before we start testcases we need to know if
process is expected to fork() children.

> > * Child processes are created via SAFE_FORK(), which flushes stdout,
> >   just in case there is something there, checks for for fork() failure
> >   and clears the result structure.
> > 
> > * After each test run (call to test() function), wait() is called until
> >   it returns ECHILD.
> > 
> >   If child was succesfully waited(), pipe is examined and if it contains
> >   test results, these are added to parent results.
> > 
> >   We look into the pipe after each sucessful wait() in order not to fill
> >   up the pipe capacity with many children.
> > 
> > * If child calls tst_brk(), exit() with non-zero value is called which is
> >   handled in parent wait() and the parent exits with tst_brk() as well.
> > 
> >   Techincaly any child that does not exit with 0 cause main test process
> >   to report TCONF/TBROK.
> > 
> >   At the moment the tst_brk() semantics is to exit the whole test since
> >   something unexpected happened. Which seems to be right course of
> >   action since failing SAFE_MACRO() in child should really cause main
> >   test process to exit.
> 
> We have tests that crash/kill child on purpose. As I recall some examples
> are mprotect and oom tests.
>
> These tests would need to wait for child themselves, since non-zero exit
> code is expected and we don't want reap_children() to see them and stop
> the test.

This is the reason the library does not store children pids or counts
forked children. All it cares about are child processes that outlived
the main test process. If the main test process waits() it's children
and the children does crash/exit() they never end up in the library code
so the child would not write the result and the parent will not reap it
since it was waited() allready. It will leak the pipe file descriptor in
the child in this case, but that will be closed at exit() by system.

Or did I miss something?

> >   So if tst_brk() stays as it is we would need to add another call that
> >   can exit the child (would do the same action as returning from the
> >   test() function, i.e. write results and do exit(0)).
> 
> Other notes:
> 
> write_result calls "exit(0);", and run_tests calls exit as well after
> it calls write_result.

Right my mistake.

> If we stay with pipe and write_result, can we use atexit() to call it?
> That would allow child to exit anywhere with "exit()" instead of making
> sure it returns all the way to run_tests function.

That would break the case when the test process does wait() for it's
own children since we will end up writing results anyway.

Maybe the page of shared memory is right way to propagate the results
after all. I will think about it.

-- 
Cyril Hrubis
chrubis@suse.cz
