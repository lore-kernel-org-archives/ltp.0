From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Feb 2019 12:57:46 +0100
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <4cae2a11-47c2-c319-19cf-9a8fecc7793d@google.com>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <5C667060.7020405@cn.fujitsu.com>
 <CAFA6WYO8qg79rQ-qwU3i6FpfNRQhiTNXzGHtDsJ6FpTty6W77g@mail.gmail.com>
 <20190215121611.GA14270@rei>
 <CAFA6WYOF1Kh1rspdiPgne9q4jUQsMW4p5BN_J4evcsr9O-KD1Q@mail.gmail.com>
 <20190215132251.GB26339@rei>
 <4cae2a11-47c2-c319-19cf-9a8fecc7793d@google.com>
Message-ID: <20190218115746.GA25025@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> Thanks for the pointers. IIUC, you are referring to following change:
> >>
> >> -       TEST(syncfs(fd));
> >> +       TEST(tst_syscall(__NR_syncfs, fd));
> >>
> >> If yes, then I will incorporate it.
> > 
> > The most complete solution is configure check + fallback definition.
> > 
> > Have a look at:
> > 
> > include/lapi/execveat.h
> > m4/ltp-execveat.m4
> > configure.ac
> 
> For tests in testcases/kernel/syscalls, should the tests typically 
> directly call the syscall? I'd think this is preferable to the use of C 
> library wrappers as these tests (by their location in the tree) seem to 
> be focused on the syscall functionality in the kernel.

My take on this is that for a functional testing we really have to test
the kernel together with the library that wraps the syscalls because
otherwise bugs are bound to happen such as these:

https://sourceware.org/bugzilla/show_bug.cgi?id=23069
https://sourceware.org/bugzilla/show_bug.cgi?id=23579

And I always cared about syscalls being correct on the C library level.

I guess that for most of the syscalls that are just thin wrappers it
does not matter since these just prepare the parameters and jump to the
kernel, but in certain cases libc does quite a lot of work which is
sometimes complex code I do not want to replicate that unless really
needed. And with that I think that it's actually much easier to go with
the libc API whenever possible rather than reviewing the libc code each
time we write a testcase.

Does that sound reasonable to you?

-- 
Cyril Hrubis
chrubis@suse.cz
