Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RvUJ2-0006pt-By
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 13:45:00 +0000
Date: Thu, 9 Feb 2012 14:59:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120209135859.GA28992@saboteur.suse.cz>
References: <1328775194-10631-1-git-send-email-caspar@casparzhang.com>
	<1328793121-20852-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1328793121-20852-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v4] safe_macros: add SAFE_STRTOL
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> usage: SAFE_STRTOL(cleanup_fn, string, min, max);
> when no specific range required, min could be LONG_MIN and max could be
> LONG_MAX;
> 
> return: converted long int type value.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

Acked-by: Cyril Hrubis <chrubis@suse.cz>

(feel free to commit)

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
