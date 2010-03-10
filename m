Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NpEV2-0001yD-NH
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:30:28 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpEV1-0007nT-Mo
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:30:28 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2A5Q84x026082
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 00:26:08 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2A5ULGv2125998
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 00:30:21 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2A5UL1E003101
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 02:30:21 -0300
Date: Wed, 10 Mar 2010 11:00:18 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100310053018.GB3109@linux.vnet.ibm.com>
References: <E1NpDZI-0002Ux-VZ@sfp-scmshell-2.v30.ch3.sourceforge.com>
	<4B972BAC.5000704@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B972BAC.5000704@cn.fujitsu.com>
Subject: Re: [LTP] [Git] ltp updated.
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Mar 10, 2010 at 01:18:36PM +0800, Shi Weihua wrote:
> Hi Rishikesh,
> 
> at 2010-3-10 12:30, Rishi kesh K Rajak wrote:
> > The branch, master, has been updated
> >        via  48c52fcd4e7668bc36bbe080f53462d410712b69 (commit)
> >       from  c962f51674b971496e14ac4be0cc75da98b75fca (commit)
> > 
> > 
> > - Log -----------------------------------------------------------------
> > commit 48c52fcd4e7668bc36bbe080f53462d410712b69
> > Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
> > Date:   Wed Mar 10 10:00:22 2010 +0530
> > 
> >     Instead of LIBS, it should be LDLIBS in container/Makefile
> >     
> >     Signed-off-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
> > 
> > -----------------------------------------------------------------------
> > 
> > Summary of changes:
> >  testcases/kernel/containers/Makefile |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >  
> > diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/containers/Makefile
> > index 26f1856..29394c3 100644
> > --- a/testcases/kernel/containers/Makefile
> > +++ b/testcases/kernel/containers/Makefile
> > @@ -26,7 +26,7 @@ FILTER_OUT_DIRS		:= $(LIBDIR)
> >  
> >  LIB			:= $(LIBDIR)/libclone.a
> >  
> > -LIB			:= -ld
> > +LDLIB			:= -ldl
> 
> make failed on my machine. should be LDLIBS ?

corrected now. apologize for inconvenience. Thanks Shi.

-Rishi
> 
> >  
> >  INSTALL_TARGETS		:= *.sh 
> >  
> > 
> > 
> > hooks/post-receive

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
