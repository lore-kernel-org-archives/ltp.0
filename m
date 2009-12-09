Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NIHIB-0001h5-MZ
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 07:48:59 +0000
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NIHI5-0005oc-AV
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 07:48:59 +0000
Received: by yxe40 with SMTP id 40so2608305yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Dec 2009 23:48:48 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <000001ca78a2$93fd5a50$bbf80ef0$@co.jp>
Date: Tue, 8 Dec 2009 23:48:45 -0800
Message-Id: <7F8A730D-2350-4FB1-8A5A-F37B8CFABFE9@gmail.com>
References: <000001ca78a2$93fd5a50$bbf80ef0$@co.jp>
Subject: Re: [LTP] make error
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Dec 8, 2009, at 11:38 PM, Mitani wrote:

> Hi,
> 
> Sorry, I don't know how to response to following thread:
> "http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08965.html"
> but I want to comment it:
> 
> 
>>> On Thursday 12 November 2009 01:20:37 yali_ning wrote:
>>>> I came across an error , when compiling the ltp-20091030. the step
>>> is :
>>>> 
>>>> gcc -Wall -g -Os -g -O2 -fno-strict-aliasing -pipe -Wall 
>>>> 
>>> -I/mnt/sdb1/nly1/ltp-1030/ltp-full-20091031/testcases/kernel/include
>>>> -I../../../../include -I../../../../include -L../../../../lib 
>>> vfork.c 
>>>> -lltp -o vfork In file included from /usr/include/asm/ptrace.h:58,
>>>> from /usr/include/linux/ptrace.h:49,
>>>> from vfork.c:45:
>>>> /usr/include/asm/fpu.h:57: error: redefinition of 'struct
>>> ia64_fpreg'
>>>> In file included from /usr/include/linux/ptrace.h:49,
>>>> from vfork.c:45:
>>>> /usr/include/asm/ptrace.h:208: error: redefinition of 'struct
>>>> pt_all_user_regs'
>>> 
>>> this should be fixed already in latest cvs
>>> -mike
>> No, I tried to install latest cvs version under RHEL5.4 on a ia64
>> machine but the same error still existed.
>> 
>> What puzzled me is, it said it was the redefinition-error, but I 
>> couldn't even find the originally defined structs.
>> 
>> Thanks,
>> Caspar 
> 
> 
> ============
> 
> 
> Well, I think that the report that Caspar says is right.
> 
> I tried to "make" with "ltp-2009-12-08" version 
> in RHEL5.4 (kernel 2.6.18-164.el5) and ia64 architecture, too.
> But it output the error message same as Caspar's report
> and ended in failure.
> 
> And same failure occurred in "ltp-full-20091031.tgz" version, too.
> 
> I tried various versions until now.
> 
>       LTP version       ---  error occurred in...
> ---------------------------------------------------------------------
>  (1)  ltp-full-20091031 ---  "vfork.c" (This failure)
>  (2)  ltp-2009-11-17    ---  "vfork.c" (Resembles this failure)
>  (3)  ltp-2009-11-19    ---  "vfork.c" (Resembles this failure)
>  (4)  ltp-2009-11-24    ---  "vfork.c" (Resembles this failure)
>  (5)  ltp-2009-11-26    ---  "vfork.c" (Resembles this failure)
>  (6)  ltp-2009-11-27    ---  "pidns03.c" (Before than this failure)
>  (7)  ltp-2009-11-30    ---  "pidns03.c" (Before than this failure)
>  (8)  ltp-2009-12-01    ---  "libclone.c" (Before than this failure)
>  (9)  ltp-2009-12-02    ---  "libclone.c" (Before than this failure)
>  (10) ltp-full-20091130 ---  "libclone.c" (Before than this failure)
>  (11) ltp-2009-12-07    ---  "vfork.c" (This failure)
>  (12) ltp-2009-12-08    ---  "vfork.c" (This failure)

I'm making multiple versioned copies of Fedora based toolchains and sysroots to work around these issues, as I don't have a toolchain setup for ia64, nor do I have real hardware to compile on. Really counterproductive when trying to resolve these issues :(...

I'll try and get them all panned out by the weekend.

Thanks,
-Garrett
------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
