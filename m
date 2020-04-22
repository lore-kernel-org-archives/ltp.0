From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Apr 2020 16:29:17 +0800
Subject: [LTP] [PATCH] lib/tst_hugepage: TCONF when huge pages are not
 supported
In-Reply-To: <bc3c52ff5b97feefa4200c3d87002de5a61ee360.1587539566.git.jstancek@redhat.com>
References: <bc3c52ff5b97feefa4200c3d87002de5a61ee360.1587539566.git.jstancek@redhat.com>
Message-ID: <CAEemH2fWhXzLRV+g=hN9yJRcmqsj2iGMxxy14GGGKDpBAEX5HQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On Wed, Apr 22, 2020 at 3:13 PM Jan Stancek <jstancek@redhat.com> wrote:

> /sys/kernel/mm/hugepages is not present when there are no
> supported hugepage sizes. This is common for ppc64le KVM guests,
> when hypervisor does not enable hugepages. Guest will boot with:
>   hugetlbfs: disabling because there are no supported hugepage sizes
>
>   # cat /proc/filesystems  | grep huge; echo $?
>   1
>
> End the test with TCONF to avoid TBROK on mmap, set_sys_tune, etc.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  lib/tst_hugepage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> index 52667a14e8ff..eb66c4fbbc91 100644
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -18,7 +18,7 @@ unsigned long tst_request_hugepages(unsigned long hpages)
>
>         if (access(PATH_HUGEPAGES, F_OK)) {
>                 tst_hugepages = 0;
> -               goto out;
> +               tst_brk(TCONF, "Huge pages not supported.");
>

We don't do that because hugetlb is not the hard requirement for some tests
(i.e pkey01.c). If we exit with TCONF at an early phase on a non-hugetlb
system the remaining test will be missed too. In a word, the goto out here
is on purpose.


>         }
>
>         if (nr_opt)
> --
> 2.18.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200422/4c25d7a1/attachment.htm>
