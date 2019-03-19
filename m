From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 19 Mar 2019 15:41:33 +0100
Subject: [LTP] mbind() fails to fail with EIO
In-Reply-To: <20190319142639.wbind5smqcji264l@kshutemo-mobl1>
References: <20190315160142.GA8921@rei>
 <CAHbLzkqvQ2SW4soYHOOhWG0ShkdUhaiNK0_y+ULaYYHo62O0fQ@mail.gmail.com>
 <20190319132729.s42t3evt6d65sz6f@d104.suse.de>
 <20190319142639.wbind5smqcji264l@kshutemo-mobl1>
Message-ID: <20190319144130.lidqtrkfl75n2haj@d104.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 19, 2019 at 05:26:39PM +0300, Kirill A. Shutemov wrote:
> That's all sounds reasonable.
> 
> We only need to make sure the bug fixed by 77bf45e78050 will not be
> re-introduced.

I gave it a spin with the below patch.
Your testcase works (so the bug is not re-introduced), and we get -EIO
when running the ltp test [1].
So unless I am missing something, it should be enough.

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index af171ccb56a2..b192b13460f0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -502,11 +508,16 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
                        continue;
                if (!queue_pages_required(page, qp))
                        continue;
-               migrate_page_add(page, qp->pagelist, flags);
+               if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+                       migrate_page_add(page, qp->pagelist, flags);
+               else
+                       break;
        }
        pte_unmap_unlock(pte - 1, ptl);
        cond_resched();
-       return 0;
+       return addr != end ? -EIO : 0;
 }

 static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
@@ -603,7 +614,8 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
        }

        /* queue pages from current vma */
-       if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+       if ((flags & MPOL_MF_STRICT) ||
+               (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
                return 0;
  

[1] https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c

-- 
Oscar Salvador
SUSE L3
