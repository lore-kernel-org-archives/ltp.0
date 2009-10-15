Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MyRg6-0007v1-0I
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 14:51:42 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MyRft-0004B6-OI
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 14:51:36 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091014.192322.1139091462053274638.yamato@redhat.com>
References: <20091009.154445.548431512384017812.yamato@redhat.com>
	<1255445034.8438.71.camel@subratamodak.linux.ibm.com>
	<20091014.192322.1139091462053274638.yamato@redhat.com>
Date: Thu, 15 Oct 2009 20:21:11 +0530
Message-Id: <1255618271.5869.15.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Complete the test cases for getuid16
Reply-To: subrata@linux.vnet.ibm.com
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
To: Masatake YAMATO <yamato@redhat.com>
Cc: ltp-list@lists.sf.net

On Wed, 2009-10-14 at 19:23 +0900, Masatake YAMATO wrote: 
> Hi,
> 
> > Except the Makefile part, others would apply fine:
> > 
> > patching file testcases/kernel/syscalls/getuid/Makefile
> > Hunk #1 FAILED at 16.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > testcases/kernel/syscalls/getuid/Makefile.rej
> > patching file testcases/kernel/syscalls/getuid/getuid01.c
> > patching file testcases/kernel/syscalls/getuid/getuid02.c
> > patching file testcases/kernel/syscalls/getuid/getuid03.c
> 
> Sorry. I forgot to update my local copy.
> 
> I've just recreated the patch with newer build system.
> 
> To apply getuid-20091015.patch use -p0 option.
> Put compat_uid.h  at testcases/kernel/syscalls/utils/compat_uid.h.
> Put compat_16.h.  at testcases/kernel/syscalls/getuid/compat_16.h.
> 
> I've just modified Makefile since last submitting.
> 
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

Thanks.

Regards--
Subrata

> 
> plain text document attachment (compat_16.h)
> /*
>  *
>  *   Copyright (c) Red Hat Inc., 2008
>  *
>  *   This program is free software;  you can redistribute it and/or modify
>  *   it under the terms of the GNU General Public License as published by
>  *   the Free Software Foundation; either version 2 of the License, or
>  *   (at your option) any later version.
>  *
>  *   This program is distributed in the hope that it will be useful,
>  *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>  *   the GNU General Public License for more details.
>  *
>  *   You should have received a copy of the GNU General Public License
>  *   along with this program;  if not, write to the Free Software
>  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>  */
> 
> /* Author: Masatake YAMATO <yamato@redhat.com> */
> 
> #ifndef __GETUID_COMPAT_16_H__
> #define __GETUID_COMPAT_16_H__
> 
> 
> #include "linux_syscall_numbers.h"
> #include "compat_uid.h"
> 
> 
> #ifdef TST_USE_COMPAT16_SYSCALL
> 
> UID_T
> GETUID(void)
> {
> 	return syscall(__NR_getuid);
> }
> 
> UID_T
> GETEUID(void)
> {
> 	return syscall(__NR_geteuid);
> }
> 
> #else
> 
> UID_T
> GETUID(void)
> {
> 	return getuid();
> }
> 
> UID_T
> GETEUID(void)
> {
> 	return geteuid();
> }
> 
> #endif
> 
> #endif /* __GETUID_COMPAT_16_H__ */
> plain text document attachment (compat_uid.h)
> /*
>  *
>  *   Copyright (c) Red Hat Inc., 2009
>  *
>  *   This program is free software;  you can redistribute it and/or modify
>  *   it under the terms of the GNU General Public License as published by
>  *   the Free Software Foundation; either version 2 of the License, or
>  *   (at your option) any later version.
>  *
>  *   This program is distributed in the hope that it will be useful,
>  *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>  *   the GNU General Public License for more details.
>  *
>  *   You should have received a copy of the GNU General Public License
>  *   along with this program;  if not, write to the Free Software
>  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>  */
> 
> /* Author: Masatake YAMATO <yamato@redhat.com> */
> 
> #ifndef __COMPAT_UID_16_H__
> #define __COMPAT_UID_16_H__
> 
> 
> #include <asm/posix_types.h>
> 
> 
> #ifdef TST_USE_COMPAT16_SYSCALL
> typedef __kernel_old_uid_t UID_T;
> int 
> UID_SIZE_CHECK(uid_t uid)
> {
> 	/* See high2lowuid in linux/highuid.h
> 	   Return 0 if uid is too large to store
> 	   it to __kernel_old_uid_t. */
> 	return ((uid) & ~0xFFFF)? 0: 1;
> }
> 
> #else
> 
> typedef uid_t UID_T;
> int 
> UID_SIZE_CHECK(uid_t uid)
> {
> 	return 1;
> }
> 
> #endif
> 
> #endif /* __SETUID_COMPAT_16_H__ */


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
