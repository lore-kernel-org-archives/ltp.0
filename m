From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Feb 2020 13:23:03 +0800
Subject: [LTP] [PATCH V2 04/10] syscalls/fsopen: New tests
In-Reply-To: <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2f7eezS27odRq9qvAN=BCskpvvELECr7+Nsdd+Z_7sofA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 19, 2020 at 5:28 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> ...
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsopen/fsopen01.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Description:
> + * Basic fsopen() test which tries to configure and mount the filesystem
> as
> + * well.
> + */
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +
> +#define MNTPOINT       "mntpoint"
> +
> +static struct tcase {
> +       char *name;
> +       unsigned int flags;
> +} tcases[] = {
> +       {"Flag 0", 0},
> +       {"Flag FSOPEN_CLOEXEC", FSOPEN_CLOEXEC},
>

Maybe better to remove the 'Flag' keywords from here and add it to the
print sentence.


> +static void run(unsigned int n)
> +{
> ...
> +
> +       if (!tst_ismount(MNTPOINT))
> +               tst_res(TPASS, "%s: fsopen() passed", tc->name);
>

tst_res(TPASS, "Flag %s: fsopen() passed", tc->name);

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/b99343b4/attachment.htm>
