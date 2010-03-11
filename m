Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NpkFe-00029I-Qo
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 15:24:42 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpkFd-0004J4-RE
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 15:24:42 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2BFGRUU004262
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Mar 2010 10:16:27 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2BFOaD4122436
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Mar 2010 10:24:36 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2BFOZPO005796
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Mar 2010 12:24:36 -0300
Date: Thu, 11 Mar 2010 20:54:30 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100311152430.GA3526@linux.vnet.ibm.com>
References: <364299f41003102111u7b24fd76i25b97c292d026af1@mail.gmail.com>
	<1268312580.2518.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1268312580.2518.12.camel@localhost.localdomain>
Subject: Re: [LTP] Remove libevent?
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
To: Lucas Meneghel Rodrigues <lmr@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Thu, Mar 11, 2010 at 10:03:00AM -0300, Lucas Meneghel Rodrigues wrote:
> On Wed, 2010-03-10 at 21:11 -0800, Garrett Cooper wrote:
> > Hi all,
> >     I just looked at the latest libevent, and I'm typically not one to
> > suggest this, but because libevent switched over to libtool in the 2.x
> > release (which is a pain in the ass to integrate), I think we just
> > drop the libevent testcase(s). I assume the maintainers run their
> > testcases on a subset of Unix machines, so it would just be an
> > annoying earmark that LTP has to maintain a dead // useless version of
> > libevent (eventually our version will go out of date and the code that
> > we have will bear little relevance and may be more buggy than the
> > latest version which should have appropriate tests and be executed and
> > triaged appropriately upstream).
> 
> +1. Of course I am not in a position of saying something about what it
> should be done, but I totally agree that LTP should strive in keeping
> only well maintainted tests. It's harmful to keep unmantained code, it
> bitrots and tends to make everyone's life difficult.

Well said Lucas & garret. We need to really look for some outdated testcase
currently existing with LTP. I can look into it incrementally, but like garret
if someone come to know about outdated testcase with LTP or some tetssuit which
need renewal, please let us know. We will work to renew them on high priority.

Some of the testsuits i am looking are:
    - cpu hot plug
    - memory hotplug

-Rishi


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
