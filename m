Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfVum-00039p-HD
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:32:36 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfVue-0003Xv-1c
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:32:36 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7O9QiFv010065
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 03:26:44 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7O9WKeB220220
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 03:32:20 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7O9WJL0000924
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 03:32:19 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 24 Aug 2009 15:02:10 +0530
Message-Id: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 00/02] Integrate Valgrind Memory Check Tool to LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3836918105744104148=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

--===============3836918105744104148==

Hi,

Introducing and Integrating the Valgrind Memory Leak Check tools to LTP.
This again is in line with the OLS 2009 paper where we proposed that
memory leak check for LTP test cases will become part of LTP soon. 

Valgrind is one of the best Memory Leak Check tools available to the open
source community and being widely used by many maintainers of Open Source
Projects to regularly check the health of their code. On similar lines, we
would like it to check the various dynamic issues related to Memory Leaks,
Thread Concurrencies for the LTP tests so that we minimize those errors
for the LTP tests. The following set of Patches will:

1) Integrate within LTP infrastructure the use of VALGRIND tool,
2) Internal check against unavailability of this tools on your machine,
3) Running through runltp, the various:
	3.1) Memory Leak Checks,
	3.2) Thread Concurrency Checks,
on all LTP tests that the user intents to run/check,
4) Comparisn of how a normal test run differs from the the test run
through Valgrind,

Now, you may ask the question why don��t we use Valgrind independantly ?
True, it can be done. But, it becomes more simple when we can ask runltp
to do the job for us and remaining everything remains in LTP format. And,
this is handy for test case developers who can do a quick check on the
tests they have just developed.

When you want to run your tests/sub-tests through Valgrind tool, what you
have to just do is:

./runltp -f <your-command-file> -M [1,2,3]

CHECK_TYPE=1 => Full Memory Leak Check tracing children as well
CHECK_TYPE=2 => Thread Concurrency Check tracing children as well
CHECK_TYPE=3 => Full Memory Leak & Thread Concurrency Check tracing children as well

The above options in LTP will usher in better Test Case development.

Regards--
Subrata



--===============3836918105744104148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3836918105744104148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3836918105744104148==--
