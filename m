From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 8 Mar 2019 15:49:54 +0100
Subject: [LTP] [PATCH] libltpnuma: Fix compilation with libnuma v1
In-Reply-To: <20190308135114.5120-1-chrubis@suse.cz>
References: <20190308135114.5120-1-chrubis@suse.cz>
Message-ID: <20190308144954.GA6533@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> With libnuma v1 HAVE_NUMA_H is defined but $(NUMA_LIBS) is not, which
> leads to compilation failures on very very old distributions.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Petr Vorel <pvorel@suse.cz>
> CC: Jan Stancek <jstancek@redhat.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

FYI c9e5e75e1 ("numa: Drop NUMA API v1 support")
There are other places, (testcases/kernel/mem/{lib,oom,vma}/),
but these might be ok (not using our libnuma).

Kind regards,
Petr

> ---
>  libs/libltpnuma/tst_numa.c                                | 4 ++--
>  testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c | 6 +++---
>  testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c | 6 +++---
>  testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c | 6 +++---
>  testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c | 6 +++---
>  5 files changed, 14 insertions(+), 14 deletions(-)

> diff --git a/libs/libltpnuma/tst_numa.c b/libs/libltpnuma/tst_numa.c
> index 6bd23e949..0ba6daf39 100644
> --- a/libs/libltpnuma/tst_numa.c
> +++ b/libs/libltpnuma/tst_numa.c
> @@ -8,7 +8,7 @@
>  #include <stdio.h>
>  #include <ctype.h>
>  #include "config.h"
> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2
>  # include <numa.h>
>  # include <numaif.h>
>  #endif
> @@ -43,7 +43,7 @@ void tst_nodemap_free(struct tst_nodemap *nodes)
>  	free(nodes);
>  }

> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2

>  const char *tst_numa_mode_name(int mode)
>  {
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
> index d3c17bb9b..96a275411 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
> @@ -13,14 +13,14 @@

>  #include <errno.h>
>  #include "config.h"
> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2
>  # include <numa.h>
>  # include <numaif.h>
>  #endif
>  #include "tst_test.h"
>  #include "tst_numa.h"

> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2

>  #include "set_mempolicy.h"

> @@ -117,4 +117,4 @@ static struct tst_test test = {

>  TST_TEST_TCONF(NUMA_ERROR_MSG);

> -#endif /* HAVE_NUMA_H */
> +#endif /* HAVE_NUMA_V2 */
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
> index e257c1c2c..4cdec1785 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
> @@ -14,14 +14,14 @@

>  #include <errno.h>
>  #include "config.h"
> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2
>  # include <numa.h>
>  # include <numaif.h>
>  #endif
>  #include "tst_test.h"
>  #include "tst_numa.h"

> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2

>  #include "set_mempolicy.h"

> @@ -116,4 +116,4 @@ static struct tst_test test = {

>  TST_TEST_TCONF(NUMA_ERROR_MSG);

> -#endif /* HAVE_NUMA_H */
> +#endif /* HAVE_NUMA_V2 */
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> index eb3e046f2..24775de10 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> @@ -11,7 +11,7 @@

>  #include <errno.h>
>  #include "config.h"
> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2
>  # include <numaif.h>
>  # include <numa.h>
>  #endif
> @@ -21,7 +21,7 @@
>  #define MNTPOINT "mntpoint"
>  #define PAGES_ALLOCATED 16u

> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2

>  #include "set_mempolicy.h"

> @@ -110,4 +110,4 @@ static struct tst_test test = {

>  TST_TEST_TCONF(NUMA_ERROR_MSG);

> -#endif /* HAVE_NUMA_H */
> +#endif /* HAVE_NUMA_V2 */
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> index 60601e7c1..8d8aa988d 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> @@ -22,7 +22,7 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include "config.h"
> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2
>  # include <numa.h>
>  # include <numaif.h>
>  #endif
> @@ -32,7 +32,7 @@
>  #define MNTPOINT "mntpoint"
>  #define FILES 10

> -#ifdef HAVE_NUMA_H
> +#ifdef HAVE_NUMA_V2

>  #include "set_mempolicy.h"

> @@ -139,4 +139,4 @@ static struct tst_test test = {

>  TST_TEST_TCONF(NUMA_ERROR_MSG);

> -#endif /* HAVE_NUMA_H */
> +#endif /* HAVE_NUMA_V2 */
