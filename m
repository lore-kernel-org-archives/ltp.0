Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <metan@suse.de>) id 1fGjRQ-00029X-Oq
 for ltp-list@lists.sourceforge.net; Thu, 10 May 2018 11:08:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1:ECDHE-RSA-AES256-SHA:256) (Exim 4.90_1) id 1fGjRN-00CjKO-Jg
 for ltp-list@lists.sourceforge.net; Thu, 10 May 2018 11:08:56 +0000
Date: Thu, 10 May 2018 13:06:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20180510110640.GB8934@rei>
References: <20180503114252.12548-1-jack@suse.cz>
 <CAOQ4uxgQK9HtojVteoQNJfaP5qVX67HxmHoQ-XKLtjaTq4==Lg@mail.gmail.com>
 <20180504140622.GC7653@rei>
 <20180509130356.czmvg4b3ndrtosir@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180509130356.czmvg4b3ndrtosir@quack2.suse.cz>
Subject: Re: [LTP] [PATCH] inotify07: Add test for kernel crash during event
 notification
List-Id: Linux Test Project General Discussions
 <ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ltp-list>,
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
Cc: ltp-list@lists.sourceforge.net, Amir Goldstein <amir73il@gmail.com>

Hi!
> > > BTW, Cyril, do you have a preference between github pull request
> > > and posting the patch to the list?
> > > I suppose I should have posted to fsdevel and CC Jan anyway...
> > 
> > I do prefer mailing list over pull requests but I work with both.
> 
> Cyril, should I rebase on top of that pull request or will you handle the
> conflict on your own?

I usually handle simple enough collisions myself, no need to rebase and
resend just because of that.

Also as we are in the middle of pre-release freeze please be patient as
the review will have to wait at least a week or two.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
