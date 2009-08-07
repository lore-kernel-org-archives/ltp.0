Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MZPHa-0003Y1-Ji
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 13:14:54 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZPHU-0007oT-Bm
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 13:14:54 +0000
Message-Id: <2A1B6719-9C0B-4271-8A81-1730F79F5E33@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <364299f40908061017g44fd05ecv9c6454ebf04badb4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Fri, 7 Aug 2009 08:14:38 -0500
References: <1842FA33-8C6C-4BE1-8FB4-B8836F1C8F6E@kernel.crashing.org>
	<364299f40908061017g44fd05ecv9c6454ebf04badb4@mail.gmail.com>
Subject: Re: [LTP] RANLIB not set?
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP <ltp-list@lists.sourceforge.net>


On Aug 6, 2009, at 12:17 PM, Garrett Cooper wrote:

> On Thu, Aug 6, 2009 at 9:18 AM, Kumar  
> Gala<galak@kernel.crashing.org> wrote:
>> I'm seeing this on fedora 11 on ppc64:
>>
>> make[3]: Leaving directory `/root/ltp/testcases/network/ipv6'
>> make[3]: Entering directory `/root/ltp/testcases/network/lib6'
>> cc -Wall  -I../../../include -g -D_GNU_SOURCE   -c -o runcc.o runcc.c
>> ar cr runcc.a runcc.o
>> runcc.a
>> make[3]: runcc.a: Command not found
>> make[3]: *** [runcc.a] Error 127
>> make[3]: Leaving directory `/root/ltp/testcases/network/lib6'
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory `/root/ltp/testcases/network'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/root/ltp/testcases'
>> make: *** [all] Error 2
>>
>> - k
>
>    Make sure to export CROSS_COMPILER=1 at the top-level make, or
> define RANLIB=$(CROSS_COMPILE)ranlib, where $(CROSS_COMPILE) is the
> prefix for your compiler set, e.g. $(CROSS_COMPILE)gcc.
>    One of the many things that will be fixed in a more kosher manner
> in the next couple months.
> Thanks,
> -Garrett

I see you committed a change to the lib6/Makefile for ranlib.  I  
believe we need a similar patch to the toplevel Makefile since it  
exports RANLIB:

diff --git a/Makefile b/Makefile
index 953eddf..9f8056a 100644
--- a/Makefile
+++ b/Makefile
@@ -9,6 +9,8 @@ AR=$(CROSS_COMPILER)ar
  RANLIB=$(CROSS_COMPILER)ranlib
  endif

+RANLIB         ?= ranlib
+
  HAS_NUMA=$(shell sh tools/scripts/numa_test.sh)

  export CFLAGS += -Wall $(CROSS_CFLAGS)


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
