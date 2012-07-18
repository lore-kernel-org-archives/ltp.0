Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SrTSO-0000DJ-N5
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 12:34:20 +0000
Date: Wed, 18 Jul 2012 13:50:17 +0200
From: chrubis@suse.cz
Message-ID: <20120718115017.GB10102@saboteur.suse.cz>
References: <1342086687-5242-1-git-send-email-kai.kang@windriver.com>
	<20120713130745.GA8634@saboteur.suse.cz>
	<50066129.7030802@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50066129.7030802@windriver.com>
Subject: Re: [LTP] [PATCH] pthread_cond_signal/1-1: use sched_yield to
 schedule child threads
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng.Zhao@windriver.com

Hi!
> >>This case fails on mips board routerstation randomly. The root cause is
> >>that when main thread call usleep(100) after signal the child threads,
> >>no child thread is scheduled to run.  So the case fails.
> >>
> >>I update it to set main thread with a lower priority and child threads
> >>with a higher one, then when sched_yield is called in main thread, one
> >>of the child threads will be scheduled and run.
> >>
> >>Signed-off-by: Kang Kai<kai.kang@windriver.com>
> >>---
> >>  .../interfaces/pthread_cond_signal/1-1.c           |   55 ++++++++++++++++++--
> >>  1 files changed, 50 insertions(+), 5 deletions(-)
> >>
> >>diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> >>index bf55b31..51c0cfb 100644
> >>--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> >>+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> >>@@ -11,6 +11,7 @@
> >>   */
> >>
> >>  #define _XOPEN_SOURCE 600
> >>+#define _GNU_SOURCE
> >This is open posix testsuite keep that in mind so inserting _GNU_SOURCE
> >is not allowed here.
> 
> _GNU_SOURCE is needed by set_affinity().
> I once thought multi-processor will break the sync between main
> thread and children threads. Maybe I am wrong that set_affinity() is
> not needed.

Ah, then we are missing the _GNU_SOUCE in the affinity.h.

> >And as far as I remeber the original problem was that some of the
> >threads failed to wake up because the while loop that wakes them was too
> >tight. Does inserting sched_yield() there help?
> >
> 
> Only insert sched_yield() can NOT make sure the main thread really
> sleep. In my test increase usleep to 1000 works.
> I still hope the last patch which increase the usleep value can be
> accept. If can't, I'll send a V2.

Hmm, complicated. What about calling sched_yield() and then doing the
usleep with slightly increased time?

Ideal solution would of course be synchronization of the main thread
with the children so that the main thread would wait until the some
child has been scheduled, but that would require more complex code.

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
