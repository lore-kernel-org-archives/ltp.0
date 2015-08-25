Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZUCQO-0007Ja-JJ
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 11:29:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZUCQN-0006uw-JB
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 11:29:56 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id EF979ADB7
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Aug 2015 11:29:48 +0000 (UTC)
Date: Tue, 25 Aug 2015 13:29:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150825112920.GB20082@rei.suse.de>
References: <1439215460-15670-1-git-send-email-jack@suse.com>
	<20150811141432.GA21861@rei.suse.de>
	<20150811142035.GD2659@quack.suse.cz>
	<20150825092925.GA19905@rei.suse.de>
	<20150825103803.GA15280@quack.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150825103803.GA15280@quack.suse.cz>
Subject: Re: [LTP] [PATCH v2] inotify: Add test for inotify mark destruction
 race
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Interesting, probably SRCU is much slower with this older kernel. From my
> experiments 100 iterations isn't quite reliable to trigger the oops in my
> testing instance. But 400 seem to be good enough.

I've changed the nuber of iterations to 400 and pushed it to git,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
