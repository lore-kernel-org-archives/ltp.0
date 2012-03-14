Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1S7pZi-0002bR-5d
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 14:53:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7pZc-0001vS-J9
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 14:53:14 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2EEr2kd024230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Mar 2012 10:53:02 -0400
Message-ID: <4F60B0CC.606@redhat.com>
Date: Wed, 14 Mar 2012 15:53:00 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020107080509010902070907"
Subject: [LTP] [PATCH] io_submit: uninitialized iocb may not return -EINVAL
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jeffrey Burke <jburke@redhat.com>

This is a multi-part message in MIME format.
--------------020107080509010902070907
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Testcase 1.3 - EINVAL: uninitialized iocb
is about submitting uninitialized iocb structure.

Test is expecting to get -EINVAL, but other values are also
possible as uninitialized struct can contain any values.

For example following data fails with -EBADF:
--- snip ---
unsigned char bad_iocb[64] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x84, 0xa5,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x0f, 0xff, 0xe0, 0x10, 0x0c, 0x30,
     0x00, 0x00, 0x0f, 0xff, 0xe0, 0x10, 0x0c, 0x40,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
memcpy(&iocb, bad_iocb, sizeof(iocb));
iocbs[0] = &iocb;
TEST(io_submit(ctx, 1, iocbs));
check_result(-EINVAL, TEST_RETURN);
--- snip ---

This patch accepts also few other errno codes as valid return value.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/syscalls/io_submit/io_submit01.c |   16 +++++++++++++++-
  1 files changed, 15 insertions(+), 1 deletions(-)



--------------020107080509010902070907
Content-Type: text/x-patch;
	name="0001-io_submit-uninitialized-iocb-may-not-return-EINVAL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-io_submit-uninitialized-iocb-may-not-return-EINVAL.patc";
	filename*1="h"

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index da15aa0..3983fa4 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -126,7 +126,21 @@ int main(int argc, char *argv[])
 		/* 1.3 - EINVAL: uninitialized iocb */
 		iocbs[0] = &iocb;
 		TEST(io_submit(ctx, 1, iocbs));
-		check_result(-EINVAL, TEST_RETURN);
+		switch(TEST_RETURN) {
+			case -EINVAL:
+			case -EBADF:
+			case -EFAULT:
+			case -EPERM:
+				tst_resm(TPASS, "expected failure - "
+						"returned value = %ld : %s",
+						TEST_RETURN, strerror(-1 * TEST_RETURN));
+				break;
+			default:
+				tst_resm(TFAIL, "unexpected failure - "
+						"returned value = %ld : %s, "
+						"expected one of -EINVAL, -EBADF, -EFAULT, -EPERM",
+						TEST_RETURN, strerror(-1 * TEST_RETURN));
+		}
 
 		/* 2 - EFAULT: iocb points to invalid data */
 		TEST(io_submit(ctx, 1, (struct iocb **)-1));


--------------020107080509010902070907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--------------020107080509010902070907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020107080509010902070907--

