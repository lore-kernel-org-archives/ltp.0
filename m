Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi@firstfloor.org>) id 1MvQ6I-0003PA-UU
	for ltp-list@lists.sourceforge.net; Wed, 07 Oct 2009 06:34:14 +0000
Received: from one.firstfloor.org ([213.235.205.2])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MvQ6C-0005wa-KS
	for ltp-list@lists.sourceforge.net; Wed, 07 Oct 2009 06:34:14 +0000
From: Andi Kleen <andi@firstfloor.org>
Date: Wed, 07 Oct 2009 08:08:24 +0200
Message-ID: <87my43zqg7.fsf@basil.nowhere.org>
MIME-Version: 1.0
Subject: [LTP] ./testcases/kernel/hotplug/memory_hotplug in LTP vs memtoy
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
To: subrata@linux.vnet.ibm.com, ltp-list@lists.sf.net, Lee.Schermerhorn@hp.com


Subrata, Lee,

I was looking at 

ltp/testcases/kernel/hotplug/memory_hotplug/

in LTP and it seems to be just a outdated copy of Lee's memtoy NUMA tester, which 
does not really test any memory hotadd, just NUMA policies.

The ChangeLog just says

CPU and MEMORY HOTPLUG test cases picked up from http://devresources.linux-foundation.org/dev/hotplug/

Is there a real memory hotplug test somewhere or how is this intended to be used?

Thanks,
-Andi


-- 
ak@linux.intel.com -- Speaking for myself only.

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
