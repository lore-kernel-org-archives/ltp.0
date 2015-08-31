Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZWNC1-000331-AJ
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2015 11:24:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZWNC0-0000y4-9g
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2015 11:24:05 +0000
Date: Mon, 31 Aug 2015 13:23:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150831112319.GB17776@rei.suse.cz>
References: <20150813123035.GB14976@rei.suse.de>
	<20150820150617.GE3994@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150820150617.GE3994@rei.suse.de>
Subject: Re: [LTP] LTP release
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
To: ltp-list@lists.sourceforge.net
Cc: Jiri Jaburek <jjaburek@redhat.com>

Hi!
I've did my release testing and pushed a few fixes, mosty minor ones.

Now the only problem that that blocks the release on my side are
failures of the newly rewritten netns testcases that were discussed
last week.

Jiri: What about changing the ns_exec to join only net namespace for
      now and rewriting it after the release?

Everybody: If you have issues with the latest git please report them.
           And if you haven't tested it yet please do so ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
