Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SU8gG-0002ta-H2
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 03:44:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SU8gF-00007e-6C
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 03:44:12 +0000
Message-ID: <4FB1D0BA.1020301@cn.fujitsu.com>
Date: Tue, 15 May 2012 11:42:50 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <659b63f6-b191-4e73-84f7-37e33d4c9873@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <659b63f6-b191-4e73-84f7-37e33d4c9873@zmail13.collab.prod.int.phx2.redhat.com>
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 05/15/2012 11:18 AM, Zhouping Liu wrote:

> 
> 
> ----- Original Message -----
>> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> To: "ZhoupingLiu" <zliu@redhat.com>
>> Cc: "Caspar Zhang" <caspar@casparzhang.com>, "LTP List" <ltp-list@lists.sourceforge.net>
>> Sent: Tuesday, May 15, 2012 10:56:37 AM
>> Subject: Re: [LTP] ksm03
>>
>> On 04/05/2012 01:21 PM, ZhoupingLiu wrote:
>>
>>> On 04/05/2012 01:04 PM, Wanlong Gao wrote:
>>>> On 04/05/2012 01:00 PM, ZhoupingLiu wrote:
>>>>
>>>>> On 04/02/2012 02:56 PM, Wanlong Gao wrote:
>>>>>> Hi Caspar,
>>>>>>
>>>>>> Have you ever seen like below? It happens on ksm03,
>>>>>> the page_sharing numbers is always incorrect, it
>>>>>> occurs on RHEL7-Alpha, any ides?
>>>>> hi, Wanlong
>>>>>
>>>>> I caught this error, but it just only occurred in s390x,
>>>>> and not 100% occurred, I will check the reason.
>>>>> could you tell me which arches do you met the issue?
>>>>
>>>> Not fortunately, I met on x86_64 :(
>>>> and the case can't finish then.
>>>
>>> Okay, I'll dig it deeper, thanks for your info.
>>
>>
>> Got any idea? :-)
> 
> Wanlong, as the case is not always occurred in my testing boxes,
> I'm sorry I don't find the real reason now, but I'll speed up
> to find the murderer, if you have any info, please let me know :)


OK, can you test on RHEL7-Alpha1-x86_64 using below control file?
It may help you.

#cd /opt/ltp
#cat <<EOF > runtest/ksm
>ksm01 ksm01
>ksm01_1 ksm01 -u 128
>ksm02 ksm02
>ksm02_1 ksm02 -u 128
>ksm03 ksm03
>ksm03_1 ksm03 -u 128
>ksm04 ksm04
>ksm04_1 ksm04 -u 128
>ksm05 ksm05 -I 10
>EOF
#./runltp -f ksm

Thanks,
Wanlong Gao

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
