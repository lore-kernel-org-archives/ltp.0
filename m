Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPrwL-0006D9-Os
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 12:49:01 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPrwI-0005f9-0p
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 12:49:01 +0000
Date: Thu, 13 Aug 2015 14:48:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150813124830.GC14976@rei.suse.de>
References: <1439432306-2918-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439432306-2918-1-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH] mem/thp: skip thp02/thp03 if system not support
 hugepage
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
I've reworded the commit message and the TCONF message a bit and pushed,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
