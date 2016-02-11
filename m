From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Feb 2016 17:03:13 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <20160210114134.GA10106@rei.lan>
References: <20160105111136.GA32659@rei.lan>
 <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
 <20160204105638.GA4615@rei> <20160208180211.GE9844@rei>
 <20160209164352.GC11823@rei.lan> <20160209165703.GA5441@rei.lan>
 <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
 <20160210114134.GA10106@rei.lan>
Message-ID: <20160211160313.GA22877@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've redone the child handling and now it does:

* If test sets forks_child flag in test structure pipe is opened at the
  start of the test which is used to propagate test results from a child
  to parent

* Child processes are created via SAFE_FORK(), which flushes stdout,
  just in case there is something there, checks for for fork() failure
  and clears the result structure.

* After each test run (call to test() function), wait() is called until
  it returns ECHILD.

  If child was succesfully waited(), pipe is examined and if it contains
  test results, these are added to parent results.

  We look into the pipe after each sucessful wait() in order not to fill
  up the pipe capacity with many children.

* If child calls tst_brk(), exit() with non-zero value is called which is
  handled in parent wait() and the parent exits with tst_brk() as well.

  Techincaly any child that does not exit with 0 cause main test process
  to report TCONF/TBROK.

  At the moment the tst_brk() semantics is to exit the whole test since
  something unexpected happened. Which seems to be right course of
  action since failing SAFE_MACRO() in child should really cause main
  test process to exit.

  So if tst_brk() stays as it is we would need to add another call that
  can exit the child (would do the same action as returning from the
  test() function, i.e. write results and do exit(0)).

The code is at the same place at:

https://github.com/metan-ucw/ltp

Few test/example programs:

https://github.com/metan-ucw/ltp/blob/master/lib/newlib_tests/test05.c
https://github.com/metan-ucw/ltp/blob/master/lib/newlib_tests/test06.c
https://github.com/metan-ucw/ltp/blob/master/lib/newlib_tests/test07.c

There are probably stil a few rough edges: children forked from
children, waiting for rest of the children after one of them called
tst_brk(), etc. But the basic functionality seems to work fine.

As usuall comments are welcome.

-- 
Cyril Hrubis
chrubis@suse.cz
