From: Li Wang <liwang@redhat.com>
Date: Thu, 15 Aug 2019 15:10:30 +0800
Subject: [LTP] [RFC PATCH 1/1] capability: Introduce capability API
In-Reply-To: <20190808153825.18363-2-rpalethorpe@suse.com>
References: <20190808153825.18363-1-rpalethorpe@suse.com>
 <20190808153825.18363-2-rpalethorpe@suse.com>
Message-ID: <CAEemH2czBk5KKgFB0_4bWtnwdnJdq0sJNmo=q3_u1UipEhaOJw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Aug 8, 2019 at 11:39 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> ---
>  include/tst_capability.h | 56 +++++++++++++++++++++++++++++
>  include/tst_test.h       |  6 ++++
>  lib/tst_capability.c     | 78 ++++++++++++++++++++++++++++++++++++++++
>  lib/tst_test.c           |  3 ++
>  4 files changed, 143 insertions(+)
>  create mode 100644 include/tst_capability.h
>  create mode 100644 lib/tst_capability.c
>
> diff --git a/include/tst_capability.h b/include/tst_capability.h
> new file mode 100644
> index 000000000..6342b667e
> --- /dev/null
> +++ b/include/tst_capability.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
> + */
> +/**
> + * @file tst_capability.h
> + *
> + * Limited capability operations without libcap.
> + */
> +
> +#include <stdint.h>
> +
> +#include "lapi/syscalls.h"
> +
> +#ifndef TST_CAPABILITY_H
> +#define TST_CAPABILITY_H
> +
> +#ifndef CAP_SYS_ADMIN
> +# define CAP_SYS_ADMIN        21
> +#endif
> +
> +#ifndef CAP_TO_MASK
> +# define CAP_TO_MASK(x)      (1 << ((x) & 31))
> +#endif
> +
> +#define TST_DROP 1
> +#define TST_REQUIRE 1 << 1
> +
> +#define TST_CAP(action, capability) {action, capability, #capability}
> +
> +struct tst_cap_user_header {
> +       uint32_t version;
> +       int pid;
> +};
> +
> +struct tst_cap_user_data {
> +       uint32_t effective;
> +       uint32_t permitted;
> +       uint32_t inheritable;
> +};
> +
> +struct tst_cap {
> +       uint32_t action;
> +       uint32_t id;
> +       char *name;
> +};
> +
> +int tst_capget(struct tst_cap_user_header *hdr,
> +              struct tst_cap_user_data *data);
> +int tst_capset(struct tst_cap_user_header *hdr,
> +              const struct tst_cap_user_data *data);
> +
> +void tst_cap_action(struct tst_cap *cap);
> +void tst_cap_setup(struct tst_cap *cap);
> +
> +#endif
> diff --git a/include/tst_test.h b/include/tst_test.h
> index cdeaf6ad0..84acf2c59 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -36,6 +36,7 @@
>  #include "tst_sys_conf.h"
>  #include "tst_coredump.h"
>  #include "tst_buffers.h"
> +#include "tst_capability.h"
>
>  /*
>   * Reports testcase result.
> @@ -206,6 +207,11 @@ struct tst_test {
>          * NULL-terminated array to be allocated buffers.
>          */
>         struct tst_buffers *bufs;
> +
> +       /*
> +        * NULL-terminated array of capability settings
> +        */
> +       struct tst_cap *caps;
>  };
>
>  /*
> diff --git a/lib/tst_capability.c b/lib/tst_capability.c
> new file mode 100644
> index 000000000..d229491ae
> --- /dev/null
> +++ b/lib/tst_capability.c
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_capability.h"
> +
> +int tst_capget(struct tst_cap_user_header *hdr,
> +              struct tst_cap_user_data *data)
> +{
> +       return tst_syscall(__NR_capget, hdr, data);
> +}
> +
> +int tst_capset(struct tst_cap_user_header *hdr,
> +              const struct tst_cap_user_data *data)
> +{
> +       return tst_syscall(__NR_capset, hdr, data);
> +}
> +
> +void tst_cap_action(struct tst_cap *cap)
> +{
> +       struct tst_cap_user_header hdr = {
> +               .version = 0x20080522,
> +               .pid = tst_syscall(__NR_gettid),
> +       };
> +       struct tst_cap_user_data cur = { 0 };
> +       struct tst_cap_user_data new = { 0 };
> +       uint32_t mask = CAP_TO_MASK(cap->id);
> +       uint32_t act = cap->action;
> +
> +       if (tst_capget(&hdr, &cur))
> +               tst_brk(TBROK | TTERRNO, "tst_capget()");
> +
> +       new = cur;
> +
> +       switch (act) {
> +       case TST_DROP:
> +               if (cur.effective & mask) {
> +                       tst_res(TINFO, "Dropping %s(%d)",
> +                               cap->name, cap->id);
> +                       new.effective &= ~mask;
> +                       new.permitted &= ~mask;
> +                       new.inheritable &= ~mask;
> +               }
> +               break;
> +       case TST_REQUIRE:
> +               if (cur.permitted ^ mask) {
> +                       tst_brk(TCONF, "Need %s(%d)",
> +                               cap->name, cap->id);
> +               } else if (cur.effective ^ mask) {
> +                       tst_res(TINFO, "Permitting %s(%d)",
> +                               cap->name, cap->id);
> +                       new.effective |= mask;
> +                       new.inheritable |= mask;
> +               }
> +               break;
> +       default:
> +               tst_brk(TBROK, "Unrecognised action %d", cap->action);
> +       }
> +
> +       if (cur.effective != new.effective) {
> +               if (tst_capset(&hdr, &new))
> +                       tst_brk(TBROK | TERRNO, "tst_capset(%s)", cap->name);

It does not work for this simple cap_test.c, did I miss anything?

# whoami
root

# ./cap_test
tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
tst_capability.c:42: INFO: Dropping CAP_SYS_ADMIN(21)
tst_capability.c:65: BROK: tst_capset(CAP_SYS_ADMIN): EPERM

# ./cap_test
tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
tst_capability.c:51: CONF: Need CAP_SYS_ADMIN(21)

# cat cap_test.c
#include "tst_test.h"
#include "linux/capability.h"

static void do_test(void)
{
        tst_res(TPASS, "Hello");
}

static struct tst_test test = {
        .test_all = do_test,
        .needs_root = 1,
        .caps = (struct tst_cap []) {
//                TST_CAP(TST_DROP, CAP_SYS_ADMIN),
                TST_CAP(TST_REQUIRE, CAP_SYS_ADMIN),
                {},
        },
};

-- 
Regards,
Li Wang
