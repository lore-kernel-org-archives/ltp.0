Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vgc8Q-00089c-NX
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 15:13:38 +0000
Date: Wed, 13 Nov 2013 16:13:23 +0100
From: chrubis@suse.cz
Message-ID: <20131113151322.GA12936@rei>
References: <1374807380-20319-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<20130731111608.GB1047@rei.scz.novell.com>
	<52836390.5080104@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52836390.5080104@cn.fujitsu.com>
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
> > Since there was recently a discussion about this on glibc ML and some
> > clarfication requests for Austin Group were created, I would wait a
> > little more until the POSIX is clear on how this locks should behave and
> > then we can fix the tests (and possibly skip them on glibc).
> > 
> > See:
> > 
> > http://austingroupbugs.net/view.php?id=722
> > http://austingroupbugs.net/view.php?id=720
> 
> 
> Hi Cyril,
> 
> How about the discuss status? It's a POSIX SPEC bug? Do we need to fix our test suite?

I haven't been following the discussion for a while, I've read the
resolutions now.

So they removed the contradicting line from pthread_rwlock_wrlock() and
clarified the deadlock conditions.

If I understand the changes right, the write locks can now be
implemented to take precedence before the read locks, the testcase is
correct (actually three testcases pthread_rwlock_unlock_3-1,
pthread_rwlock_rdlock_2-1 and pthread_rwlock_rdlock_2-2) and the ball is
on glibc side. I will write a mail to the glibc ML to discuss it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
