Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mgc5W-00037L-Mp
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 10:20:14 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mgc5S-0003TQ-TF
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 10:20:14 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7RAGJLp030939
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Aug 2009 04:16:19 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7RAK3ZS150192
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Aug 2009 04:20:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7RAK3uo005476
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Aug 2009 04:20:03 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A955C57.7020502@redhat.com>
References: <4A92DCAE.5060102@redhat.com>
	<1251194293.5534.24.camel@subratamodak.linux.ibm.com>
	<4A955C57.7020502@redhat.com>
Date: Thu, 27 Aug 2009 15:49:58 +0530
Message-Id: <1251368398.4993.18.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Bug in memory controller test - memctl test #4 -
	PATCH	repost
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
To: Mike Gahagan <mgahagan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

On Wed, 2009-08-26 at 12:01 -0400, Mike Gahagan wrote: 
> On 08/25/2009 05:58 AM, Subrata Modak wrote:
> > On Mon, 2009-08-24 at 14:32 -0400, Mike Gahagan wrote:
> >> When running the Memory Controller test # 4, I'm seeing this behavior below.
> >>
> >> TEST 4: MEMORY CONTROLLER TESTING
> >> RUNNING SETUP.....
> >> TEST STARTED: Please avoid using system while this test executes
> >> /mnt/tests/kernel/distribution/ltp/20090731/ltp-full-20090731/testcases/bin/run_memctl_test.sh:
> >> line 327: [: 62955520: unary operator expected
> >> TINFO   Memory Resource Controller: stat check test fails in first run
> >> /mnt/tests/kernel/distribution/ltp/20090731/ltp-full-20090731/testcases/bin/run_memctl_test.sh:
> >> line 364: [: 78704640: unary operator expected
> >> TFAIL   Memory Resource Controller: stat check test FAILED
> >> *** infinite loop here, script exists memctl_test01 remains running ***
> >> ^Cincrementing stop
> >>
> >> The bash error is due to the 'grep -w "active"' not matching anything so
> >> one of the variables isn't getting set like it is supposed to. I believe
> >> the test was written with an old version of the memory controller what
> >> put a field called memory.stat.active in the file memory.stat. The
> >
> > Correct. Somebody needs to revisit these tests, as the ABIs has changed.

Would be able to spend some time here ?

> > Thanks for pointing that out. However, your patch has the following
> > problem:
> >
> > 1) Missing Signed-off-by:
> > 2) missing header for unified diff at line 3 of patch
> > patching file testcases/kernel/controllers/memctl/run_memctl_test.sh
> >
> > Please look into them when you send a patch next time ;-)
> >
> > Regards--
> > Subrata
> >
> >> current memory controller I am testing appears to have replaced this
> >> field with "rss". There are fields showing anonymous and file backed
> >> pages in memory.stat, but I don't think they are ever going to match the
> >> memory.usage.in.bytes the test is looking for. Rss always matches and I
> >> believe that is what we should update the check in the test to look for.
> >> The attached patch fixes test #4 to compare memory.usage.in.bytes with rss.
> >> ------------------------------------------------------------------------------
> 
> Hello,
> 
> Here is a resubmission of my memctl test patch. It should clear up the 
> issues noted above. No functional change from the previous patch.
> 
> Signed-off-by: Mike Gahagan <mgahagan@redhat.com>

Thanks. I already merged your patch.

Regards--
Subrata

> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
