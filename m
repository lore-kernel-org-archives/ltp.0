Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SPYgH-0005o7-Mc
	for ltp-list@lists.sourceforge.net; Wed, 02 May 2012 12:29:17 +0000
Date: Wed, 2 May 2012 14:27:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120502122730.GC366@saboteur.suse.cz>
References: <1331270886-22153-1-git-send-email-caspar@casparzhang.com>
	<1B7D43CE-92E4-4D04-BBEF-97CEE3AB1D69@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1B7D43CE-92E4-4D04-BBEF-97CEE3AB1D69@gmail.com>
Subject: Re: [LTP] [PATCH] sched_getaffinity: fix possible fail in negative
 case
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > in negative case:
> > 
> >    QUICK_TEST(sched_getaffinity(getpid()+1, len, mask));
> > 
> > sometimes getpid()+1 will exist if there're other processes running.
> > This patch uses a different way to make sure the required pid doesn't
> > exist by forking a child and terminating it. The pid of the terminated
> > child will not be used for a short time and it's enough for the test to
> > continue.
> 
> 	pid_t is signed on FreeBSD and Linux, so it's safe to assume that a pid of -1 won't work. It all depends on what you're trying to achieve (the EINVAL or the ESRCH requirement).
> 	Testing to make sure that a pid isn't running via kill(pid, 0) is another semi-viable method, but it's also racy.

On Linux we could use /proc/sys/kernel/pid_max value + 1 value too. But
that would probably lead to EINVAL as well as -1.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
