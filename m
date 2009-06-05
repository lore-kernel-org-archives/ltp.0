Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <iwamatsu.nobuhiro@renesas.com>) id 1MCNiK-0006AU-D1
	for ltp-list@lists.sourceforge.net; Fri, 05 Jun 2009 00:55:20 +0000
Received: from mail.renesas.com ([202.234.163.13] helo=mail02.idc.renesas.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MCNiF-0002rx-FL
	for ltp-list@lists.sourceforge.net; Fri, 05 Jun 2009 00:55:20 +0000
Date: Fri, 05 Jun 2009 09:41:03 +0900
From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
In-reply-to: <200906040418.12742.vapier@gentoo.org>
Message-id: <4A28699F.3040702@renesas.com>
MIME-version: 1.0
References: <4A277665.1080402@renesas.com>
	<200906040418.12742.vapier@gentoo.org>
Subject: Re: [LTP] [RFC][PATCH] Add cpu architecrute check
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi,

Mike Frysinger wrote:
> On Thursday 04 June 2009 03:23:17 Nobuhiro Iwamatsu wrote:
>> --- a/Makefile
>> +++ b/Makefile
>> +ifndef ARCH
>> +# copy from Makefile in linux kernel
>> +ARCH := $(shell uname -m
> 
> executing uname to detect build/target systems is never acceptable.

I see.

> 
>> --- a/testcases/kernel/syscalls/fallocate/Makefile
>> +++ b/testcases/kernel/syscalls/fallocate/Makefile
>> @@ -20,8 +20,14 @@
>>  CFLAGS += -I../../../../include -Wall
>>  LDLIBS += -L../../../../lib -lltp
>>
>> +# This system call is suported in i386, x86_64 and ppc only.
>> +ifneq (,$(findstring $(ARCH), i386 x86_64 ppc))
>>  SRCS    = $(wildcard *.c)
>>  TARGETS = $(patsubst %.c,%,$(SRCS))
>> +else
>> +SRCS    =
>> +TARGETS =
>> +endif
> 
> atm, better to put the ifdef logic into the test itself.  look at some of the 
> other tests that get stubbed out in the syscalls dir.
I see, again.
I check your point and Subrata's patch.
Thank you.

Best regards,
 Nobuhiro


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
