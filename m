From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 16 Jun 2021 19:54:26 +0800
Subject: [LTP] [PATCH 1/3] lib: tst_process_state: Add
 tst_process_release_wait()
In-Reply-To: <YMnavJjzrS7B8fgd@yuki>
References: <20210616093606.214856-1-xieziyao@huawei.com>
 <20210616093606.214856-2-xieziyao@huawei.com> <YMnavJjzrS7B8fgd@yuki>
Message-ID: <55d788bc-a454-0c9a-f0bd-733aaf0b95c1@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> 
> First of all changes in license and whitespaces should be in a separate
> patch from the newly added functionality.
Agree with you, thx.

> 
>>   #include <stdio.h>
>> @@ -28,9 +12,8 @@
>>   #include "test.h"
>>   #include "tst_process_state.h"
>>
>> -int tst_process_state_wait(const char *file, const int lineno,
>> -                            void (*cleanup_fn)(void), pid_t pid,
>> -			    const char state, unsigned int msec_timeout)
>> +int tst_process_state_wait(const char *file, const int lineno, void (*cleanup_fn)(void),
>> +			   pid_t pid, const char state, unsigned int msec_timeout)
>>   {
>>   	char proc_path[128], cur_state;
>>   	unsigned int msecs = 0;
>> @@ -39,7 +22,7 @@ int tst_process_state_wait(const char *file, const int lineno,
>>
>>   	for (;;) {
>>   		safe_file_scanf(file, lineno, cleanup_fn, proc_path,
>> -		                "%*i %*s %c", &cur_state);
>> +				"%*i %*s %c", &cur_state);
>>
>>   		if (state == cur_state)
>>   			break;
>> @@ -84,3 +67,26 @@ int tst_process_state_wait2(pid_t pid, const char state)
>>   		usleep(10000);
>>   	}
>>   }
>> +
>> +int tst_process_release_wait(pid_t pid, unsigned int msec_timeout)
>> +{
>> +	char proc_path[128];
>> +	unsigned int msecs = 0;
>> +
>> +	snprintf(proc_path, sizeof(proc_path), "/proc/%i", pid);
>> +
>> +	for (;;) {
>> +		if (access(proc_path, F_OK))
>> +			break;
>> +
>> +		usleep(1000);
>> +		msecs += 1;
>> +
>> +		if (msec_timeout && msecs >= msec_timeout) {
>> +			errno = ETIMEDOUT;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return 1;
>> +}
> 
> What exactly do we need this for?
> 
> When does /proc/$PID ceases to exit? My guess would be that the
> directory ceases to exists once the child has been waited() for by a
> parent process and we do not need this at all since call to system()
> does wait for it's children anyways.
Hi, this function is writtten for sig_ign() in getrusage03, which tests 
getrusage by ignoring the SIGCHLD signal.

When a child is terminated, a corresponding SIGCHLD signal is delivered 
to the parent, if we call the signal(SIGCHLD,SIG_IGN), then the SIGCHLD 
signal is ignored by the system, and the child process entry is deleted 
from the process table. Thus, no zombie is created. However, in this 
case, the parent cannot know about the exit status of the child.

So I checked /proc/$PID here instead of using waitpid().


Thanks for your review.

Kind Regards,
Ziyao
