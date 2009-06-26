Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MK4e3-0008Jj-Uj
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 06:10:43 +0000
Received: from ey-out-1920.google.com ([74.125.78.144])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MK4dz-0005ub-8G
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 06:10:43 +0000
Received: by ey-out-1920.google.com with SMTP id 5so98605eyb.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Jun 2009 23:10:37 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 25 Jun 2009 23:10:36 -0700
Message-ID: <d51f89b0906252310r45a7644fu46e1831841aa8b24@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: [LTP] Issues of TIRPC test suite of network test cases
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
To: subrata@linux.vnet.ibm.com, LTP List <ltp-list@lists.sourceforge.net>, CAI Qian <caiqian@cclom.cn>

Hi All,

I am getting the following errors with run_rpc_tests.sh test suite in
LTP May-09 release.

/home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:29:29:
error: tirpc/netconfig.h: No such file or directory
/home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:31:27:
error: tirpc/rpc/rpc.h: No such file or directory
/home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:32:29:
error: tirpc/rpc/types.h: No such file or directory
/home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:33:27:
error: tirpc/rpc/xdr.h: No such file or directory
/home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src:34:27:
error: tirpc/rpc/svc.h: No such file or directory
mkdir: cannot create directory
`/home/moblin/LTP_NS_MAY/ltp-full-20090531/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack':
File exists

tests_pack/tirpc_svc_2/tirpc_svc_2.c:29:29: error: tirpc/netconfig.h:
No such file or directory
tests_pack/tirpc_svc_2/tirpc_svc_2.c:31:27: error: tirpc/rpc/rpc.h: No
such file or directory
tests_pack/tirpc_svc_2/tirpc_svc_2.c:32:29: error: tirpc/rpc/types.h:
No such file or directory
tests_pack/tirpc_svc_2/tirpc_svc_2.c:33:27: error: tirpc/rpc/xdr.h: No
such file or directory
tests_pack/tirpc_svc_2/tirpc_svc_2.c:34:27: error: tirpc/rpc/svc.h: No
such file or directory
tests_pack/tirpc_svc_2/tirpc_svc_2.c: In function main
tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: bool_t undeclared
(first use in this function)
tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: (Each undeclared
identifier is reported only once
tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: for each function it
appears in.)
tests_pack/tirpc_svc_2/tirpc_svc_2.c:55: error: expected ; before rslt
tests_pack/tirpc_svc_2/tirpc_svc_2.c:65: error: rslt undeclared (first
use in this function)
tests_pack/tirpc_svc_2/tirpc_svc_2.c:66: error: xdrproc_t undeclared
(first use in this function)
tests_pack/tirpc_svc_2/tirpc_svc_2.c:66: error: expected ) before xdr_int
make: *** [all] Error 1
cc: .c.src: No such file or directory.


Similar bug has been already reported to LTP. Please confirm if the
patch for this bug is merged into next LTP release.


Regards,
Gnaneswar

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
