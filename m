Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NJ6R9-0005p1-1v
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 14:25:39 +0000
Received: from mail-yw0-f175.google.com ([209.85.211.175])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NJ6R3-0002LC-LU
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 14:25:39 +0000
Received: by ywh5 with SMTP id 5so1761026ywh.11
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Dec 2009 06:25:28 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1429667615.6061260277679532.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Fri, 11 Dec 2009 06:25:24 -0800
Message-Id: <CECC7627-B7D9-4402-8BFC-5CEB883F916B@gmail.com>
References: <1429667615.6061260277679532.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
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
To: Caspar Zhang <czhang@redhat.com>
Cc: yali_ning <yali_ning@126.com>, Mike Frysinger <vapier@gentoo.org>, ltp-list@lists.sourceforge.net

On Dec 8, 2009, at 5:07 AM, Caspar Zhang wrote:

> 
> ----- "Mike Frysinger" <vapier@gentoo.org> wrote:
> 
>> On Thursday 12 November 2009 01:20:37 yali_ning wrote:
>>>  I came across an error , when compiling the ltp-20091030. the step
>> is :
>>> 
>>> gcc -Wall -g -Os -g -O2 -fno-strict-aliasing -pipe -Wall 
>>> 
>> -I/mnt/sdb1/nly1/ltp-1030/ltp-full-20091031/testcases/kernel/include
>>> -I../../../../include -I../../../../include   -L../../../../lib 
>> vfork.c  
>>> -lltp -o vfork In file included from /usr/include/asm/ptrace.h:58,
>>>                 from /usr/include/linux/ptrace.h:49,
>>>                 from vfork.c:45:
>>> /usr/include/asm/fpu.h:57: error: redefinition of 'struct
>> ia64_fpreg'
>>> In file included from /usr/include/linux/ptrace.h:49,
>>>                 from vfork.c:45:
>>> /usr/include/asm/ptrace.h:208: error: redefinition of 'struct
>>> pt_all_user_regs'
>> 
>> this should be fixed already in latest cvs
>> -mike
> No, I tried to install latest cvs version under RHEL5.4 on a ia64
> machine but the same error still existed.
> 
> What puzzled me is, it said it was the redefinition-error, but I 
> couldn't even find the originally defined structs.

    The definition exists in /usr/include/asm*/ptrace.h, or maybe your build is fubared and you're referencing legitimate kernel source headers instead of system headers. We'd need more details in order to determine what's going on here...
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
