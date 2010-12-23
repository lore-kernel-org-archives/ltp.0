Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PVfQ1-0002Jf-9b
	for ltp-list@lists.sourceforge.net; Thu, 23 Dec 2010 07:16:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PVfPz-0001RR-I2
	for ltp-list@lists.sourceforge.net; Thu, 23 Dec 2010 07:16:57 +0000
Message-ID: <4D12F6A1.6040701@cn.fujitsu.com>
Date: Thu, 23 Dec 2010 15:13:37 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <2128862333.62000.1293087724834.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2128862333.62000.1293087724834.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH]Fix building error.
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list@lists.sourceforge.net



CAI Qian wrote:
>> However, many people use the LTP to test their own linux system, if those kernel
>> is not support KSM, at least we should make sure they can build
>> successfully.
> In that case, why not use an older version?

 But how to choose the older version, it means which LTP is the better one?  ^_^
 And, maybe a new case is designed to test all versions of linux include the older one.

> 
> CAI Qian
> 
> 

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
