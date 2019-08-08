From: Michal Hocko <mhocko@kernel.org>
Date: Thu, 8 Aug 2019 20:53:13 +0200
Subject: [LTP] [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
In-Reply-To: <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
 <20190808074607.GI11812@dhcp22.suse.cz>
 <20190808074736.GJ11812@dhcp22.suse.cz>
 <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
Message-ID: <20190808185313.GG18351@dhcp22.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu 08-08-19 09:55:45, Mike Kravetz wrote:
> On 8/8/19 12:47 AM, Michal Hocko wrote:
> > On Thu 08-08-19 09:46:07, Michal Hocko wrote:
> >> On Wed 07-08-19 17:05:33, Mike Kravetz wrote:
> >>> Li Wang discovered that LTP/move_page12 V2 sometimes triggers SIGBUS
> >>> in the kernel-v5.2.3 testing.  This is caused by a race between hugetlb
> >>> page migration and page fault.
> <snip>
> >>> Reported-by: Li Wang <liwang@redhat.com>
> >>> Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> >>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>> Tested-by: Li Wang <liwang@redhat.com>
> >>
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Btw. is this worth marking for stable? I haven't seen it triggering
> > anywhere but artificial tests. On the other hand the patch is quite
> > straightforward so it shouldn't hurt in general.
> 
> I don't think this really is material for stable.  I added the tag as the
> stable AI logic seems to pick up patches whether marked for stable or not.
> For example, here is one I explicitly said did not need to go to stable.
> 
> https://lkml.org/lkml/2019/6/1/165
> 
> Ironic to find that commit message in a stable backport.
> 
> I'm happy to drop the Fixes tag.

No, please do not drop the Fixes tag. That is a very _useful_
information. If the stable tree maintainers want to abuse it so be it.
They are responsible for their tree. If you do not think this is a
stable material then fine with me. I tend to agree but that doesn't mean
that we should obfuscate Fixes.

-- 
Michal Hocko
SUSE Labs
