From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 12 Feb 2020 14:41:51 +0800
Subject: [LTP] [PATCH] syscalls/kill11: add a check between hard limit
 and MIN_RLIMIT_CORE
In-Reply-To: <5E439705.4010303@cn.fujitsu.com>
References: <1581486286-13615-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5E439705.4010303@cn.fujitsu.com>
Message-ID: <05dd082a-417b-b71b-909a-2691b96adec9@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2020/02/12 14:11, Xiao Yang wrote:
> On 2020/2/12 13:44, Yang Xu wrote:
>> Currently, running this case will report EINVAL error if I run "ulimit -c
>> 1023" command firstly. From setrlimit(2)manpage, it got EINVAL error 
>> because
>> rlim->rlim_cur was greater than rlim->rlim_max. So add a check for it 
>> before
>> setrlimit.
> Hi Xu,
> 
> It seems better to fix the issue by setting both rlim_cur and rlimit_max 
> to the MIN_RLIMIT_CORE.
> We can not raise rlim_max value under unprivileged user. Or, should I 
cleanup this case and use needs_root=1 ?

Best Regards
Yang Xu
> Thanks,
> Xiao Yang
>> Reported-by: Pankaj Vinadrao Joshi<Pankaj.VJ@exaleapsemi.com>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>> ? testcases/kernel/syscalls/kill/kill11.c | 3 +++
>> ? 1 file changed, 3 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/kill/kill11.c 
>> b/testcases/kernel/syscalls/kill/kill11.c
>> index 83fba5beb..5f70b0a07 100644
>> --- a/testcases/kernel/syscalls/kill/kill11.c
>> +++ b/testcases/kernel/syscalls/kill/kill11.c
>> @@ -201,6 +201,9 @@ void setup(void)
>>
>> ????? SAFE_GETRLIMIT(NULL, RLIMIT_CORE,&rlim);
>>
>> +??? if (rlim.rlim_max<? MIN_RLIMIT_CORE)
>> +??????? tst_brkm(TCONF, NULL, "hard limit(%lu)less than 
>> MIN_RLIMT_CORE(%i)",
>> +??????????????? rlim.rlim_max, MIN_RLIMIT_CORE);
>> ????? if (rlim.rlim_cur<? MIN_RLIMIT_CORE) {
>> ????????? tst_resm(TINFO, "Adjusting RLIMIT_CORE to %i", 
>> MIN_RLIMIT_CORE);
>> ????????? rlim.rlim_cur = MIN_RLIMIT_CORE;
> 


