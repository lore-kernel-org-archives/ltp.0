From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 18 Feb 2019 10:08:40 +0800
Subject: [LTP] [PATCH v2] syscalls/setrlimit06: Add new test for
	RLIMIT_CPU
In-Reply-To: <1548997446-3969-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20190131105343.GA11386@rei>
 <1548997446-3969-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <5C6A13A8.5030009@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Could you help me review the v2 patch.
Thanks a lot. :-)

Best Regards,
Xiao Yang
On 2019/02/01 13:04, Xiao Yang wrote:
> Set CPU time limit for a process and check its behavior when
> reaching CPU time limit.
>
> Note:
> This is also a regression test for commit c3bca5d450b62 in kernel:
> "posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated"
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  runtest/syscalls                                  |   1 +
>  testcases/kernel/syscalls/setrlimit/.gitignore    |   1 +
>  testcases/kernel/syscalls/setrlimit/setrlimit06.c | 115 ++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/setrlimit/setrlimit06.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 668c87c..2e36709 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1197,6 +1197,7 @@ setrlimit02 setrlimit02
>  setrlimit03 setrlimit03
>  setrlimit04 setrlimit04
>  setrlimit05 setrlimit05
> +setrlimit06 setrlimit06
>  
>  set_robust_list01 set_robust_list01
>  set_thread_area01 set_thread_area01
> diff --git a/testcases/kernel/syscalls/setrlimit/.gitignore b/testcases/kernel/syscalls/setrlimit/.gitignore
> index e91f7e8..a790eb9 100644
> --- a/testcases/kernel/syscalls/setrlimit/.gitignore
> +++ b/testcases/kernel/syscalls/setrlimit/.gitignore
> @@ -3,3 +3,4 @@
>  /setrlimit03
>  /setrlimit04
>  /setrlimit05
> +/setrlimit06
> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit06.c b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
> new file mode 100644
> index 0000000..76e84e3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + */
> +
> +/*
> + * Description:
> + * Set CPU time limit for a process and check its behavior
> + * after reaching CPU time limit.
> + * 1) Process got SIGXCPU after reaching soft limit of CPU time.
> + * 2) Process got SIGKILL after reaching hard limit of CPU time.
> + *
> + * Note:
> + * This is also a regression test for the following kernel bug:
> + * 'c3bca5d450b62 ("posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated")'
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +#include <sys/mman.h>
> +
> +#include "tst_test.h"
> +
> +static int *end;
> +
> +static void sighandler(int sig)
> +{
> +	*end = sig;
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_SIGNAL(SIGXCPU, sighandler);
> +
> +	end = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (end)
> +		SAFE_MUNMAP(end, sizeof(int));
> +}
> +
> +static void verify_setrlimit(void)
> +{
> +	int status;
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		struct rlimit rlim = {
> +			.rlim_cur = 2,
> +			.rlim_max = 3,
> +		};
> +
> +		TEST(setrlimit(RLIMIT_CPU, &rlim));
> +		if (TST_RET == -1) {
> +			tst_res(TFAIL | TTERRNO,
> +				"setrlimit(RLIMIT_CPU) failed");
> +			exit(1);
> +		}
> +
> +		alarm(10);
> +
> +		while (1);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
> +		return;
> +
> +	if (WIFSIGNALED(status)) {
> +		if (WTERMSIG(status) == SIGKILL && *end == SIGXCPU) {
> +			tst_res(TPASS,
> +				"Got SIGXCPU then SIGKILL after reaching both limit");
> +			return;
> +		}
> +
> +		if (WTERMSIG(status) == SIGKILL && !*end) {
> +			tst_res(TFAIL,
> +				"Got only SIGKILL after reaching both limit");
> +			return;
> +		}
> +
> +		if (WTERMSIG(status) == SIGALRM && *end == SIGXCPU) {
> +			tst_res(TFAIL,
> +				"Got only SIGXCPU after reaching both limit");
> +			return;
> +		}
> +
> +		if (WTERMSIG(status) == SIGALRM && !*end) {
> +			tst_res(TFAIL,
> +				"Got no signal after reaching both limit");
> +			return;
> +		}
> +	}
> +
> +	tst_res(TBROK, "Child %s", tst_strstatus(status));
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_setrlimit,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +};



