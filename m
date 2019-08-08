From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Aug 2019 15:04:46 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: Fix #12 when TMPDIR
 is on tmpfs or ext[234]
In-Reply-To: <20190807094119.10834-1-pvorel@suse.cz>
References: <20190807094119.10834-1-pvorel@suse.cz>
Message-ID: <CAEemH2cM7mhkYBvTTFC4UhjnYxG0D_e-nkCmSF2U8pB61UT0bw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for highlight this.

> Cyril, Jan, Li, still not sure what the policy about errno is (see
> Cyril's statements in recent discussion about it in Jinhui's patch [1]
> [2]). With these frequent changes we should IMHO check for all possible
> variants (EXDEV, EFBIG, EINVAL).
>
> Or should we investigate all fixes and keep errors which highlight
> important fix was not backported (to both stable and LTS/enterprise
> distros kernels?). That'd be weird but approach practical :).

That sounds not very realistic. We can't satisfy all distributions for
errno checking, because we don't know when/wheather it backports the
patch.

>
> Anyway, we should define and write down LTP policy / rules about it.

I think we might have these ways of choosing:

1. Only align with the latest kernel behavior
    e.g limit the latest kernel version and verify that valid errno
The disadvantage of this is only tested on a small kernel range.

2. Guarded by kernel version check as Cyril suggests in [1]
    e.g  kernel >= 4.10; Check errno == EBADF
           kernel < 4.10; Check errno == EISDIR
           ....
The disadvantage is that the test result is affected by LTS with a
backport-patch.

3. Regards all acceptable errnos as valid on any kernel version
    e.g  whatever errno get any of them EXDEV, EFBIG, EINVAL, regard valid
This sounds obviously awful.

Or, anything else?

-- 
Regards,
Li Wang
