From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 8 Feb 2019 10:08:09 +0800
Subject: [LTP] [PATCH] block/ltp_block_dev.c: Update tests for the newer
 kernel
In-Reply-To: <20190206070648.GA1720@x230>
References: <1545980604-19404-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190206070648.GA1720@x230>
Message-ID: <5C5CE489.9010501@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/02/06 15:06, Petr Vorel wrote:
> Hi Xiao,
>
> ...
>> +++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
>> @@ -52,7 +52,8 @@ MODULE_LICENSE("GPL");
>>    *             |--------------------------+---------+-------------
>>    *             | [1..255]                 | valid   | tc03
>>    *             |--------------------------+---------+-------------
>> - *             | [256..UINT_MAX]          | valid   | tc04, tc05
>> + *             | [256..511]               | valid   | tc04
>> + *             | [512..UINT_MAX]          | invalid | tc05
>>    *  -----------+--------------------------+---------+-------------
>>    *  name       | [valid pointer to a zero |         |
>>    *             |  terminated string]      | valid   | tc01, tc02
>> @@ -205,17 +206,24 @@ static int tc03(void)
>>   static int tc04(void)
>>   {
>>   	int major, pass = 8;
>> +	unsigned int i, test_major[2] = {256, 511};
>> -	prk_info("Test Case 4: register_blkdev() with major=256\n");
>> +	prk_info("Test Case 4: register_blkdev() with major=256/511\n");
> Could we use test_major[0] and test_major[1] here?
>
>> -	major = register_blkdev(256, BLK_DEV_NAME);
>> -	prk_debug("major = %i\n", major);
>> +	for (i = 0; i<  sizeof(test_major) / sizeof(unsigned int); i++) {
>> +		major = register_blkdev(test_major[i], BLK_DEV_NAME);
>> +		prk_debug("major = %i\n", major);
>> -	if (major == 0) {
>> -		unregister_blkdev(256, BLK_DEV_NAME);
>> -	} else {
>> -		pass = 0;
>> -		prk_debug("register_blkdev() failed with error %i\n", major);
>> +		if (major == 0) {
>> +			unregister_blkdev(test_major[i], BLK_DEV_NAME);
>> +		} else if (major == -EBUSY) {
>> +			prk_debug("device was busy, register_blkdev() with "
>> +				  "major %u skipped\n", test_major[i]);
>> +		} else {
>> +			pass = 0;
>> +			prk_debug("register_blkdev() with major %u got "
>> +				  "error %i\n", test_major[i], major);
>> +		}
>>   	}
>>   	prk_info("Test Case Result: %s\n", result_str(pass));
>> @@ -225,18 +233,21 @@ static int tc04(void)
>>   static int tc05(void)
>>   {
>>   	int major, pass = 16;
>> +	unsigned int i, test_major[2] = {512, UINT_MAX};
>> -	prk_info("Test Case 5: register_blkdev() with major=%u\n", UINT_MAX);
>> +	prk_info("Test Case 5: register_blkdev() with major=512/%u\n", UINT_MAX);
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
>> +		if (major>= 0) {
>> +			unregister_blkdev(test_major[i], BLK_DEV_NAME);
>> +			pass = 0;
>> +		} else {
>> +			prk_debug("register_blkdev() with major %u got "
>> +				  "error %i\n", test_major[i], major);
> I'd prefer to have string on a single line.
>
> + I'd replace licence info at the top with SPDX-License-Identifier.
>
> Otherwise it looks good to me.
Hi Petr,

Thanks for your comment, and i will send v2 patch as you suggested. :-)

Best Regards,
Xiao Yang
> Kind regards,
> Petr
>
>
> .
>



