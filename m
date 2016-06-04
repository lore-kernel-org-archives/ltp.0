From: Li Wang <liwang@redhat.com>
Date: Sat, 4 Jun 2016 10:29:56 +0800
Subject: [LTP] [PATCH] tst_test.h: include tst_kvercmp.h
In-Reply-To: <1464956996-26578-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1464956996-26578-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <CAEemH2c_rp3nc4M8-LLZZbi8rXxOHE2E8K+1xpqAEU+r8W25Vg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jun 3, 2016 at 8:29 PM, Stanislav Kholmanskikh
<stanislav.kholmanskikh@oracle.com> wrote:
> tst_kvercmp.h is included in test.h, but is not included in tst_test.h.
> Fixed it.
>
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  include/tst_test.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 88b46d6..871b273 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -31,6 +31,7 @@
>  #include "tst_cpu.h"
>  #include "tst_process_state.h"
>  #include "tst_atomic.h"
> +#include "tst_kvercmp.h"

In the tst_test.h file, there have achieved a kernel comparative method:
struct tst_test {
    ...
    const char *min_kver;
    ...
};

but sometimes we have to make choice in a specific condition
judgement, so it would be better to include that and remove the line:
#include "tst_kvercmp.h" from other place(ie.
/kernel/syscalls/madvise/madvise06.c) at the same time.


-- 
Regards,
Li Wang
Email: liwang@redhat.com
