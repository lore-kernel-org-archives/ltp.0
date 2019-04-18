From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Apr 2019 21:37:41 +0200
Subject: [LTP] [PATCH] [RFC] Proof-of-concept for test documentation
 format
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF97706BBB@USCULXMSG01.am.sony.com>
References: <20181128104420.30110-1-chrubis@suse.cz>
 <20190415145157.GA9645@rei.lan>
 <ECADFF3FD767C149AD96A924E7EA6EAF97706BBB@USCULXMSG01.am.sony.com>
Message-ID: <20190418193740.GE8766@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sorry to have not responded sooner.  I assume you are referring to
> https://lists.yoctoproject.org/pipermail/automated-testing/2018-November/000359.html

Yes.

> I think having an RST-formatted comment inside the test, along with some conventions
> (or even a standard) for the schema for the comment contents, is very useful.
> It would be superior to what we started doing in Fuego with RST-formatted documents
> that were separate from the code (indeed, they were separate from the whole upstream
> project - which makes maintenance a real burden.)
> 
> With regard to the possible movement of needs_root into a declarative statement
> inside the RST, there are some pros and cons.  In Fuego we are trying to move to as
> much declarative syntax as possible for test dependencies (or requirements/pre-requisites).
> This allows a test scheduler to examine the code ahead of time, and avoid executing the
> test if the pre-requisites are not met.
> 
> In this case, with the comment parseable prior to compile time, it would even allow
> for the build system to avoid compiling the code and deploying it, if the static dependencies
> were not met.  This is particularly useful for kernel config dependencies, to avoid compilation
> errors.  So, that's a "strong support" vote from me on that part of the concept.

Good.

> This allows other parts of the test stack (the scheduler and the builder) to take into account
> this information, which is extremely useful.  That's completely aside from being able to 
> show this information easily to humans (e.g. incorporate it into the visualization part of the stack)
> which is also extremely useful.

That is exactly what I'm aiming for. One of my motivations is that this
is a stepping stone for running tests in parallel.

> In the short term, it's quite handy for the test itself to continue to
> check its pre-requisites at runtime.

The run-time checking is something that cannot go away at any time. The
main reason is that kernel devs will still need to be able to execute a
single testcase outside of any automated framework to reproduce bugs.

> It would be nice to avoid having this be reliant on complicated build infrastructure.
> So, IMHO it would be better to auto-populate either the tst_test structure from the meta-data
> or the meta-data from the tst_test structure. (My vote would be for the latter, in the short term).
> This would mean, however, that there should be a policy that the tst_test attributes are the
> single source for this information, and that the 'Requirements' section of the RST document
> should not be edited by humans (unless you intend to put additional advisory or explanatory
> elements in that section, just for documentation purposes.) 

This part is something I'm not decided on yet, I guess that I will have
to keep experimenting a bit, then we can argue which solution is the
best.

I thing that it would be bettr to have all the metadata in the top level
comment and generate the C structures out of that, but I can be proved
wrong :-).

All in all we can desing it so that:

* make metadata rebuilds the metadata for a given targets
* add git hooks that checks for metadata consitency

With that it should be fairly easy to keep the comment and C structures
in sync and we would avoid any build-time magic.

> The TL;DR of all this is that I think this is a good idea.

Great!

-- 
Cyril Hrubis
chrubis@suse.cz
