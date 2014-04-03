Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WVf9O-0007l0-8N
	for ltp-list@lists.sourceforge.net; Thu, 03 Apr 2014 10:45:38 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WVf9N-0006Fx-9s
	for ltp-list@lists.sourceforge.net; Thu, 03 Apr 2014 10:45:38 +0000
Message-ID: <533D3BC7.8010309@oracle.com>
Date: Thu, 03 Apr 2014 14:45:27 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: [LTP] numastats updates
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
To: linux-numa@vger.kernel.org
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hello!

In LTP we have a test - numa01.sh 
(https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/numa/numa01.sh)

In general, this script does something like:
   * numastat > /tmp/before
   * starts a binary with the specified numa memory policy using numactl 
(or a like):
     numactl --interleave=all get_some_memory_with_malloc_and_write_it
   * `sleep` for few seconds
   * numastat > /tmp/after
   * compares /tmp/before and /tmp/after to check that the numa policy
was applied the right way

But the problem is that on a host with many NUMA nodes (8) the process
of updating that numastats statistics takes some time. Even 10 seconds
may be not enough. Therefore the test fails.

Is there a direct or indirect way to force the kernel to update the NUMA 
statistics?

Thank you.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
