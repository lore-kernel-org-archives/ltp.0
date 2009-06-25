Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJlrf-00034G-My
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:07:31 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJlrb-0007HY-6O
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:07:31 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906231038l233636ecy2af34d42a63b9031@mail.gmail.com>
References: <f5a7b3810906231038l233636ecy2af34d42a63b9031@mail.gmail.com>
Date: Thu, 25 Jun 2009 14:41:06 +0530
Message-Id: <1245921066.5542.52.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCHES] All patches
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Tue, 2009-06-23 at 23:08 +0530, naresh kamboju wrote: 
> Hi Subrata,
> 
> To make your job easy,
> I have attached following patched to fix system call number to
> __NR_syscall representation.
> You can commit all these patches.
> 

Ok, thanks.

Regards--
Subrata

> LIST:
> 
> ltp-fix-add_key.patch
> ltp-fix-bdflush.patch
> ltp-fix-keyctl.patch
> ltp-fix-newuname.patch
> ltp-fix-rt_sigprocmask.patch
> ltp-fix-rt_sigsuspend.patch
> ltp-fix-set_thread_area.patch
> ltp-fix-set_tid_address.patch
> ltp-fix-ssetmask.patch
> ltp-fix-tkill.patch
> 
> 
> Best regards
> Naresh Kamboju


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
