Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <noreply@sourceforge.net>) id 1Q7Vey-0005hJ-Pk
	for ltp-list@lists.sourceforge.net; Wed, 06 Apr 2011 16:32:48 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1Q7Vey-00050Z-Cl@sfs-web-5.v29.ch3.sourceforge.com>
Date: Wed, 06 Apr 2011 16:32:48 +0000
Subject: [LTP] [ ltp-Bugs-3267963 ] process_stress infinite loop
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
To: noreply@sourceforge.net

Bugs item #3267963, was opened at 2011-04-01 23:07
Message generated for change (Settings changed) made by metan
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3267963&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: Scheduler
>Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: Mike Kravetz (mkravetz)
Assigned to: Cyril Hrubis (metan)
Summary: process_stress infinite loop

Initial Comment:
./testcases/kernel/sched/process_stress/process -b10 -d2 can go into an infinite loop.

The test creates a tree of processes.  Each process will send a message
(msgsnd, queue up) to all of its siblings.  After sending messages, it 
will then read (msgrcv) from its siblings.

The issue/bug is that on a large systems with lots of cores/processors 
(64 cores in my case) it is possible for many processes to be sending 
messages in parallel.  All before any/many processes have started 
reading/receiving messages.  This will result in the message queue filling 
up before the processes start emptying (msgrcv) the queue.  Once the queue 
is full, processes retry forever hoping someone will drain.  But, everyone 
is sending 'at once'.

This 'works' in environments with lower core/processor counts as processes 
are able to queue up request and drain some in the same time slice.

To test/verify you can add a 'sleep(1)' to the testcase after it does 
all the sends, and before doing any receives.  I ran this on a small
(4 processor) system and it failed (ran forever) in the same manner as 
it did on the large system.


----------------------------------------------------------------------

Comment By: Cyril Hrubis (metan)
Date: 2011-04-06 18:30

Message:
Thanks for the detailed report. We've seen similar symptoms while testing
SUSE linux here in suse. I'll look at the code.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3267963&group_id=3382

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
