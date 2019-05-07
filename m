From: Christian Amann <camann@suse.de>
Date: Tue, 7 May 2019 10:59:44 +0200
Subject: [LTP] [PATCH v1] crypto/af_alg02: fixed read() being stuck
In-Reply-To: <CAEemH2e=9J_7OtSsS5wq+4YgfOm1zj=PK5cnaBk69LKtdR71ZA@mail.gmail.com>
References: <20190507065530.12174-1-camann@suse.com>
 <CAEemH2e=9J_7OtSsS5wq+4YgfOm1zj=PK5cnaBk69LKtdR71ZA@mail.gmail.com>
Message-ID: <7f9b69db-12a2-6e88-7687-602b88ce8cd7@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Li,

Thanks for having a look at my patch. To my knowledge
/pthread_timedjoin_np/ does not kill the thread if it times out. It
returns ETIMEDOUT which, in this case, leads to the whole testcase
terminating.

I chose this method over setting test.timeout because this way an
informative error-message can be printed.

I may be missing the problem here. Can you point me in the right
direction why this is bad practice?

Kind regards,

Christian


On 07/05/2019 10:07, Li Wang wrote:
> Hi Christian,
>
> On Tue, May 7, 2019 at 2:56 PM Christian Amann <camann@suse.com
> <mailto:camann@suse.com>> wrote:
>
>     On kernels < 4.14 (missing commit 2d97591ef43d) reading from
>     the request socket does not return and the testcase does not
>     finish.
>
>     This fix moves the logic to a child thread in order for the
>     parent to handle the timeout and report a message to the user.
>
>     Signed-off-by: Christian Amann <camann@suse.com
>     <mailto:camann@suse.com>>
>     ---
>      testcases/kernel/crypto/Makefile   |  2 ++
>      testcases/kernel/crypto/af_alg02.c | 36
>     +++++++++++++++++++++++++++++++++++-
>      2 files changed, 37 insertions(+), 1 deletion(-)
>
>     diff --git a/testcases/kernel/crypto/Makefile
>     b/testcases/kernel/crypto/Makefile
>     index 76f9308c2..6547e1cb6 100644
>     --- a/testcases/kernel/crypto/Makefile
>     +++ b/testcases/kernel/crypto/Makefile
>     @@ -20,3 +20,5 @@ include $(top_srcdir)/include/mk/testcases.mk
>     <http://testcases.mk>
>      CFLAGS                 += -D_GNU_SOURCE
>
>      include $(top_srcdir)/include/mk/generic_leaf_target.mk
>     <http://generic_leaf_target.mk>
>     +
>     +af_alg02: CFLAGS += -pthread
>     diff --git a/testcases/kernel/crypto/af_alg02.c
>     b/testcases/kernel/crypto/af_alg02.c
>     index a9e820423..056511993 100644
>     --- a/testcases/kernel/crypto/af_alg02.c
>     +++ b/testcases/kernel/crypto/af_alg02.c
>     @@ -7,12 +7,23 @@
>       * Regression test for commit ecaaab564978 ("crypto: salsa20 - fix
>       * blkcipher_walk API usage"), or CVE-2017-17805.  This test
>     verifies that an
>       * empty message can be encrypted with Salsa20 without crashing
>     the kernel.
>     + *
>     + * read() fix:
>     + * Calls read() in child thread in order to manually kill it
>     after timeout.
>     + * With kernels missing commit 2d97591ef43d ("crypto: af_alg -
>     consolidation
>     + * of duplicate code") read() does not return.
>       */
>
>      #include "tst_test.h"
>      #include "tst_af_alg.h"
>     +#include "tst_safe_pthread.h"
>     +#include <pthread.h>
>     +#include <time.h>
>     +#include <errno.h>
>
>     -static void run(void)
>     +#define VERIFY_TIMEOUT (time(NULL) + 5)
>
>
> It is very neccessary to take some action before process being killed
> in timeout. In LTP, we have an tst_timeout_remaining() function. Have
> a look?
>
>     +
>     +void *verify_encrypt(void *arg)
>      {
>             char buf[16];
>             int reqfd = tst_alg_setup_reqfd("skcipher", "salsa20",
>     NULL, 16);
>     @@ -22,6 +33,29 @@ static void run(void)
>                     tst_res(TPASS, "Successfully \"encrypted\" an
>     empty message");
>             else
>                     tst_res(TBROK, "read() didn't return 0");
>     +       return arg;
>     +}
>     +
>     +static void run(void)
>     +{
>     +       pthread_t thr;
>     +       int join_ret;
>     +       struct timespec read_timeout;
>     +
>     +       read_timeout.tv_sec  = VERIFY_TIMEOUT;
>     +       read_timeout.tv_nsec = 0;
>     +
>     +       SAFE_PTHREAD_CREATE(&thr, NULL, verify_encrypt, NULL);
>     +       join_ret = pthread_timedjoin_np(thr, NULL, &read_timeout);
>     +
>     +       if (join_ret != 0) {
>     +               if (join_ret == ETIMEDOUT)
>     +                       tst_brk(TBROK,
>     +                               "Timed out while reading from
>     request socket.");
>     +               else
>     +                       tst_brk(TBROK | TTERRNO,
>     +                               "Error while joining child thread");
>     +       }
>      }
>
>      static struct tst_test test = {
>     -- 
>     2.16.4
>
>
>     -- 
>     Mailing list info: https://lists.linux.it/listinfo/ltp
>
>
>
> -- 
> Regards,
> Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190507/b6480749/attachment.html>
