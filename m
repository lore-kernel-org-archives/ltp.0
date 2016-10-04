From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 4 Oct 2016 04:23:03 -0400 (EDT)
Subject: [LTP] new shell library
In-Reply-To: <20161003145835.GD7583@rei.suse.cz>
References: <20161003145835.GD7583@rei.suse.cz>
Message-ID: <2007222752.190298.1475569383933.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Monday, 3 October, 2016 4:58:35 PM
> Subject: new shell library
> 
> Hi!
> I've played bit with the shell test library in order to make it more
> aligned with the C library, have a look at:
> 
> https://github.com/metan-ucw/ltp
> 
> So far I've converted all testcases in commands/ directory, you can have
> a look at last 12 commits in the repo to see how the new shell library
> and testcases looks like. I would love to get someone to review the code
> before I attempt to convert more testcases.

Hi,

As a person who sees this first time, my immediate concern was,
how do I know what variables functions names are reserved
(without need to read entire tst_test.sh) and what happens if
I make a typo?

It also forces me to use specific names as the names
of my functions (e.g. "test", which presumably shadows test(1)).

And there's now requirement on when you can include new library,
it has to be at the end of file, because there are side-effects
(it starts the test on inclusion).

So, I was thinking:

. tst_test.sh

...

tst_def TID="du01"
tst_def TCNT=23
tst_def TST_SETUP mysetup
tst_def TST_CLEANUP mycleanup
tst_def TST_TESTFUNC mytest
tst_def TST_NEEDS_TMPDIR=1
tst_def TST_NEEDS_CMDS="dd du stat"
tst_start

tst_def - makes it clear that this variable defines something for tst_test,
          checks for potential typos, doesn't allow non-existent ones,
          is a single place in tst_test.sh where I can see all possible variables together

TST_TESTFUNC - allows me to give test function any name

tst_start - starts the test
            allows us to keep all includes at one place

IMO all of these would make the interface between tst_test.sh and actual
test more apparent and it's still in the spirit of C counter-part.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
