From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Mon, 2 Aug 2021 15:01:48 +0000
Subject: [LTP] [PATCH v1] shmget02: check if CONFIG_HUGETLBFS enabled in
 kernel
In-Reply-To: <YQgET2rMo4BSNnrq@yuki>
References: <20210802143236.28791-1-bogdan.lezhepekov@suse.com>,
 <YQgET2rMo4BSNnrq@yuki>
Message-ID: <VI1PR04MB49588E7EF259841E40FD6CAE93EF9@VI1PR04MB4958.eurprd04.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril,

Thanks a lot for reviewing.

I agree that reading kconfig every time is not fun. But would it be better to read it once into global variable? My concern is that your solution implicitly changes expected values that might confuse people who occasionally don't look at the bottom of program.

How about:

inline void _hugetlbfs_supported()
{
struct tst_kconfig_var kconfig = {
.id = CONFIG_HUGETLBFS,
.id_len = sizeof(CONFIG_HUGETLBFS)-1,
};

tst_kconfig_read(&kconfig, 1);
hugetlbfs_supported = kconfig.choice == 'y';
}
....

static void do_test(unsigned int n)
{
struct tcase *tc = &tcases[n];
pid_t pid;

if (((tc->flags & SHM_HUGETLB) == SHM_HUGETLB) && ! hugetlbfs_supported)
{
tst_brk(TCONF,
"Unsuitable kernel config: CONFIG_HUGETLBFS missing");
}
....

---
Thanks,
Bogdan Lezhepekov, SUSE
________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Monday, August 2, 2021 17:42
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v1] shmget02: check if CONFIG_HUGETLBFS enabled in kernel

Hi!
> Two tests call shmget with a flag SHM_HUGETLB, trying to
> allocate the segment using "huge" pages. The hugetlbpage
> support needs to be enabled in kernel (CONFIG_HUGETLBFS),
> otherwise shmget returns EINVAL.
>
> Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
> ---
>  .../kernel/syscalls/ipc/shmget/shmget02.c     | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> index 66a4b94ee..4d515fb81 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> @@ -32,10 +32,13 @@
>  #include <sys/shm.h>
>  #include <grp.h>
>  #include "tst_safe_sysv_ipc.h"
> +#include "tst_kconfig.h"
>  #include "tst_test.h"
>  #include "libnewipc.h"
>  #include "lapi/shm.h"
>
> +#define CONFIG_HUGETLBFS "CONFIG_HUGETLBFS"
> +
>  static int shm_id = -1;
>  static key_t shmkey, shmkey1;
>  static struct passwd *pw;
> @@ -60,11 +63,29 @@ static struct tcase {
>        {&shmkey1, SHM_SIZE, IPC_CREAT | SHM_HUGETLB, 0, 0, ENOMEM}
>  };
>
> +inline static int hugetlbfs_enabled()
> +{
> +     struct tst_kconfig_var kconfig = {
> +             .id = CONFIG_HUGETLBFS,
> +             .id_len = sizeof(CONFIG_HUGETLBFS)-1,
> +     };
> +
> +     tst_kconfig_read(&kconfig, 1);
> +     return kconfig.choice == 'y';
> +}
> +
>  static void do_test(unsigned int n)
>  {
>        struct tcase *tc = &tcases[n];
>        pid_t pid;
>
> +     if (((tc->flags & SHM_HUGETLB) == SHM_HUGETLB) && ! hugetlbfs_enabled())
> +     {
> +             tst_brk(TCONF,
> +                     "Unsuitable kernel config: CONFIG_HUGETLBFS missing");
> +             return;
> +     }

We whould really update the tcases array in the setup instead as this
will re-read the whole kernel config on each do_test() iteration.

Something as:

static void setup(void)
{
        ...

        if (!hugetlb_supported()) {

                tst_res(TINFO, "SHM_HUGETLB not supported by kernel");

                for (i = 0; i < ARRAY_SIZE(tcases); i++) {
                        if (tcases[i].flags & SHM_HUGETLB)
                                tcases[i].exp_err = EINVAL;
                }
        }
        ...
}

>        if (tc->exp_user == 0 && tc->exp_group == 0) {
>                TST_EXP_FAIL2(shmget(*tc->shmkey, tc->size, tc->flags), tc->exp_err,
>                        "shmget(%i, %lu, %i)", *tc->shmkey, tc->size, tc->flags);
> --
> 2.32.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

--
Cyril Hrubis
chrubis@suse.cz

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210802/052d3e18/attachment-0001.htm>
