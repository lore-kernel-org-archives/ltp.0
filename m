Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMxgR-0007bM-54
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 12:20:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMxgQ-0006T5-6r
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 12:20:35 +0000
Date: Wed, 5 Aug 2015 14:20:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150805122011.GC31234@rei.suse.de>
References: <1436347259-942-1-git-send-email-liuchangsheng@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436347259-942-1-git-send-email-liuchangsheng@inspur.com>
Subject: Re: [LTP] [PATCH] netns,
 make a verfication to name of virtul network interface card
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
To: Changsheng Liu <liuchangsheng@inspur.com>
Cc: ltp-list@lists.sourceforge.net, wunan@inspur.com

Hi!
> The current ltp version get name of virtul network interface card
> with "veth62@veth63" in the newest kernel version,
> But we need a file name with "veth62".

That looks suspicious, Alexey have you seen this?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
