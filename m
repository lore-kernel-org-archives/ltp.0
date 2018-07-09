From: Yang Shi <yang.shi@linux.alibaba.com>
Date: Mon, 9 Jul 2018 09:50:30 -0700
Subject: [LTP] [PATCH] memcg/memcg_subgroup_charge: Fix out of memory
In-Reply-To: <20180704140748.nmpe7ewhyne575v2@dell5510>
References: <1530783438-9860-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180704140748.nmpe7ewhyne575v2@dell5510>
Message-ID: <b663391f-40bb-a2ef-532e-45375961b400@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 7/4/18 7:07 AM, Petr Vorel wrote:
> Hi Xiao,
>
>> Since commit f0b9d18, memcg_process maps 33 pages for a process, but
>> memory.limit_in_bytes is still restricted to 1 page, so that moving
>> the process into group or subgroup results in oom.
>> Fixes: f0b9d18 ("memcg/functional: 4.16 kernel updates stat counter in a batch of 33 pages")
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> +++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
> ...
>>   testcase_1()
>>   {
>> -	test_subgroup $PAGESIZE $((2*PAGESIZE))
>> +	test_subgroup $PAGESIZES $((2*PAGESIZES))
>>   }
>>   testcase_2()
>>   {
>> -	test_subgroup $PAGESIZE $PAGESIZE
>> +	test_subgroup $PAGESIZES $PAGESIZES
>>   }
>>   testcase_3()
>>   {
>> -	test_subgroup $PAGESIZE 0
>> +	test_subgroup $PAGESIZES 0
>>   }
>>   run_tests
> Thanks for your fix, pushed.
>
> BTW some of these tests fail on recent kernel even after these 2 fixes.
> They work well on 3.10, but on 4.x fail at least.
>
> Some of the issues has been reported:
> * memcg_stat_test.sh
> memcg_stat_test 6 TFAIL: hierarchical_memory_limit is 4096, 8192 expected
> memcg_stat_test 2 TFAIL: mapped_file is 0, 4096 expected
> https://github.com/linux-test-project/ltp/issues/326
>
> * memcg_usage_in_bytes_test.sh
> memcg_usage_in_bytes_test 1 TFAIL: memory.usage_in_bytes is 4325376, 4194304 expected
> https://github.com/linux-test-project/ltp/issues/326
>
> * memcg_use_hierarchy_test.sh
> memcg_use_hierarchy_test 2 TFAIL: echo 1 > memory.use_hierarchy passed unexpectedly
> https://github.com/linux-test-project/ltp/issues/93

The last one sounds unrelated to those two fixes.

Yang

>
>
> Kind regards,
> Petr
>

