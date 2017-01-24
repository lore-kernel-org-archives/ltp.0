From: Jan Kara <jack@suse.cz>
Date: Tue, 24 Jan 2017 13:13:44 +0100
Subject: [LTP] [PATCH] fanotify: Add test for permission event
	destruction
In-Reply-To: <20170123121947.GB22484@rei.lan>
References: <20170120132951.10312-1-jack@suse.cz>
 <20170123121947.GB22484@rei.lan>
Message-ID: <20170124121344.GD20153@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On Mon 23-01-17 13:19:48, Cyril Hrubis wrote:
> Just FYI we have switched to a new test library for all new testcases
> quite some time ago, you can have a look at the documentation on our
> wiki[1], or look at a comparsion of the same test I've prepared for a
> lwn.net article[2].

Ah, I didn't notice. Honestly, I've just copied some older fanotify test
and modified it ;).

> I can convert the test if you want, it's not complicated, but please
> keep in mind to use the new library API next time you start writing a
> testcase.

One thing that is not quite clear to me with the new API:

Should I use .test or .test_all callback? The test has two parts => we call
tst_resm() twice. That would indicate I should set .tcnt to 2 and use .test
callback however that is seriously impractical as the two tests are very
closely related and in fact the second test just verifies that the cleanup
of the first test went fine. So we need to propagate a lot of state between
the first and the second state.

								Honza


> [1]: https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c
> [2]: article: https://lwn.net/Articles/708182/ (see most notable changes)
>      old test: https://lwn.net/Articles/708250/
>      new test: https://lwn.net/Articles/708251/
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
