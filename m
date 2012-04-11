Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SHtos-0002iA-FE
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 09:26:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SHtoo-0002F6-Fs
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 09:26:30 +0000
Message-ID: <4F854DFA.20704@cn.fujitsu.com>
Date: Wed, 11 Apr 2012 17:25:14 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <alpine.BSF.2.00.1204041735200.25027@toaster.local>
	<201204042152.56885.vapier@gentoo.org>
	<4F84F1E1.7000602@cn.fujitsu.com>
	<45B655E5-9D04-457E-ADD6-4B79761A3B68@gmail.com>
In-Reply-To: <45B655E5-9D04-457E-ADD6-4B79761A3B68@gmail.com>
Subject: Re: [LTP] [PATCH 1/2] Clean up inotify(7) wrappers
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

On 04/11/2012 05:21 PM, Garrett Cooper wrote:

> On Apr 10, 2012, at 7:52 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> 
>> On 04/05/2012 09:52 AM, Mike Frysinger wrote:
>>
>>> On Wednesday 04 April 2012 20:38:31 Garrett Cooper wrote:
>>>> +/*
>>>> + * ``junk`` is needed to make the macro function like a void argument
>>>> + * function.
>>>> + */
>>>> +#define    myinotify_init(junk)    syscall(__NR_inotify_init)
>>>
>>> you lost me.  how does this make it work like a (void) func ?  i think this 
>>> should drop the "junk" and just do:
>>>    #define myinotify_init() ...
>>
>>
>> Cooper,
>>
>> Any update on what Mike said?
> 
> Simply put, his method is cleaner/better. I need to produce a new patch with his suggested change.


That's great!

Thanks,
Wanlong Gao

> 
> Thanks!
> -Garrett
> 



------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
