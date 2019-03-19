From: Kirill A. Shutemov <kirill@shutemov.name>
Date: Tue, 19 Mar 2019 17:26:39 +0300
Subject: [LTP] mbind() fails to fail with EIO
In-Reply-To: <20190319132729.s42t3evt6d65sz6f@d104.suse.de>
References: <20190315160142.GA8921@rei>
 <CAHbLzkqvQ2SW4soYHOOhWG0ShkdUhaiNK0_y+ULaYYHo62O0fQ@mail.gmail.com>
 <20190319132729.s42t3evt6d65sz6f@d104.suse.de>
Message-ID: <20190319142639.wbind5smqcji264l@kshutemo-mobl1>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 19, 2019 at 02:27:33PM +0100, Oscar Salvador wrote:
> +CC Kirill
> 
> On Mon, Mar 18, 2019 at 11:12:19AM -0700, Yang Shi wrote:
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index abe7a67..6ba45aa 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -521,11 +521,14 @@ static int queue_pages_pte_range(pmd_t *pmd,
> > unsigned long addr,
> >                         continue;
> >                 if (!queue_pages_required(page, qp))
> >                         continue;
> > -               migrate_page_add(page, qp->pagelist, flags);
> > +               if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
> > +                       migrate_page_add(page, qp->pagelist, flags);
> > +               else
> > +                       break;
> >         }
> >         pte_unmap_unlock(pte - 1, ptl);
> >         cond_resched();
> > -       return 0;
> > +       return addr != end ? -EIO : 0;
> >  }
> > 
> >  static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
> 
> This alone is not going to help.
> 
> The problem is that we do skip the vma early in queue_pages_test_walk() in
> case MPOL_MF_MOVE and MPOL_MF_MOVE_ALL are not set.
> 
> walk_page_range
>  walk_page_test
>   queue_pages_test_walk
> 
> 	...
>  	...
> 	/* queue pages from current vma */
> 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
> 		return 0;
> 	return 1;
> 
> So, we skip the vma and keep going.
> 
> Before ("77bf45e78050: mempolicy: do not try to queue pages from !vma_migratable()"),
> queue_pages_test_walk() would not have skipped the vma in case we had MPOL_MF_STRICT
> or MPOL_MF_MOVE | MPOL_MF_MOVE_ALL.
> 
> I did not give it a lot of thought, but it seems to me that we might need to reach
> queue_pages_to_pte_range() in order to see whether the page is in the required node
> or not by calling queue_pages_required(), and if it is not, check for
> MPOL_MF_MOVE | MPOL_MF_MOVE_ALL like the above patch does, so we would be able to
> return -EIO.
> That would imply that we would need to re-add MPOL_MF_STRICT in queue_pages_test_walk().

That's all sounds reasonable.

We only need to make sure the bug fixed by 77bf45e78050 will not be
re-introduced.

-- 
 Kirill A. Shutemov
