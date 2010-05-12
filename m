Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OCFv9-0005pW-5C
	for ltp-list@lists.sourceforge.net; Wed, 12 May 2010 17:40:35 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OCFv6-00063Q-Nq
	for ltp-list@lists.sourceforge.net; Wed, 12 May 2010 17:40:35 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Wed, 12 May 2010 23:10:23 +0530
Message-Id: <1273686023.4910.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [RFC] Testcase for recvmmsg(),
	a syscall for batching recvmsg()	calls
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
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hello Arnaldo,

Your code in 2.6.33 kernel introduced a new system call called
recvmmsg(), a syscall for batching recvmsg() calls. Would you like to
share the set of test cases you used to test this new code with the LTP
community ?

Regards--
Subrata



------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
