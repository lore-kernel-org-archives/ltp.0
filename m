From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 18 Feb 2019 13:22:45 +0530
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <4cae2a11-47c2-c319-19cf-9a8fecc7793d@google.com>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <5C667060.7020405@cn.fujitsu.com>
 <CAFA6WYO8qg79rQ-qwU3i6FpfNRQhiTNXzGHtDsJ6FpTty6W77g@mail.gmail.com>
 <20190215121611.GA14270@rei>
 <CAFA6WYOF1Kh1rspdiPgne9q4jUQsMW4p5BN_J4evcsr9O-KD1Q@mail.gmail.com>
 <20190215132251.GB26339@rei> <4cae2a11-47c2-c319-19cf-9a8fecc7793d@google.com>
Message-ID: <CAFA6WYMEveSLb0i7Yaw-p+W9gGG521RWOO2wBammALkcw7NiYQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, 16 Feb 2019 at 05:47, Steve Muckle <smuckle@google.com> wrote:
>
> On 02/15/2019 05:22 AM, Cyril Hrubis wrote:
> > Hi!
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
>

Sounds reasonable to me. But as per following manpage text for syscall():

"Each architecture ABI has its own requirements on how system call
arguments are passed to the kernel.  For system calls that have a
glibc  wrapper  (e.g., most  system  calls), glibc handles the details
of copying arguments to the right registers in a manner suitable for
the architecture. However, when using syscall() to make a system call,
the caller might need to handle architecture-dependent details; this
requirement is most commonly encountered  on certain 32-bit
architectures."

So I am not sure how we handle this architecture specific stuff if
required in test-cases.

-Sumit

> thanks,
> steve
