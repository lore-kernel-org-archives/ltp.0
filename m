Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Lee.Schermerhorn@hp.com>) id 1Mvuvp-0005uN-Ph
	for ltp-list@lists.sourceforge.net; Thu, 08 Oct 2009 15:29:29 +0000
Received: from g1t0026.austin.hp.com ([15.216.28.33])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mvuvj-0006vx-8r
	for ltp-list@lists.sourceforge.net; Thu, 08 Oct 2009 15:29:29 +0000
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
In-Reply-To: <87my43zqg7.fsf@basil.nowhere.org>
References: <87my43zqg7.fsf@basil.nowhere.org>
Date: Thu, 08 Oct 2009 11:29:12 -0400
Message-Id: <1255015752.9520.84.camel@useless.americas.hpqcorp.net>
Mime-Version: 1.0
Subject: Re: [LTP] ./testcases/kernel/hotplug/memory_hotplug in LTP vs memtoy
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
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sf.net

On Wed, 2009-10-07 at 08:08 +0200, Andi Kleen wrote:
> Subrata, Lee,
> 
> I was looking at 
> 
> ltp/testcases/kernel/hotplug/memory_hotplug/
> 
> in LTP and it seems to be just a outdated copy of Lee's memtoy NUMA tester, which 
> does not really test any memory hotadd, just NUMA policies.


Hi, Andi:

Yes, memtoy is really just a tool for making ad hoc calls to various vm
system calls to create/map/mbind/mlock/... memory areas--as you say, for
testing NUMA policies and such.  There is a newer version at:

http://free.linux.hp.com/~lts/Tools/memtoy-latest.tar.gz


> 
> The ChangeLog just says
> 
> CPU and MEMORY HOTPLUG test cases picked up from http://devresources.linux-foundation.org/dev/hotplug/
> 
> Is there a real memory hotplug test somewhere or how is this intended to be used?
> 

Took a look at that page.  Still says "OSDL" :).   Don't know whether
those are "real" memory hotplug tests or whether others exist.

Regards,
Lee


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
