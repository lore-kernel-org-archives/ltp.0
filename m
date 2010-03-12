Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jmtt@us.ibm.com>) id 1NqH66-00022t-4L
	for ltp-list@lists.sourceforge.net; Sat, 13 Mar 2010 02:29:02 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NqH65-00062E-5N
	for ltp-list@lists.sourceforge.net; Sat, 13 Mar 2010 02:29:02 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2D2RPSw031517
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 19:27:25 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2D2SsXY151138
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 19:28:54 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2D2SsHX000735
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 19:28:54 -0700
Received: from taco.beaverton.ibm.com (taco.beaverton.ibm.com [9.47.22.97])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o2D2SrAJ000716
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 19:28:54 -0700
Resent-Message-ID: <20100313022536.GA29505@us.ibm.com>
Resent-To: ltp-list@lists.sourceforge.net
Date: Fri, 12 Mar 2010 10:38:16 -0800
From: James Takahashi <takahash@us.ibm.com>
Message-ID: <20100312183816.GA9691@us.ibm.com>
References: <mailman.93693.1268384199.5237.ltp-list@lists.sourceforge.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <mailman.93693.1268384199.5237.ltp-list@lists.sourceforge.net>
Subject: Re: [LTP] Remove pounder? (was: Remove libevent?)
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

On Thu, 11 Mar 2010 22:13:18 -0800 Garrett Cooper wrote:
> 
> Under testcases/:
> - pounder* - don't use it; it doesn't get compiled, etc
> 
I assume you mean, "you don't use it," as opposed to a warning to others
to not use pounder.  And that you mean, "it doesn't get compiled by
default," as opposed to its compilation is broken.

There are at least two teams in IBM that use the pounder framework on a
regular basis.  We historically had received intermittent requests from
distro partners for that framework when they would be investigating some
problem we had hit while running pounder, so some years ago, IBM sought
and gained approval to keep pounder in the LTP source tree.

In short, please do not remove pounder.

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
