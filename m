Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N2Sz3-0000RY-6S
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 17:03:53 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N2Syw-0008GI-Rr
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 17:03:52 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091023.203832.41091033407475231.yamato@redhat.com>
References: <20091023.203832.41091033407475231.yamato@redhat.com>
Date: Mon, 26 Oct 2009 22:32:53 +0530
Message-Id: <1256576573.4929.58.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [patch] Complete the test cases for geteuid16
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

On Fri, 2009-10-23 at 20:38 +0900, Masatake YAMATO wrote: 
> Another small patch to complete the test cases for *16.
> 
> Put compat_16.h to testcases/kernel/syscalls/geteuid.
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

Thanks YAMATO.

Regards--
Subrata

> plain text document attachment (compat_16.h)
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
> GETEUID(void)
> {
> 	return syscall(__NR_geteuid);
> }
> 
> #else
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
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


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
