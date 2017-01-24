From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jan 2017 14:00:26 +0100
Subject: [LTP] [PATCH] fanotify: Add test for permission event
	destruction
In-Reply-To: <20170124121344.GD20153@quack2.suse.cz>
References: <20170120132951.10312-1-jack@suse.cz>
 <20170123121947.GB22484@rei.lan>
 <20170124121344.GD20153@quack2.suse.cz>
Message-ID: <20170124130025.GA29054@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Just FYI we have switched to a new test library for all new testcases
> > quite some time ago, you can have a look at the documentation on our
> > wiki[1], or look at a comparsion of the same test I've prepared for a
> > lwn.net article[2].
> 
> Ah, I didn't notice. Honestly, I've just copied some older fanotify test
> and modified it ;).

I assumed, we are slowly converting old testcases, but given the number
of old tests the old library and new library will coexist alongside for
a few years.

> > I can convert the test if you want, it's not complicated, but please
> > keep in mind to use the new library API next time you start writing a
> > testcase.
> 
> One thing that is not quite clear to me with the new API:
> 
> Should I use .test or .test_all callback? The test has two parts => we call
> tst_resm() twice. That would indicate I should set .tcnt to 2 and use .test
> callback however that is seriously impractical as the two tests are very
> closely related and in fact the second test just verifies that the cleanup
> of the first test went fine. So we need to propagate a lot of state between
> the first and the second state.

The conditioins are quite relaxed in the new library. The test_all
function or each iteration test function has to report some results,
anything else is up to you.

We have quite a number of testcases where each step depends on previous
one and because of that everyting is executed in a sequence in the
test_all() function which in turn produces several TPASS messages. For
instance the fallocate testcases that insert and then remove blocks in a
middle of a file.

-- 
Cyril Hrubis
chrubis@suse.cz
