Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1MEMZH-00059t-0w
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2009 12:06:11 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MEMZE-0002Ii-Ch
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2009 12:06:10 +0000
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5AC5xrS011935
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2009 22:05:59 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5AC63wI393704
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2009 22:06:04 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5AC63u3023370
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2009 22:06:03 +1000
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Date: Wed, 10 Jun 2009 17:36:25 +0530
Message-Id: <1244635585.9465.14.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: [LTP] Some of the testcases which are resulting in FAIL even though
	they	might not be
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
To: ltp-list@lists.sourceforge.net
Cc: iranna.ankad@in.ibm.com

Hi,

Here is the list of testcases in May 2009 LTP, which *may* result in
FAIL even though it is a configuration error, not the error due to the
functionality we are testing. Those tests should give "CONF" message,
not "FAIL". I ran LTP on 2.6.18 kernel, x86 architecture.

   1. InitNuma
Error output:
Initnuma 0 WARN : non-NUMA aware kernel is running or your machine does
not support numa policy or
your machine is not a NUMA machine
Initnuma 1 FAIL : INIT NUMA FAILED !!

   2. ht_enable
Error output:
ht_enable 0 INFO : Begin: HyperThreading Enabled
ht_enable 0 INFO : The kernel boot paramter 'noht' is not set.
ht_enable 1 FAIL : HT feature is not included in this Linux Kernel.
ht_enable 0 INFO : End: HyperThreading Enabled

   3. get_mempolicy01
Part of code, which is not correct
tst_resm(TFAIL, "set_mempolicy() failed - errno = %d : %s",TEST_ERRNO,
strerror(TEST_ERRNO));
...
...
tst_resm(TFAIL, "malloc failed - errno = %d : %s",TEST_ERRNO,
strerror(TEST_ERRNO));

   4. mq_open01
Part of code, which is not correct
if (TEST_RETURN < 0) {
                        tst_resm(TFAIL, "mq_getsetattr failed - errno =
%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));

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
