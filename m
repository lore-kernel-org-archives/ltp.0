Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PGS2L-0004Yx-TL
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:37 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGS2K-0003ZK-7f
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:37 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAB7edo7031866
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 02:40:39 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAB7vUR3195238
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 02:57:30 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAB7vTei002736
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 00:57:30 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTi=4eSqeEqJz84s2ThkKd2+BMtngT4_14Fd6bX5f@mail.gmail.com>
References: <1747284477.1389541288853682476.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<957775683.1389581288853739343.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<AANLkTi=4eSqeEqJz84s2ThkKd2+BMtngT4_14Fd6bX5f@mail.gmail.com>
Date: Thu, 11 Nov 2010 13:27:14 +0530
Message-Id: <1289462234.5622.42.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v8] mmap/munmap /dev/zero: a common way
	of	malloc()/free() anonymous memory on Solaris
Reply-To: subrata@linux.vnet.ibm.com
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, caiqian@redhat.com

On Sun, 2010-11-07 at 22:05 -0800, Garrett Cooper wrote: 
> On Wed, Nov 3, 2010 at 11:55 PM,  <caiqian@redhat.com> wrote:
> > The basic purpose of this is a to test if it is possible to map and
> > unmap /dev/zero, and to read and write the mapping. Being inspired by
> > two bugs in the past, the design of the test was added some variations
> > based on the reproducers for them. It also accept an option to
> > mmap/munmap anonymous pages.
> >
> > One is to trigger panic with transparent hugepage feature that
> > split_huge_page is very strict in checking the rmap walk was
> > perfect. Keep it strict because if page_mapcount isn't stable and just
> > right, the __split_huge_page_refcount that follows the rmap walk could
> > lead to erratic page_count()s for the subpages. The bug in fork lead
> > to the rmap walk finding the parent huge-pmd twice instead of just
> > one, because the anon_vma_chain objects of the child vma still point
> > to the vma->vm_mm of the parent. That trips on the split_huge_page
> > mapcount vs page_mapcount check leading to a BUG_ON.
> >
> > The other bug is mmap() of /dev/zero results in calling map_zero()
> > which on RHEL5 maps the ZERO_PAGE in every PTE within that virtual
> > address range. Since the application which maps a region from 5M to
> > 16M in size is also multi-threaded the subsequent munmap() of
> > /dev/zero results is TLB shootdowns to all other CPUs. When this
> > happens thousands or millions of times the application performance is
> > terrible. The mapping ZERO_PAGE in every pte within that virtual
> > address range was an optimization to make the subsequent pagefault
> > times faster on RHEL5 that has been removed/changed upstream.
> >
> > Signed-off-by: CAI Qian <caiqian@redhat.com>
> > ---
> > v8: add an option to utilize KSM; no need to open /dev/zero for
> >    anonymous page testing.
> > v7: another "(void)" fix
> > v6: really use git format; check return from children; cleanup.
> > v5: add an option to test anonymous pages; move open() into setup().
> > v4: comment fix; code cleanup.
> > v3: really mmap /dev/zero; replace _exit() with exit(); fix patch
> >    format.
> > v2: incorporate comments from Mike and Garrett.
> 
> Looks fine. Please attach the file as a patch and also add a necessary
> entry in one of the runtest files. If it looks ok Subrata, please

Yes, a combined patch adding an entry to the runtest file is required.
Please send me. I will push it.

Regards--
Subrata

> commit.
> Thanks,
> -Garrett


------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
