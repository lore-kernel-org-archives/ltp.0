Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SV1fW-0007Cm-5b
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 14:27:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SV1fT-0003f4-TH
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 14:27:06 +0000
Message-ID: <4FB50AAB.8020002@redhat.com>
Date: Thu, 17 May 2012 16:26:51 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <4f473639-dcf2-43c7-ba27-be826fbb81d2@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4f473639-dcf2-43c7-ba27-be826fbb81d2@zmail17.collab.prod.int.phx2.redhat.com>
Content-Type: multipart/mixed; boundary="------------030709000806060000040703"
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>, Christopher Yeoh <cyeoh@au1.ibm.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030709000806060000040703
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/15/2012 04:56 PM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> From: "Caspar Zhang" <caspar@casparzhang.com>
>> To: "Christopher Yeoh" <cyeoh@au1.ibm.com>
>> Cc: ltp-list@lists.sourceforge.net, "Jan Stancek" <jstancek@redhat.com>
>> Sent: Wednesday, 9 May, 2012 3:00:51 PM
>> Subject: Re: [LTP] [PATCH] Simple tests for cross memory attach (process_vm_[readv|writev] syscalls)
>> Hi Chris, thanks very much for the patch, I tried to backport your
>> testcases in http://ozlabs.org/~cyeoh/cma/ to LTP and composed an
>> unfinished version, then I was busy for other things. I'm happy to
>> see
>> you can backport it by yourself :) There are some more new cma
>> patches
>> (aims on testing retcode and errnos) sent by Jan Stancek (cc-ed) [1],
>> I
>> think we need to discuss the testcase organization..
>>
>> And I will review the testcases when I get more free time.
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
> - I would split some code to more functions, for example process_vm_writev01.c
>   main function seems complex
> 
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
> 
> 2. how to invoke new syscalls
> a)
> Patch from Chris is defining new syscall numbers in test and
> using syscall(2).
> 
> b)
> My patch adds configure check for glibc wrappers process_vm_readv/writev
> and if those does not exists it checks for __NR_process_vm_readv.
> 
> I think we should not define syscall numbers in tests directly,
> but I'm relying on LTP maintainers to provide guidance here.
> In any case, if you run it on older kernel it should end with TCONF.
> 
> I would go with using Chris' process_vm.h, but remove syscall number
> defines and use names that wont conflict with glibc wrappers:
> test_process_vm_readv
> test_process_vm_writev
> 
> These could be function pointers, that would get initialized with
> function using glibc wrapper
> function using syscall(__NR_process_vm_readv,..)
> or NULL
> 
> each testcase could check in setup for NULL, and end with TCONF,
> if there is no way invoke that syscall.
> 
> There was question from Caspar, if we should check for both glibc wrapper
> and syscall number (http://thread.gmane.org/gmane.linux.ltp/16055).
> I think we should, as we use glibc wrappers by default.
> 
> Any thoughts?

I'm attaching sample process_vm.h for illustration.
This would go on top of:
http://thread.gmane.org/gmane.linux.ltp/16053
http://thread.gmane.org/gmane.linux.ltp/16054

each test would include that, check ltp_process_vm_readv/writev for NULL
and optionally end with TCONF or continue.

Regards,
Jan

> 
> Regards,
> Jan
> 
>>
>> Thanks,
>> Caspar
>>
>> [1]
>> http://thread.gmane.org/gmane.linux.ltp/16052
>> http://thread.gmane.org/gmane.linux.ltp/16053
>> http://thread.gmane.org/gmane.linux.ltp/16054
>> http://thread.gmane.org/gmane.linux.ltp/16055
>>


--------------030709000806060000040703
Content-Type: text/x-chdr;
 name="process_vm.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="process_vm.h"

/*
 * Copyright (C) 2012 Linux Test Project, Inc.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of version 2 of the GNU General Public
 * License as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it would be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * Further, this software is distributed without any warranty that it
 * is free of the rightful claim of any third person regarding
 * infringement or the like.  Any license provided herein, whether
 * implied or otherwise, applies only to this software file.  Patent
 * licenses, if any, provided herein do not apply to combinations of
 * this program with other software, or any other product whatsoever.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301, USA.
 */

#ifndef _PROCESS_VM_H_
#define _PROCESS_VM_H_

#include <sys/syscall.h>
#include <sys/uio.h>
#include <unistd.h>

#define CMA_PARAMS pid, lvec, liovcnt, rvec, riovcnt, flags
#define CMA_PARAMS_TYPES pid_t pid, const struct iovec *lvec, unsigned long liovcnt,\
        const struct iovec *rvec, unsigned long riovcnt, unsigned long flags
#define CMA_FUNC_PROTO(func_name) ssize_t func_name(CMA_PARAMS_TYPES)
#define CMA_FUNCP_PROTO(func_name) ssize_t (*func_name)(CMA_PARAMS_TYPES)

/* 
 * process_vm_readv 
 */
#if (HAVE_PROCESS_VM_READV==1)
static inline CMA_FUNC_PROTO(ltp_process_vm_readv)
{
    return process_vm_readv(CMA_PARAMS);
}
#elif defined(__NR_process_vm_readv)
static inline CMA_FUNC_PROTO(ltp_process_vm_readv)
{
    return syscall(__NR_process_vm_readv, CMA_PARAMS);
}
#else
CMA_FUNCP_PROTO(ltp_process_vm_readv) = NULL;
#endif

/* 
 * process_vm_writev 
 */
#if (HAVE_PROCESS_VM_WRITEV==1)
static inline CMA_FUNC_PROTO(ltp_process_vm_writev)
{
    return process_vm_writev(CMA_PARAMS);
}
#elif defined(__NR_process_vm_writev)
static inline CMA_FUNC_PROTO(ltp_process_vm_writev)
{
    return syscall(__NR_process_vm_writev, CMA_PARAMS);
}
#else
CMA_FUNCP_PROTO(ltp_process_vm_writev) = NULL;
#endif

#endif /* _PROCESS_VM_H_ */

--------------030709000806060000040703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------030709000806060000040703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030709000806060000040703--

