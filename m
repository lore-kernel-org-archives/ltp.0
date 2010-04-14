Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O1wEf-00030J-9x
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 06:38:05 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O1wEc-0006IB-CI
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 06:38:03 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3E6Qeda025649
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Apr 2010 02:26:40 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3E6buvf151740
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Apr 2010 02:37:56 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3E6bu7T023594
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Apr 2010 03:37:56 -0300
Date: Wed, 14 Apr 2010 12:07:37 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100414063736.GA3596@linux.vnet.ibm.com>
References: <g2k72fb0a5c1004132248q96998dc3u560e90bd448c6041@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <g2k72fb0a5c1004132248q96998dc3u560e90bd448c6041@mail.gmail.com>
Subject: Re: [LTP] query !!
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
To: rahul agarwal <raahul4321@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hello Rahul,

You need to always run as "./runltp -f syscalls" inside /opt/ltp dir.

e.g: If you want to run fallocate testcases, please create a file called
fallocate under /opt/ltp/runtest and run as:

# cat /opt/ltp/testcases/runtest/fallocate
fallocate01 fallocate01
fallocate02 fallocate02
fallocate03 fallocate03
# cd /opt/ltp
#./runltp -f fallocate

This will run only fallocate testcases.

Before you execute above steps, you need to change your fallocate file and do
make & make install inside ~/ltp-full-20100331/testcases/kernel/syscalls/fallocate

Let me know if you still face some problem.

-Rishi
On Wed, Apr 14, 2010 at 11:18:10AM +0530, rahul agarwal wrote:
> I have a query regarding how to compile individual testcase in ltp.
> 
> For example:
> fallocate tests inside syscalls are failing and so I want to compile and
> check them seperately after some modifications. But I am facing the problem
> due to various dependencies which are there. And as a result I am not being
> able to isolate the errors which I am facing.
> 
> Kindly guide me so that I can overcome such a problem.
> 
> With Regards
> Rahul Agarwal
> +91-9999720591


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
