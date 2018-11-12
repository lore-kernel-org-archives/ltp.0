From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Mon, 12 Nov 2018 16:09:15 +0000
Subject: [LTP] [Automated-testing] [RFC] [PATCH] lib: Add support for
 test tags
In-Reply-To: <20181109122804.GB19700@rei.lan>
References: <20181107142209.8965-1-chrubis@suse.cz>
 <CAEemH2dw1qeKgswzh8k_PdesQwGtRm72wzfG2erqw3J-WTJG0A@mail.gmail.com>
 <20181108125210.GB29767@rei>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A34661@USCULXMSG01.am.sony.com>
 <20181109122804.GB19700@rei.lan>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF88A3CBD9@USCULXMSG01.am.sony.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: Cyril Hrubis 
...
> > > > > This commit also adds adds the -q test flag, that can be used to query
> > > > > test information, which includes these tags, but is not limited to them.
> > > > >
> > > > > The main inteded use for the query operation is to export test
> metadata
> > > > > and constraints to the test execution system. The long term goal for
> > > > > this would be parallel test execution as for this case the test runner
> > > > > would need to know which global system resources is the test using
> to
> > > > > avoid unexpected failures.

I don't think I was paying enough attention when I read through this
earlier.  This is very interesting, and different from the external dependencies
I've focused on in my analysis of dependencies.  But it's certainly as important
as what I've thought about in Fuego.

> > > > >
> > > > > So far it exposes only if test needs root and if block device is needed
> > > > > for the test, but I would expect that we will need a few more tags for
> > > > > various resources, one that comes to my mind would be "test is using
> > > > > SystemV SHM" for that we can do something as add a "constraint" tag
> > > with
> > > > > value "SysV SHM" or anything else that would be fitting. Another
> would
> > > > > be "Test is changing system wide clocks", etc.
> >
> > It sounds like you will be preserving test metadata with two different uses:
> > 1) dependencies required for the test to execute
> > 2) possible explanations for test failure
> >
> > There might be a value in keeping these distinct.
> 
> It's a bit more complicated than this in LTP we have basically three sets:
> 
> 1) test dependencies that could be derived from the test structure
>    (these are the needs_root, needs_device, but also needs mkfs.foo or
> others)
> 
> 2) test dependencies that has to be specified explicitely
>    (test is doing something with global resources, SysV IPC, Wall
>    clock)

Ahhh.   This turned on a light bulb in my head, and was a new thought
for me, that really blew my mind.

The reason is that Fuego runs only one test at a time on the target, so
any test automatically has exclusive access (from a test standpoint)
to on-target resources.  This is a result of how Fuego uses Jenkins
to schedule testing jobs.

I've been focused on off-target resource allocation (like the netperf
server, or off-board power measurement hardware).  It's important
for tests that work in the same "lab" to be able to reserve these
exclusively to avoid contention and perturbation of the test results.
And this is a difficult problem because there are no standards whatsoever
for doing this.  This ends up being a test scheduling issue (and possibly
a deadlock avoidance/resolution issue).

But this dependency you mention is focused on on-target resources, to
which a test might also need exclusive access.  This also presents a 
test scheduling issue.

A few questions:

Can LTP run multiple tests simultaneously?    I seem to recall something
about ltp-pan running multiple tests at the same time (for stress testing).

Does LTP have a mechanism to "claim" or "reserve" a resource
on the system under test?

Does LTP have a mechanism to schedule tests?  That is, to check for
resource availability and hold off test execution until a resource
becomes available?

Thanks.  I really appreciate that you posted this to the automated-testing
list so we could think about it and the problems it's solving for you.

 -- Tim

