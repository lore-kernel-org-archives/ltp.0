Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YQXzU-0008S2-7J
	for ltp-list@lists.sourceforge.net; Wed, 25 Feb 2015 09:10:48 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YQXzT-0003Mb-Ad
	for ltp-list@lists.sourceforge.net; Wed, 25 Feb 2015 09:10:48 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1P9Aecj028323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Feb 2015 09:10:41 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1P9AdjA028022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Feb 2015 09:10:40 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1P9AdvO021915
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Feb 2015 09:10:39 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Feb 2015 12:13:05 +0300
Message-Id: <1424855586-9818-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1424855586-9818-1-git-send-email-alexey.kodanev@oracle.com>
References: <1424855586-9818-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/3] runtest/kernel_misc: add lock_torture.sh
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/kernel_misc |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index c12c31e..6a29de6 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -8,3 +8,4 @@ ltp_acpi ltp_acpi
 cpufreq_boost cpufreq_boost
 uaccess uaccess
 rcu_torture rcu_torture.sh
+lock_torture lock_torture.sh
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
