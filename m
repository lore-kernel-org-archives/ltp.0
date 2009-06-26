Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MK9kY-0000zo-8Y
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 11:37:46 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MK9kV-00081M-DT
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 11:37:46 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5QBaxQo022242
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 05:36:59 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5QBbgFs251564
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 05:37:42 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5QBbfhA021285
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 05:37:41 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0906252310r45a7644fu46e1831841aa8b24@mail.gmail.com>
References: <d51f89b0906252310r45a7644fu46e1831841aa8b24@mail.gmail.com>
Date: Fri, 26 Jun 2009 17:03:15 +0530
Message-Id: <1246015995.6196.24.camel@subratamodak.linux.ibm.com>
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
To: rohit verma <rohit.170309@gmail.com>, Le Rouzic <aime.le-rouzic@bull.net>, =?ISO-8859-1?Q?Aur=E9lien?= Charbon <aurelien.charbon@ext.bull.net>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi Rohit,

On Thu, 2009-06-25 at 23:10 -0700, rohit verma wrote: 
> Hi All,
> 
> I am getting the following errors with run_rpc_tests.sh test suite in
> LTP May-09 release.

The problem with this part of the testsuite was always there from the
beginning. However, lets ask something from the developer directly.

Le,

Can you please look into this ?

Regards--
Subrata

> 
> /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:29:29:
> error: tirpc/netconfig.h: No such file or directory
> /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:31:27:
> error: tirpc/rpc/rpc.h: No such file or directory
> /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:32:29:
> error: tirpc/rpc/types.h: No such file or directory
> /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:33:27:
> error: tirpc/rpc/xdr.h: No such file or directory
> /home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:34:27:
> error: tirpc/rpc/svc.h: No such file or directory
> mkdir: cannot create directory
> `/home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack':
> File exists
> 
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:29:29: error: tirpc/netconfig.h:
> No such file or directory
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:31:27: error: tirpc/rpc/rpc.h: No
> such file or directory
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:32:29: error: tirpc/rpc/types.h:
> No such file or directory
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:33:27: error: tirpc/rpc/xdr.h: No
> such file or directory
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:34:27: error: tirpc/rpc/svc.h: No
> such file or directory
> tests_pack/tirpc_svc_2/tirpc_svc_2.c: In function main
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: bool_t undeclared
> (first use in this function)
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: (Each undeclared
> identifier is reported only once
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: for each function it
> appears in.)
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: expected ; before rslt
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:65: error: rslt undeclared (first
> use in this function)
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:66: error: xdrproc_t undeclared
> (first use in this function)
> tests_pack/tirpc_svc_2/tirpc_svc_2.c:66: error: expected ) before xdr_int
> make: *** [all] Error 1
> cc: .c.src: No such file or directory.
> 
> 
> Similar bug has been already reported to LTP. Please confirm if the
> patch for this bug is merged into next LTP release.

I remember merging all patches to this effect. Please point me to the
patch which i ought have missed ;-)

Regards--
Subrata

> 
> 
> Regards,
> Gnaneswar


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
