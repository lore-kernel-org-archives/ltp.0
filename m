From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Apr 2020 19:49:21 +0800
Subject: [LTP] [PATCH v2] hugetlb: check for requested huge pages first
In-Reply-To: <3529bb886952f26fa38095ce99ceef115f71cb18.1587554860.git.jstancek@redhat.com>
References: <bc3c52ff5b97feefa4200c3d87002de5a61ee360.1587539566.git.jstancek@redhat.com>
 <3529bb886952f26fa38095ce99ceef115f71cb18.1587554860.git.jstancek@redhat.com>
Message-ID: <CAEemH2e_h+4_nMTaVVtu9ngewvV_qrzVvtnKrqhQPCzZxDY80w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 22, 2020 at 7:40 PM Jan Stancek <jstancek@redhat.com> wrote:

> /sys/kernel/mm/hugepages is not present when there are no
> supported hugepage sizes. This is common for ppc64le KVM guests,
> when hypervisor does not enable hugepages. Guest will boot with:
>   hugetlbfs: disabling because there are no supported hugepage sizes
>
>   # cat /proc/filesystems  | grep huge; echo $?
>   1
>
> Move the check up in setup to check it as first thing to avoid
> running into TBROK on mount or set_sys_tune when hugetlbfs is
> not available:
>   safe_macros.c:766: BROK: hugemmap01.c:82: mount(none,
> /mnt/testarea/ltp-07Kg6lCOmm/Ai9D0M, hugetlbfs, 0, (nil)) failed: ENODEV
> (19)
>   safe_macros.c:766: BROK: hugemmap02.c:129: mount(none,
> /mnt/testarea/ltp-07Kg6lCOmm/Cxf7A6, hugetlbfs, 0, (nil)) failed: ENODEV
> (19)
>   safe_macros.c:766: BROK: hugemmap04.c:100: mount(none,
> /mnt/testarea/ltp-07Kg6lCOmm/kS60Mk, hugetlbfs, 0, (nil)) failed: ENODEV
> (19)
>   safe_file_ops.c:219: BROK: Expected 1 conversions got 0 at
> hugemmap06.c:42
>   safe_file_ops.c:155: BROK: The FILE '/proc/sys/vm/nr_hugepages' ended
> prematurely at mem.c:836
>   safe_file_ops.c:219: BROK: Expected 1 conversions got 0 at
> hugeshmat05.c:39
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>
Acked-by: Li Wang <liwang@redhat.com>

This is obviously right! ACK.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200422/4d0a864b/attachment-0001.htm>
