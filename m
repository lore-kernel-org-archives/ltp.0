Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nm1Sl-0000jj-Ta
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 08:58:51 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nm1Si-0006E2-DS
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 08:58:50 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o218ouiB023258
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 03:50:56 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o218wgdg163740
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 03:58:42 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o218wfHk023017
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 03:58:42 -0500
Date: Mon, 1 Mar 2010 14:28:39 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100301085839.GH3860@linux.vnet.ibm.com>
References: <d270b4401002202353pec0431w4a2bb947544ff444@mail.gmail.com>
	<364299f41002261213q24890454jac60233bd8f92ded@mail.gmail.com>
	<d270b4401002270505n59e448eev69b6f7b263ecd61d@mail.gmail.com>
	<d270b4401002270606y1f695cc8u3afaefb8b722528c@mail.gmail.com>
	<364299f41002271224x2aef49b0i4079babd986403e7@mail.gmail.com>
	<20100228181445.GB4850@linux.vnet.ibm.com>
	<d270b4401002281837x589df62ds4ce246066c3d9442@mail.gmail.com>
	<20100301052100.GA3860@linux.vnet.ibm.com>
	<20100301062821.GC3860@linux.vnet.ibm.com>
	<d270b4401002282340p45597f24tcb61bd3fa9366c31@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d270b4401002282340p45597f24tcb61bd3fa9366c31@mail.gmail.com>
Subject: Re: [LTP] Testcase to validate the memory usage limit imposed by
 the topmost memory cgroup
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
To: Mohamed Naufal <naufal11@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Mar 01, 2010 at 01:10:31PM +0530, Mohamed Naufal wrote:
> On 1 March 2010 11:58, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com> wrote:
> 
> 
> [...]
> 
> 
> >
> > Please create your patch against next tree or attach the source file
> > here as text, i will create a patch.
> >
> 
> [...]
> 
> Please find the patch attached. Hope this is good enough.


Yes commited now to next branch. It will be evaluated in future, once it
is tagged as tested and no regression found will include it to master
branch and followed by month end tar ball release. Let somebody test it
here and find it useful through next branch only till now.
 
Thanks for working on this patch, much appreciable.

You can find as commit id:
c0b8157365beb18a627fe197be6ab111e8281e86

http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=commit;h=c0b8157365beb18a627fe197be6ab111e8281e86

Thanks for your patch

-Rishi

> 
> Naufal



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
