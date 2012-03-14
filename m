Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1S7mcm-0003hv-Su
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 11:44:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7mcl-0000qw-SK
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 11:44:12 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2EBi5IC010302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Mar 2012 07:44:06 -0400
Message-ID: <4F608484.30205@redhat.com>
Date: Wed, 14 Mar 2012 12:44:04 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070009030507060805020102"
Subject: [LTP] [PATCH] readlink03: fix expected errno for kernel >=3.2
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
--------------070009030507060805020102
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


This kernel commit restored original behavior:
commit 1fa1e7f615f4d3ae436fa319af6e4eebdd4026a8
Author: Andy Whitcroft <apw@canonical.com>
Date:   Wed Nov 2 09:44:39 2011 +0100
     readlinkat: ensure we return ENOENT for the empty pathname for
normal lookups

For kernel >= 3.2, ENOENT should be expected errno code.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/syscalls/readlink/readlink03.c |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)



--------------070009030507060805020102
Content-Type: text/x-patch;
	name="0001-readlink03-fix-expected-errno-for-kernel-3.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-readlink03-fix-expected-errno-for-kernel-3.2.patch"

diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index 370bf7d..85141f9 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -174,7 +174,8 @@ int main(int ac, char **av)
 			}
 
 			if (strncmp(test_desc, "Symlink Pathname is empty", 25) == 0) {
-				if ((tst_kvercmp(2, 6, 39)) >= 0)
+				if (tst_kvercmp(2, 6, 39) >= 0
+					&& tst_kvercmp(3, 2, 0) < 0)
 					Test_cases[i].exp_errno = EINVAL;
 			}
 


--------------070009030507060805020102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--------------070009030507060805020102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070009030507060805020102--

