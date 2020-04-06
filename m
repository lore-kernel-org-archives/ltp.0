From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Apr 2020 13:53:09 +0530
Subject: [LTP] mm/mremap.c : WARNING: at mm/mremap.c:211
 move_page_tables+0x5b0/0x5d0
In-Reply-To: <20200404160631.7eny3swsqn665m2p@box>
References: <CA+G9fYs1xStrrsvGbW7bc4h1a0Kjfz0_zn4c7LL7-bGZb0GH6g@mail.gmail.com>
 <20200402133849.mmkvekzx37kw4nsj@box>
 <CA+G9fYv0xNtnD=eBmxVqYqEoYTbMk6mdn04WmgSUasDw2L7uFg@mail.gmail.com>
 <20200403133252.ivdqoppxhc6w5b47@box>
 <CA+G9fYsnD0vkCpSH98Lpsi6nxXBS+JYbSPhTnNE16CrQ4s4QhQ@mail.gmail.com>
 <20200404160631.7eny3swsqn665m2p@box>
Message-ID: <CA+G9fYtmSMLaqmt-OEovQxXseGqiq_HUDyq_dZZ1kSbsuNQo=Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, 4 Apr 2020 at 21:36, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sat, Apr 04, 2020 at 08:10:42PM +0530, Naresh Kamboju wrote:
> > On Fri, 3 Apr 2020 at 19:02, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Fri, Apr 03, 2020 at 12:56:57AM +0530, Naresh Kamboju wrote:
> > > > [  734.876355] old_addr: 0xbfe00000, new_addr: 0xbfc00000, old_end: 0xc0000000
> > >
> > > The ranges are overlapping. We don't expect it. mremap(2) never does this.
> > >
> > > shift_arg_pages() only moves range downwards. It should be safe.
> > >
> > > Could you try this:
> >
> > Applied the patch and tested and still getting kernel warning.
> > CONFIG_HIGHMEM64G=y is still enabled.
> >
> > [  790.041040] ------------[ cut here ]------------
> > [  790.045664] WARNING: CPU: 3 PID: 3195 at mm/mremap.c:212
> > move_page_tables+0x7a7/0x840
>
> Are you sure the patch is applied? The line number in the warning supposed
> to change.

Yes. The patch was applied and tested.
The reason for line number change is due to linux/mmdebug.h included
because an earlier patch "dump_vma(vma);" needed this.

diff --git a/mm/mremap.c b/mm/mremap.c
index af363063ea23..cf02d4244e83 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -24,6 +24,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm-arch-hooks.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/mmdebug.h>

 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -208,7 +209,7 @@ static bool move_normal_pmd(struct vm_area_struct
*vma, unsigned long old_addr,
         * The destination pmd shouldn't be established, free_pgtables()
         * should have release it.
         */
-       if (WARN_ON(!pmd_none(*new_pmd)))
+       if (WARN_ON(!pmd_none(*new_pmd) && old_addr > new_addr))
                return false;

        /*



- Naresh
