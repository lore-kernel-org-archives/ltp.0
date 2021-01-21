From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 21 Jan 2021 10:21:06 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls: Take use of TST_EXP_PASS_SILENT
In-Reply-To: <YAgHUvIge6svN0gu@yuki.lan>
References: <20210112020227.11775-1-yangx.jy@cn.fujitsu.com>
 <20210112020227.11775-3-yangx.jy@cn.fujitsu.com> <YAgHUvIge6svN0gu@yuki.lan>
Message-ID: <6008E512.50704@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/1/20 18:34, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/syscalls/capget/capget01.c b/testcases/kernel/syscalls/capget/capget01.c
>> index 6c17a7c7c..af088e2fc 100644
>> --- a/testcases/kernel/syscalls/capget/capget01.c
>> +++ b/testcases/kernel/syscalls/capget/capget01.c
>> @@ -32,8 +32,10 @@ static void verify_capget(unsigned int n)
>>   	hdr->version = tc->version;
>>   	hdr->pid = pid;
>>
>> -	TST_EXP_PASS(tst_syscall(__NR_capget, hdr, data),
>> +	TST_EXP_PASS_SILENT(tst_syscall(__NR_capget, hdr, data),
>>   	             "capget() with %s", tc->message);
>> +	if (!TST_PASS)
>> +		return;
>>
>>   	if (data[0].effective&  1<<  CAP_NET_RAW)
>>   		tst_res(TFAIL, "capget() gets CAP_NET_RAW unexpectedly in pE");
> I do not agree with the change in the capget01 here since there are
> really two testcases there and the test was producing the same amount of
> TPASS messages before the change to the TST_EXP_PASS() as well.
Hi Cyril,

Running  capget01 with TST_EXP_PASS() shows:
--------------------------------------------------------
capget01.c:35: TPASS: capget() with LINUX_CAPABILITY_VERSION_1 passed
capget01.c:41: TPASS: capget() doesn't get CAP_NET_RAW as expected in PE
capget01.c:35: TPASS: capget() with LINUX_CAPABILITY_VERSION_2 passed
capget01.c:41: TPASS: capget() doesn't get CAP_NET_RAW as expected in PE
capget01.c:35: TPASS: capget() with LINUX_CAPABILITY_VERSION_3 passed
capget01.c:41: TPASS: capget() doesn't get CAP_NET_RAW as expected in PE

Summary:
passed   6
--------------------------------------------------------

Running  capget01 with TST_EXP_PASS_SILENT() shows:
--------------------------------------------------------
capget01.c:43: TPASS: capget() doesn't get CAP_NET_RAW as expected in PE
capget01.c:43: TPASS: capget() doesn't get CAP_NET_RAW as expected in PE
capget01.c:43: TPASS: capget() doesn't get CAP_NET_RAW as expected in PE

Summary:
passed   3
--------------------------------------------------------

If you want to keep two TPASS for a subtest, how about merging two TPASS 
into one? like this:
------------------------------------------------------------------------------------------
capget01.c:43: TPASS: capget() with LINUX_CAPABILITY_VERSION_1 doesn't 
get CAP_NET_RAW as expected in PE
capget01.c:43: TPASS: capget() with LINUX_CAPABILITY_VERSION_2 doesn't 
get CAP_NET_RAW as expected in PE
capget01.c:43: TPASS: capget() with LINUX_CAPABILITY_VERSION_3 doesn't 
get CAP_NET_RAW as expected in PE

Summary:
passed   3
------------------------------------------------------------------------------------------ 

BTW, I just want to avoid many TPASS for a subtest.

Best Regards,
Xiao Yang
> Other than that the patchset is fine.
>
> So with the capget change removed you can add my:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>



