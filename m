Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SHtjx-0005lg-MV
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 09:21:25 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SHtjt-0005so-Te
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 09:21:25 +0000
Received: by mail-pb0-f47.google.com with SMTP id um15so1072841pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Apr 2012 02:21:21 -0700 (PDT)
References: <alpine.BSF.2.00.1204041735200.25027@toaster.local>
	<201204042152.56885.vapier@gentoo.org>
	<4F84F1E1.7000602@cn.fujitsu.com>
In-Reply-To: <4F84F1E1.7000602@cn.fujitsu.com>
Mime-Version: 1.0 (1.0)
Message-Id: <45B655E5-9D04-457E-ADD6-4B79761A3B68@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Wed, 11 Apr 2012 02:21:13 -0700
Subject: Re: [LTP] [PATCH 1/2] Clean up inotify(7) wrappers
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
To: "gaowanlong@cn.fujitsu.com" <gaowanlong@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

On Apr 10, 2012, at 7:52 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:

> On 04/05/2012 09:52 AM, Mike Frysinger wrote:
> 
>> On Wednesday 04 April 2012 20:38:31 Garrett Cooper wrote:
>>> +/*
>>> + * ``junk`` is needed to make the macro function like a void argument
>>> + * function.
>>> + */
>>> +#define    myinotify_init(junk)    syscall(__NR_inotify_init)
>> 
>> you lost me.  how does this make it work like a (void) func ?  i think this 
>> should drop the "junk" and just do:
>>    #define myinotify_init() ...
> 
> 
> Cooper,
> 
> Any update on what Mike said?

Simply put, his method is cleaner/better. I need to produce a new patch with his suggested change.

Thanks!
-Garrett

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
