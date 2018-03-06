From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Mar 2018 16:03:02 +0100
Subject: [LTP] [PATCH 2/3] syscalls/pipe*: Fix compiler warnings
In-Reply-To: <5A9DF1CD.40706@cn.fujitsu.com>
References: <1519977744-1595-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1519977744-1595-2-git-send-email-huangjh.jy@cn.fujitsu.com>
 <20180305080334.amcwf4ghvb7cxv7c@dell5510>
 <5A9DF1CD.40706@cn.fujitsu.com>
Message-ID: <20180306150301.zghwxc35fiv65i6k@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Jinhui,

> > > Signed-off-by: Jinhui Huang<huangjh.jy@cn.fujitsu.com>
> > > ---
> > >   testcases/kernel/syscalls/pipe/pipe04.c | 2 +-
> > >   testcases/kernel/syscalls/pipe/pipe05.c | 4 ++--
> > >   testcases/kernel/syscalls/pipe/pipe07.c | 2 +-
> > >   testcases/kernel/syscalls/pipe/pipe08.c | 2 ++
> > >   testcases/kernel/syscalls/pipe/pipe11.c | 6 +++---
> > >   5 files changed, 9 insertions(+), 7 deletions(-)
...

> Hi Petr,

> The compiler warning:
> pipe05.c: In function ‘main’:
> pipe05.c:62:6: warning: variable ‘lc’ might be clobbered by ‘longjmp’ or
> ‘vfork’ [-Wclobbered]
> int lc;
> We may avoid this warning by declaring "lc" as volatile which tells the
> optimizer not to optimize it.
Thanks for info. This was issued by gcc-4.x, that's why I didn't notice that.
I pushed the patch, thanks!
BTW these tests deserve rewriting into new API, that would be a big improvement.


Kind regards,
Petr
