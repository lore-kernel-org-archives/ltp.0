Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nlziz-0001B0-2z
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 07:07:29 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nlziy-0004WO-1s
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 07:07:29 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2175urH006493
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 00:05:56 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2177LsX091210
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 00:07:21 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2177LQb010234
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 00:07:21 -0700
Date: Mon, 1 Mar 2010 12:37:19 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100301070718.GE3860@linux.vnet.ibm.com>
References: <364299f41002280211i5ab0e74dr4d9693ed40f2b4b5@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002280211i5ab0e74dr4d9693ed40f2b4b5@mail.gmail.com>
Subject: Re: [LTP] RFC : refactor LTP execution model
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi Garret,

My point will still not be so much useful for you but i tried to understand your
proposal last weekend and thought to reply you. May be Subrata can give
you much input here as he is with this project from long time.

>   My proposal is as follows:
>
>   1. A discrete set of reporting functions should be created (error,
>info,
>warning, etc). This messages should adhere to the following basic
>paradigm:
>       error - always displayed.
>       info - only displayed when quiet isn't used.
>       warning - only displayed when quiet isn't used.
>       That way folks could
>

Hmm.... that's way we can give crisp info to user, but what about TBROK
tetscases ? Are we going to categorize that in error ?

>   2. runltp be split into discrete functional blocks, as follows:
>       i.   Parse core options. Parse any additional options for
>functionality like email, HTML output, etc.
>       ii.  Prepare the tests based on the runtests files and options
>passed
>in (run valgrind on the tests, etc).
>       iii. Basic setup.
>       iv.  Execute the tests.
>       v.   Basic teardown.
>       vi.  Output methods for email, HTML, etc.
>
So are you proposing for writing all new scripts ? Did not quite
understand what could be the motive behind it. We are already having
runalltest.sh , which does this segregation for user whether he wants an
email, HTML or not.

>    So when runltp is executed, it does something like the following:
>    1. source testscript [if it exists].
>    2. Change the test ``execution plan'' so that they setup and
>teardown
>inexplicably executed in the following manner (following Java's
>unit-test
>and python unittest):
>
>    Setup the test; if successful, continue on with the test(s) and
>teardown
>at the end.
>
    The purpose for making this into a script as opposed to any other
>sort
>of metadata, is that anyone executing the tests standalone will only
>need to
>source the script to set everything up, then execute the test itself.
>    The only thing that might be a problem is that runtest files are
>mashed
>together if multiple runtest scenario files are specified. This
>shouldn't be
>an issue though if everything is strung together properly via the calls
>above (setup, test, teardown).
>    Thoughts?

Overall nice proposal, i also could not understand this "teardown" concept.

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
