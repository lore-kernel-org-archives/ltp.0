From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 1 Feb 2019 09:47:54 +0800
Subject: [LTP] [PATCH] syscalls/setrlimit06: Add new test for RLIMIT_CPU
In-Reply-To: <20190131105343.GA11386@rei>
References: <1548924876-4509-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190131105343.GA11386@rei>
Message-ID: <5C53A54A.8070700@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/01/31 18:53, Cyril Hrubis wrote:
> Hi!
>> This is also a regression test for commit c3bca5d450b62 in kernel:
>> "posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated"
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   runtest/syscalls                                  |   1 +
>>   testcases/kernel/syscalls/setrlimit/.gitignore    |   1 +
>>   testcases/kernel/syscalls/setrlimit/setrlimit06.c | 108 ++++++++++++++++++++++
>>   3 files changed, 110 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/setrlimit/setrlimit06.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 668c87c..2e36709 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1197,6 +1197,7 @@ setrlimit02 setrlimit02
>>   setrlimit03 setrlimit03
>>   setrlimit04 setrlimit04
>>   setrlimit05 setrlimit05
>> +setrlimit06 setrlimit06
>>
>>   set_robust_list01 set_robust_list01
>>   set_thread_area01 set_thread_area01
>> diff --git a/testcases/kernel/syscalls/setrlimit/.gitignore b/testcases/kernel/syscalls/setrlimit/.gitignore
>> index e91f7e8..a790eb9 100644
>> --- a/testcases/kernel/syscalls/setrlimit/.gitignore
>> +++ b/testcases/kernel/syscalls/setrlimit/.gitignore
>> @@ -3,3 +3,4 @@
>>   /setrlimit03
>>   /setrlimit04
>>   /setrlimit05
>> +/setrlimit06
>> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit06.c b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
>> new file mode 100644
>> index 0000000..d6004a5
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
>> @@ -0,0 +1,108 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>> + * Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> + */
>> +
>> +/*
>> + * Description:
>> + * Set CPU time limit for a process and check its behavior
>> + * when reaching CPU time limit.
>> + * 1) Process received SIGXCPU signal when reaching soft limit
>> + *    of CPU time.
>> + * 2) Process received SIGKILL signal when reaching hard limit
>> + *    of CPU time.
>> + *
>> + * Note:
>> + * This is also a regression test for the following kernel bug:
>> + * 'c3bca5d450b62 ("posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated")'
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include<errno.h>
>> +#include<sys/types.h>
>> +#include<unistd.h>
>> +#include<sys/time.h>
>> +#include<sys/resource.h>
>> +#include<sys/wait.h>
>> +
>> +#include "tst_test.h"
>> +
>> +static volatile int end;
>> +
>> +static void sighandler(int sig)
>> +{
>> +	end = sig;
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	SAFE_SIGNAL(SIGALRM, SIG_DFL);
> The SIGALRM handler should be set to SIG_DFL for the test process in the
> test library. At least that's what we do in fork_testrun() function in
> tst_test.c
Hi Cyril,

Thanks for your remind, and i will remove it.
>> +	SAFE_SIGNAL(SIGXCPU, sighandler);
>> +}
>> +
>> +static void verify_setrlimit(void)
>> +{
>> +	int status;
>> +	pid_t pid;
>> +
>> +	pid = vfork();
>> +	if (pid == -1)
>> +		tst_brk(TBROK, "vfork() failed");
> Why vfork? You are not supposed to use vfork() for anything but vfork()
> + exec(). As it is the code below invokes undefined behavior.
By vfork, i want to ensure that the value of end can be shared by child 
and parnet.
Perhaps, i should use shared memory instead of vfork. :-)
>> +	if (!pid) {
>> +		struct rlimit rlim = {
>> +			.rlim_cur = 2,
>> +			.rlim_max = 3,
>> +		};
>> +
>> +		TEST(setrlimit(RLIMIT_CPU,&rlim));
>> +		if (TST_RET == -1) {
>> +			tst_res(TFAIL | TTERRNO,
>> +				"setrlimit(RLIMIT_CPU) failed");
>> +			_exit(1);
>> +		}
>> +
>> +		alarm(10);
>> +
>> +		while (1);
>> +	}
>> +
>> +	SAFE_WAITPID(pid,&status, 0);
>> +
>> +	if (WIFEXITED(status)&&  WEXITSTATUS(status) == 1)
>> +		return;
>> +
>> +	if (WIFSIGNALED(status)) {
>> +		if (WTERMSIG(status) == SIGKILL&&  end == SIGXCPU) {
>> +			tst_res(TPASS,
>> +				"Process received SIGXCPU and SIGKILL when reaching soft and hard limit of CPU time");
> This message is far too long, please be short and to the point,
> somethig as:
>
> 	tst_res(TPASS, "Got SIGXCPU then SIGKILL after reaching both limits");
>
I will shorten all message as you said.

Best Regards,
Xiao Yang
>> +			return;
>> +		}
>> +
>> +		if (WTERMSIG(status) == SIGKILL&&  !end) {
>> +			tst_res(TFAIL,
>> +				"Process only received SIGKILL when reaching CPU time hard limit");
> Here as well, something as:
>
> 	tst_res(TFAIL, "Got only SIGKILL after reaching both limits");
>
>> +			return;
>> +		}
>> +
>> +		if (WTERMSIG(status) == SIGALRM&&  end == SIGXCPU) {
>> +			tst_res(TFAIL,
>> +				"Process only received SIGXCPU when reaching CPU time soft limit");
> And here as well.
>
>> +			return;
>> +		}
>> +
>> +		if (WTERMSIG(status) == SIGALRM&&  !end) {
>> +			tst_res(TFAIL,
>> +				"Process didn't receive any signal when reaching soft and hard limit of CPU time");
> And here as well.
>
>> +			return;
>> +		}
>> +	}
>> +
>> +	tst_res(TBROK, "child %s", tst_strstatus(status));
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = verify_setrlimit,
>> +	.setup = setup,
>> +};



