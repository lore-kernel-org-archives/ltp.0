From: Li Wang <liwang@redhat.com>
Date: Thu, 9 May 2019 12:59:46 +0800
Subject: [LTP] [PATCH v3] crypto/af_alg02: fixed read() being stuck
In-Reply-To: <20190508071636.13804-1-camann@suse.com>
References: <20190508071636.13804-1-camann@suse.com>
Message-ID: <CAEemH2cSz+JTxy6mT7H0JYj+RsBbgAuFL-q7RY775n9oJQAwoQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 8, 2019 at 3:16 PM Christian Amann <camann@suse.com> wrote:

> On kernels < 4.14 (missing commit 2d97591ef43d) reading from
> the request socket does not return and the testcase does not
> finish.
>
> This fix moves the logic to a child thread in order for the
> parent to handle the timeout and report a message to the user.
>
> Signed-off-by: Christian Amann <camann@suse.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>

---
>
> Notes:
>     Hi Li,
>
>     > We could set LTP_ATTRIBUTE_UNUSED at the behind of unused parameter
> to get
>     > rid of compiling warning
>
>     Thats very useful but I couldn't find it anywhere in the documentation.
>     IMHO it should be put in there, because I stumbled upon this problem
>     a couple of times.
>

This is just a definition for variable attribute which supports by GNU
compiler, I'm not sure if we should add it to LTP documents.

$ grep LTP_ATTRIBUTE_UNUSED . -r
tst_common.h:25:#define LTP_ATTRIBUTE_UNUSED __attribute__((unused))


>
>     Anyway, I implemented your suggestions. I hope it's an alright patch
> now.
>     Thanks for your feedback!
>
>     Regards,
>     Christian
>
>  testcases/kernel/crypto/Makefile   |  2 ++
>  testcases/kernel/crypto/af_alg02.c | 37
> +++++++++++++++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/crypto/Makefile
> b/testcases/kernel/crypto/Makefile
> index 76f9308c2..6547e1cb6 100644
> --- a/testcases/kernel/crypto/Makefile
> +++ b/testcases/kernel/crypto/Makefile
> @@ -20,3 +20,5 @@ include $(top_srcdir)/include/mk/testcases.mk
>  CFLAGS                 += -D_GNU_SOURCE
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +af_alg02: CFLAGS += -pthread
> diff --git a/testcases/kernel/crypto/af_alg02.c
> b/testcases/kernel/crypto/af_alg02.c
> index a9e820423..1c725212a 100644
> --- a/testcases/kernel/crypto/af_alg02.c
> +++ b/testcases/kernel/crypto/af_alg02.c
> @@ -7,23 +7,56 @@
>   * Regression test for commit ecaaab564978 ("crypto: salsa20 - fix
>   * blkcipher_walk API usage"), or CVE-2017-17805.  This test verifies
> that an
>   * empty message can be encrypted with Salsa20 without crashing the
> kernel.
> + *
> + * Fix for kernels < 4.14:
> + * With kernels missing commit 2d97591ef43d ("crypto: af_alg -
> consolidation
> + * of duplicate code") read() does not return in this situation. The call
> is
> + * now moved to a child thread in order to cancel it in case read() takes
> an
> + * unusual long amount of time.
>   */
>
>  #include "tst_test.h"
>  #include "tst_af_alg.h"
> +#include "tst_safe_pthread.h"
> +#include <pthread.h>
> +#include <errno.h>
>
> -static void run(void)
> +void *verify_encrypt(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
>         char buf[16];
>         int reqfd = tst_alg_setup_reqfd("skcipher", "salsa20", NULL, 16);
>
> +       TST_CHECKPOINT_WAKE(0);
> +
>         /* With the bug the kernel crashed here */
>         if (read(reqfd, buf, 16) == 0)
>                 tst_res(TPASS, "Successfully \"encrypted\" an empty
> message");
>         else
> -               tst_res(TBROK, "read() didn't return 0");
> +               tst_res(TFAIL, "read() didn't return 0");
> +       return arg;
>

Since arg has been marked as unused, so here better to return NULL.

Anyway, patch V3 looks good to me.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190509/b74f1cc3/attachment.html>
