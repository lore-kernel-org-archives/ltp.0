From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 6 Dec 2016 18:27:23 +0800
Subject: [LTP] [PATCH 5/5] syscalls/setpriority01: Use new user id to
 avoid messing system environment
In-Reply-To: <20161205144526.GH22344@rei.lan>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1480507955-12652-5-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161205144526.GH22344@rei.lan>
Message-ID: <5846928B.2010805@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 12/05/2016 10:45 PM, Cyril Hrubis wrote:
> Hi!
>>  #include "tst_test.h"
>> +#include "linux_syscall_numbers.h"
>> +
>> +static char username[32];
>> +static uid_t uid;
>> +static struct __user_cap_header_struct header;
>> +static struct __user_cap_data_struct data;
> 
> Are you sure these are the right structure prototypes to use? The double
> underscore usually means "library internal, do not touch".
> 

It's my mistake, thanks for review, I will correct this.

>>  	int which;
>> @@ -35,9 +49,8 @@ static struct tcase {
>>  	{PRIO_USER}
>>  };
>>  
>> -static void verify_setpriority(unsigned int n)
>> +static void setpriority_test(struct tcase *tc)
>>  {
>> -	struct tcase *tc = &tcases[n];
>>  	int new_prio, cur_prio;
>>  	int failflag = 0;
>>  
>> @@ -68,9 +81,60 @@ static void verify_setpriority(unsigned int n)
>>  	}
>>  }
>>  
>> +static void verify_setpriority(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +
>> +	if (!SAFE_FORK()) {
>> +		SAFE_PRCTL(PR_SET_KEEPCAPS, 1);
>> +
>> +		SAFE_SETUID(uid);
>> +		SAFE_SETPGID(0, 0);
>> +
>> +		if (tst_syscall(__NR_capset, &header, &data) == -1)
>> +			tst_brk(TBROK | TERRNO, "capset() failed");
>> +
>> +		setpriority_test(tc);
>> +
>> +		exit(0);
>> +	}
>> +
>> +	tst_reap_children();
> 
> Hmm, why do we run the actuall testcase in the child here? That
> complicates the whole test far more than it should have.
> 
> We can instead just run pause() in the child and run the setpriority()
> call in the parent with right pid/group/uid. Or did I miss something?
> 

Sorry, if we do the actual test in the parent, we have to do the process
synchronization, because parent needs child to be ready (prctl, setuid...)
and after every test, child's pause() needs to be waken up by parent, so
I feel it's more complicated by comparison...

Best Regards,
Guangwen Feng

>> +}
>> +
>> +static void setup(void)
>> +{
>> +	char cmd[64];
>> +	struct passwd *ltpuser;
>> +
>> +	sprintf(username, "setpriority01.%d", getpid());
>> +
>> +	sprintf(cmd, "useradd %s", username);
>> +	SAFE_SYSTEM(cmd);
>> +
>> +	ltpuser = SAFE_GETPWNAM(username);
>> +	uid = ltpuser->pw_uid;
>> +
>> +	header.version = _LINUX_CAPABILITY_VERSION;
>> +	header.pid = 0;
>> +	if (tst_syscall(__NR_capget, &header, &data) == -1)
>> +		tst_brk(TBROK | TERRNO, "capget() failed");
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	char cmd[64];
>> +
>> +	sprintf(cmd, "userdel -r %s", username);
>> +	SAFE_SYSTEM(cmd);
>> +}
>> +
>>  static struct tst_test test = {
>>  	.tid = "setpriority01",
>>  	.tcnt = ARRAY_SIZE(tcases),
>>  	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>>  	.test = verify_setpriority,
>>  };
>> -- 
>> 1.8.4.2
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


