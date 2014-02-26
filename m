Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WIaEp-0004tr-0R
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 08:53:11 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WIaEn-0008RJ-Vu
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 08:53:10 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1Q8r3h3018791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:04 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1Q8r29N017083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:03 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1Q8r2IM014993
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:02 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 26 Feb 2014 12:52:45 +0400
Message-Id: <1393404766-18032-6-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1393404766-18032-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1393404766-18032-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 5/6] kernel/module/delete_module: added .gitignore
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
 testcases/kernel/module/delete_module/.gitignore |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/module/delete_module/.gitignore

diff --git a/testcases/kernel/module/delete_module/.gitignore b/testcases/kernel/module/delete_module/.gitignore
new file mode 100644
index 0000000..8ffd425
--- /dev/null
+++ b/testcases/kernel/module/delete_module/.gitignore
@@ -0,0 +1,5 @@
+/delete_module01
+/delete_module02
+/delete_module03
+/dummy_del_mod.ko
+/dummy_del_mod_dep.ko
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
