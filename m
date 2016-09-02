From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 2 Sep 2016 10:57:04 +0300
Subject: [LTP] [PATCH] cpuacct_task: exit cleanly on SIGVTALRM
In-Reply-To: <57C6E8FA.6030603@oracle.com>
References: <1472638914-22308-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160831133416.GA30378@rei.lan> <57C6E8FA.6030603@oracle.com>
Message-ID: <57C930D0.2020208@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 08/31/2016 05:26 PM, Stanislav Kholmanskikh wrote:
> Hi!
> 
> On 08/31/2016 04:34 PM, Cyril Hrubis wrote:
>> Hi!
>>> We don't handle the SIGVTALRM signal in cpuacct_task,
>>> so the process gets terminated, and it makes cpuacct.sh generate
>>> a "Virtual timer expired" message for each cpuacct_task process.
>>>
>>> In my opinion, these messages have no real value, and there is no
>>> need in keeping them in the output.
>>
>> I was just too lazy to install the signal handler in this case given
>> that the default action for the signal is to terminate the process...
>>
>>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>>> ---
>>>  .../kernel/controllers/cpuacct/cpuacct_task.c      |   23 +++++++++++++++++++-
>>>  1 files changed, 22 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_task.c b/testcases/kernel/controllers/cpuacct/cpuacct_task.c
>>> index 0ca01d1..94aa4e6 100644
>>> --- a/testcases/kernel/controllers/cpuacct/cpuacct_task.c
>>> +++ b/testcases/kernel/controllers/cpuacct/cpuacct_task.c
>>> @@ -25,11 +25,21 @@
>>>  #include <sys/time.h>
>>>  #include <sys/types.h>
>>>  #include <unistd.h>
>>> +#include <signal.h>
>>>  #include <stdlib.h>
>>> +#include <string.h>
>>> +
>>> +static volatile int got_signal;
>>> +
>>> +static void sig_handler(int signo)
>>> +{
>>> +	got_signal = 1;
>>> +}
>>
>> We can as well do _exit(0); here. Then we don't have to add the global
>> variable and the main loop will stay as for (;;);
> 
> Ok
> 
>>
>>>  int main(int argc, char **argv)
>>>  {
>>>  	FILE *f;
>>> +	struct sigaction sa;
>>>  
>>>  	if (argc != 2) {
>>>  		fprintf(stderr, "Usage: %s /cgroup/.../tasks\n", argv[0]);
>>> @@ -44,9 +54,20 @@ int main(int argc, char **argv)
>>>  
>>>  	fprintf(f, "%i\n", getpid());
>>>  	fclose(f);
>>> +
>>> +	memset(&sa, 0, sizeof(sa));
>>> +	sigemptyset(&sa.sa_mask);
>>> +	sa.sa_handler = sig_handler;
>>> +
>>> +	if (sigaction(SIGVTALRM, &sa, NULL)) {
>>> +		perror("sigaction failed");
>>> +		return 1;
>>> +	}
>>
>> I would just use simpler signal(SIGVTALRM, sig_handler); here.
> 
> I tend to use sigaction() everywhere, since the man page for signal()
> gives preference to sigaction() for the general case.
> 
>>
>>>  	struct itimerval it = {.it_value = {.tv_sec = 0, .tv_usec = 10000}};
>>>  
>>>  	setitimer(ITIMER_VIRTUAL, &it, NULL);
>>> -	for (;;);
>>> +	while (!got_signal)
>>> +		;
>>>  	return 0;
>>>  }
>>
>> Other than that it's fine.
>>
> 

Updated the patch to use _exit(0) and pushed it.

Thank you.
