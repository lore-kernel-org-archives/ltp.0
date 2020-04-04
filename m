From: Kirill A. Shutemov <kirill@shutemov.name>
Date: Sat, 4 Apr 2020 19:06:31 +0300
Subject: [LTP] mm/mremap.c : WARNING: at mm/mremap.c:211
 move_page_tables+0x5b0/0x5d0
In-Reply-To: <CA+G9fYsnD0vkCpSH98Lpsi6nxXBS+JYbSPhTnNE16CrQ4s4QhQ@mail.gmail.com>
References: <CA+G9fYs1xStrrsvGbW7bc4h1a0Kjfz0_zn4c7LL7-bGZb0GH6g@mail.gmail.com>
 <20200402133849.mmkvekzx37kw4nsj@box>
 <CA+G9fYv0xNtnD=eBmxVqYqEoYTbMk6mdn04WmgSUasDw2L7uFg@mail.gmail.com>
 <20200403133252.ivdqoppxhc6w5b47@box>
 <CA+G9fYsnD0vkCpSH98Lpsi6nxXBS+JYbSPhTnNE16CrQ4s4QhQ@mail.gmail.com>
Message-ID: <20200404160631.7eny3swsqn665m2p@box>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Apr 04, 2020 at 08:10:42PM +0530, Naresh Kamboju wrote:
> On Fri, 3 Apr 2020 at 19:02, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Fri, Apr 03, 2020 at 12:56:57AM +0530, Naresh Kamboju wrote:
> > > [  734.876355] old_addr: 0xbfe00000, new_addr: 0xbfc00000, old_end: 0xc0000000
> >
> > The ranges are overlapping. We don't expect it. mremap(2) never does this.
> >
> > shift_arg_pages() only moves range downwards. It should be safe.
> >
> > Could you try this:
> 
> Applied the patch and tested and still getting kernel warning.
> CONFIG_HIGHMEM64G=y is still enabled.
> 
> [  790.041040] ------------[ cut here ]------------
> [  790.045664] WARNING: CPU: 3 PID: 3195 at mm/mremap.c:212
> move_page_tables+0x7a7/0x840

Are you sure the patch is applied? The line number in the warning supposed
to change.

-- 
 Kirill A. Shutemov
