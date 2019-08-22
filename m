From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 22 Aug 2019 16:41:53 +0800
Subject: [LTP] [RFC PATCH 1/1] capability: Introduce capability API
In-Reply-To: <20190808153825.18363-2-rpalethorpe@suse.com>
References: <20190808153825.18363-1-rpalethorpe@suse.com>
 <20190808153825.18363-2-rpalethorpe@suse.com>
Message-ID: <5D5E5551.9050308@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/08/08 23:38, Richard Palethorpe wrote:

> ---
>   include/tst_capability.h | 56 +++++++++++++++++++++++++++++
>   include/tst_test.h       |  6 ++++
>   lib/tst_capability.c     | 78 ++++++++++++++++++++++++++++++++++++++++
>   lib/tst_test.c           |  3 ++
>   4 files changed, 143 insertions(+)
>   create mode 100644 include/tst_capability.h
>   create mode 100644 lib/tst_capability.c
>
> diff --git a/include/tst_capability.h b/include/tst_capability.h
> new file mode 100644
> index 000000000..6342b667e
> --- /dev/null
> +++ b/include/tst_capability.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2019 Richard Palethorpe<rpalethorpe@suse.com>
> + */
> +/**
> + * @file tst_capability.h
> + *
> + * Limited capability operations without libcap.
> + */
> +
> +#include<stdint.h>
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
> +# define CAP_TO_MASK(x)      (1<<  ((x)&  31))
> +#endif
> +
> +#define TST_DROP 1
> +#define TST_REQUIRE 1<<  1
> +
> +#define TST_CAP(action, capability) {action, capability, #capability}
> +
> +struct tst_cap_user_header {
> +	uint32_t version;
> +	int pid;
> +};
> +
> +struct tst_cap_user_data {
> +	uint32_t effective;
> +	uint32_t permitted;
> +	uint32_t inheritable;
> +};
> +
> +struct tst_cap {
> +	uint32_t action;
> +	uint32_t id;
> +	char *name;
> +};
> +
> +int tst_capget(struct tst_cap_user_header *hdr,
> +	       struct tst_cap_user_data *data);
> +int tst_capset(struct tst_cap_user_header *hdr,
> +	       const struct tst_cap_user_data *data);
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
>   #include "tst_sys_conf.h"
>   #include "tst_coredump.h"
>   #include "tst_buffers.h"
> +#include "tst_capability.h"
>
>   /*
>    * Reports testcase result.
> @@ -206,6 +207,11 @@ struct tst_test {
>   	 * NULL-terminated array to be allocated buffers.
>   	 */
>   	struct tst_buffers *bufs;
> +
> +	/*
> +	 * NULL-terminated array of capability settings
> +	 */
> +	struct tst_cap *caps;
>   };
>
>   /*
> diff --git a/lib/tst_capability.c b/lib/tst_capability.c
> new file mode 100644
> index 000000000..d229491ae
> --- /dev/null
> +++ b/lib/tst_capability.c
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2019 Richard Palethorpe<rpalethorpe@suse.com>
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_capability.h"
> +
> +int tst_capget(struct tst_cap_user_header *hdr,
> +	       struct tst_cap_user_data *data)
> +{
> +	return tst_syscall(__NR_capget, hdr, data);
> +}
> +
> +int tst_capset(struct tst_cap_user_header *hdr,
> +	       const struct tst_cap_user_data *data)
> +{
> +	return tst_syscall(__NR_capset, hdr, data);
> +}
> +
> +void tst_cap_action(struct tst_cap *cap)
> +{
> +	struct tst_cap_user_header hdr = {
> +		.version = 0x20080522,
> +		.pid = tst_syscall(__NR_gettid),
> +	};
Hi Richard

If we use _LINUX_CAPABILITY_VERSION_1, kernel will report the following warning: `cap_test' uses 32-bit capabilities (legacy support in use)

_LINUX_CAPABILITY_VERSION_2 has been deprecated since kernel 2.6.25, so we can only use _LINUX_CAPABILITY_VERSION_3.

But _LINUX_CAPABILITY_VERSION_3 uses 64-bit capabilities as man-page said, effective defined as uint32_t in tst_cap_usr_data is not enough.
I guess we need to define cur[2] ,new[2] and compare. Also, it can slove the EPERM failure as Li wang's cap_test.c found.
  
ps: I changed  kernel code to track this problem.
diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..291eb4e71031 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -247,24 +247,31 @@ int cap_capset(struct cred *new,
         if (cap_inh_is_capped()&&
             !cap_issubset(*inheritable,
                           cap_combine(old->cap_inheritable,
-                                     old->cap_permitted)))
+                                     old->cap_permitted))) {
                 /* incapable of using this inheritable set */
