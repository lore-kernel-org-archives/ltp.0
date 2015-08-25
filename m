Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZUCFn-0006xs-Hq
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 11:18:59 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZUCFm-0002Pj-Jg
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 11:18:59 +0000
Date: Tue, 25 Aug 2015 13:18:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150825111823.GA20082@rei.suse.de>
References: <1440492714-3600-1-git-send-email-alexey.kodanev@oracle.com>
	<55DC450D.4070501@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55DC450D.4070501@oracle.com>
Subject: Re: [LTP] [PATCH] network/tcp_fastopen: fix typo in check_opt() and
 check_opt_l()
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Can we apply this patch before release?

Sure, acked.

(I wonder how we missed that in the review...)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
