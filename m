Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SU7xZ-0002Ax-A7
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 02:58:01 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SU7xX-0007PX-Vx
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 02:58:01 +0000
Message-ID: <4FB1C5E5.10407@cn.fujitsu.com>
Date: Tue, 15 May 2012 10:56:37 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F794D8B.6050505@cn.fujitsu.com> <4F7D26DC.5090605@redhat.com>
	<4F7D27D5.9080006@cn.fujitsu.com> <4F7D2BF7.6070201@redhat.com>
In-Reply-To: <4F7D2BF7.6070201@redhat.com>
Subject: Re: [LTP] ksm03
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
To: ZhoupingLiu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/05/2012 01:21 PM, ZhoupingLiu wrote:

> On 04/05/2012 01:04 PM, Wanlong Gao wrote:
>> On 04/05/2012 01:00 PM, ZhoupingLiu wrote:
>>
>>> On 04/02/2012 02:56 PM, Wanlong Gao wrote:
>>>> Hi Caspar,
>>>>
>>>> Have you ever seen like below? It happens on ksm03,
>>>> the page_sharing numbers is always incorrect, it
>>>> occurs on RHEL7-Alpha, any ides?
>>> hi, Wanlong
>>>
>>> I caught this error, but it just only occurred in s390x,
>>> and not 100% occurred, I will check the reason.
>>> could you tell me which arches do you met the issue?
>>
>> Not fortunately, I met on x86_64 :(
>> and the case can't finish then.
> 
> Okay, I'll dig it deeper, thanks for your info.


Got any idea? :-)

Thanks,
Wanlong Gao

> 
> -- 
> Thanks,
> Zhouping
> 



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
