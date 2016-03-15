From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 15 Mar 2016 14:18:36 +0300
Subject: [LTP] [PATCH] device-drivers/uaccess: add a workaround for
 Intel's SMAP feature
In-Reply-To: <56E7D636.9040804@cn.fujitsu.com>
References: <1458033917-13891-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
 <56E7D636.9040804@cn.fujitsu.com>
Message-ID: <56E7EF8C.3010702@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/15/2016 12:30 PM, Xiaoguang Wang wrote:
> hello,
>
> Sorry, I do not have a machine with this SMAP feature, anybody can
> help to test this patch, thanks very much.
>
> Regards,
> Xiaoguang Wang
>
> On 03/15/2016 05:25 PM, Xiaoguang Wang wrote:
>> When Intel's new "Supervisor Mode Access Prevention" (SMAP) feature is
>> enabled, kernel will be forbidden to visit user space memory, please
>> see url: https://lwn.net/Articles/517475/ for detailed infomation.
>>
>> Here, we explicitly call stac()/clac() to enable/disable SMAP feature.
>>
>> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>   testcases/kernel/device-drivers/uaccess/ltp_uaccess.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c b/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c
>> index a9a06e9..35a9aa0 100644
>> --- a/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c
>> +++ b/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c
>> @@ -68,6 +68,9 @@ static ssize_t sys_tcase(struct device *dev,
>>   	str = (char *) ptr;
>>   	test_result = 0;
>>   
>> +#ifdef CONFIG_X86_SMAP
>> +	stac();
>> +#endif
>>   	switch (tc) {
>>   	case TC_READ_USER:
>>   		if (copy_from_user(buffer, str, str_size))
>> @@ -90,6 +93,11 @@ static ssize_t sys_tcase(struct device *dev,
>>   	break;
>>   	}
>>   
>> +#ifdef CONFIG_X86_SMAP
>> +	clac();
>> +#endif


copy_from_user() and others have stac() / clac() already. Are you sure we
need to invoke them there again?

Thanks,
Alexey

