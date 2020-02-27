From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 27 Feb 2020 10:24:17 +0530
Subject: [LTP] [PATCH V3 05/10] syscalls/fsconfig: New tests
In-Reply-To: <20200225134648.GB62318@gacrux.arch.suse.de>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <ccb816c7032270dd2ef51ab14290aacb2c89db38.1582612624.git.viresh.kumar@linaro.org>
 <20200225134648.GB62318@gacrux.arch.suse.de>
Message-ID: <20200227045417.tl2vf6boupp7s7iw@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25-02-20, 14:46, Petr Vorel wrote:
> > diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig02.c b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
> > new file mode 100644
> > index 000000000000..d51a869ac3ff
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> > + *
> > + * Basic fsconfig() failure tests.
> > + */
> > +#include "tst_test.h"
> > +#include "lapi/fsmount.h"
> > +
> > +int fd = -1, temp_fd = -1, invalid_fd = -1;
> > +int aux_0 = 0, aux_1 = 1, aux_fdcwd = AT_FDCWD, aux_minus1 = -1;
> These 2 should be static (also fd could be default 0, but who cares :)).

No, fd was intentionally set to -1 here. If we return early due to
tst_brk() from fsopen_supported_by_kernel(), then we need to handle
that case in cleanup().

-- 
viresh
