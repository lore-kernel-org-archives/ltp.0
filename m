Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4UO9-0006YR-NY
	for ltp-list@lists.sourceforge.net; Wed, 31 Jul 2013 11:16:17 +0000
Date: Wed, 31 Jul 2013 13:16:08 +0200
From: chrubis@suse.cz
Message-ID: <20130731111608.GB1047@rei.scz.novell.com>
References: <1374807380-20319-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1374807380-20319-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/3] pthread_rwlock_rdlock:2-1: do not test on
	glibc
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
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> Since the reader can always acquire the rwlock if there's not a writer
> held the lock.

Since there was recently a discussion about this on glibc ML and some
clarfication requests for Austin Group were created, I would wait a
little more until the POSIX is clear on how this locks should behave and
then we can fix the tests (and possibly skip them on glibc).

See:

http://austingroupbugs.net/view.php?id=722
http://austingroupbugs.net/view.php?id=720

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
