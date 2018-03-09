From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Mar 2018 11:50:06 +0100
Subject: [LTP] [PATCH] Add regression test for CVE-2017-16939
In-Reply-To: <20180309103310.qx3oac43twii7wvh@linux.suse.de>
References: <20180206140359.18387-1-mmoese@suse.de> <20180307170529.GC2607@rei>
 <20180309103310.qx3oac43twii7wvh@linux.suse.de>
Message-ID: <20180309105006.GA24656@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also we should probably allocate these once in the test setup so that we
> > do not waste memory when the test is executed with the -i option.
> I was trying to keep as close as possible to the reproducer. I can check if
> this can be moved to setup, and maybe only initialize once. However, I think
> it is not a big waste of memory, after all the test does not loop or fork 
> or anything like this.

Note that all testcases can take -i or -I parameter which causes that
the test() function is called in a loop. That is the reason why we
should care for allocating memory out of the test() function, or at
least freeing it at the end of it.

> > > +	pid = SAFE_FORK();
> > > +	if (pid == 0) {
> > > +		do_run();
> > > +	} else {
> > > +		usleep(250000);
> >                 ^
> > 		Why the usleep here? Should just the waitpid() below
> > 		suffice in waiting for the child to exit?
> > 
> Well, this is something asynchronous happening in the kernel. When we don't 
> wait for a while, the crash happens way after we reported a PASS.. but maybe
> the usleep makes more sense after the waitpid(). 

Well that's a good question, the problem is that if we add the usleep to
the test it will slow down the testsuite in all cases, which is bad as
the longer the testsuite takes the less useful it is. But if we don't
add it will be a bit more complicated to to figure out which test caused
the crash.

But at least the usleep() requires proper comment about why it's there,
something as "the corruption usually manifests within a short time frame
hence we sleep here for a while" or something like that.

Or we may try to help it by running the actuall test in a loop for
several iterations instead of idling which may increase the probability
of failing earlier.

-- 
Cyril Hrubis
chrubis@suse.cz
