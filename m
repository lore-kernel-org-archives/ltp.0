From: Michal Hocko <mhocko@kernel.org>
Date: Thu, 8 Aug 2019 09:47:36 +0200
Subject: [LTP] [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
In-Reply-To: <20190808074607.GI11812@dhcp22.suse.cz>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
 <20190808074607.GI11812@dhcp22.suse.cz>
Message-ID: <20190808074736.GJ11812@dhcp22.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu 08-08-19 09:46:07, Michal Hocko wrote:
> On Wed 07-08-19 17:05:33, Mike Kravetz wrote:
> > Li Wang discovered that LTP/move_page12 V2 sometimes triggers SIGBUS
> > in the kernel-v5.2.3 testing.  This is caused by a race between hugetlb
> > page migration and page fault.
> > 
> > If a hugetlb page can not be allocated to satisfy a page fault, the task
> > is sent SIGBUS.  This is normal hugetlbfs behavior.  A hugetlb fault
> > mutex exists to prevent two tasks from trying to instantiate the same
> > page.  This protects against the situation where there is only one
> > hugetlb page, and both tasks would try to allocate.  Without the mutex,
> > one would fail and SIGBUS even though the other fault would be successful.
> > 
> > There is a similar race between hugetlb page migration and fault.
> > Migration code will allocate a page for the target of the migration.
> > It will then unmap the original page from all page tables.  It does
> > this unmap by first clearing the pte and then writing a migration
> > entry.  The page table lock is held for the duration of this clear and
> > write operation.  However, the beginnings of the hugetlb page fault
> > code optimistically checks the pte without taking the page table lock.
> > If clear (as it can be during the migration unmap operation), a hugetlb
> > page allocation is attempted to satisfy the fault.  Note that the page
> > which will eventually satisfy this fault was already allocated by the
> > migration code.  However, the allocation within the fault path could
> > fail which would result in the task incorrectly being sent SIGBUS.
> > 
> > Ideally, we could take the hugetlb fault mutex in the migration code
> > when modifying the page tables.  However, locks must be taken in the
> > order of hugetlb fault mutex, page lock, page table lock.  This would
> > require significant rework of the migration code.  Instead, the issue
> > is addressed in the hugetlb fault code.  After failing to allocate a
> > huge page, take the page table lock and check for huge_pte_none before
> > returning an error.  This is the same check that must be made further
> > in the code even if page allocation is successful.
> > 
> > Reported-by: Li Wang <liwang@redhat.com>
> > Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Tested-by: Li Wang <liwang@redhat.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Btw. is this worth marking for stable? I haven't seen it triggering
anywhere but artificial tests. On the other hand the patch is quite
straightforward so it shouldn't hurt in general.
-- 
Michal Hocko
SUSE Labs
