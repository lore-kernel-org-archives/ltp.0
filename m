From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 19 Apr 2019 12:04:47 -0700
Subject: [LTP] crypto test af_alg04.c crash the LPAR
In-Reply-To: <3CADF61C-036A-45F5-B7A4-644F3D16F814@gmail.com>
References: <OFC91206F0.EB621360-ON002583E1.004ACB92-002583E1.004B8DDC@notes.na.collabserv.com>
 <20190419171116.GA183327@gmail.com>
 <3CADF61C-036A-45F5-B7A4-644F3D16F814@gmail.com>
Message-ID: <20190419190446.GB183327@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Apr 19, 2019 at 11:03:23AM -0700, Enji Cooper wrote:
> On Apr 19, 2019, at 10:11, Eric Biggers <ebiggers@kernel.org> wrote:
> 
> >> Is this test doing an intentional crash? When it is run on RHEL8.0 latest
> >> kernel, it immediately crashes the LPAR
> > 
> > Do not send HTML email, people will usually ignore it...
> > 
> > But yes, the test is testing for a bug that caused a kernel crash, so your
> > kernel has that bug.  That's the whole point of the test; see the comment at the
> > top of the file.
> > 
> > In general if anything userspace does crashes the kernel, it's a kernel bug.
> 
> I agree with your statement, but there are a few things to potentially do to mitigate this:
> 1. If the test is a crash test for a known kernel bug fixed on a particular version, it should have a version check.

What for?  It's not possible to reliably determine whether the bug exists based
on the kernel version.  The fix has been backported to many older kernels, plus
the bug could be reintroduced in the future.

I trust you'll ensure this bug gets fixed in the kernel you're testing?

> 2. Printing out a diagnostic message to signal the intent may remove potential confusion about the intent of the test, as the end-user might not have access to the test sources. In this case, it might be smart to trigger the message via syslog on all consoles as the output could be lost on stdout.
> Thank you!
> -Enji

Perhaps we should add an INFO log message for good measure, but if a kernel
crash occurs while running LTP don't you need a way to determine which test was
running anyway?  A crash could occur during any test; you can't assume that only
tests "intended" to cause a crash will do so.  Also, when a test fails you need
the test source anyway, to determine what fix is needed.

- Eric
