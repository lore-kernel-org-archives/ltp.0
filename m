From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Thu, 26 Aug 2021 19:10:45 +0800
Subject: [LTP] [PATCH 5/7] syscalls/clone05: Convert to new API
In-Reply-To: <YSZTn5KKmOgFINNX@yuki>
References: <20210813072657.21976-1-zhanglianjie@uniontech.com>
 <YSZTn5KKmOgFINNX@yuki>
Message-ID: <4b6bac9e-1f35-fabc-a6ef-1c52bf9cdccc@uniontech.com>+5943B6CE1329538A
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

>> +static void verify_clone(void)
>> +{
>> +	TST_EXP_POSITIVE(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
>> +					CHILD_STACK_SIZE, child_stack), "clone with vfork");
>>
>> -	free(child_stack);
>> +	if (!TST_PASS)
>> +		return;
>>
>> -	cleanup();
>> -	tst_exit();
>> +	TST_EXP_PASS(!child_exited);
> 
> This is misuse of the macro, since the macro checks for -1 on failure
> and we will get 1 on failure here.
> 
> I guess that we should add TST_EXP_VAL() instead for cases like this and
> we would do:
> 
> 	TST_EXP_VAL(child_exited, 1);
> 
> Will you send a patch or should I add it?
> 
I will send patch to add TST_EXP_VAL, thank you.

-- 
Regards,
Zhang Lianjie


