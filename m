Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PZCTR-0004J3-53
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 01:11:05 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZCTP-0005mh-Sb
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 01:11:05 +0000
Received: by pxi17 with SMTP id 17so2698192pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 01 Jan 2011 17:10:58 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4D1986DE.50309@cn.fujitsu.com>
Date: Sat, 1 Jan 2011 17:11:05 -0800
Message-Id: <770BF2E0-F6BC-4D51-9A5D-448B25525204@gmail.com>
References: <4D1986DE.50309@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]fix bug of tst_brk
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

On Dec 27, 2010, at 10:42 PM, Bian Naimeng wrote:

> Test will fail if invoke tst_brk with (TCONF | TERRNO), it's not our expectation.
> 
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

Good catch -- thanks!
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
