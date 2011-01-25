Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PhZKZ-0003rE-3o
	for ltp-list@lists.sourceforge.net; Tue, 25 Jan 2011 03:12:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhZKX-0008Qt-3s
	for ltp-list@lists.sourceforge.net; Tue, 25 Jan 2011 03:12:31 +0000
Message-ID: <4D3E3F6C.9060808@cn.fujitsu.com>
Date: Tue, 25 Jan 2011 11:11:40 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <000001cb96a5$12026c30$36074490$@co.jp>	<4D3D4D36.1030002@cn.fujitsu.com>
	<AANLkTinUjNU4z9GBqv=Mvf2vZF-0VTNzFDa89K_X3P7B@mail.gmail.com>
In-Reply-To: <AANLkTinUjNU4z9GBqv=Mvf2vZF-0VTNzFDa89K_X3P7B@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix "sched_getparam/6-1" and
 "sched_getscheduler/7-1" tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, =?UTF-8?B?55W25bqnIOWBpeW4gg==?= <toza@ryobi.co.jp>, Mitani <mitani@ryobi.co.jp>



Garrett Cooper wrote:
> On Mon, Jan 24, 2011 at 1:58 AM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
>>
>> Mitani wrote:
>>> Hi,
>>>
>>>
>>> Following POSIX testsets failed:
>>> ------------
>>> conformance/interfaces/sched_getparam/6-1: execution: FAILED: Output:
>>> Testing with user 'bin' (euid: 1)(uid: 1)
>>> The function sched_getparam has successed.
>>> ------------
>>>
>>> ------------
>>> conformance/interfaces/sched_getscheduler/7-1: execution: FAILED: Output:
>>> Testing with user 'bin' (uid: 1)
>>> The function sched_getscheduler has successed.
>>> ------------
>>>
>>> The environments are as follows:
>>>   - RHEL4.8 --- (x86, x86_64, ia64)
>>>   - kernel  --- kernel-2.6.9-89.EL
>>>   - glibc   --- glibc-2.3.4-2.43
>>>
>>>   - RHEL5.5 --- (x86, x86_64, ia64)
>>>   - kernel  --- kernel-2.6.18-194.el5
>>>   - glibc   --- glibc-2.5-49
>>>
>>>
>>> They are permission tests.
>>>
>>> The comment of "sched_getparam/6-1" testset source is as follows:
>>> ------------
>>>   * On Linux, e.g, the kernel makes no check on user permission to call this
>>>   * API. So basically we don't know on what condition a system should return
>>>   * EPERM. It is implementation defined.
>>> ------------
>>>
>> Hi Garrett,
>>
>>  I think it's better to report UNRESOLVED, whatever the os is.
> 
>     It's not implementation defined according to 2008.1, and it's flat
> out a requirement failure (not UNRESOLVED):
> 
> The sched_getparam() function shall fail if:
> 
> [EPERM]
>     The requesting process does not have permission to obtain the
> scheduling parameters of the specified process.
> 
> `shall' -> `must' in POSIX terms.

Thanks very much for telling me this information.

But the spec does not point out the what condition a process does not
have permission to do it.

> 
>     The test is incorrect because it fails to setgid the group to the
> non-root user's group.

Ditto.

The POSIX spec does not point out non-root user(non-root group too) does not
have permission to obtain the scheduling parameters of the init process.

Maybe i miss something. If so, please tell me, thanks very much.

Thanks
 Bian

> Thanks,
> -Garrett
> 
> 

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
