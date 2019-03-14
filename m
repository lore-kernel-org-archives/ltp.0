From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 Mar 2019 18:12:35 +0800
Subject: [LTP] [PATCH] block/ltp_block_dev.c: Fix error on
	older	distributions
In-Reply-To: <5C85D5BC.1010205@cn.fujitsu.com>
References: <1552274488-18515-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <5C85D5BC.1010205@cn.fujitsu.com>
Message-ID: <5C8A2913.2090402@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Pushed, thanks.

Best Regards,
Xiao Yang
On 2019/03/11 11:27, Xiao Yang wrote:
> Hi Jinhui,
>
> It looks good to me. :-)
> Reviewed-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>
> Best Regards,
> Xiao Yang
> On 2019/03/11 11:21, Jinhui huang wrote:
>> major number was limited to 511(i.e. BLKDEV_MAJOR_MAX - 1) by commit 133d55c
>> since kernel v4.14 so that register_blkdev() with a major number gather than
>> 511 got failure on older distributions.  It's just a change of limit rather
>> than bug fix so we want to accept both of results on all kernels.
>>
>> Fixes: 8d19ee6 ("block/ltp_block_dev.c: Update tests for the newer kernel")
>>
>> Signed-off-by: Jinhui huang<huangjh.jy@cn.fujitsu.com>
>> ---
>>   .../kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c     | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
>> index b0f6ce5..c7c8683 100644
>> --- a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
>> +++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
>> @@ -232,10 +232,15 @@ static int tc05(void)
>>
>>   		if (major == 0) {
>>   			unregister_blkdev(test_major[i], BLK_DEV_NAME);
>> +#ifdef BLKDEV_MAJOR_MAX
>>   			pass = 0;
>> +#endif
>>   		} else {
>>   			prk_debug("register_blkdev() with major %u got error %i\n",
>>   				  test_major[i], major);
>> +#ifndef BLKDEV_MAJOR_MAX
>> +			pass = 0;
>> +#endif
>>   		}
>>   	}
>>
>
>
>



