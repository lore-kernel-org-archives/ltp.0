Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Ry5K7-00086e-Q1
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 17:40:51 +0000
Date: Thu, 16 Feb 2012 18:40:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120216174045.GA6793@saboteur.suse.cz>
References: <1329209618-20920-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1329210855-23074-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1329210855-23074-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH-v2] aio_suspend: cleanup the coding style
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -	aiocbs = (struct aiocb**)malloc(sizeof(struct aiocb *) * NUM_AIOCBS);
> +	aiocbs = (struct aiocb **)malloc(sizeof(struct aiocb *) * NUM_AIOCBS);

Casting pointers returned from malloc is not needed so please remove
these too. Other than that it looks good.

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
