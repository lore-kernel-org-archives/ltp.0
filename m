Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UiJgd-0007O9-TQ
	for ltp-list@lists.sourceforge.net; Fri, 31 May 2013 07:23:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UiJgc-0004d0-D0
	for ltp-list@lists.sourceforge.net; Fri, 31 May 2013 07:23:43 +0000
Message-ID: <51A84F5A.9060708@cn.fujitsu.com>
Date: Fri, 31 May 2013 15:20:58 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51A5C347.4020202@cn.fujitsu.com>
	<1098836685.51729.1369819107988.JavaMail.root@redhat.com>
	<51A5D7A9.3070801@cn.fujitsu.com>
	<577470418.347391.1369824283490.JavaMail.root@redhat.com>
In-Reply-To: <577470418.347391.1369824283490.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach
 SHM_NORESERVE to shmflg
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 05/29/2013 06:44 PM, Jan Stancek wrote:
> 
> ----- Original Message -----
>> From: "DAN LI" <li.dan@cn.fujitsu.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: "LTP list" <ltp-list@lists.sourceforge.net>
>> Sent: Wednesday, 29 May, 2013 12:25:45 PM
>> Subject: Re: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach SHM_NORESERVE to shmflg
>>
>> On 05/29/2013 05:18 PM, Jan Stancek wrote:
>>>
>>> ----- Original Message -----
>>>> From: "DAN LI" <li.dan@cn.fujitsu.com>
>>>> To: "LTP list" <ltp-list@lists.sourceforge.net>
>>>> Sent: Wednesday, 29 May, 2013 10:58:47 AM
>>>> Subject: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach SHM_NORESERVE
>>>> to shmflg
>>>>
>>>>
>>>> 1. Remove useless comments
>>>>
>>>> 2. Revise code to follow ltp-code-style
>>>>
>>>> 3. Add SHM_NORESERVE to shmflg to test
>>>
>>> Can you add some description why you are adding this flag?
>>
>> Actually, we are trying to complete test cases and expand
>> the test scope of LTP.
>>
>> So, it is just for completeness of this case.
> 
> My concern here is:
> So if we add this flag, we cover SHM_NORESERVE path.
> Do we have a testcase which still covers current non-SHM_NORESERVE path?

Hi Jan,

Sorry for the late reply. :)

In my opinion, SHM_NORESERVE is an independent feature of others and should have
no effect on them, so we do not need a non-SHM_NORESERVE path.
They are like two branches of a river, one branch can do nothing on the other one,
but if either of them goes wrong, the river will get feedback.

And maybe, it's just what the author of this case considered since he tested
SHM_RW(S_IRUSR | S_IWUSR) together with IPC_CREAT | IPC_EXCL.


Regards,
DAN LI

> 
> Regards,
> Jan
> 

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
