From: Mike Rapoport <rppt@linux.ibm.com>
Date: Tue, 25 Aug 2020 14:13:03 +0300
Subject: [LTP] [PATCH] arm: __pmd_free_tlb(): call page table desctructor
 (Was: BUG: Bad page state in process true pfn:a8fed on arm)
In-Reply-To: <CADYN=9+2RDeUdbNT+XT6WgTW70UCdsARqaAL7PQ0+OPLvrkNng@mail.gmail.com>
References: <CA+G9fYt=oYWHEG6VNkfEh8+UxbReS6_+9hnz+1bOYZHj5j1F_Q@mail.gmail.com>
 <20200824110645.GC17456@casper.infradead.org>
 <CA+G9fYvjKGF3HZXyd=JQHzRG=r=bmD0hYQn02VL4Y=5y57OgaA@mail.gmail.com>
 <20200825083119.GA69694@linux.ibm.com>
 <CADYN=9+2RDeUdbNT+XT6WgTW70UCdsARqaAL7PQ0+OPLvrkNng@mail.gmail.com>
Message-ID: <20200825111303.GB69694@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 25, 2020 at 10:53:22AM +0200, Anders Roxell wrote:
> On Tue, 25 Aug 2020 at 10:32, Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Tue, Aug 25, 2020 at 01:03:53PM +0530, Naresh Kamboju wrote:
> > > On Mon, 24 Aug 2020 at 16:36, Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Aug 24, 2020 at 03:14:55PM +0530, Naresh Kamboju wrote:
> > > > > [   67.545247] BUG: Bad page state in process true  pfn:a8fed
> > > > > [   67.550767] page:9640c0ab refcount:0 mapcount:-1024
> > > >
> > > > Somebody freed a page table without calling __ClearPageTable() on it.
> > >
> > > After running git bisect on this problem,
> > > The first suspecting of this problem on arm architecture this patch.
> > > 424efe723f7717430bec7c93b4d28bba73e31cf6
> > > ("mm: account PMD tables like PTE tables ")
> > >
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> >
> > Can you please check if this fix helps?
> 
> That fixed the problem.

Since this is still in -mm tree, I've omitted commit sha and Fixes.

Andrew, is it possible to add this as a fixup to for the original
commit?


From db2efd7b89b1d943eb250e7e195c8cbaaa2e6ac9 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Tue, 25 Aug 2020 13:57:12 +0300
Subject: [PATCH] arm: __pmd_free_tlb(): call page table desctructor

As long as PMD tables are accounted as PTE tables ("mm: account PMD tables
like PTE tables") they can be freed only after pgtable_pmd_page_dtor() is
called.

Add the missing call in ARM's version of __pmd_free_tlb for
CONFIG_ARM_LPAE=y case.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/include/asm/tlb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 9415222b49ad..b8cbe03ad260 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -59,6 +59,7 @@ __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 #ifdef CONFIG_ARM_LPAE
 	struct page *page = virt_to_page(pmdp);
 
+	pgtable_pmd_page_dtor(page);
 	tlb_remove_table(tlb, page);
 #endif
 }
-- 
2.26.2
