From: Steve Muckle <smuckle@google.com>
Date: Tue, 23 Apr 2019 17:01:39 -0700
Subject: [LTP] [PATCH 1/1] preadv,
 pwritev: Fix preadv and pwritev link errors on android
In-Reply-To: <20190423221244.27287-1-pvorel@suse.cz>
References: <20190423221244.27287-1-pvorel@suse.cz>
Message-ID: <fb54cf3f-389d-f8cd-af30-f22a2e457a7a@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Steve Muckle <smuckle@google.com>

On 4/23/19 3:12 PM, Petr Vorel wrote:
> From: Petr Vorel <petr.vorel@gmail.com>
> 
> pwritev() declaration on in bionic C library is guarded with __USE_GNU,
> therefore define _GNU_SOURCE.
> 
> This fixes link errors implicit declaration errors.
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Hi,
> 
> this is IMHO better than adding -D_GNU_SOURCE into CFLAGS.
> 
> Kind regards,
> Petr
> ---
>   testcases/kernel/syscalls/preadv/preadv01.c   | 2 ++
>   testcases/kernel/syscalls/preadv/preadv02.c   | 2 ++
>   testcases/kernel/syscalls/pwritev/pwritev02.c | 2 ++
>   3 files changed, 6 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
> index 0565a086b..2b4ad5e20 100644
> --- a/testcases/kernel/syscalls/preadv/preadv01.c
> +++ b/testcases/kernel/syscalls/preadv/preadv01.c
> @@ -23,6 +23,8 @@
>   * and after reading the file, the file offset is not changed.
>   */
>   
> +#define _GNU_SOURCE
> +
>   #include <string.h>
>   #include <sys/uio.h>
>   
> diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
> index af1c3b0c4..9935e3835 100644
> --- a/testcases/kernel/syscalls/preadv/preadv02.c
> +++ b/testcases/kernel/syscalls/preadv/preadv02.c
> @@ -38,6 +38,8 @@
>   * 8) preadv(2) should return -1 and set errno to ESPIPE.
>   */
>   
> +#define _GNU_SOURCE
> +
>   #include <sys/uio.h>
>   #include <unistd.h>
>   #include "tst_test.h"
> diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
> index 2e6dbab57..9d8ff8725 100644
> --- a/testcases/kernel/syscalls/pwritev/pwritev02.c
> +++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
> @@ -36,6 +36,8 @@
>   * 7) pwritev(2) should return -1 and set errno to ESPIPE.
>   */
>   
> +#define _GNU_SOURCE
> +
>   #include <sys/uio.h>
>   #include <unistd.h>
>   #include "tst_test.h"
> 

