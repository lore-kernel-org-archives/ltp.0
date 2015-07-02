Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZAg2w-0002Ix-VU
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 15:05:02 +0000
Date: Thu, 2 Jul 2015 17:03:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150702150340.GB21990@rei.suse.de>
References: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
	<1435320294-45783-6-git-send-email-maninder1.s@samsung.com>
	<20150702150222.GA21990@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150702150222.GA21990@rei.suse.de>
Subject: Re: [LTP] [PATCH 05/13] kernel/mq_open: use ARRAY_SIZE
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
To: Maninder Singh <maninder1.s@samsung.com>
Cc: ltp-list@lists.sourceforge.net, pankaj.m@samsung.com

Hi!
> >  			/*
> >  			 * Execute test
> >  			 */
> > -			for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0]));
> > +			for (i = 0; i < (int)ARRAY_SIZE(tcase);
> >  			     i++) {
> 
> After the change the whole for statement fits on one line (has less than
> 80 chars) can you fix that as well?

And the same for the rest of mq_* testcases in this patchset.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
