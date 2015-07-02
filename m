Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1ZAX3w-0004Oj-PA
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 05:29:28 +0000
Received: from mail-pa0-f52.google.com ([209.85.220.52])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZAX3w-0002XR-0W
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 05:29:28 +0000
Received: by paceq1 with SMTP id eq1so34414547pac.3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 01 Jul 2015 22:29:22 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Thu,  2 Jul 2015 13:29:09 +0800
Message-Id: <1435814949-4420-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH] network/xinetd: wait a while to make sure telnetd
	restart
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
To: LTP List <ltp-list@lists.sourceforge.net>

telnetd not restart immediately after xinetd restart, which make xinetd
failed. e.g.
\# service xinetd restart; echo "^D" | /usr/bin/telnet ::1
Stopping xinetd: [  OK  ]
Starting xinetd: [  OK  ]
Trying ::1...
telnet: connect to address ::1: Connection refused

Wait a while after xinetd restart will make sure telnetd up and the test passed

\# service xinetd restart; sleep 1; echo "^D" | /usr/bin/telnet ::1
Stopping xinetd: [  OK  ]
Starting xinetd: [  OK  ]
Trying ::1...
Connected to ::1.
Escape character is '^]'.
Connection closed by foreign host.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/network/xinetd/xinetd_tests.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index ff1219a..a12f6b9 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -315,6 +315,8 @@ test01()
         fi
     fi
 
+    sleep 1s
+
     # Not checking for exit code from telnet command because telnet is
     # not terminated by the test gracefully.
     if [ $IPV6_ENABLED -eq 1 ]
@@ -381,6 +383,8 @@ test01()
         fi
     fi
 
+    sleep 1s
+
     # Not checking for exit code from telnet command because telnet is
     # not terminated by the test gracefully.
     if [ $IPV6_ENABLED -eq 1 ]
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
