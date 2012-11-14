Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TYYGY-00065h-FY
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 08:24:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TYYGT-0000GD-VE
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 08:24:10 +0000
Message-ID: <50A354EF.2080900@cn.fujitsu.com>
Date: Wed, 14 Nov 2012 16:23:11 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1352879855-18742-1-git-send-email-jin.li@windriver.com>
	<1352879855-18742-2-git-send-email-jin.li@windriver.com>
In-Reply-To: <1352879855-18742-2-git-send-email-jin.li@windriver.com>
Subject: Re: [LTP] [V2] [PATCH] Fix cpuhotplug test case cpuhotplug01
Reply-To: gaowanlong@cn.fujitsu.com
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
To: jin.li@windriver.com
Cc: ltp-list@lists.sourceforge.net

On 11/14/2012 03:57 PM, jin.li@windriver.com wrote:
> From: Jin Li <jin.li@windriver.com>
> 
> Fix for case cpuhotplug01:
> 
> 1. Give all available parameters to function migrate_irq.
> 2. Add the INFO note for the IRQ whose IRQ affinity is NOT permitted to changed.
> 3. Remove the variable cpustate and related code in function do_clean. The cpu,
> which was off before the test start, has been closed correctly in do_clean.
> 4. Add test case PASS at the end of the passed case


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
