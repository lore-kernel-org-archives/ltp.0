From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 25 Aug 2020 17:44:10 +1000
Subject: [LTP] BUG: Bad page state in process true pfn:a8fed on arm
In-Reply-To: <CA+G9fYvjKGF3HZXyd=JQHzRG=r=bmD0hYQn02VL4Y=5y57OgaA@mail.gmail.com>
References: <CA+G9fYt=oYWHEG6VNkfEh8+UxbReS6_+9hnz+1bOYZHj5j1F_Q@mail.gmail.com>
 <20200824110645.GC17456@casper.infradead.org>
 <CA+G9fYvjKGF3HZXyd=JQHzRG=r=bmD0hYQn02VL4Y=5y57OgaA@mail.gmail.com>
Message-ID: <20200825174410.1af823db@canb.auug.org.au>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

On Tue, 25 Aug 2020 13:03:53 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 24 Aug 2020 at 16:36, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Aug 24, 2020 at 03:14:55PM +0530, Naresh Kamboju wrote:  
> > > [   67.545247] BUG: Bad page state in process true  pfn:a8fed
> > > [   67.550767] page:9640c0ab refcount:0 mapcount:-1024  
> >
> > Somebody freed a page table without calling __ClearPageTable() on it.  
> 
> After running git bisect on this problem,
> The first suspecting of this problem on arm architecture this patch.
> 424efe723f7717430bec7c93b4d28bba73e31cf6
> ("mm: account PMD tables like PTE tables ")
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Additional information:
> We have tested linux next by reverting this patch and confirmed
> that the reported BUG is not reproduced.
> 
> These configs enabled on the running device,
> 
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> 
> 
> -- Suspecting patch --
> commit 424efe723f7717430bec7c93b4d28bba73e31cf6
> Author: Matthew Wilcox <willy@infradead.org>
> Date:   Thu Aug 20 10:01:30 2020 +1000
> 
>     mm: account PMD tables like PTE tables

OK, I have reverted that patch from todays' linux-next.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200825/b9884bc4/attachment-0001.sig>
