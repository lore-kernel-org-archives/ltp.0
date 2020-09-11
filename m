From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 11 Sep 2020 16:09:50 +0530
Subject: [LTP] [PATCH 00/16] syscalls: Use common variants structure
In-Reply-To: <20200911095314.GA9505@dell5510>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
 <20200911095314.GA9505@dell5510>
Message-ID: <20200911103950.kehhklgyie2tqpxh@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11-09-20, 11:53, Petr Vorel wrote:
> Hi Viresh,
> One of the commits fails on various tests [1].
> 
> Some failures (I haven't checked all):
> 
> * missing nfds_t (<poll.h> is probably from old commits) [2]:
> 
> CC testcases/kernel/syscalls/mq_open/mq_open01
> In file included from ../../../../include/time64_variants.h:13,
>                  from /usr/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq_timed.h:10,
>                  from mq_timedreceive01.c:17:
> /usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
>     1 | #warning redirecting incorrect #include <sys/poll.h> to <poll.h>
>       |  ^~~~~~~
> In file included from /usr/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq_timed.h:10,
>                  from mq_timedreceive01.c:17:
> ../../../../include/time64_variants.h:41:35: error: unknown type name 'nfds_t'
> 41 |  int (*ppoll)(struct pollfd *fds, nfds_t nfds, void *tmo_p,
> 
> * <libaio.h> not found [3]:
> BUILD libltpnewipc.a
> make[6]: Nothing to be done for 'all'.
> In file included from /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop02.c:29:
> In file included from In file included from /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop01.c:15:
> In file included from /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop.h:7:
> /usr/src/ltp/include/time64_variants.h:10:10: fatal error: /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop.h'libaio.h' file not
>       found
> :7:
> /usr/src/ltp/include/time64_variants.h:10:10: fatal error: 'libaio.h' file#include <libaio.h>
>          ^~~~~~~~~~
>  not
>       found
> #include <libaio.h>

I didn't get any of these on my x86 box :(

I think this should fix it, but I would required help of your bot to
get the testing done for all these architectures. This should get
merged in the first patch, I will resend it.

diff --git a/include/time64_variants.h b/include/time64_variants.h
index 934268b0328b..972eb333b614 100644
--- a/include/time64_variants.h
+++ b/include/time64_variants.h
@@ -7,10 +7,13 @@
 #ifndef TIME64_VARIANTS_H
 #define TIME64_VARIANTS_H
 
+#ifdef HAVE_LIBAIO
 #include <libaio.h>
+#endif /* HAVE_LIBAIO */
+
 #include <signal.h>
 #include <stdio.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <time.h>
 #include "tst_timer.h"
 
@@ -32,8 +35,12 @@ struct time64_variants {
        int (*timer_settime)(kernel_timer_t timerid, int flags, void *its, void *old_its);
        int (*tfd_gettime)(int fd, void *its);
        int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
+
+#ifdef HAVE_LIBAIO
        int (*io_pgetevents)(io_context_t ctx, long min_nr, long max_nr,
                        struct io_event *events, void *timeout, sigset_t *sigmask);
+#endif /* HAVE_LIBAIO */
+
        int (*mqt_send)(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
                        unsigned int msg_prio, void *abs_timeout);
        ssize_t (*mqt_receive)(mqd_t mqdes, char *msg_ptr, size_t msg_len,

-- 
viresh
