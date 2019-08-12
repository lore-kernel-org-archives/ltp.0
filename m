From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 12 Aug 2019 10:45:24 +0200
Subject: [LTP] [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
In-Reply-To: <20190811234614.GZ17747@sasha-vm>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
 <20190808074607.GI11812@dhcp22.suse.cz>
 <20190808074736.GJ11812@dhcp22.suse.cz>
 <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
 <20190808185313.GG18351@dhcp22.suse.cz>
 <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
 <20190809064633.GK18351@dhcp22.suse.cz>
 <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
 <20190811234614.GZ17747@sasha-vm>
Message-ID: <20190812084524.GC5117@dhcp22.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun 11-08-19 19:46:14, Sasha Levin wrote:
> On Fri, Aug 09, 2019 at 03:17:18PM -0700, Andrew Morton wrote:
> > On Fri, 9 Aug 2019 08:46:33 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > > Maybe we should introduce the Fixes-no-stable: tag.  That should get
> > > > their attention.
> > > 
> > > No please, Fixes shouldn't be really tight to any stable tree rules. It
> > > is a very useful indication of which commit has introduced bug/problem
> > > or whatever that the patch follows up to. We in Suse are using this tag
> > > to evaluate potential fixes as the stable is not reliable. We could live
> > > with Fixes-no-stable or whatever other name but does it really makes
> > > sense to complicate the existing state when stable maintainers are doing
> > > whatever they want anyway? Does a tag like that force AI from selecting
> > > a patch? I am not really convinced.
> > 
> > It should work if we ask stable trees maintainers not to backport
> > such patches.
> > 
> > Sasha, please don't backport patches which are marked Fixes-no-stable:
> > and which lack a cc:stable tag.
> 
> I'll add it to my filter, thank you!

I would really prefer to stick with Fixes: tag and stable only picking
up cc: stable patches. I really hate to see workarounds for sensible
workflows (marking the Fixes) just because we are trying to hide
something from stable maintainers. Seriously, if stable maintainers have
a different idea about what should be backported, it is their call. They
are the ones to deal with regressions and the backporting effort in
those cases of disagreement.

-- 
Michal Hocko
SUSE Labs
