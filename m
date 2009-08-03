Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1MY6yv-000146-DU
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 23:30:17 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MY6ys-0000XE-VU
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 23:30:17 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73NSJtK025405
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 17:28:19 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73NU83X214198
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 17:30:08 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73NU80Q003945
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 17:30:08 -0600
Message-ID: <4A7772FE.20808@us.ibm.com>
Date: Mon, 03 Aug 2009 16:30:06 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
Subject: [LTP] realtime measurement tests: approach to criteria
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
To: LTP <ltp-list@lists.sourceforge.net>
Cc: Clark Williams <williams@redhat.com>, amrith <amrith@linux.ibm.com>

The current ltp/testcases/realtime tests belong to one of func, perf, or 
stress.  While strict pass/fail criteria make sense for functional tests 
(did the tasks wake up in priority order?), the others use "arbitrary" 
values and compare those against the whatever is being measured (wakeup 
latency, etc.) and then determine pass/fail.  Ideally the tests 
themselves would not determine the pass/fail criteria, and would instead 
simply report on their measurements since the criteria will vary in 
every use-case based on requirements, workload, hardware, etc.

I'd like to propose an approach where the tests only report their 
measured values (with the exception of the func/* tests which will 
maintain their pass/fail criteria).  Users should be able to populate a 
criteria.conf file that specified the criteria of each test.  The 
results could then be parsed, compared against the results, and a 
pass/fail determined from there.  I suspect it would be best for the .c 
tests to just report the numbers and the statistics in a common format 
and rely on python parser scripts to read the config file and determine 
pass/fail from there.

I'd like users thoughts on this approach before we jump in and start 
changing things (as this is a fairly invasive change).

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