+               printk("xuyang 0\n");
                 return -EPERM;
+       }

         if (!cap_issubset(*inheritable,
                           cap_combine(old->cap_inheritable,
-                                     old->cap_bset)))
+                                     old->cap_bset))) {
                 /* no new pI capabilities outside bounding set */
+               printk("xuyang 1\n");
                 return -EPERM;
+       }

         /* verify restrictions on target's new Permitted set */
-       if (!cap_issubset(*permitted, old->cap_permitted))
+       if (!cap_issubset(*permitted, old->cap_permitted)) {
+               printk("xuyang  2\n");
                 return -EPERM;
+       }

         /* verify the _new_Effective_ is a subset of the _new_Permitted_ */
-       if (!cap_issubset(*effective, *permitted))
+       if (!cap_issubset(*effective, *permitted)) {
+               printk("xuyang 3\n");
                 return -EPERM;
-
+       }
         new->cap_effective   = *effective;
         new->cap_inheritable = *inheritable;

#./cap_test  (dmesg will report "xuyang 3",return EPERM if use version 3)

Thanks
Yang Xu

> +	struct tst_cap_user_data cur = { 0 };
> +	struct tst_cap_user_data new = { 0 };
> +	uint32_t mask = CAP_TO_MASK(cap->id);
> +	uint32_t act = cap->action;
> +
> +	if (tst_capget(&hdr,&cur))
> +		tst_brk(TBROK | TTERRNO, "tst_capget()");
> +
> +	new = cur;
> +
> +	switch (act) {
> +	case TST_DROP:
> +		if (cur.effective&  mask) {
> +			tst_res(TINFO, "Dropping %s(%d)",
> +				cap->name, cap->id);
> +			new.effective&= ~mask;
> +			new.permitted&= ~mask;
> +			new.inheritable&= ~mask;
> +		}
> +		break;
> +	case TST_REQUIRE:
> +		if (cur.permitted ^ mask) {
> +			tst_brk(TCONF, "Need %s(%d)",
> +				cap->name, cap->id);
> +		} else if (cur.effective ^ mask) {
> +			tst_res(TINFO, "Permitting %s(%d)",
> +				cap->name, cap->id);
> +			new.effective |= mask;
> +			new.inheritable |= mask;
> +		}
> +		break;
> +	default:
> +		tst_brk(TBROK, "Unrecognised action %d", cap->action);
> +	}
> +
> +	if (cur.effective != new.effective) {
> +		if (tst_capset(&hdr,&new))
> +			tst_brk(TBROK | TERRNO, "tst_capset(%s)", cap->name);
> +	} else {
> +		tst_res(TINFO, "No capability changes needed");
> +	}
> +}
> +
> +void tst_cap_setup(struct tst_cap *caps)
> +{
> +	struct tst_cap *cap;
> +
> +	for (cap = caps; cap->action; cap++) {
> +		tst_cap_action(cap);
> +	}
> +}
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8dc71dbb3..62e54d071 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -893,6 +893,9 @@ static void do_test_setup(void)
>
>   	if (main_pid != getpid())
>   		tst_brk(TBROK, "Runaway child in setup()!");
> +
> +	if (tst_test->caps)
> +		tst_cap_setup(tst_test->caps);
>   }
>
>   static void do_cleanup(void)



