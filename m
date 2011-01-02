Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PZCen-0006EL-Dv
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 01:22:49 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZCem-0005ff-Ij
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 01:22:49 +0000
Received: by pzk12 with SMTP id 12so2594075pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 01 Jan 2011 17:22:43 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4D195DE8.4070209@cn.fujitsu.com>
Date: Sat, 1 Jan 2011 17:22:50 -0800
Message-Id: <CBF78D5D-C7F6-4C8E-9246-E4775265F87D@gmail.com>
References: <4D195DE8.4070209@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]Fix bug of add_key01
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

On Dec 27, 2010, at 7:47 PM, Bian Naimeng wrote:

> Never pass TPASS to tst_brkm, tst_brkm will set TBROK to T_exitval,
> then cause test fail.

	I just simplified the testcase instead because IIRC the original version did the wrong thing and tst_resm + called cleanup immediately (or maybe I just got it backwards, but I hate the looping garbage ... so bye bye loop logic!).
	Again, good catch though.
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
