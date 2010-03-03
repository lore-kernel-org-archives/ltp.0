Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NmmA5-00016i-Hl
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 10:50:41 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmmA4-0003Qr-BD
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 10:50:41 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o23An6sG013593
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 03:49:06 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o23AoV52055326
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 03:50:31 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o23AoULJ002230
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 03:50:31 -0700
Date: Wed, 3 Mar 2010 16:20:28 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100303105028.GC23601@linux.vnet.ibm.com>
References: <4B8E3C08.2080901@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B8E3C08.2080901@in.ibm.com>
Subject: Re: [LTP] Version file from Feb LTP release still contains 20100131
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
To: Sachin Sant <sachinp@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Mar 03, 2010 at 04:08:00PM +0530, Sachin Sant wrote:
> Not a major issue, but noticed something with latest LTP tarball
> from Feb.

Actually the script design is like that, it will update the version file
once you compiled and build, reading from Changelog.

Can you confirm if you are not having Changelog starting from :
LTP-20100228 .

Mostly it will not be there as you would have extracted next branch. But
it will be always available with master branch.

Thanks
Rishi
> 
> The Version file still contains 20100131.
> 
> :/home/sachin/work # cat ltp-full-20100228/Version LTP-20100131
> :/home/sachin/work #
> 
> Should this be 20100228 ?
> 
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
