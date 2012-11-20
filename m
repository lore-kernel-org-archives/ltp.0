Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TadVv-0001rp-Rx
	for ltp-list@lists.sourceforge.net; Tue, 20 Nov 2012 02:24:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TadVu-00065h-IU
	for ltp-list@lists.sourceforge.net; Tue, 20 Nov 2012 02:24:39 +0000
Message-ID: <50AAE9A6.6000300@cn.fujitsu.com>
Date: Tue, 20 Nov 2012 10:23:34 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <6c96a49f0109d33e28d1222f5f87dcca45c9c272.1352885663.git.jstancek@redhat.com>
In-Reply-To: <6c96a49f0109d33e28d1222f5f87dcca45c9c272.1352885663.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] waitpid02: avoid core file
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 11/14/2012 05:36 PM, Jan Stancek wrote:
> Depending on configuration this testcase may create core
> file with various location and name. The signal causing
> core dump is here by design so this core file isn't interesting.
> 
> Avoid this core file by setting RLIMIT_CORE to 1.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

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
