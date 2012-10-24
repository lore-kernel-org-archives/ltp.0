Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TQv1v-0006Qj-9Y
	for ltp-list@lists.sourceforge.net; Wed, 24 Oct 2012 07:05:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TQv1q-000873-GM
	for ltp-list@lists.sourceforge.net; Wed, 24 Oct 2012 07:05:31 +0000
Message-ID: <508792B4.1050101@cn.fujitsu.com>
Date: Wed, 24 Oct 2012 15:03:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <953803847.5389852.1351060988163.JavaMail.root@redhat.com>
In-Reply-To: <953803847.5389852.1351060988163.JavaMail.root@redhat.com>
Subject: Re: [LTP] Regarding shmat01 syscall test
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
Cc: ltp-list@lists.sourceforge.net

On 10/24/2012 02:43 PM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> To: "Om Prakash PAL" <omprakash.pal@stericsson.com>
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 24 October, 2012 2:45:47 AM
>> Subject: Re: [LTP] Regarding shmat01 syscall test
>>
>> On 10/23/2012 06:05 PM, Om Prakash PAL wrote:
>>>
>>>
>>> -----Original Message-----
>>> From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com]
>>> Sent: Tuesday, October 23, 2012 3:07 PM
>>> To: Om Prakash PAL
>>> Cc: ltp-list@lists.sourceforge.net
>>> Subject: Re: [LTP] Regarding shmat01 syscall test
>>>
>>> On 10/23/2012 05:24 PM, Om Prakash PAL wrote:
>>>> Hi,
>>>>
>>>> I am working on syscall test:  shmat01.c
>>>>
>>>> I have some confusion:
>>>>
>>>>  
>>>>
>>>> In setup() : it is  allocating shared memory by shmget() and then
>>>> attaching by shmat() and after  that detaching the attached
>>>> address (i.e. shmdt())
>>>>
>>>>  
>>>>
>>>>         if (shmdt((const void *)base_addr) == -1) {
>>>>
>>>>                 tst_brkm(TBROK, cleanup, "Couldn't detach shared
>>>>                 memory");
>>>>
>>>>         }
>>>>
>>>>  
>>>>
>>>> And again in main function it is using same "base_addr" as
>>>> attaching address,
>>>>
>>>>  
>>>>
>>>> addr = shmat(*(TC[i].shmid), base_addr+TC[i].offset,
>>>>
>>>>                                      TC[i].flags);
>>>>
>>>> how can we ensure(100%) that base_addr (virtual) will be free till
>>>> this point for attaching?.
>>>
>>> Maybe we can't, but I didn't see any fail on this. Did you see any
>>> testing failure here?
>>>
>>> Yes, I got some failure and the reason of failure is : the address
>>> at which we want to attach is busy.
>>
>> OK, please feel free to send a patch, or can you tell us how to
>> reproduce it?
> 
> I recall I could reproduce it, if I added single printf:
> http://article.gmane.org/gmane.linux.ltp/16480

Do you get a solution? Send out a patch?


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
