Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLSm-0007Zv-4l
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:31:48 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLSh-0006VW-Ma
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:31:48 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5IHPUHv011796
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:25:30 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IHVfAY229206
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:31:42 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IHVek5030113
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:31:41 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1244635585.9465.14.camel@munipradeep-laptop>
References: <1244635585.9465.14.camel@munipradeep-laptop>
Date: Thu, 18 Jun 2009 23:01:32 +0530
Message-Id: <1245346293.5041.33.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Some of the testcases which are resulting in FAIL even
	though	they might not be
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
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>, pradeepkumars <pradeepkumars@in.ibm.com>, Cai Qian <caiqian@cclom.cn>, rohit verma <rohit.170309@gmail.com>
Cc: ltp-list@lists.sourceforge.net, iranna.ankad@in.ibm.com

On Wed, 2009-06-10 at 17:36 +0530, Munipradeep Beerakam wrote: 
> Hi,
> 
> Here is the list of testcases in May 2009 LTP, which *may* result in
> FAIL even though it is a configuration error, not the error due to the
> functionality we are testing. Those tests should give "CONF" message,
> not "FAIL". I ran LTP on 2.6.18 kernel, x86 architecture.
> 
>    1. InitNuma
> Error output:
> Initnuma 0 WARN : non-NUMA aware kernel is running or your machine does
> not support numa policy or
> your machine is not a NUMA machine
> Initnuma 1 FAIL : INIT NUMA FAILED !!

Contact Pradeep for this.

> 
>    2. ht_enable
> Error output:
> ht_enable 0 INFO : Begin: HyperThreading Enabled
> ht_enable 0 INFO : The kernel boot paramter 'noht' is not set.
> ht_enable 1 FAIL : HT feature is not included in this Linux Kernel.
> ht_enable 0 INFO : End: HyperThreading Enabled
> 

Cai/Rohit has been discussing this for long.

> 3. get_mempolicy01
> Part of code, which is not correct
> tst_resm(TFAIL, "set_mempolicy() failed - errno = %d : %s",TEST_ERRNO,
> strerror(TEST_ERRNO));
> ...
> ...
> tst_resm(TFAIL, "malloc failed - errno = %d : %s",TEST_ERRNO,
> strerror(TEST_ERRNO));
> 
>    4. mq_open01
> Part of code, which is not correct
> if (TEST_RETURN < 0) {
>                         tst_resm(TFAIL, "mq_getsetattr failed - errno =
> %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> 

And they are as per my earlier mail.

Regards--
Subrata

> Regards
> Muni
> 


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
