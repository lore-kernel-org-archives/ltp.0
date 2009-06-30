Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLY5G-0007Bw-Jf
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:48:54 +0000
Received: from [32.97.182.146] (helo=e6.ny.us.ibm.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLY5E-0004kW-NY
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:48:53 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5U7pPbh021063
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 03:51:25 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5U7mInX240530
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 03:48:18 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5U7mHcZ027560
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 03:48:18 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1246015995.6196.24.camel@subratamodak.linux.ibm.com>
References: <d51f89b0906252310r45a7644fu46e1831841aa8b24@mail.gmail.com>
	<1246015995.6196.24.camel@subratamodak.linux.ibm.com>
Date: Tue, 30 Jun 2009 13:11:27 +0530
Message-Id: <1246347687.4819.34.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Issues of TIRPC test suite of network test cases
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
To: rohit verma <rohit.170309@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>, Le Rouzic <aime.le-rouzic@bull.net>, =?ISO-8859-1?Q?Aur=E9lien?= Charbon <aurelien.charbon@ext.bull.net>

On Fri, 2009-06-26 at 17:03 +0530, Subrata Modak wrote: 
> Hi Rohit,
> 
> On Thu, 2009-06-25 at 23:10 -0700, rohit verma wrote: 
> > Hi All,
> > 
> > I am getting the following errors with run_rpc_tests.sh test suite in
> > LTP May-09 release.
> 
> The problem with this part of the testsuite was always there from the
> beginning. However, lets ask something from the developer directly.
> 
> Le,
> 
> Can you please look into this ?

Le,

Any comments from your side ??

Regards--
Subrata

> 
> Regards--
> Subrata
> 
> > 
> > /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:29:29:
> > error: tirpc/netconfig.h: No such file or directory
> > /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:31:27:
> > error: tirpc/rpc/rpc.h: No such file or directory
> > /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:32:29:
> > error: tirpc/rpc/types.h: No such file or directory
> > /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:33:27:
> > error: tirpc/rpc/xdr.h: No such file or directory
> > /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:34:27:
> > error: tirpc/rpc/svc.h: No such file or directory
> > mkdir: cannot create directory
> > `/home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack':
> > File exists
> > 
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:29:29: error: tirpc/netconfig.h:
> > No such file or directory
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:31:27: error: tirpc/rpc/rpc.h: No
> > such file or directory
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:32:29: error: tirpc/rpc/types.h:
> > No such file or directory
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:33:27: error: tirpc/rpc/xdr.h: No
> > such file or directory
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:34:27: error: tirpc/rpc/svc.h: No
> > such file or directory
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c: In function main
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: bool_t undeclared
> > (first use in this function)
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: (Each undeclared
> > identifier is reported only once
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: for each function it
> > appears in.)
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: expected ; before rslt
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:65: error: rslt undeclared (first
> > use in this function)
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:66: error: xdrproc_t undeclared
> > (first use in this function)
> > tests_pack/tirpc_svc_2/tirpc_svc_2.c:66: error: expected ) before xdr_int
> > make: *** [all] Error 1
> > cc: .c.src: No such file or directory.
> > 
> > 
> > Similar bug has been already reported to LTP. Please confirm if the
> > patch for this bug is merged into next LTP release.
> 
> I remember merging all patches to this effect. Please point me to the
> patch which i ought have missed ;-)
> 
> Regards--
> Subrata
> 
> > 
> > 
> > Regards,
> > Gnaneswar
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
