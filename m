From: Yang Shi <shy828301@gmail.com>
Date: Mon, 18 Mar 2019 11:12:19 -0700
Subject: [LTP] mbind() fails to fail with EIO
In-Reply-To: <20190315160142.GA8921@rei>
References: <20190315160142.GA8921@rei>
Message-ID: <CAHbLzkqvQ2SW4soYHOOhWG0ShkdUhaiNK0_y+ULaYYHo62O0fQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 15, 2019 at 9:02 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> I've started to write tests for mbind() and found out that mbind() does
> not work as described in manual page in a case that page has been
> faulted on different node that we are asking it to bind to. Looks like
> this is working fine on older kernels. On my testing machine with 3.0
> mbind() fails correctly with EIO but succeeds unexpectedly on newer
> kernels such as 4.12.
>
> What the test does is:
>
> * mmap() private mapping
> * fault it
> * find out on which node it is faulted on
> * mbind() it to a different node with MPOL_BIND and MPOL_MF_STRICT and
>   expects to get EIO

It looks the behavior was changed since v4.0 by the below commit:

6f4576e3687b mempolicy: apply page table walker on queue_pages_range()

The new queue_pages_to_pte_range() doesn't return -EIO anymore. Could
you please try the below patch (5.1-rc1 based)?

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index abe7a67..6ba45aa 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -521,11 +521,14 @@ static int queue_pages_pte_range(pmd_t *pmd,
unsigned long addr,
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


Yang





>
> The test code can be seen and compiled from:
>
> https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
