Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TYYGt-00026B-SF
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 08:24:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TYYGp-0005OZ-Rz
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 08:24:31 +0000
Message-ID: <50A3550A.9040609@cn.fujitsu.com>
Date: Wed, 14 Nov 2012 16:23:38 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1352705641-27644-1-git-send-email-jin.li@windriver.com>
	<1352705641-27644-3-git-send-email-jin.li@windriver.com>
In-Reply-To: <1352705641-27644-3-git-send-email-jin.li@windriver.com>
Subject: Re: [LTP] [PATCH 2/3] Fix cpuhotplug test case cpuhotplug03
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

On 11/12/2012 03:34 PM, jin.li@windriver.com wrote:
> From: Jin Li <jin.li@windriver.com>
> 
> Fix test case cpuhotplug03 as follows:
> 1. Avoid to check whether the cpu0 is on.
> 2. Check the cpu before turn it on


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
