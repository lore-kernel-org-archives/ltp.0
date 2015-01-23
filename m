Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YEaj0-0006iF-Sr
	for ltp-list@lists.sourceforge.net; Fri, 23 Jan 2015 09:40:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YEaiw-0004vr-Kj
	for ltp-list@lists.sourceforge.net; Fri, 23 Jan 2015 09:40:20 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t0N9dYr2006601
	for <ltp-list@lists.sourceforge.net>; Fri, 23 Jan 2015 17:39:34 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 23 Jan 2015 17:36:12 +0800
Message-ID: <1422005772-19099-7-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1422005772-19099-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1422005772-19099-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 7/7] ipv6_lib: add it into default
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
To: ltp-list@lists.sourceforge.net

* Add ipv6_lib tests to scenario_groups/default.

* Currently I'm not very clear about some test
  cases eg. asapi_04.c, so disable them. Later
  I will add it subsequently.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 runtest/ipv6_lib        | 8 ++++----
 scenario_groups/default | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/runtest/ipv6_lib b/runtest/ipv6_lib
index 75614fb..4b49cb5 100644
--- a/runtest/ipv6_lib
+++ b/runtest/ipv6_lib
@@ -1,11 +1,11 @@
 #DESCRIPTION:IPV6 related tests
 in6_01 in6_01
 in6_02 in6_02
-getaddrinfo_01 getaddrinfo_01
+#getaddrinfo_01 getaddrinfo_01
 asapi_01 asapi_01
 asapi_02 asapi_02
 asapi_03 asapi_03
-asapi_04 asapi_04
-asapi_05 asapi_05
-asapi_06 asapi_06
+#asapi_04 asapi_04
+#asapi_05 asapi_05
+#asapi_06 asapi_06
 asapi_07 asapi_07
diff --git a/scenario_groups/default b/scenario_groups/default
index 3a55702..60b1b27 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -32,3 +32,4 @@ dma_thread_diotest
 cpuacct
 can
 cpuhotplug
+ipv6_lib
-- 
1.9.3


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
