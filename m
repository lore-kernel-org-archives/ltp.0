From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Mon, 26 Jul 2021 05:15:06 +0000
Subject: [LTP] [PATCH 1/2] lib/tst_hugepage: Fix .request_hugepages = 0
 bug
In-Reply-To: <YPrZhzFng/7nHywg@yuki>
References: <1627017584-30405-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YPrZhzFng/7nHywg@yuki>
Message-ID: <60FE44F9.3080404@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
>> +'tst_hugepages' will be set to 0. If need zero hugepage on supported hugetlb
>                                        ^
> 				      If the hugepage size needs to be
> 				      set to 0 on ...
>> +system, please use '.request_hugepages = TST_NO_HUGEPAGES'.
I use number instead of size and then push this patchset.
Thanks for your review.

Best Regards
Yang Xu
>>
>>   Also, we do cleanup and restore work for the hpages resetting automatically.
>>
>> diff --git a/include/tst_test.h b/include/tst_test.h
>> index c7d77eb09..40c725995 100644
>> --- a/include/tst_test.h
>> +++ b/include/tst_test.h
>> @@ -125,6 +125,8 @@ struct tst_tag {
>>
>>   extern unsigned int tst_variant;
>>
>> +#define TST_NO_HUGEPAGES ((unsigned long)-1)
>> +
>>   struct tst_test {
>>   	/* number of tests available in test() function */
>>   	unsigned int tcnt;
>> @@ -175,7 +177,8 @@ struct tst_test {
>>   	 * have enough hpage for using, it will try the best to reserve 80% available
>>   	 * number of hpages. With success test stores the reserved hugepage number in
>>   	 * 'tst_hugepages. For the system without hugetlb supporting, variable
>> -	 * 'tst_hugepages' will be set to 0.
>> +	 * 'tst_hugepages' will be set to 0. If need zero hugepage on supported hugetlb
>> +	 * system, please use '.request_hugepages = TST_NO_HUGEPAGES'.
>
> Here as well.
>
>
> Other than that it looks good.
>
