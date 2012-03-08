Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S5crI-0002DA-3x
	for ltp-list@lists.sourceforge.net; Thu, 08 Mar 2012 12:54:16 +0000
Date: Thu, 8 Mar 2012 13:55:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120308125554.GE31640@saboteur.suse.cz>
References: <20120308124800.GD31640@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120308124800.GD31640@saboteur.suse.cz>
Subject: Re: [LTP] LTP git repositories
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
Cc: Mike Frysinger <vapier@gentoo.org>

> Hi!
> Good news everyone. After some discussion we (Me, Caspar and Wanlong)
> prepared official LTP repository on github.com.
> 
> It's located at https://github.com/linux-test-project/ltp
> 
> The resons for such move are obvious, github provides more natural way
> to handle development using git (not to mention that their servers are
> much faster than sourceforge).
> 
> So now everyone can fork the repo with a few clicks and send a pull
> request to this mailing list. Let's see how that will work in real
> usage.
> 
> Now there are few things to settle and I we would like to hear from you
> (especially people who are developers in the ltp.sf.net project).
> 
> With the current setup we have git repo both on sf.net and github, my
> plan is to make one of them mirror of the other one (for now I have
> prepared sync script to be run every hour via cron).
> 
> I would personally preffer the sf.net repo becoming mirror of the github
> one, but that means nobody but the sync script would commit to the
> sf.net repo and all commits would go to the github one. But that
> shouldn't be the problem as we would add people who needs commit acces
> to the github project.

Sorry for mailing again, somewhere between the mail client and smtp part
of the CC list was eaten. :(

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
