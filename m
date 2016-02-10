From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Feb 2016 11:56:42 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan>
 <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
 <20160204105638.GA4615@rei> <20160208180211.GE9844@rei>
 <20160209164352.GC11823@rei.lan> <20160209165703.GA5441@rei.lan>
 <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
Message-ID: <20160210105642.GA9591@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I had a look and have some comments/questions?
> 
> 1. Why is tcnt not ARRAY_SIZE(tcases)?
>    https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/creat/creat04.c#L83

My mistake. Will fix that.

> static struct tst_test test = {
> 	.tid = "creat04",
> 	.tcnt = 2,
> 
> 2. It would be nice if we could pass any parameters to child.
> Atm. child func accepts only int and only way to share something else
> appears to be passing it via global variables, which may become
> confusing for bigger tests.

I was thinking about passing a pointer just as pthread_create() does as
well. Let's go this way instead.

> 3. Sum based on tcnt still worries me because number of assertions per
> test may vary:
>    if (sum != tcnt * acnt * iterations)
> 	tst_brk(TBROK, "Number passes/fails/skipps does not match number of tests");
> 
> What if we verified instead, that after every testcase, at least one of
> pass/fail/skip increased?

That is a good idea. I will rework it this way.

> 4. suggestion: improved safeguard for cleanup
> Record pid of main process at start and call cleanup only if current
> pid is recorded pid. This doesn't make it depend on using specific
> API call to run child process.

There is another problem that has to be solved if we want to go this
way. We have to pass the results from the child to the parent and since
it's more complicated than single PASS/FAIL/SKIP/BROK now, we have to
pass it somehow. So we would have to create a communication channel
anyway. Which means either opening one by default before the test starts
or doing that in tst_fork() wrapper.

-- 
Cyril Hrubis
chrubis@suse.cz
