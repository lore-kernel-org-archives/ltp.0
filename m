From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Jul 2021 12:25:21 +0200
Subject: [LTP] [PATCH] Add set_mempolicy05, CVE-2017-7616
In-Reply-To: <878s1rlqa6.fsf@suse.de>
References: <20210726154605.7828-1-rpalethorpe@suse.com>
 <YQALVdEAGOVa+g4H@yuki> <878s1rlqa6.fsf@suse.de>
Message-ID: <YQPTkYcAFcsmp+UV@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that we are doing this so that a call to a syscall() does not
> > clobber the stack we have initialized to the pattern. I guess that if
> > more tests that need this arise we may as well add the magic macros
> > glibc uses to generate these into lapi/ somewhere...
> 
> Sort of the opposite, we want the syscall to allocate in the area where
> the pattern is. Usually syscalls do not push anything onto the user
> stack AFAICT.

The glibc syscall() is a function, so I suppose that if we called that
instead of the inline assembly we will end up with a return address on
the stack, but thinking of it again a function call would move the stack
pointer after the end of the area we have allocated and the syscall will
modify stack after the array we have carefuly prepared.

> The stack segment is changed by the interrupt. It seems the kernel may
> then change the stack segment again on entry to a per CPU/thread
> kernel stack. At any rate, nothing is written after the stack pointer
> unless the bug is present. At least on newer kernels and CPUS of
> course.

Well that's not important here, since a few of the compat syscalls
explicitly allocate userspace stack with compat_alloc_user_space()

> > Also it may make sense to write a more generic test that calls different
> > syscalls and scans stack for any data leakage, which should be far more
> > useful than this.
> 
> The problem is identifying sensitive data. Compat syscalls will write to
> the user stack. I suppose it will usually be the same data passed in,
> but marshalled to 64-bit. However if they wrote something else to the
> stack, that would not necessarily be a bug.

Looks like there were even more serious bugs in there see:

https://www.cvedetails.com/cve/CVE-2010-3081/
https://seclists.org/fulldisclosure/2010/Sep/268

So it may make sense to add another test that would check that the data
are written in rigth part of the stack as well when ty syscall actuall
succeeds for the few syscalls...

> I suppose for an ordinary systemcall you would not expect the user stack
> to be modified... I'm not sure this is a useful thing to invest time in
> though. Apart from to educate us on how kernel entry code works on
> various architectures.

Indeed.

-- 
Cyril Hrubis
chrubis@suse.cz
