From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Thu, 8 Nov 2018 20:01:55 +0000
Subject: [LTP] [Automated-testing] [RFC] [PATCH] lib: Add support
	for	test tags
In-Reply-To: <20181108125210.GB29767@rei>
References: <20181107142209.8965-1-chrubis@suse.cz>
 <CAEemH2dw1qeKgswzh8k_PdesQwGtRm72wzfG2erqw3J-WTJG0A@mail.gmail.com>
 <20181108125210.GB29767@rei>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF88A34661@USCULXMSG01.am.sony.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> -----Original Message-----
> From: Cyril Hrubis on  Thursday, November 08, 2018 4:52 AM
> 
> Hi!
> > > This is just proof of concept of moving some of the test metadata into
> > > more structured form. If implemented it will move some information
> from
> > > comments in the test source code to an array to the tst_test structure.
> >
> > I have to say, this is really a good proposal to LTP especially for
> > that regressions, we sometimes spend a lot of time to dig into test
> > failures and read code comments to find the reason/clue, if now
> > testcase can print out useful info when trigger the issue, that'd be
> > more friendly to LTP runner.
> 
> This is exactly the reason I looked into the problem.

I'll go on record as really liking this proposal as well, for the same reasons
given.

We created a mechanism in Fuego to address this issue, but it would
be much better to see it addressed upstream.  I'll describe below our
"solution" so  you can compare it's features with the proposed features.
Note that it is only partially implemented and not populated with
much information yet (only a few testcases have the files described).

> 
> > Another thought come to my mind is, can we build a correlation for one
> > case which have many alias? e.g cve-2017-15274 == add_key02. If LTP
> > framework has finished cve-2017-15274 test then run add_key02 in next,
> > just skip and mark it as the same result with cve-2017-15274 show.
> 
> Well the way how we track testcases is something that should be probably
> rethinked in the future. The runtest files are far from optimal, maybe
> we can build something based on tags in the future.

I'm a big proponent of having each testcase have a unique identifier, to
solve this problem.  There were a few slides in the ATS presentation about
what I call 'tguids' (Testcase Globally Unique Identifiers), but I didn't have
time to get into the rationale for these at the summit.  

At one Linaro Connect where I presented this idea, Neil Williams gave
some good feedback, and pointed out some problems with the idea,
but I think it would be good to discuss this concept on the list.

I'll try to start a discussion thread on tguids and UTI (uniform testcase
identifiers) sometime in the future, to discuss some of the issues.

> 
> > > It's not finished and certainly not set into a stone, this patch is
> > > mainly intended to start a discussion.
> > >
> > > The newly introduced test tags are generic name-value pairs that can
> > > hold test metadata, the intended use for now is to store kernel commit
> > > hashes for kernel reproducers as well as CVE ids. The mechanism is
> > > however choosen to be very generic so that it's easy to add basically
> > > any information later on.
> > >
> > > As it is the main purpose is to print hints for a test failures. If a
> > > test that has been written as a kernel reproducer fails it prints nice
> > > URL pointing to a kernel commit that may be missing.

That's really great.

> > > This commit also adds adds the -q test flag, that can be used to query
> > > test information, which includes these tags, but is not limited to them.
> > >
> > > The main inteded use for the query operation is to export test metadata
> > > and constraints to the test execution system. The long term goal for
> > > this would be parallel test execution as for this case the test runner
> > > would need to know which global system resources is the test using to
> > > avoid unexpected failures.
> > >
> > > So far it exposes only if test needs root and if block device is needed
> > > for the test, but I would expect that we will need a few more tags for
> > > various resources, one that comes to my mind would be "test is using
> > > SystemV SHM" for that we can do something as add a "constraint" tag
> with
> > > value "SysV SHM" or anything else that would be fitting. Another would
> > > be "Test is changing system wide clocks", etc.

It sounds like you will be preserving test metadata with two different uses:
1) dependencies required for the test to execute
2) possible explanations for test failure

There might be a value in keeping these distinct.

I can think of some other use categories that meta-data
might fall into. One would be:
3) things that need to be (can be) adjusted on the target in
order for a test to run (this is different from something
that straight-up blocks a test from being able to run on the target)

Overall, I think it would be useful to clarify the category and
expected handling for the different meta-data that is defined
around tests.

