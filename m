Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TTrdz-0006ws-Dg
	for ltp-list@lists.sourceforge.net; Thu, 01 Nov 2012 10:04:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TTrdx-0007uT-2E
	for ltp-list@lists.sourceforge.net; Thu, 01 Nov 2012 10:04:59 +0000
Message-ID: <50924959.10905@cn.fujitsu.com>
Date: Thu, 01 Nov 2012 18:05:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1211223113.3263014.1351763732593.JavaMail.root@redhat.com>
In-Reply-To: <1211223113.3263014.1351763732593.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] ioctl01: change the errno to ENOTTY when passed
 an	invalid command
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>
Cc: shyju pv <shyju.pv@huawei.com>, sanil kumar <sanil.kumar@huawei.com>, max maxiansheng <max.maxiansheng@huawei.com>, Mike Frysinger <vapier@gentoo.org>, LTP <ltp-list@lists.sourceforge.net>

On 11/01/2012 05:55 PM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: "sanil kumar" <sanil.kumar@huawei.com>, "Mike Frysinger" <vapier@gentoo.org>, "shyju pv" <shyju.pv@huawei.com>,
>> "max maxiansheng" <max.maxiansheng@huawei.com>, "LTP" <ltp-list@lists.sourceforge.net>
>> Sent: Thursday, 1 November, 2012 9:15:08 AM
>> Subject: Re: [LTP] [PATCH] ioctl01: change the errno to ENOTTY when passed an	invalid command
>>
>>>> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c
>>>> b/testcases/kernel/syscalls/ioctl/ioctl01.c
>>>> index 8b044e7..ef64896 100644
>>>> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
>>>> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
>>>> @@ -87,7 +87,7 @@ struct test_case_t {
>>>>  	&fd, TCGETA, (struct termio *)-1, EFAULT},
>>>>  	    /* command is invalid */
>>>>  	{
>>>> -	&fd, INVAL_IOCTL, &termio, EINVAL},
>>>> +	&fd, INVAL_IOCTL, &termio, ENOTTY},
>>>
>>> Won't this break on older kernels? Can we test for kernel version
>>> with tst_kvercmp()?
>>
>> Surely will, this is also a trouble on my side.
>> Does we treat this as a kernel bug or a kernel change?
>> I think if we treat it as a kernel bug, we needn't check the kernel
>> version, while if
>> it just a kernel change, we need.
>> And, What's your opinion about this?
> 
> I'd go with kernel change, it worked the old way for years, there may be
> applications which rely on that. If we just change it to 'ENOTTY' it will
> start failing on older kernels and there are 2 choices: fix the kernel
> or stop using this testcase. And I'm not sure there are enough arguments
> to justify changing it in various distro's (stable) kernels.

OK, agree.

> 
> Is this commit backported to any upstream stable trees? Are there plans to do so?

I didn't see any backport, it may because some drivers return the old value, we can't
ensure to backport all of them, so I think there is no backprot plan. it's needless.

Thanks,
Wanlong Gao

> 
> Regards,
> Jan
> 


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
