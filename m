From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 12 Aug 2019 15:22:26 +0200
Subject: [LTP] [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
In-Reply-To: <39b59001-55c1-a98b-75df-3a5dcec74504@suse.cz>
References: <20190808074607.GI11812@dhcp22.suse.cz>
 <20190808074736.GJ11812@dhcp22.suse.cz>
 <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
 <20190808185313.GG18351@dhcp22.suse.cz>
 <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
 <20190809064633.GK18351@dhcp22.suse.cz>
 <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
 <20190811234614.GZ17747@sasha-vm>
 <20190812084524.GC5117@dhcp22.suse.cz>
 <39b59001-55c1-a98b-75df-3a5dcec74504@suse.cz>
Message-ID: <20190812132226.GI5117@dhcp22.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon 12-08-19 15:14:12, Vlastimil Babka wrote:
> On 8/12/19 10:45 AM, Michal Hocko wrote:
> > On Sun 11-08-19 19:46:14, Sasha Levin wrote:
> >> On Fri, Aug 09, 2019 at 03:17:18PM -0700, Andrew Morton wrote:
> >>> On Fri, 9 Aug 2019 08:46:33 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> >>>
> >>> It should work if we ask stable trees maintainers not to backport
> >>> such patches.
> >>>
> >>> Sasha, please don't backport patches which are marked Fixes-no-stable:
> >>> and which lack a cc:stable tag.
> >>
> >> I'll add it to my filter, thank you!
> > 
> > I would really prefer to stick with Fixes: tag and stable only picking
> > up cc: stable patches. I really hate to see workarounds for sensible
> > workflows (marking the Fixes) just because we are trying to hide
> > something from stable maintainers. Seriously, if stable maintainers have
> > a different idea about what should be backported, it is their call. They
> > are the ones to deal with regressions and the backporting effort in
> > those cases of disagreement.
> 
> +1 on not replacing Fixes: tag with some other name, as there might be
> automation (not just at SUSE) relying on it.
> As a compromise, we can use something else to convey the "maintainers
> really don't recommend a stable backport", that Sasha can add to his filter.
> Perhaps counter-intuitively, but it could even look like this:
> Cc: stable@vger.kernel.org # not recommended at all by maintainer

I thought that absence of the Cc is the indication :P. Anyway, I really
do not understand why should we bother, really. I have tried to explain
that stable maintainers should follow Cc: stable because we bother to
consider that part and we are quite good at not forgetting (Thanks
Andrew for persistence). Sasha has told me that MM will be blacklisted
from automagic selection procedure.

I really do not know much more we can do and I really have strong doubts
we should care at all. What is the worst that can happen? A potentially
dangerous commit gets to the stable tree and that blows up? That is
something that is something inherent when relying on AI and
aplies-it-must-be-ok workflow.
-- 
Michal Hocko
SUSE Labs
