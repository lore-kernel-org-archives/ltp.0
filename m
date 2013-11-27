Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VleaG-0003NF-8o
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 12:51:12 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 87113A7D41
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Nov 2013 13:51:05 +0100 (CET)
Date: Wed, 27 Nov 2013 13:50:43 +0100
From: chrubis@suse.cz
Message-ID: <20131127125043.GB7549@rei.suse.cz>
References: <1385362041-17578-1-git-send-email-jshao@redhat.com>
	<20131126182827.GA15092@rei.suse.cz>
	<20131127094113.GR14611@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131127094113.GR14611@redhat.com>
Subject: Re: [LTP] [PATCH] netns: remove accumulated errmesg assignment
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

Hi!
> > I wonder why there is errmesg variable at all and not just echo, it
> > doesn't seems to be used anywhere else.
> 
> I wonder too, but I thought there might be some reason, so I only fix
> the error and leave the imperfect behind.

I'm perfectly happy with applying this patch, but I would be even
happier with fixing it up correctly.

> > Moreover the way the testcases are executed is not well designed, the
> > runtest file 'containers' executes script container_test.sh which
> > executes several scripts and the scripts finally executes the tescases.
> > This is really nightmare if you are trying to find what fails and why...
> >
> > It would be much better to execute the testcases directly one by one
> > from the runtest file, and in most of the cases that would just need to
> > move code the checks if there is support for particual container to the
> > testcases.
> 
> Can't agree more, but it takes time to change the whole structure in
> testcases/kernel/containers/netns/ ...

We can do that easily in a few steps. First we need to add checks if the
containers are enabled to the actual testcases (that will not break
anything), then we can add new runtest file for them and once everything
is working, we can finally remove the original scripts.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
