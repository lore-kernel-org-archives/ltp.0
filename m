Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nouyf-0003JF-35
	for ltp-list@lists.sourceforge.net; Tue, 09 Mar 2010 08:39:45 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nouyb-00062P-Qq
	for ltp-list@lists.sourceforge.net; Tue, 09 Mar 2010 08:39:45 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o298XrE7030615
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Mar 2010 01:33:53 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o298dZhl146200
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Mar 2010 01:39:35 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o298dYmn022432
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Mar 2010 01:39:35 -0700
Date: Tue, 9 Mar 2010 14:09:30 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100309083930.GC5875@linux.vnet.ibm.com>
References: <4B946761.8030301@cn.fujitsu.com>
	<364299f41003080753h78ddb8c0uc20027ccf2e3c990@mail.gmail.com>
	<20100308171707.GA4999@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100308171707.GA4999@linux.vnet.ibm.com>
Subject: Re: [LTP] [BUG?] container_test.sh: should to delete
 check_for_unshare's source in cvs/git ?
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
To: Garrett Cooper <yanegomi@gmail.com>, Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, Mar 08, 2010 at 10:47:07PM +0530, Rishikesh K Rajak wrote:
> On Mon, Mar 08, 2010 at 07:53:08AM -0800, Garrett Cooper wrote:
> > On Sun, Mar 7, 2010 at 6:56 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> > >
> > > Now, my question: should to delete check_for_unshare's source in cvs/git ?
> > 
> > There was some discussion and the check was reenabled post the February release.
> 
> I looked at a glance in sleep mode and found there is something need to
> be fixed here as i am still not able to find check_for_unshare.c . Well
> i will look and fix tomorrow.

Hi Shi,

Thanks for reporting this failure. Just now i committed  to next branch.

commit bdfe0b2a9dd720c3013225cc4aa1628e77888b24
Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Date:   Tue Mar 9 14:05:46 2010 +0530

    Adding check_for_unshare.c file and linking the porper lib.
    
    Signed-off-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
    Reported-By: Shi Weihua <shiwh@cn.fujitsu.com>



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
