From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 13 Feb 2019 18:11:32 +0800
Subject: [LTP] [PATCH v2] block/ltp_block_dev.c: Update tests for the
 newer kernel
In-Reply-To: <20190208114833.GA26843@dell5510>
References: <20190206070648.GA1720@x230>
 <1549597075-7589-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190208114833.GA26843@dell5510>
Message-ID: <5C63ED54.4080009@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Pushed,  thanks for your review again. :-)

Best Regards,
Xiao Yang
On 2019/02/08 19:48, Petr Vorel wrote:
> Hi Xiao,
>
>> The maximum major number is set to 511 since kernel commit 133d55c,
>> so register_blkdev() with a major number grater than the maximum(511)
>> will get failure instead of pass as expected.
>> 1) Update tests for the newer behavior of register_blkdev().
>> 2) Add more major numbers(i.e. 511 and 512) to test.
>> Note:
>> It is possible that specified major numbers have been used
>> by system, so we skip them if register_blkdev() returns EBUSY.
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> Reviewed-by: Petr Vorel<pvorel@suse.cz>
> Acked-by: Petr Vorel<pvorel@suse.cz>
> Thanks for your updates.
>
>> ---
>>   .../block/block_dev_kernel/ltp_block_dev.c         | 64 +++++++++++-----------
>>   1 file changed, 32 insertions(+), 32 deletions(-)
>> diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
> ...
>> @@ -225,18 +221,22 @@ static int tc04(void)
>>   static int tc05(void)
> ...
>
>> -	major = register_blkdev(UINT_MAX, BLK_DEV_NAME);
>> -	prk_debug("major = %i\n", major);
>> +	for (i = 0; i<  sizeof(test_major) / sizeof(unsigned int); i++) {
>> +		major = register_blkdev(test_major[i], BLK_DEV_NAME);
>> +		prk_debug("major = %i\n", major);
>> -	if (major == 0) {
>> -		unregister_blkdev(UINT_MAX, BLK_DEV_NAME);
>> -	} else {
>> -		prk_debug("reg blkdev with major %d failed with error %i\n",
>> -			UINT_MAX, major);
>> -		pass = 0;
>> +		if (major == 0) {
> In v1 this was major>= 0.
> It looks to me as well that major == 0 is correct.
>
>> +			unregister_blkdev(test_major[i], BLK_DEV_NAME);
>> +			pass = 0;
>> +		} else {
>> +			prk_debug("register_blkdev() with major %u got error %i\n",
>> +				  test_major[i], major);
>> +		}
>>   	}
>>   	prk_info("Test Case Result: %s\n", result_str(pass));
>
> Kind regards,
> Petr
>
>
> .
>