It also might be good to share different systems constraint/dependency
mechanisms and phrasing, for more commonality between systems and
easier understanding by users.  But that's independent of this hinting
thing you're talking about.

----
Here's how we solved the problem of allowing users to share
information with each other about testcases, in Fuego.

For each test, there is (or can be) a documentation directory, where
reStructuredText documents can be placed to describe testcases.  It is
expected that the directory would be sparse, and that only the
"problematical" testcases would have this documentation.

The overall idea is to prevent users from having to research
failures by digging through code, if someone else had already
done that and posted the information.

Here is our document for the testcase we call: "Functional.LTP.syscalls.add_key02"
The file is between ---------------------------- lines, with additional explanation (this e-mail)
below it:

File: fuego-core/engine/tests/Functional.LTP/docs/Functional.LTP.syscalls.add_key02.ftmp
----------------------------------------------------
===========
Description
===========

Obtained from addkey02.c DESCRIPTION:
	Test that the add_key() syscall correctly handles a NULL payload with nonzero
	length.  Specifically, it should fail with EFAULT rather than oopsing the
	kernel with a NULL pointer dereference or failing with EINVAL, as it did
	before (depending on the key type).  This is a regression test for commit
	5649645d725c ("KEYS: fix dereferencing NULL payload with nonzero length").
	
	Note that none of the key types that exhibited the NULL pointer dereference
	are guaranteed to be built into the kernel, so we just test as many as we
	can, in the hope of catching one.  We also test with the "user" key type for
	good measure, although it was one of the types that failed with EINVAL rather
	than dereferencing NULL.
	
	This has been assigned CVE-2017-15274.

Other notes:
	Commit 5649645d725c appears to have been included since the kernel 4.12.

====
Tags
====

* kernel, syscall, addkey

=========
Resources
=========

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5649645d725c73df4302428ee4e02c869248b4c5

=======
Results
=======

Running on a PC (64 bits) using Debian Jessie (kernel 3.16):
  add_key02.c:81: CONF: kernel doesn't support key type 'asymmetric'
  add_key02.c:81: CONF: kernel doesn't support key type 'cifs.idmap'
  add_key02.c:81: CONF: kernel doesn't support key type 'cifs.spnego'
  add_key02.c:81: CONF: kernel doesn't support key type 'pkcs7_test'
  add_key02.c:81: CONF: kernel doesn't support key type 'rxrpc'
  add_key02.c:81: CONF: kernel doesn't support key type 'rxrpc_s'
  add_key02.c:96: FAIL: unexpected error with key type 'user': EINVAL
  add_key02.c:96: FAIL: unexpected error with key type 'logon': EINVAL

The kernel should have returned an EFAULT error, not EINVAL:
  Ref: https://github.com/linux-test-project/ltp/issues/182

.. fuego_result_list::

======
Status
======

.. fuego_status::

=====
Notes
=====
----------------------------------------------------

So, a few more observations on this...
The format is rst, with some Sphinx macros.  This allows
the system to replace the macros with data from the current system
(from a set of runs).  The macros were not parameterized yet, but
the intent was to add parameters to the macros so that a report
generated with this file would include a data over a specific time
period, or with specific attributes (e.g. only the failures), and indicating
what meta-data fields from the test runs to include.  Thus, Fuego 
end-users could customize the output from these using external
settings.  This was intended to allow us to populate the results
interface with nice friendly documents with additional data.

This puts the information into a human-readable form, with
tables with recent results, but IMHO this doesn't lend itself to
additional automation, the way your more-structured tag system
does.  I could envision in your system a mechanism that went back
to the source and did a check using git to see if the kernel included
the commit or not, and if so flagging this as a regression.  That would
be a really neat additional level of results diagnosis/analysis, that
could be automated with your system.

In any event - that's what we're doing now in Fuego to solve what
I think is the same problem.
  -- Tim

P.S. If you want to see additional testcase documentation files in Fuego
for LTP, please see:
https://bitbucket.org/tbird20d/fuego-core/src/bf8c28cab5ec2dde5552ed2ff1e6fe2e0abf9582/engine/tests/Functional.LTP/docs/
We don't have a lot of them yet, but they show the general pattern of
what we were trying for.

