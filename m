Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MJmDt-0005gS-4K
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:30:29 +0000
Received: from mail-gx0-f218.google.com ([209.85.217.218])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJmDs-0004Zx-9t
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:30:29 +0000
MIME-Version: 1.0
In-Reply-To: <1245921066.5542.52.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810906231038l233636ecy2af34d42a63b9031@mail.gmail.com>
	<1245921066.5542.52.camel@subratamodak.linux.ibm.com>
Date: Thu, 25 Jun 2009 16:00:27 +0530
Message-ID: <f5a7b3810906250330u2ba9b08dq847d531093714055@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [FIX PATCHES] All patches
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Mike Frysinger <vapier@gentoo.org>, Jiri Palecek <jpalecek@web.de>

Hi Subrata,

You may get patch conflict for ltp-fix-set_thread_area.patch

Because there is one more patch from Jiri Palecek
[PATCH] Use present autoconf test for asm/ldt.h in set_thread_area*
tests to prevent build failures (Jiri Palecek >)

Please review the same.
If you have any issue please let me know.


Best regards
Naresh Kamboju


On Thu, Jun 25, 2009 at 2:41 PM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> On Tue, 2009-06-23 at 23:08 +0530, naresh kamboju wrote:
>> Hi Subrata,
>>
>> To make your job easy,
>> I have attached following patched to fix system call number to
>> __NR_syscall representation.
>> You can commit all these patches.
>>
>
> Ok, thanks.
>
> Regards--
> Subrata
>
>> LIST:
>>
>> ltp-fix-add_key.patch
>> ltp-fix-bdflush.patch
>> ltp-fix-keyctl.patch
>> ltp-fix-newuname.patch
>> ltp-fix-rt_sigprocmask.patch
>> ltp-fix-rt_sigsuspend.patch
>> ltp-fix-set_thread_area.patch
>> ltp-fix-set_tid_address.patch
>> ltp-fix-ssetmask.patch
>> ltp-fix-tkill.patch
>>
>>
>> Best regards
>> Naresh Kamboju
>
>

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
