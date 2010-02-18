Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NhxhV-0001TA-WB
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 04:09:18 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NhxhR-0006ZD-O9
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 04:09:17 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1I41XQU004549
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 21:01:33 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1I49385102978
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 21:09:03 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1I492ju013311
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 21:09:03 -0700
Date: Thu, 18 Feb 2010 09:38:50 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100218040850.GB13013@rishikesh.in.ibm.com>
References: <4B7BA709.8080306@linux.vnet.ibm.com>
	<70aae6bd1002170035j6b8ad2a3la26a90d13b7b800e@mail.gmail.com>
	<20100217120746.GA5966@rishikesh.in.ibm.com>
	<70aae6bd1002171928r7b86a5c2g568117a65dc462fe@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <70aae6bd1002171928r7b86a5c2g568117a65dc462fe@mail.gmail.com>
Subject: Re: [LTP] CAN LTP BE CROSS COMPILED FOR ANDROID PLATFORM
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
To: md zafar ziya <md.zafar.ziya@gmail.com>
Cc: Rishikesh <risrajak@in.ibm.com>, ltp-list@lists.sourceforge.net

On Thu, Feb 18, 2010 at 08:58:48AM +0530, md zafar ziya wrote:
> Hello Rishikesh,
> 
> 1.All LTP application has to compiled against Android bionic library.
> 2.Use Android Target Cross compiler for building Testcases executables(That
> use compiler builtin API also).
> 3.Android libraray dont have -lrt and -lpthread library,Real time
> library(rt) and Thread library(pthread) are not defined inside Bionic,so
> just remove these entries from Makefile because these library function are
> being moved to bionic C library and for thread API include proper header
> file only.
> 4.Header files are placed to different location in bionic ,So update the
> source as per requirement.
> 5.to run LTP on android based target,use busybox(Cross compiled for
> android:Path-http://benno.id.au/blog/2007/11/14/android-busybox).Push to
> target and use.
> 6.Modify script as per requirement because android based target has
> different interpretation.
> 7.Push only scripts and binary of the executables(because of memory
> constraints) inside target.
> 8.Run runltp
> 
> 
> The above steps anyone can follow to cross compile LTP to ANDROID and run on
> target.

Thanks for your time and metioning the steps , i am sure it will help
others too.
> 
> My Job was not to add new test cases(To check kernel stability only),so i
> didnt think about that so far.
> 
> But i would like to contribute new test case to LTP in the future.LTP is
> very good project,If any one would add test cases that can show benchmark of
> different interrupt latency ,that will be big advantage for LTP future and
> it can make LTP popular among developers.

Very well said, and we are looking forward for your contributions.

Thanks
Rishi
> 
> Thank you
> 
> Regards
> 
> md zafar ziya
> 
> 
> On Wed, Feb 17, 2010 at 5:37 PM, Rishikesh K Rajak <
> rishikesh@rishikesh.in.ibm.com> wrote:
> 
> > On Wed, Feb 17, 2010 at 02:05:38PM +0530, md zafar ziya wrote:
> > > Hello Rishikesh,
> > >
> > > Thanks for support.
> > >
> > > LTP cross compilation is being done(Specific test cases for Testing linux
> > > kernel features only).
> > >
> > > If any one want assistance, Contact on zafar.ziya@samsung.com or
> > > md.zafar.ziya@gmail.com
> > Hi Zafar,
> >
> > Good to know that it worked for you. It will helpful if you could
> > explain the steps here so that everyone over can take the advantage. Also
> > let
> > us know if you have have faced some hurdles while solving this issue.
> >
> > And also any plans for new contribution to ltp with new testcases ?
> >
> > Thanks
> > -Rishi
> > >
> > > Thank you again.
> > >
> > > regards
> > >
> > > Zafar ziya
> > >
> > > On Wed, Feb 17, 2010 at 1:51 PM, Rishikesh <risrajak@linux.vnet.ibm.com
> > >wrote:
> > >
> > > > Hi All,
> > > >
> > > > Please help Zafar, if anyone has compiled LTP on andriod .
> > > >
> > > > Ref Mail:
> > > > http://marc.info/?l=ltp-list&m=126286998319361&w=2
> > > >
> > > > --
> > > > Thanks&  Regards
> > > > Rishi Kesh K Rajak
> > > > IBM LTC, Bangalore
> > > > LTP Maintainer
> > > > Please join IRC: #ltp @ freenode.net
> > > >
> > > >
> >

------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
