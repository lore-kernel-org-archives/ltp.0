From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 13 Feb 2020 09:43:32 +0800
Subject: [LTP] [PATCH] syscalls/kill11: add a check between hard limit
 and MIN_RLIMIT_CORE
In-Reply-To: <1892366945.7197852.1581514327491.JavaMail.zimbra@redhat.com>
References: <1581486286-13615-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1892366945.7197852.1581514327491.JavaMail.zimbra@redhat.com>
Message-ID: <71c807c2-b77b-5081-76f8-335aaf1cbe3a@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



on 2020/02/12 21:32, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> Currently, running this case will report EINVAL error if I run "ulimit -c
>> 1023" command firstly. From setrlimit(2)manpage, it got EINVAL error because
>> rlim->rlim_cur was greater than rlim->rlim_max. So add a check for it before
>> setrlimit.
>>
>> Reported-by: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/kill/kill11.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/kill/kill11.c
>> b/testcases/kernel/syscalls/kill/kill11.c
>> index 83fba5beb..5f70b0a07 100644
>> --- a/testcases/kernel/syscalls/kill/kill11.c
>> +++ b/testcases/kernel/syscalls/kill/kill11.c
>> @@ -201,6 +201,9 @@ void setup(void)
>>   
>>   	SAFE_GETRLIMIT(NULL, RLIMIT_CORE, &rlim);
>>   
>> +	if (rlim.rlim_max < MIN_RLIMIT_CORE)
>> +		tst_brkm(TCONF, NULL, "hard limit(%lu)less than MIN_RLIMT_CORE(%i)",
>> +				rlim.rlim_max, MIN_RLIMIT_CORE);
> 
> This looks OK, but could we also raise the limit when possible?
> 
Of course. Your way is more wise.
But I also want to change this size of MIN_RLIMIT_CORE.
 From ulimit manpage, I know in posix mode "-c" used 512-byte block. I 
doubt whether we can change MIN_RLIMIT_CORE(512 *1024), so this case
can also pass in unbuntu(default environment).
What do you think about this?

ps: I tested it on el7,el8, they all pass.

> 
> +       if (rlim.rlim_max < MIN_RLIMIT_CORE) {
> +               if (geteuid() != 0) {
> +                       tst_brkm(TCONF, NULL, "hard limit(%lu)less than MIN_RLIMT_CORE(%i)",
> +                               rlim.rlim_max, MIN_RLIMIT_CORE);
> +               }
> +               tst_resm(TINFO, "Raising rlim_max to %i", MIN_RLIMIT_CORE);
> +               rlim.rlim_max = MIN_RLIMIT_CORE;
> +       }
> 
> 
> 


