Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S5cOh-0000pw-9z
	for ltp-list@lists.sourceforge.net; Thu, 08 Mar 2012 12:24:43 +0000
Date: Thu, 8 Mar 2012 13:26:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120308122626.GA29867@saboteur.suse.cz>
References: <4F578418.2060100@redhat.com> <4F581E1B.60208@casparzhang.com>
	<4F582C39.10307@cn.fujitsu.com>
	<20120308122426.GA26903@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120308122426.GA26903@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH] getrusage04: initialise [us]last to current values
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
> > I can't see that linux-test-project/ltp auto sync from sf since you commit
> > this patch, so I guess Cyril set the auto sync from linux-test-project/ltp
> > to sf, so, maybe you should commit to github and it'll auto sync to sf, right?
> 
> The auto sync is prepared but not yet running. I'll will start that once
> we discuss this change on LTP mailing list and make sure everybody
> understand the change. Till that sync is done by hand.

And FYI, I've just verifed that the script is working and synced the
github repo with the sf one.

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
