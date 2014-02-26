Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WIaEm-0004aN-UZ
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 08:53:08 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WIaEl-0006er-R7
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 08:53:08 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1Q8r1QT018565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:01 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1Q8r0H3016939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:01 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1Q8r0JA014885
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:00 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 26 Feb 2014 12:52:43 +0400
Message-Id: <1393404766-18032-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1393404766-18032-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1393404766-18032-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/6] testcases/kernel/fs/ext4-new-features: added
	.gitignore
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
Cc: vasily.isaenko@oracle.com

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/fs/ext4-new-features/.gitignore |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/fs/ext4-new-features/.gitignore

diff --git a/testcases/kernel/fs/ext4-new-features/.gitignore b/testcases/kernel/fs/ext4-new-features/.gitignore
new file mode 100644
index 0000000..d0f1f74
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/.gitignore
@@ -0,0 +1,4 @@
+/ext4-inode-version/ext4_test_inode_version
+/ext4-nsec-timestamps/ext4_file_time
+/ext4-subdir-limit/create_long_dirs
+/ext4-subdir-limit/create_short_dirs
-- 
1.7.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
