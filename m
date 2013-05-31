Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UiJkr-0002Fs-9P
	for ltp-list@lists.sourceforge.net; Fri, 31 May 2013 07:28:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UiJkp-00052Q-7r
	for ltp-list@lists.sourceforge.net; Fri, 31 May 2013 07:28:05 +0000
Message-ID: <51A85062.7080406@cn.fujitsu.com>
Date: Fri, 31 May 2013 15:25:22 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51A5C347.4020202@cn.fujitsu.com>
	<1098836685.51729.1369819107988.JavaMail.root@redhat.com>
	<51A5D7A9.3070801@cn.fujitsu.com>
	<51A5E61E.7000405@casparzhang.com>
In-Reply-To: <51A5E61E.7000405@casparzhang.com>
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 05/29/2013 07:27 PM, Caspar Zhang wrote:
> On 05/29/2013 06:25 PM, DAN LI wrote:
>> On 05/29/2013 05:18 PM, Jan Stancek wrote:
>>>
>>> ----- Original Message -----
>>>> From: "DAN LI" <li.dan@cn.fujitsu.com>
>>>> To: "LTP list" <ltp-list@lists.sourceforge.net>
>>>> Sent: Wednesday, 29 May, 2013 10:58:47 AM
>>>> Subject: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach SHM_NORESERVE to shmflg
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
> Would it be better to split the code-style fix and the functional/feature part?

Agree.

Coming V2 will make it.

Regards,
DAN LI
> 
> Caspar
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
