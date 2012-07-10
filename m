Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SoOHQ-0005tQ-Fn
	for ltp-list@lists.sourceforge.net; Tue, 10 Jul 2012 00:26:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SoOHO-000253-Q1
	for ltp-list@lists.sourceforge.net; Tue, 10 Jul 2012 00:26:16 +0000
Message-ID: <4FFB7686.3020303@cn.fujitsu.com>
Date: Tue, 10 Jul 2012 08:25:42 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1ab75ea0-ace3-4553-8ab6-ead97938046c@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1ab75ea0-ace3-4553-8ab6-ead97938046c@zmail13.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 2/2] mm/lib: increase sleep time in ksm scanning
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 07/09/2012 11:51 PM, Zhouping Liu wrote:
> 
> 
> ----- Original Message -----
>> From: "Caspar Zhang" <caspar@casparzhang.com>
>> To: gaowanlong@cn.fujitsu.com
>> Cc: "Zhouping Liu" <zliu@redhat.com>, "LTP list" sourceforge.net>
>> Sent: Monday, July 9, 2012 10:15:17 PM
>> Subject: Re: [LTP] [PATCH 2/2] mm/lib: increase sleep time in ksm scanning
>>
>> On 07/09/2012 09:10 PM, Wanlong Gao wrote:
>>> On 07/09/2012 08:37 PM, Caspar Zhang wrote:
>>>> On 07/09/2012 07:32 PM, Wanlong Gao wrote:
>>>>> On 07/09/2012 05:51 PM, Caspar Zhang wrote:
>>>>>>
>>>>>> for some systems under pressure, we've observed that sleeping 5
>>>>>> seconds is not sufficient for completing ksm scanning, to fix
>>>>>> this, we should give ksmd more time to scan the mergable pages
>>>>>> by increasing sleeping time to 10s.
>>>>>
>>>>> If 5s is not enough, isn't we waiting here already?
>>>>
>>>> Sorry, I'm not catching you... :-( the problem currently we
>>>> encounter is that if 5s given, all ksm values (pages_sharing,
>>>> pages_shared, etc) might remain the same between before and after
>>>> sleeping, so the wait_ksmd function could exit. But in fact the
>>>> kernel could be busy under pressure and it just needs more than 5s
>>>> to merge the same page. Using 10s as polling interval can make
>>>> sure
>>>> if ksm values remains the same between each loop, it should
>>>> indicates that ksmd has done scanning correctly.
>>>>
>>>
>>> Oops, it's a serious problem, so can we first wait for changing and
>>> then wait for not changing? I'm afraid that hard coded sleep time
>>> can't do the right thing on some systems.
>>
>> IMO the current implementation does the same thing as you suggested.
>> We
>> wait for certain interval (5s for now, 10s proposed), and check if
>> ksm
>> values increased, if still changing, continue next sleep interval.
>> Adding a "wait-for-not-changing" in fact has the same effect as
>> increasing the original sleep time.
>>
>> theoretically, sleeping interval should be as larger as possible, but
>> it
>> will cost unnecessary running time if the interval is set too big in
>> the
>> this case. I'd say 10s is a "for-now-best-practice" during my several
>> running (both w/ and w/o pressure). Besides, I'm not sure how ksm
>> developers think of current ksm performance, but I think if ksmd
>> takes
>> more than 10s to merge two same pages, it will be a big performance
>> issue.
> 
> yes, I think so.
> 
> and 5s interval is enough, I tested it on several low-memory/dull systems
> during composing the patch, it's all OK.
> But in order to cover more different systems, IMO, I also proposed 10s,
> and it shouldn't be more bigger, or it will be a defect of ksm performance.

Ok, no objection.

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

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
