From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Nov 2018 15:51:06 +0100
Subject: [LTP] [Automated-testing] [RFC] [PATCH] lib: Add support for
 test tags
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF88A3CBD9@USCULXMSG01.am.sony.com>
References: <20181107142209.8965-1-chrubis@suse.cz>
 <CAEemH2dw1qeKgswzh8k_PdesQwGtRm72wzfG2erqw3J-WTJG0A@mail.gmail.com>
 <20181108125210.GB29767@rei>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A34661@USCULXMSG01.am.sony.com>
 <20181109122804.GB19700@rei.lan>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A3CBD9@USCULXMSG01.am.sony.com>
Message-ID: <20181116145106.GA13883@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > It sounds like you will be preserving test metadata with two different uses:
> > > 1) dependencies required for the test to execute
> > > 2) possible explanations for test failure
> > >
> > > There might be a value in keeping these distinct.
> > 
> > It's a bit more complicated than this in LTP we have basically three sets:
> > 
> > 1) test dependencies that could be derived from the test structure
> >    (these are the needs_root, needs_device, but also needs mkfs.foo or
> > others)
> > 
> > 2) test dependencies that has to be specified explicitely
> >    (test is doing something with global resources, SysV IPC, Wall
> >    clock)
> 
> Ahhh.   This turned on a light bulb in my head, and was a new thought
> for me, that really blew my mind.
> 
> The reason is that Fuego runs only one test at a time on the target, so
> any test automatically has exclusive access (from a test standpoint)
> to on-target resources.  This is a result of how Fuego uses Jenkins
> to schedule testing jobs.
> 
> I've been focused on off-target resource allocation (like the netperf
> server, or off-board power measurement hardware).  It's important
> for tests that work in the same "lab" to be able to reserve these
> exclusively to avoid contention and perturbation of the test results.
> And this is a difficult problem because there are no standards whatsoever
> for doing this.  This ends up being a test scheduling issue (and possibly
> a deadlock avoidance/resolution issue).
> 
> But this dependency you mention is focused on on-target resources, to
> which a test might also need exclusive access.  This also presents a 
> test scheduling issue.
> 
> A few questions:
> 
> Can LTP run multiple tests simultaneously?    I seem to recall something
> about ltp-pan running multiple tests at the same time (for stress testing).

Not at the moment, but given that even embedded hardware have multicore
CPUs these days it's a waste of resources and even more on server grade
hardware with many cores.

There is subset of tests that will fail if the machine is under load for
example, which also prevents us from runnig the testsuite with some kind
of backgroud CPU load and under memory pressure, which is just another
reason why we need annotations like this.

> Does LTP have a mechanism to "claim" or "reserve" a resource
> on the system under test?

There is none, which is the reason I started to look into this.

My take on the problem is that each test would export this information
to the testrunner so that the testrunner can make informed decisions.

It could be as simple as a sinle bit of data that tells the testrunner
not to run the tests in parallel, but I would like to be a bit more
granular from the start. For instance we can run a few tests that
require loop device in parallel as well, no need to limit this.

> Does LTP have a mechanism to schedule tests?  That is, to check for
> resource availability and hold off test execution until a resource
> becomes available?

Not yet, this is what I'm currently looking into.

But I do not see any complications down the road, once the testrunner
has the information, we just need to refrain from running conflicting
tests while saturating the CPU usage with running NCPU+1 test at a time
or so.

> Thanks.  I really appreciate that you posted this to the automated-testing
> list so we could think about it and the problems it's solving for you.

And I do appreciate that there is some discussion around this :-).

-- 
Cyril Hrubis
chrubis@suse.cz
