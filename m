From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 21 Jul 2020 18:03:27 +0200
Subject: [LTP] [PATCH 6/9] syscalls/ipc: Add shmctl() IPC_INFO test
In-Reply-To: <20200717163453.9587-7-chrubis@suse.cz>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-7-chrubis@suse.cz>
Message-ID: <7a26989c-93b8-c390-a87c-3d19c6603721@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,
for patches 2, 4 and 5:
Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Patch 3 needs a test scenario redesign as reported by Li Wang.

In this patch, you should also check for other negative return values
from shmctl() besides -1.

On 17. 07. 20 18:34, Cyril Hrubis wrote:
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/syscalls                              |  1 +
>  runtest/syscalls-ipc                          |  1 +
>  .../kernel/syscalls/ipc/shmctl/.gitignore     |  1 +
>  .../kernel/syscalls/ipc/shmctl/shmctl03.c     | 38 +++++++++++++++++++
>  4 files changed, 41 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 5ce482dc7..819e8d8ee 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1355,6 +1355,7 @@ shmat03 shmat03
>  
>  shmctl01 shmctl01
>  shmctl02 shmctl02
> +shmctl03 shmctl03
>  shmctl04 shmctl04
>  shmctl05 shmctl05
>  shmctl06 shmctl06
> diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
> index 10cb92c7d..c3a35896c 100644
> --- a/runtest/syscalls-ipc
> +++ b/runtest/syscalls-ipc
> @@ -53,6 +53,7 @@ shmat02 shmat02
>  
>  shmctl01 shmctl01
>  shmctl02 shmctl02
> +shmctl03 shmctl03
>  shmctl04 shmctl04
>  shmctl05 shmctl05
>  shmctl06 shmctl06
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/.gitignore b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
> index 08aa83c19..46b107344 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/.gitignore
> +++ b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
> @@ -1,5 +1,6 @@
>  /shmctl01
>  /shmctl02
> +/shmctl03
>  /shmctl04
>  /shmctl05
>  /shmctl06
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
> new file mode 100644
> index 000000000..7df8c12ce
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
> + */
> +/*
> + * Call shmctl() with IPC_INFO flag and check that the data are consistent with
> + * /proc/sys/kernel/shm*.
> + */
> +
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "libnewipc.h"
> +
> +static void verify_ipcinfo(void)
> +{
> +	struct shminfo info;
> +
> +	TEST(shmctl(0, IPC_INFO, (struct shmid_ds *)&info));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "shmctl(0, IPC_INFO, ...)");
> +		return;
> +	}
> +

if (TST_RET < 0)
	tst_res(TFAIL...)

> +	if (info.shmmin != 1)
> +		tst_res(TFAIL, "shmmin = %li, expected 1", info.shmmin);
> +	else
> +		tst_res(TPASS, "shmmin = 1");
> +
> +	TST_ASSERT_ULONG("/proc/sys/kernel/shmmax", info.shmmax);
> +	TST_ASSERT_ULONG("/proc/sys/kernel/shmmni", info.shmmni);
> +	TST_ASSERT_ULONG("/proc/sys/kernel/shmall", info.shmall);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_ipcinfo,
> +};
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
