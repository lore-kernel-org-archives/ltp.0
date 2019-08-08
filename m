From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 8 Aug 2019 16:39:28 -0700
Subject: [LTP] [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
In-Reply-To: <20190808185313.GG18351@dhcp22.suse.cz>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
 <20190808074607.GI11812@dhcp22.suse.cz>
 <20190808074736.GJ11812@dhcp22.suse.cz>
 <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
 <20190808185313.GG18351@dhcp22.suse.cz>
Message-ID: <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 8 Aug 2019 20:53:13 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > https://lkml.org/lkml/2019/6/1/165
> > 
> > Ironic to find that commit message in a stable backport.
> > 
> > I'm happy to drop the Fixes tag.
> 
> No, please do not drop the Fixes tag. That is a very _useful_
> information. If the stable tree maintainers want to abuse it so be it.
> They are responsible for their tree. If you do not think this is a
> stable material then fine with me. I tend to agree but that doesn't mean
> that we should obfuscate Fixes.

Well, we're responsible for stable trees too.  And yes, I find it
irksome.  I/we evaluate *every* fix for -stable inclusion and if I/we
decide "no" then dangit, it should be backported.

Maybe we should introduce the Fixes-no-stable: tag.  That should get
their attention.
