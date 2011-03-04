Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <tytso@mit.edu>) id 1PvaU0-0006wp-9f
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 19:16:12 +0000
Received: from dmz-mailsec-scanner-4.mit.edu ([18.9.25.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvaTz-0000bN-H2
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 19:16:12 +0000
Mime-Version: 1.0 (Apple Message framework v1082)
From: Theodore Tso <tytso@MIT.EDU>
In-Reply-To: <1469445745.266603.1299117157337.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Fri, 4 Mar 2011 13:58:45 -0500
Message-Id: <6AFCFCC5-DBC2-403E-9EED-D2A85FFCB21C@mit.edu>
References: <1469445745.266603.1299117157337.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
Cc: ltp-list@lists.sf.net, vapier@gentoo.org, linux-kernel@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, akpm@linux-foundation.org, torvalds@linux-foundation.org


On Mar 2, 2011, at 8:52 PM, CAI Qian wrote:

> Those days, there just too many tests and testing projects for kernel like
> LTP, autotest, xfstests and so on. Why not have somewhere to collabrate and
> then to extract the best?

Part of the problem is that every single testing project has different goals and
priorities.   For example xfstests is maintained by the XFS folks, as well as people
from some of the other file system development efforts (the ext4 one in particular,
thanks to people like Eric Sandeen), to test file systems.

At least at one point, I had heard a complaint that LTP was more focused on 
increasing test coverage as measured by a code coverage tool in the kernel
than it was about about covering edge conditions, or races.  There's nothing 
wrong with that, per se, and I don't know if it was true then or now, but it's a very
different focus from one which is focused increasing the data reliability of file
systems, quickly and efficiently.

And then there's the LSB test suites, which is really code at testing correctness
from a standards perspective, which is a different focus yet again from the LTP
and xfstests approach.

Bottom line, I'm a big fan of having different test suites, with different philosophies.
Each philosophy has its strengths and blind spots, and so a problem that might
be missed by one test suite might get caught by another.

The only real problem is an operational one.   There are some programs which
are used by both LTP and xfstests, and changes that is made in one, don't 
necessarily get propagated to the other unless someone manually does it.
But I think we can solve that without trying to merge all of these tests into a
single Grand Unified Test Suite.

-- Ted


------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
