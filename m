Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PVqnc-000460-RA
	for ltp-list@lists.sourceforge.net; Thu, 23 Dec 2010 19:26:04 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PVqnc-0002dE-1h
	for ltp-list@lists.sourceforge.net; Thu, 23 Dec 2010 19:26:04 +0000
Received: by pwi8 with SMTP id 8so529396pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 23 Dec 2010 11:25:58 -0800 (PST)
References: <2128862333.62000.1293087724834.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2128862333.62000.1293087724834.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Message-Id: <3733F585-4591-4813-A34B-6B47C9D665B6@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Thu, 23 Dec 2010 11:25:40 -0800
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Dec 22, 2010, at 11:02 PM, CAI Qian <caiqian@redhat.com> wrote:

> 
>> However, many people use the LTP to test their own linux system, if those kernel
>> is not support KSM, at least we should make sure they can build
>> successfully.
> In that case, why not use an older version?

Implementing the fix is trivial. Please write some autoconf tests for KSM, et all.
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
