From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 Feb 2016 05:42:58 -0500 (EST)
Subject: [LTP] Test library API changes
In-Reply-To: <20160209174618.GB5441@rei.lan>
References: <20160105111136.GA32659@rei.lan>
 <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
 <20160204105638.GA4615@rei> <20160208180211.GE9844@rei>
 <20160209164352.GC11823@rei.lan> <20160209165703.GA5441@rei.lan>
 <20160209174618.GB5441@rei.lan>
Message-ID: <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 9 February, 2016 6:46:18 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> > And I was writing faster than thinking. We will need another one where
> > starting and reaping child is split between two functions. I will work
> > on that tomorrow.
> 
> And I've split the function into two now:
> 
> https://github.com/metan-ucw/ltp/blob/master/include/tst_test.h#L50

I had a look and have some comments/questions?

1. Why is tcnt not ARRAY_SIZE(tcases)?
   https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/creat/creat04.c#L83

static struct tst_test test = {
	.tid = "creat04",
	.tcnt = 2,

2. It would be nice if we could pass any parameters to child.
Atm. child func accepts only int and only way to share something else
appears to be passing it via global variables, which may become
confusing for bigger tests.

3. Sum based on tcnt still worries me because number of assertions per
test may vary:
   if (sum != tcnt * acnt * iterations)
	tst_brk(TBROK, "Number passes/fails/skipps does not match number of tests");

What if we verified instead, that after every testcase, at least one of
pass/fail/skip increased?

4. suggestion: improved safeguard for cleanup
Record pid of main process at start and call cleanup only if current
pid is recorded pid. This doesn't make it depend on using specific
API call to run child process.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
