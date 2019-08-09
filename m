From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 9 Aug 2019 11:42:59 +0200
Subject: [LTP] [PATCH] syscalls/copy_file_range02: Fix #12 when TMPDIR
 is on tmpfs or ext[234]
In-Reply-To: <CAEemH2cM7mhkYBvTTFC4UhjnYxG0D_e-nkCmSF2U8pB61UT0bw@mail.gmail.com>
References: <20190807094119.10834-1-pvorel@suse.cz>
 <CAEemH2cM7mhkYBvTTFC4UhjnYxG0D_e-nkCmSF2U8pB61UT0bw@mail.gmail.com>
Message-ID: <20190809094259.GA27030@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Thanks for highlight this.

> > Cyril, Jan, Li, still not sure what the policy about errno is (see
> > Cyril's statements in recent discussion about it in Jinhui's patch [1]
> > [2]). With these frequent changes we should IMHO check for all possible
> > variants (EXDEV, EFBIG, EINVAL).

> > Or should we investigate all fixes and keep errors which highlight
> > important fix was not backported (to both stable and LTS/enterprise
> > distros kernels?). That'd be weird but approach practical :).

> That sounds not very realistic. We can't satisfy all distributions for
> errno checking, because we don't know when/wheather it backports the
> patch.
I meant it like taking individual approach: insist on errno when different errno
means something important hasn't been fixed.


> > Anyway, we should define and write down LTP policy / rules about it.

> I think we might have these ways of choosing:

> 1. Only align with the latest kernel behavior
>     e.g limit the latest kernel version and verify that valid errno
> The disadvantage of this is only tested on a small kernel range.
Sticking only for latest kernel is a big advantage.

> 2. Guarded by kernel version check as Cyril suggests in [1]
>     e.g  kernel >= 4.10; Check errno == EBADF
>            kernel < 4.10; Check errno == EISDIR
We use this one
278bbbb35 syscalls/fgetxattr02.c: Fix errno EPERM on older kernels
21c27c11c syscalls/bind03: Add version compare according to behaviour difference.

>            ....
> The disadvantage is that the test result is affected by LTS with a
> backport-patch.
Yep, that's problematic.

> 3. Regards all acceptable errnos as valid on any kernel version
>     e.g  whatever errno get any of them EXDEV, EFBIG, EINVAL, regard valid
> This sounds obviously awful.
Yep, but the problem is that we considered changed errno as a bug, but for kernel
developers it's not always a bug. See fix "RFC: changed error code when binding unix
socket twice" [1], which was never merged (it fixed a bug, so changing errno was
not a big issue). I'm sure there more cases like this one.

> Or, anything else?

How about try errno for latest kernel for any kernel (in case it has been
backported) and if not do the check based on kernel version?
Probably combined with TWARN.

Kind regards,
Petr

[1] https://marc.info/?l=linux-kernel&m=149880810113888&w=2
