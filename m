Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLzf4-0000pI-0r
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 13:15:42 +0000
Received: from [32.97.110.154] (helo=e36.co.us.ibm.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLzey-0003Vt-CG
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 13:15:37 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n61DD9ws018941
	for <ltp-list@lists.sourceforge.net>; Wed, 1 Jul 2009 07:13:09 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n61DEYkm043670
	for <ltp-list@lists.sourceforge.net>; Wed, 1 Jul 2009 07:14:37 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n61DEXcT025749
	for <ltp-list@lists.sourceforge.net>; Wed, 1 Jul 2009 07:14:34 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810907010146s247bfbc0w3e6ca9213a927d7@mail.gmail.com>
References: <f5a7b3810906300042w14bc6a4fp8046160d07d8254e@mail.gmail.com>
	<1246360333.4819.53.camel@subratamodak.linux.ibm.com>
	<f5a7b3810907010146s247bfbc0w3e6ca9213a927d7@mail.gmail.com>
Date: Wed, 01 Jul 2009 18:43:42 +0530
Message-Id: <1246454022.6978.54.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCHES] ltp-mq_unlink_speculative_7-2
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

On Wed, 2009-07-01 at 14:16 +0530, naresh kamboju wrote:
> On Tue, Jun 30, 2009 at 4:42 PM, Subrata
> Modak<subrata@linux.vnet.ibm.com> wrote:
> > Hi Naresh,
> >
> > On Tue, 2009-06-30 at 13:12 +0530, naresh kamboju wrote:
> >> Hi,
> >>
> >> I have noticed failure under open_posix_testsuite for
> >> mq_unlink/speculative/7-2.c and fixed.
> >> After changing the uninitialized to initialized char array of mqname[]
> >> test case got PASSED.
> >
> > Great. Could you also please share with us the test results before and
> > after this patch ?
> 
> Before patch Results:
> 
> conformance/interfaces/mq_unlink/speculative/7-2: execution: FAILED
> # ./7-2.test
> Test FAILED, error is Invalid argument
> 
> After patch Results:
> 
> conformance/interfaces/mq_unlink/speculative/7-2: execution: PASS
> # ./7-2.test
> Test PASSED

Thanks. What better way to start July to checkin your patch.

Regards--
Subrata

> 
> 
> Best regards,
> Naresh Kamboju
> 
> >
> > Regards--
> > Subrata
> >
> >>
> >> I have attached patch and below.
> >> Please review the same.
> >>
> >>
> >> Best Regards
> >> Naresh Kamboju
> >>
> >> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> >>
> >>
> >> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
> >> b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
> >> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
> >> 2005-06-03 22:00:59.000000000 +0530
> >> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
> >> 2009-06-30 12:37:35.000000000 +0530
> >> @@ -28,7 +28,7 @@
> >>
> >>  int main()
> >>  {
> >> -       char mqname[50];
> >> +       char mqname[50]="/123";
> >>
> >>  //     sprintf(mqname, FUNCTION "_" TEST "_%d", getpid());
> >
> >


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
