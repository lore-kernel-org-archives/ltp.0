Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pradeepkumars@in.ibm.com>) id 1MLaF7-0000RD-AK
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 10:07:13 +0000
Received: from [59.145.155.9] (helo=e28smtp09.in.ibm.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLaEs-0000TQ-VX
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 10:07:00 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp09.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5U9Huut021050
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 14:47:56 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UA65Qt2388132
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 15:36:05 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5UA642C012997
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 20:06:05 +1000
In-Reply-To: <1245346293.5041.33.camel@subratamodak.linux.ibm.com>
References: <1244635585.9465.14.camel@munipradeep-laptop>
	<1245346293.5041.33.camel@subratamodak.linux.ibm.com>
Message-ID: <OFF5ACF1B3.29E4D0F4-ON652575E5.00372C88-652575E5.00378A50@in.ibm.com>
From: Pradeep K Surisetty <pradeepkumars@in.ibm.com>
Date: Tue, 30 Jun 2009 15:34:26 +0530
MIME-Version: 1.0
Subject: Re: [LTP] Some of the testcases which are resulting in FAIL even
 though	they might not be
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
Cc: ltp-list@lists.sourceforge.net, rohit verma <rohit.170309@gmail.com>, Iranna D Ankad <iranna.ankad@in.ibm.com>



Subrata Modak <subrata@linux.vnet.ibm.com> wrote on 06/18/2009 11:01:32 PM:

> Subrata Modak <subrata@linux.vnet.ibm.com>
> 06/18/2009 11:01 PM
>
> Please respond to
> subrata@linux.vnet.ibm.com
>
> To
>
> Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>, Pradeep K
> Surisetty/India/IBM@IBMIN, Cai Qian <caiqian@cclom.cn>, rohit verma
> <rohit.170309@gmail.com>
>
> cc
>
> ltp-list@lists.sourceforge.net, Iranna D Ankad/India/IBM@IBMIN
>
> Subject
>
> Re: Some of the testcases which are resulting in FAIL even though
> they might not be
>
> On Wed, 2009-06-10 at 17:36 +0530, Munipradeep Beerakam wrote:
> > Hi,
> >
> > Here is the list of testcases in May 2009 LTP, which *may* result in
> > FAIL even though it is a configuration error, not the error due to the
> > functionality we are testing. Those tests should give "CONF" message,
> > not "FAIL". I ran LTP on 2.6.18 kernel, x86 architecture.
> >
> >    1. InitNuma
> > Error output:
> > Initnuma 0 WARN : non-NUMA aware kernel is running or your machine does
> > not support numa policy or
> > your machine is not a NUMA machine
> > Initnuma 1 FAIL : INIT NUMA FAILED !!
>
> Contact Pradeep for this.

Hi Subrata,

I have noticed few issues with NUMA test cases.
Currently I am investigating and get back to you in short.

Best Regards
Pradeep


>
> >
> >    2. ht_enable
> > Error output:
> > ht_enable 0 INFO : Begin: HyperThreading Enabled
> > ht_enable 0 INFO : The kernel boot paramter 'noht' is not set.
> > ht_enable 1 FAIL : HT feature is not included in this Linux Kernel.
> > ht_enable 0 INFO : End: HyperThreading Enabled
> >
>
> Cai/Rohit has been discussing this for long.
>
> > 3. get_mempolicy01
> > Part of code, which is not correct
> > tst_resm(TFAIL, "set_mempolicy() failed - errno = %d : %s",TEST_ERRNO,
> > strerror(TEST_ERRNO));
> > ...
> > ...
> > tst_resm(TFAIL, "malloc failed - errno = %d : %s",TEST_ERRNO,
> > strerror(TEST_ERRNO));
> >
> >    4. mq_open01
> > Part of code, which is not correct
> > if (TEST_RETURN < 0) {
> >                         tst_resm(TFAIL, "mq_getsetattr failed - errno =
> > %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> >
>
> And they are as per my earlier mail.
>
> Regards--
> Subrata
>
> > Regards
> > Muni
> >
>


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
