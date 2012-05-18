Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cyeoh@au1.ibm.com>) id 1SVIfJ-0004H7-Ml
	for ltp-list@lists.sourceforge.net; Fri, 18 May 2012 08:36:01 +0000
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SVIfE-000849-1Q
	for ltp-list@lists.sourceforge.net; Fri, 18 May 2012 08:36:01 +0000
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <cyeoh@au1.ibm.com>;
	Fri, 18 May 2012 08:30:32 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q4I8SOid3146136
	for <ltp-list@lists.sourceforge.net>; Fri, 18 May 2012 18:28:24 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	q4I8ZaFF004869
	for <ltp-list@lists.sourceforge.net>; Fri, 18 May 2012 18:35:36 +1000
Date: Fri, 18 May 2012 18:05:34 +0930
From: Christopher Yeoh <cyeoh@au1.ibm.com>
Message-ID: <20120518180534.088a07b2@Gantu>
In-Reply-To: <4f473639-dcf2-43c7-ba27-be826fbb81d2@zmail17.collab.prod.int.phx2.redhat.com>
References: <4FAA6A83.8010100@casparzhang.com>
	<4f473639-dcf2-43c7-ba27-be826fbb81d2@zmail17.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Simple tests for cross memory attach
 (process_vm_[readv|writev] syscalls)
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
To: Jan Stancek <jstancek@redhat.com>, Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 15 May 2012 10:56:17 -0400 (EDT)
Jan Stancek <jstancek@redhat.com> wrote:
> 
> Hi,
> 
> I looked at testcases sent by Chris. Good news is, they
> do not overlap (in terms of functionality) with mine :-).
> 
> The patch need some polishing to match the style guide:
> - indentation
> - I think output should be TINFO, rather than plain printf
> - single statement if without { }
> - I would split some code to more functions, for example
> process_vm_writev01.c main function seems complex

Thanks for the feedback. I'll have a go at reworking them.

> As for test organization, I think we need to decide 2 issues:
> 1. directory structure
> a)
>   testcases/kernel/syscalls/cma/
>   testcases/kernel/syscalls/cma/process_vm_readv
>   testcases/kernel/syscalls/cma/process_vm_writev
> b)
>   testcases/kernel/syscalls/process_vm_readv
>   testcases/kernel/syscalls/process_vm_writev
> 
> I'm preferring a) as these 2 syscalls are closely related,
> and we already have need to share code.

that would be fine with me.

> 2. how to invoke new syscalls
> a)
> Patch from Chris is defining new syscall numbers in test and
> using syscall(2).
> 
> b)
> My patch adds configure check for glibc wrappers
> process_vm_readv/writev and if those does not exists it checks for
> __NR_process_vm_readv.
> 
> I think we should not define syscall numbers in tests directly,
> but I'm relying on LTP maintainers to provide guidance here.

I agree - the configure check is much better. I was just trying to get
something working :-)

Regards,

Chris
-- 
cyeoh@au.ibm.com

-- 
cyeoh@au.ibm.com


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
