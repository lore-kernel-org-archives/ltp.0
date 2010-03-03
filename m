Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nml9W-0002KS-Ok
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:46:02 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nml9V-0007vo-OY
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:46:02 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o239h2uj004345
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 02:43:02 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o239jsvG148364
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 02:45:54 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o232jswP024371
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 19:45:54 -0700
Date: Wed, 3 Mar 2010 15:15:41 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100303094541.GB23601@linux.vnet.ibm.com>
References: <f5a7b3811002250545x3d5288cfqd114d3bcd79581f2@mail.gmail.com>
	<20100302085046.GA27023@linux.vnet.ibm.com>
	<f5a7b3811003020708wdd0710fv4c3e1dcf1992935c@mail.gmail.com>
	<20100303045624.GB10185@linux.vnet.ibm.com>
	<f5a7b3811003022200r32a0e108g8eaf5d9a2ce66b4a@mail.gmail.com>
	<20100303070342.GB19084@linux.vnet.ibm.com>
	<364299f41003030118x6136dda6u7017054febea4b96@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41003030118x6136dda6u7017054febea4b96@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Synchronization required before release the lock:
 sem_post/8-1.c
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
Cc: ltp-list@lists.sourceforge.net, naresh kamboju <naresh.kernel@gmail.com>

On Wed, Mar 03, 2010 at 01:18:50AM -0800, Garrett Cooper wrote:
> Uh, hold on a sec before we call it good...

oh ok, holiding on for bit.

Naresh, can you please send a patch with incorporating garret's comment
?

Thanks
Rishi
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
