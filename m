From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jan 2019 13:25:35 +0100
Subject: [LTP] [PATCH v3]  cgroup_regression_test.sh ported to newlib
In-Reply-To: <9a580965-10d4-80d1-a0c6-23c502289ee7@arm.com>
References: <20181221182516.45689-1-cristian.marussi@arm.com>
 <20190104034555.GA5992@dell5510>
 <9a580965-10d4-80d1-a0c6-23c502289ee7@arm.com>
Message-ID: <20190104122535.GA31329@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

> > See diff bellow. I also added 4 commits related to this test,
> > one of them is fixing regression I added while changing your code
> > (I'm sorry).

> Everything's fine but in cgroup_regress_test_6_2.c you reverted to old API,
> while you previously told me not to:

> > +++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
> > @@ -0,0 +1,37 @@
> [snip]

> > +#include <sched.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include "test.h"
> Please don't use legacy API. <<<<<<

> is that fine ?

I'm sorry I forget to tell you I reverted this, it was deliberate change.
Using TST_NO_DEFAULT_MAIN was wrong (it's usually used in LTP library only.
Also it's recommended to use SAFE_*() if possible.

I've sent patch to implement this for some C code [1], but it's failing (endless clone).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1020712/
