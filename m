Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VoX2G-0000L0-CO
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 11:24:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoX2F-0000ZE-22
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 11:24:00 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB5BNqx4002869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 06:23:52 -0500
Received: from dustball.brq.redhat.com (dhcp-26-174.brq.redhat.com
	[10.34.26.174])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id rB5BNp2h020810
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 06:23:52 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  5 Dec 2013 12:23:49 +0100
Message-Id: <e4485bb27118d14c0247d35fcea0f85458cda012.1386242514.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] sendmsg01: use invalid but positive msg_namelen value
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

After following 2 kernel commits:
  commit 1661bf364ae9c506bc8795fef70d1532931be1e8
  Author: Dan Carpenter <dan.carpenter@oracle.com>
  Date:   Thu Oct 3 00:27:20 2013 +0300
    net: heap overflow in __audit_sockaddr()

  commit db31c55a6fb245fdbb752a2ca4aefec89afabb06
  Author: Dan Carpenter <dan.carpenter@oracle.com>
  Date:   Wed Nov 27 15:40:21 2013 +0300
    net: clamp ->msg_namelen instead of returning an error

msg_namelen is treated as an unsigned value because of this
condition, which compares signed and unsigned arguments:
net/socket.c copy_msghdr_from_user()
  if (kmsg->msg_namelen > sizeof(struct sockaddr_storage))

User-space (accordding to POSIX spec) defines it as
"unsigned opaque integral type of length of at least 32 bits".

Passing -1 now has the effect as passing very large number
and syscall completes successfully.

Change the test to use invalid, but positive value for
"invalid to buffer length" testcase.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Tested-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 testcases/kernel/syscalls/sendmsg/sendmsg01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 5c79a45..81d5770 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -211,7 +211,7 @@ struct test_case_t tdat[] = {
 	 .msg = &msgdat,
 	 .flags = 0,
 	 .to = (struct sockaddr *)&sin1,
-	 .tolen = -1,
+	 .tolen = 1,
 	 .retval = -1,
 	 .experrno = EINVAL,
 	 .setup = setup1,
-- 
1.7.1


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
