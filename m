From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 12 Feb 2016 07:33:46 -0500 (EST)
Subject: [LTP] Test library API changes
In-Reply-To: <20160211160313.GA22877@rei.lan>
References: <20160105111136.GA32659@rei.lan> <20160208180211.GE9844@rei>
 <20160209164352.GC11823@rei.lan> <20160209165703.GA5441@rei.lan>
 <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
 <20160210114134.GA10106@rei.lan> <20160211160313.GA22877@rei.lan>
Message-ID: <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 11 February, 2016 5:03:13 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> I've redone the child handling and now it does:
> 
> * If test sets forks_child flag in test structure pipe is opened at the
>   start of the test which is used to propagate test results from a child
>   to parent

Hi,

I was thinking about mapping a piece of shared memory for "struct results",
then we wouldn't have to worry about how/when child terminates and how
big buffer for resutls we need.

And if it was always there, it is one less parameter (forks_child) user
needs to provide.

> 
> * Child processes are created via SAFE_FORK(), which flushes stdout,
>   just in case there is something there, checks for for fork() failure
>   and clears the result structure.
> 
> * After each test run (call to test() function), wait() is called until
>   it returns ECHILD.
> 
>   If child was succesfully waited(), pipe is examined and if it contains
>   test results, these are added to parent results.
> 
>   We look into the pipe after each sucessful wait() in order not to fill
>   up the pipe capacity with many children.
> 
> * If child calls tst_brk(), exit() with non-zero value is called which is
>   handled in parent wait() and the parent exits with tst_brk() as well.
> 
>   Techincaly any child that does not exit with 0 cause main test process
>   to report TCONF/TBROK.
> 
>   At the moment the tst_brk() semantics is to exit the whole test since
>   something unexpected happened. Which seems to be right course of
>   action since failing SAFE_MACRO() in child should really cause main
>   test process to exit.

We have tests that crash/kill child on purpose. As I recall some examples
are mprotect and oom tests.

These tests would need to wait for child themselves, since non-zero exit
code is expected and we don't want reap_children() to see them and stop
the test.

> 
>   So if tst_brk() stays as it is we would need to add another call that
>   can exit the child (would do the same action as returning from the
>   test() function, i.e. write results and do exit(0)).

Other notes:

write_result calls "exit(0);", and run_tests calls exit as well after
it calls write_result.

If we stay with pipe and write_result, can we use atexit() to call it?
That would allow child to exit anywhere with "exit()" instead of making
sure it returns all the way to run_tests function.

Regards,
Jan

> 
> The code is at the same place at:
> 
> https://github.com/metan-ucw/ltp
> 
> Few test/example programs:
> 
> https://github.com/metan-ucw/ltp/blob/master/lib/newlib_tests/test05.c
> https://github.com/metan-ucw/ltp/blob/master/lib/newlib_tests/test06.c
> https://github.com/metan-ucw/ltp/blob/master/lib/newlib_tests/test07.c
> 
> There are probably stil a few rough edges: children forked from
> children, waiting for rest of the children after one of them called
> tst_brk(), etc. But the basic functionality seems to work fine.
> 
> As usuall comments are welcome.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
