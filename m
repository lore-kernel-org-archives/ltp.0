Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <qcai@redhat.com>) id 1Px8IM-0006u3-1E
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 01:34:34 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Px8IL-0004jK-0k
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 01:34:33 +0000
Date: Tue, 8 Mar 2011 20:33:48 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1470848644.363281.1299634428564.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1299598078.20306.70.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 FEBRUARY 2011.
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ltp-list@lists.sf.net, vapier@gentoo.org, linux-kernel@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Theodore Tso <tytso@MIT.EDU>, akpm@linux-foundation.org, torvalds@linux-foundation.org


> > > Perhaps we need to get developer's tests into the kernel. We now
> > > have a
> > > tools/testing directory lets use it.
> > There are a few test code span over other directories too.
> > Documentation/vm/hugepage-mmap.c
> > Documentation/vm/hugepage-shm.c
> > Documentation/vm/map_hugetlb.c
> 
> These all look like "Examples", which means they should probably be
> moved to samples? As "samples" can be compiled on boot. But perhaps
> because they are user space programs its fine to keep them here?
Yes, but also test cases to check if basic hugetlb code is working.
Well, the problem is that they are all over the place, and some of
good test cases are within commit logs as well which makes things
harder to maintain, use...

CAI Qian

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
