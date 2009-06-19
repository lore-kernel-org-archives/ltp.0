Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1MHZsY-00023d-Lt
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 08:55:22 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHZsV-0001Di-OR
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 08:55:22 +0000
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5J8qoeB023599
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2009 18:52:50 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5J8tCWQ1015960
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2009 18:55:14 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5J8tCxx017962
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2009 18:55:12 +1000
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
In-Reply-To: <1245346287.5041.32.camel@subratamodak.linux.ibm.com>
References: <1244618075.10778.4.camel@munipradeep-laptop>
	<1245346287.5041.32.camel@subratamodak.linux.ibm.com>
Date: Fri, 19 Jun 2009 14:25:36 +0530
Message-Id: <1245401736.13600.5.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH]get_mempolicy01: fix for changing failure due
	to	configuration error
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

On Thu, 2009-06-18 at 23:01 +0530, Subrata Modak wrote:

Hi Subrata,

> Hi Muni,
> 
> On Wed, 2009-06-10 at 12:44 +0530, Munipradeep Beerakam wrote:
> > Hi,
> > 
> > Here is the attachment to fix the configuration error in
> > get_mempolicy01.c
> > Actually it should not fail due to configuration error. So changed the
> > necessary.
> > 
> > Thanks
> > Muni
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > differences
> > between files
> > attachment
> > (get_mempolicy01.patch)
> > 
> > 
> > ---
> > a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c 2009-06-10
> > 07:08:08.000000000 -0400
> > +++
> > b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c 2009-06-10
> > 07:12:16.000000000 -0400
> > @@ -296,7 +296,7 @@
> >                          TEST(rc = syscall(__NR_set_mempolicy,
> > tc->policy,&nodemask, maxnode));
> > 
> >                 if (TEST_RETURN < 0) {
> > -                       tst_resm(TFAIL, "set_mempolicy() failed -
> > errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> > +                       tst_resm(TCONF, "set_mempolicy() failed -
> > errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> >                          result = 1;
> >                         cleanup();
> >                          tst_exit();
> > @@ -307,7 +307,7 @@
> >                  // mmap memory
> >                  p = mmap(NULL, len, PROT_READ|PROT_WRITE,MAP_PRIVATE|
> > MAP_ANONYMOUS, 0, 0);
> >                  if (p == (void*)-1) {
> > -                       tst_resm(TFAIL, "malloc failed - errno = %d :
> > %s",TEST_ERRNO, strerror(TEST_ERRNO));
> > +                       tst_resm(TCONF, "malloc failed - errno = %d :
> > %s",TEST_ERRNO, strerror(TEST_ERRNO));
> >                          result = 1;
> >                         cleanup();
> >                          tst_exit();
> 
> The problem reported on your machine is function not implemented.
> However, if you change the FAIL to blindly CONF, that will cause issues
> like actual failures reported wrongly.
> 
> See, whether you can find out ways to isolate only function not
> implemented part.
> 
> Regards--
> Subrata
> 
> 
As I don't know what are all the error reporting options LTP have, I
changed it to CONF. We can change it accordingly to need. Can we report
it as BROKEN, as set_mempolicy is preventing the get_mempolicy test to
run?

Regards
Muni


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
