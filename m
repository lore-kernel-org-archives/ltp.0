Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PZCXU-0004at-K3
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 01:15:16 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZCXT-0007qD-PM
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 01:15:16 +0000
Received: by pvd12 with SMTP id 12so2434105pvd.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 01 Jan 2011 17:15:10 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4D199160.3070103@cn.fujitsu.com>
Date: Sat, 1 Jan 2011 17:15:16 -0800
Message-Id: <729F45BA-7F15-45FE-B300-E0BDECF4870C@gmail.com>
References: <4D199160.3070103@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]Fix bug of unshare
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Dec 27, 2010, at 11:27 PM, Bian Naimeng wrote:

> Fix two bugs of unshare01.
> 
> 1. We have test unshare(CLONE_FS) twice, the first one should be CLONE_FILES.
> 2. Child process forgot to invoke exit, it will cause test fail.

Thanks!
-Garrett


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
