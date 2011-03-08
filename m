Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <rostedt@goodmis.org>) id 1Pwz6a-0001P3-GD
	for ltp-list@lists.sourceforge.net; Tue, 08 Mar 2011 15:45:48 +0000
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pwz6Z-0000UQ-GR
	for ltp-list@lists.sourceforge.net; Tue, 08 Mar 2011 15:45:48 +0000
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1121368325.334177.1299551594318.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1121368325.334177.1299551594318.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 08 Mar 2011 10:27:58 -0500
Message-ID: <1299598078.20306.70.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list@lists.sf.net, vapier@gentoo.org, linux-kernel@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Theodore Tso <tytso@MIT.EDU>, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Mon, 2011-03-07 at 21:33 -0500, CAI Qian wrote:
> > Perhaps we need to get developer's tests into the kernel. We now have a
> > tools/testing directory lets use it.
> There are a few test code span over other directories too.
> Documentation/vm/hugepage-mmap.c
> Documentation/vm/hugepage-shm.c
> Documentation/vm/map_hugetlb.c

These all look like "Examples", which means they should probably be
moved to samples? As "samples" can be compiled on boot. But perhaps
because they are user space programs its fine to keep them here?

-- Steve

> ...




------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
