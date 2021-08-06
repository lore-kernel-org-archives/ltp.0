From: sujiaxun <sujiaxun@uniontech.com>
Date: Fri, 6 Aug 2021 09:22:06 +0800
Subject: [LTP] [PATCH] [1/6] syscalls/sysfs: Convert sysfs01 to the new
 API
In-Reply-To: <YQvRg1O7kakkm30M@yuki>
References: <20210804060736.10234-1-sujiaxun@uniontech.com>
 <YQvRg1O7kakkm30M@yuki>
Message-ID: <7da55dc8-edd4-e392-b5b5-d2adce0cfaa2@uniontech.com>+56F90A5CBDF7C3AD
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Okay, thank you for your meticulous guidance, I will revise and submit 
it again according to your suggestions.

? 2021/8/5 ??7:54, Cyril Hrubis ??:
> Hi!
>> +		TEST(tst_syscall(__NR_sysfs, 1, "proc"));
>>
>>   		/* check return code */
>> -		if (TEST_RETURN == -1) {
>> -			tst_resm(TFAIL, "sysfs(2) Failed for "
>> -				 "option 1 and set errno to %d", TEST_ERRNO);
>> +		if (TST_RET == -1) {
>> +			tst_res(TFAIL, "sysfs(2) Failed for "
>> +				 "option 1 and set errno to %d", TST_ERR);
>>   		} else {
>> -			tst_resm(TPASS, "sysfs(2) Passed for " "option 1");
>> +			tst_res(TPASS, "sysfs(2) Passed for " "option 1");
>>   		}
> 
> This could be just:
> 
> 	TST_EXP_POSSITIVE(tst_syscall(__NR_sysfs, 1, "proc"),
> 	                  "sysfs(1, "proc")");
> 

-- 
Kind regards,

sujiaxun


