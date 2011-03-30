Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q4wSB-0004Io-7q
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 14:32:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q4wSA-0002rx-A8
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 14:32:59 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2UEWqqB032282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Mar 2011 10:32:52 -0400
From: czhang@redhat.com
Date: Wed, 30 Mar 2011 22:32:35 +0800
Message-Id: <1301495555-29016-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] syscalls:epoll01: turn off flooding verbose output
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
Cc: Caspar Zhang <czhang@redhat.com>

From: Caspar Zhang <czhang@redhat.com>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

It's a small fix, not affecting functions.

epoll01 test put 13000+ lines output, it increases the size of log
file and also make me review the log more difficult. I put a "DEBUG
switch" in the code and make it turned off by default.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/epoll/epoll-ltp.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0003-syscalls-epoll01-turn-off-flooding-verbose-output.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0003-syscalls-epoll01-turn-off-flooding-verbose-output.patch"

diff --git a/testcases/kernel/syscalls/epoll/epoll-ltp.c b/testcases/kernel/syscalls/epoll/epoll-ltp.c
index c2e4a5c..3aa8c9d 100644
--- a/testcases/kernel/syscalls/epoll/epoll-ltp.c
+++ b/testcases/kernel/syscalls/epoll/epoll-ltp.c
@@ -98,8 +98,8 @@
 #include "config.h"
 #include "test.h"
 
-char *TCID = "sys_epoll02";	/* test program identifier */
-int TST_TOTAL = 1;		/* total number of tests in this file */
+char *TCID = "epoll01";
+int TST_TOTAL = 1;
 
 #ifdef HAVE_SYS_EPOLL_H
 
@@ -627,9 +627,13 @@ int test_epoll_ctl(int epoll_fd)
 									      [result]));
 							}
 							num_epoll_ctl_test_fails++;
+#ifdef DEBUG
 						} else	/* The call of epoll_ctl behaved as expected */
 							EPOLL_CTL_TEST_PASS((result_strings
 									     [result]));
+#else
+						}
+#endif
 					}
 				}
 			}
@@ -693,4 +697,4 @@ int main(void)
 	tst_brkm(TCONF, NULL, "No epoll support found.");
 }
 
-#endif
\ No newline at end of file
+#endif

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



