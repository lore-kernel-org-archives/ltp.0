From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Fri, 2 Aug 2019 03:48:26 +0000
Subject: [LTP] 
 =?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
 =?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2ZmbGlu?=
 =?utf-8?q?ed_hugepage_in_background?=
In-Reply-To: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
References: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
Message-ID: <20190802034825.GA20130@hori.linux.bs1.fc.nec.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 29, 2019 at 01:17:27PM +0800, Li Wang wrote:
> Hi Naoya and Linux-MMers,
> 
> The LTP/move_page12 V2 triggers SIGBUS in the kernel-v5.2.3 testing.
> https://github.com/wangli5665/ltp/blob/master/testcases/kernel/syscalls/
> move_pages/move_pages12.c
> 
> It seems like the retry mmap() triggers SIGBUS while doing the numa_move_pages
> () in background. That is very similar to the kernel bug which was mentioned by
> commit 6bc9b56433b76e40d(mm: fix race on soft-offlining ): A race condition
> between soft offline and hugetlb_fault which causes unexpected process SIGBUS
> killing.
> 
> I'm not sure if that below patch is making sene to memory-failures.c, but after
> building a new kernel-5.2.3 with this change, the problem can NOT be reproduced
> . 
> 
> Any comments?
> 
> ----------------------------------
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1695,15 +1695,16 @@ static int soft_offline_huge_page(struct page *page,
> int flags)
>         unlock_page(hpage);
> 
>         ret = isolate_huge_page(hpage, &pagelist);
> +       if (!ret) {
> +               pr_info("soft offline: %#lx hugepage failed to isolate\n",
> pfn);
> +               return -EBUSY;
> +       }
> +
>         /*
>          * get_any_page() and isolate_huge_page() takes a refcount each,
>          * so need to drop one here.
>          */
>         put_hwpoison_page(hpage);
> -       if (!ret) {
> -               pr_info("soft offline: %#lx hugepage failed to isolate\n",
> pfn);
> -               return -EBUSY;
> -       }

Sorry for my late response.

This change skips put_hwpoison_page() in failure path, so soft_offline_page()
should return without releasing hpage's refcount taken by get_any_page(),
maybe which is not what we want.

- Naoya
