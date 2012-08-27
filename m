Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1T5pcH-00084x-Jn
	for ltp-list@lists.sourceforge.net; Mon, 27 Aug 2012 03:03:53 +0000
Received: from rcsinet15.oracle.com ([148.87.113.117])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T5pcE-0007AO-Uy
	for ltp-list@lists.sourceforge.net; Mon, 27 Aug 2012 03:03:53 +0000
Message-ID: <503AE389.6080300@oracle.com>
Date: Mon, 27 Aug 2012 11:03:37 +0800
From: Shuang Qiu <shuang.qiu@oracle.com>
MIME-Version: 1.0
References: <2058987008.58575291.1345816080840.JavaMail.root@redhat.com>
In-Reply-To: <2058987008.58575291.1345816080840.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/24/2012 09:48 PM, Zhouping Liu wrote:
>
> ----- Original Message -----
>> From: "Shuang Qiu" <shuang.qiu@oracle.com>
>> To: "Zhouping Liu" <zliu@redhat.com>
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Friday, August 24, 2012 6:18:00 PM
>> Subject: Re: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
>>
>> On 08/24/2012 04:11 PM, Zhouping Liu wrote:
>>> ----- Original Message -----
>>>> From: "shuang qiu" <shuang.qiu@oracle.com>
>>>> To: ltp-list@lists.sourceforge.net
>>>> Sent: Thursday, August 23, 2012 2:43:01 PM
>>>> Subject: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
>>>>
>>>> From: Shuang Qiu <shuang.qiu@oracle.com>
>>>>
>>>> The value of min_free_kbytes is set too high(half of mem_free)
>>>> during
>>>> testing min_free_kbytes tunable.It often cause the system to
>>>> become
>>>> out-of-memory.Using 20% of mem_free to avoid oom and system hang.
>>> Hi, shuang
>>>
>>> I met the issue that min_free_kbytes caused system hang before, and
>>> what you said made sense.
>>>
>>> but after tested the patch, I found it still make the system hang
>>> with the patch, so I don't think
>>> this patch can fix the issue completely, maybe there are other
>>> factors, or need lower tune value.
>>> always suppose it was because of the high tune value, it's more
>>> better to add an optional to control it.
>>> also I will investigate it deeper to look after the real reason.
>>> please comment if you have other ideas.
>>>
>>> Thanks,
>>> Zhouping
>> Thanks for testing,Zhouping.
>>
>> I find it says "However, setting this parameter to a value that is
>> too
>> high (5-10% of total system memory) will cause your system to become
>> out-of-memory immediately." in redhat memory-tunables document.
>> https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Performance_Tuning_Guide/s-memory-tunables.html
>> Set the value less than 5% of total memory will make it more safe.
> Thanks for sharing this! I will take your ideas into account.
>
>> Let's think about a better option to control it.
> Ok, I will prepare a patch for this.
>
>
>> It is great that you will investigate it deeper.
>> Seems there are some other problems in this case,it always failed
>> with i386.
>> The type of total_mem "unsigned long" is not suitable with nowadays
>> memory ,it will overflow(with i386) in line 177:map_count = total_mem
>> *
>> KB / MAP_SIZE and the value of map_count is not correct.
>> Using "unsigned long long" could fix this issue.
>> But the case still failed after fix it.
>> Could you help to investigate it too.
> sure.
>
Hi Zhouping,
I think the reason for the failures which I met is also that  it just 
catched oom_killer scenario when overcommit_memory=1.
I found your patch before:
commit 4f267b6fd11749c91211c9dbfc706cf46919650b
Author: Zhouping Liu <zliu@redhat.com>
Date:   Fri Mar 30 22:29:58 2012 +0800

     mm/tunable: fix unexpected error log in min_free_kbytes

     when overcommit_memory=0, mmap() will be destroyed in two below 
scenario:
      1) MAP_FAILED with ENOMEM,
      2) oom_killer kill it.
     without the patch, it just catched oom_killer scenario,
     the patch fixed it.


Could this patch also for when overcommit_memory=1 scenario?

Thanks
Shuang



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
