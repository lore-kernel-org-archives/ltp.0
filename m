From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri, 16 Jul 2021 15:03:06 +0300
Subject: [LTP] [PATCH] crypto/af_alg02: use pthread_tryjoin_np() instead
 of pthread_kill()
In-Reply-To: <CAEemH2cXAY8KSFNNv8_23uSs-wRaResAkTPmPyZQNN6UwcMcgA@mail.gmail.com>
References: <20210715102813.106843-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cXAY8KSFNNv8_23uSs-wRaResAkTPmPyZQNN6UwcMcgA@mail.gmail.com>
Message-ID: <6e1a3663-59ea-5286-5c36-558b077184aa@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,
On 16.07.2021 10:06, Li Wang wrote:
> Hi Alexey,
> 
> On Thu, Jul 15, 2021 at 6:29 PM Alexey Kodanev <aleksei.kodanev@bell-sw.com <mailto:aleksei.kodanev@bell-sw.com>> wrote:
> 
>     musl doesn't return ESRCH for pthread_kill() if thread id is not found.
> 
>     POSIX only recommends to return ESRCH, and also says that pthread_kill()
>     produces undefined behavior if tid lifetime has ended [1].
> 
>     [1]: https://man7.org/linux/man-pages/man3/pthread_kill.3.html <https://man7.org/linux/man-pages/man3/pthread_kill.3.html>
> 
>     Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com <mailto:aleksei.kodanev@bell-sw.com>>
>     ---
>     ?testcases/kernel/crypto/af_alg02.c | 2 +-
>     ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
>     index 31d30777c..0f5793c16 100644
>     --- a/testcases/kernel/crypto/af_alg02.c
>     +++ b/testcases/kernel/crypto/af_alg02.c
>     @@ -60,7 +60,7 @@ static void run(void)
> 
>     ? ? ? ? TST_CHECKPOINT_WAIT(0);
> 
>     -? ? ? ?while (pthread_kill(thr, 0) != ESRCH) {
>     +? ? ? ?while (pthread_tryjoin_np(thr, NULL) == EBUSY) {
> 
> 
> I'm not sure ifsafeenough to use because it is nonstandard GNU extensions
> and the "_np" means nonportable.
> 
> Maybe another workaround is to define a volatile?flag 'thread_complete',?
> initialize it to '0' when thread_B starts and reset to '1' while exit, and just
> do a value check in the while loop of thread_A should acquire?thread_B status.
> Is this way a bit better? 

OK, why not, so something like this:

diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
index 0f5793c16..1fe0f3bf0 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -18,11 +18,13 @@
 #include "tst_test.h"
 #include "tst_af_alg.h"
 #include "tst_safe_pthread.h"
+#include "tst_atomic.h"
 #include <pthread.h>
 #include <errno.h>

 #define SALSA20_IV_SIZE       8
 #define SALSA20_MIN_KEY_SIZE  16
+static int completed;

 static void *verify_encrypt(void *arg)
 {
@@ -48,6 +50,8 @@ static void *verify_encrypt(void *arg)
                tst_res(TPASS, "Successfully \"encrypted\" an empty message");
        else
                tst_res(TFAIL, "read() didn't return 0");
+
+       tst_atomic_store(1, &completed);
        return arg;
 }

@@ -60,7 +64,7 @@ static void run(void)

        TST_CHECKPOINT_WAIT(0);

-       while (pthread_tryjoin_np(thr, NULL) == EBUSY) {
+       while (!tst_atomic_load(&completed)) {
                if (tst_timeout_remaining() <= 10) {
                        pthread_cancel(thr);
                        tst_brk(TBROK,
