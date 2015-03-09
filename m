Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YUtB7-0006r7-0K
	for ltp-list@lists.sourceforge.net; Mon, 09 Mar 2015 08:36:45 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YUtB0-0002zR-6t
	for ltp-list@lists.sourceforge.net; Mon, 09 Mar 2015 08:36:39 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t298Zdmq028283
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Mar 2015 16:35:39 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 9 Mar 2015 16:32:02 +0800
Message-ID: <1425889922-13650-7-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1425889922-13650-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1425889922-13650-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 7/7] ipv6_lib: add it into default
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
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
