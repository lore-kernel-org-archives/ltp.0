Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RvRZS-0001TG-4K
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 10:49:46 +0000
Date: Thu, 9 Feb 2012 12:03:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120209110340.GB22173@saboteur.suse.cz>
References: <4F2CF088.3030001@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F2CF088.3030001@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] m4/ltp-cap.m4: CAPSET should be replaced with
 SETCAP
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> Commit 4f71cae rename setcap to capset in m4/ltp-cap.m4, this is wrong.
> Commit 183c6e4 rename HAVE_SETCAP to CAPSET in in m4/ltp-cap.m4, this also is wrong.
> so CAPSET should be replaced with SETCAP m4/ltp-cap.m4.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
