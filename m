From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Nov 2019 15:11:04 -0500 (EST)
Subject: [LTP] linux-next: Tree for Nov 14
In-Reply-To: <CA+G9fYtpOaYDoUEzQuYxmKJLFH2GDvK3ipWienn-zHDB+nOMbg@mail.gmail.com>
References: <20191114193132.5de921a7@canb.auug.org.au>
 <CA+G9fYtpOaYDoUEzQuYxmKJLFH2GDvK3ipWienn-zHDB+nOMbg@mail.gmail.com>
Message-ID: <247236994.12271471.1573762264445.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Thu, 14 Nov 2019 at 14:01, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> > Changes since 20191113:
> > The y2038 tree gained a build failure for which I applied a patch.
> <trim>
> > The akpm-current tree gained a conflict against the y2038 tree.
> >
> > Non-merge commits (relative to Linus' tree): 10388
> >  9238 files changed, 397357 insertions(+), 174171 deletions(-)
> 
> Results from Linaro?s test farm.
> Regressions detected on x86_64, and i386.
> 
> LTP syscalls settimeofday01/02 failed on x86_64 and i386 running
> 5.4.0-rc7-next-20191114.
> 
> Following  ltp-syscalls-tests failed.
>     * settimeofday01
>     * settimeofday02
>     * stime01
>     * stime02

Looks like typo in
adde74306a4b ("y2038: time: avoid timespec usage in settimeofday()")

-               if (!timeval_valid(&user_tv))
+               if (tv->tv_usec > USEC_PER_SEC)

was likely meant as:

-               if (!timeval_valid(&user_tv))
+               if (new_ts.tv_nsec > USEC_PER_SEC)

since tv is user pointer.

