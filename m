From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Aug 2021 15:55:35 +0800
Subject: [LTP] [PATCH v2 01/16] lib/tst_sched: add ltp
 sys/libc_sched_*() wrappers
In-Reply-To: <20210806164730.51040-2-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-2-aleksei.kodanev@bell-sw.com>
Message-ID: <CAEemH2fe6U3cQa7bgQ=7yLx7H8Zw43mbAqzYJY9ZM_XARgsH5w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

On Sat, Aug 7, 2021 at 12:48 AM Alexey Kodanev <aleksei.kodanev@bell-sw.com>
wrote:

> The new wrappers allow to test libc and syscall variants. This is needed
> because libc implementation can differ from calling syscall directly.
> For example, musl libc implementation returns ENOSYS for some sched_*()
> functions due to commit 1e21e78bf7a5 ("add support for thread scheduling
> (POSIX TPS option)").
>
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
>  include/tst_sched.h | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 include/tst_sched.h
>
> diff --git a/include/tst_sched.h b/include/tst_sched.h
> new file mode 100644
> index 000000000..a5dc767b3
> --- /dev/null
> +++ b/include/tst_sched.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2021, BELLSOFT. All rights reserved.
> + */
> +
> +#ifndef TST_SCHED_H_
> +#define TST_SCHED_H_
> +
> +#include <sched.h>
> +
> +#include "lapi/syscalls.h"
> +
> +struct sched_variants {
> +       char *desc;
> +
> +       int (*sched_setparam)(pid_t pid, const struct sched_param *param);
> +       int (*sched_getparam)(pid_t pid, struct sched_param *param);
> +       int (*sched_setscheduler)(pid_t pid, int policy, const struct
> sched_param *param);
> +       int (*sched_getscheduler)(pid_t pid);
> +};
>

The whole patchset looks tidy and correctly, but I'm thinking maybe
we can define the varints[] unified here instead of stating them in each
test case again and again?

I.e.

--- a/include/tst_sched.h
+++ b/include/tst_sched.h
@@ -10,15 +10,6 @@

 #include "lapi/syscalls.h"

-struct sched_variants {
-       char *desc;
-
-       int (*sched_setparam)(pid_t pid, const struct sched_param *param);
-       int (*sched_getparam)(pid_t pid, struct sched_param *param);
-       int (*sched_setscheduler)(pid_t pid, int policy, const struct
sched_param *param);
-       int (*sched_getscheduler)(pid_t pid);
-};
-
 #define _TST_LIBC_SCHED_SCALL(SCALL, ...)({ \
        int tst_ret = SCALL(__VA_ARGS__); \
        if (tst_ret == -1 && errno == ENOSYS) { \
@@ -67,4 +58,24 @@ static inline int libc_sched_getscheduler(pid_t pid)
        return _TST_LIBC_SCHED_SCALL(sched_getscheduler, pid);
 }

+struct sched_variants {
+       char *desc;
+
+       int (*sched_setparam)(pid_t pid, const struct sched_param *param);
+       int (*sched_getparam)(pid_t pid, struct sched_param *param);
+       int (*sched_setscheduler)(pid_t pid, int policy, const struct
sched_param *param);
+       int (*sched_getscheduler)(pid_t pid);
+} variants[] = {
+       { .sched_setparam = libc_sched_setparam,
+         .sched_getparam = libc_sched_getparam,
+         .sched_setscheduler = libc_sched_setscheduler,
+         .desc = "libc"
+       },
+       { .sched_setparam = sys_sched_setparam,
+         .sched_getparam = sys_sched_getparam,
+         .sched_setscheduler = sys_sched_setscheduler,
+         .desc = "syscall"
+       },
+};
+
 #endif /* TST_SCHED_H_ */

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210809/ff8333a1/attachment.htm>
