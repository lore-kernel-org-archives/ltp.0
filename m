From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Thu, 18 Apr 2019 16:52:23 +0000
Subject: [LTP] [PATCH] [RFC] Proof-of-concept for test documentation
 format
In-Reply-To: <20190415145157.GA9645@rei.lan>
References: <20181128104420.30110-1-chrubis@suse.cz>
 <20190415145157.GA9645@rei.lan>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF97706BBB@USCULXMSG01.am.sony.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: Cyril Hrubis
> Has anybody any comments for this?
> 
> Even simple "concept looks OK" would be nice.

Sorry to have not responded sooner.  I assume you are referring to
https://lists.yoctoproject.org/pipermail/automated-testing/2018-November/000359.html

I think having an RST-formatted comment inside the test, along with some conventions
(or even a standard) for the schema for the comment contents, is very useful.
It would be superior to what we started doing in Fuego with RST-formatted documents
that were separate from the code (indeed, they were separate from the whole upstream
project - which makes maintenance a real burden.)

With regard to the possible movement of needs_root into a declarative statement
inside the RST, there are some pros and cons.  In Fuego we are trying to move to as
much declarative syntax as possible for test dependencies (or requirements/pre-requisites).
This allows a test scheduler to examine the code ahead of time, and avoid executing the
test if the pre-requisites are not met.

In this case, with the comment parseable prior to compile time, it would even allow
for the build system to avoid compiling the code and deploying it, if the static dependencies
were not met.  This is particularly useful for kernel config dependencies, to avoid compilation
errors.  So, that's a "strong support" vote from me on that part of the concept.

This allows other parts of the test stack (the scheduler and the builder) to take into account
this information, which is extremely useful.  That's completely aside from being able to 
show this information easily to humans (e.g. incorporate it into the visualization part of the stack)
which is also extremely useful.

In the short term, it's quite handy for the test itself to continue to check its pre-requisites
at runtime.  It would be nice to avoid having this be reliant on complicated build infrastructure.
So, IMHO it would be better to auto-populate either the tst_test structure from the meta-data
or the meta-data from the tst_test structure. (My vote would be for the latter, in the short term).
This would mean, however, that there should be a policy that the tst_test attributes are the
single source for this information, and that the 'Requirements' section of the RST document
should not be edited by humans (unless you intend to put additional advisory or explanatory
elements in that section, just for documentation purposes.) 

The TL;DR of all this is that I think this is a good idea.
  -- Tim
