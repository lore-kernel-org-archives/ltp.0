Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Ys2yp-0001YG-8P
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 05:43:47 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ys2yn-0003Jl-T8
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 05:43:47 +0000
Message-ID: <555192E8.4060307@cn.fujitsu.com>
Date: Tue, 12 May 2015 13:43:04 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <554A7CCB.5030601@oracle.com>	<1430979479-29407-1-git-send-email-weijg.fnst@cn.fujitsu.com>	<554B326F.8050808@oracle.com>
	<1430992443.2653.6.camel@localhost>
In-Reply-To: <1430992443.2653.6.camel@localhost>
Subject: Re: [LTP] [PATCH v2] kernel/syscalls/fallocate: fix array parameter
 degradation
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>, "alexey.kodanev@oracle.com" <alexey.kodanev@oracle.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 05/07/2015 05:54 PM, Wei, Jiangang wrote:
> On Thu, 2015-05-07 at 12:37 +0300, Alexey Kodanev wrote:
>> Hi,
>> On 05/07/2015 09:17 AM, Wei,Jiangang wrote:
>>> Using 'sizeof' on array given as function argument
>>> returns size of a pointer, instead of the array's.
>>> So,
>>> It needs to pass an additional parameter size_t size
>>> indicating the number of elements in the array.
>>>
>>> Besides above,
>>> Set adjacent two bytes in 'exp_buf' to zero in test04().
>>>
>>> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
>>> ---
>>>   testcases/kernel/syscalls/fallocate/fallocate04.c | 10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
>>> index 723c886..911bbe8 100644
>>> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
>>> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
>>> @@ -98,9 +98,8 @@ static void setup(void)
>>>   	get_blocksize();
>>>   }
>>>   
>>> -static void check_file_data(const char exp_buf[])
>>> +static void check_file_data(const char exp_buf[], size_t size)
>>>   {
>>> -	size_t size = sizeof(exp_buf);
>>>   	char rbuf[size];
>>>   
>>>   	tst_resm(TINFO, "reading the file, compare with expected buffer");
>>> @@ -175,7 +174,7 @@ static void test02(void)
>>>   	fill_tst_buf(exp_buf);
>>>   	memset(exp_buf + block_size, 0, block_size);
>>>   
>>> -	check_file_data(exp_buf);
>>> +	check_file_data(exp_buf, buf_size);
>>>   
>>>   	tst_resm(TPASS, "test-case succeeded");
>>>   }
>>> @@ -215,7 +214,7 @@ static void test03(void)
>>>   	fill_tst_buf(exp_buf);
>>>   	memset(exp_buf + block_size - 1, 0, block_size + 2);
>>>   
>>> -	check_file_data(exp_buf);
>>> +	check_file_data(exp_buf, buf_size);
>>>   
>>>   	tst_resm(TPASS, "test-case succeeded");
>>>   }
>>> @@ -251,7 +250,8 @@ static void test04(void)
>>>   	memcpy(exp_buf, tmp_buf, block_size);
>>>   	memcpy(exp_buf + block_size, tmp_buf + size, block_size);
>>>   
>>> -	check_file_data(exp_buf);
>>> +	exp_buf[block_size - 1] = exp_buf[block_size] = '\0';
>>> +	check_file_data(exp_buf, size);
>>>   
>>>   	tst_resm(TPASS, "test-case succeeded");
>>>   }
>>
>> Patch applied, thank you!
> 
> Thank you for your feedback so quickly.
> Do you have noticed the other commit?
>  ->[PATCH 3/3] kernel/mem/mmapstress: fix resource leak
> 
> I guess it might have been ignored...

It's a bit messy, would you repost your patches which were
not applied to make things more clearly?

Thanks,
Wanlong Gao

> 
> Thanks again,
> Wei
>>
>> Best regards,
>> Alexey
>>
>>
> 
> ------------------------------------------------------------------------------
> One dashboard for servers and applications across Physical-Virtual-Cloud 
> Widest out-of-the-box monitoring support with 50+ applications
> Performance metrics, stats and reports that give you Actionable Insights
> Deep dive visibility with transaction tracing using APM Insight.
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> .
> 


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
