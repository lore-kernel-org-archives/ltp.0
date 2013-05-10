Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UajRW-0002Ak-Tr
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 09:16:46 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UajRO-0004is-K4
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 09:16:46 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4A9GWik031864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 10 May 2013 05:16:33 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 10 May 2013 17:13:58 +0800
Message-Id: <25673a6d4dd7b2b6cd5ccf23308706256cd3c49c.1368177082.git.zliu@redhat.com>
In-Reply-To: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
References: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
In-Reply-To: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
References: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
Subject: [LTP] [PATCH 2/3] mem: introduce clean_node() func
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

There's set_node func introduced in commit cb2967b27a65, but we
don't have a func to clean the node mask yet.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/include/mem.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 551c73e..e31783e 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -21,6 +21,14 @@ static inline void set_node(unsigned long *array, unsigned int node)
 	array[node / BITS_PER_LONG] |= 1UL << (node % BITS_PER_LONG);
 }
 
+static inline void clean_node(unsigned long *array)
+{
+	int i;
+
+	for (i = 0; i < MAXNODES / BITS_PER_LONG; i++)
+		array[i] &= 0UL;
+}
+
 /* OOM */
 
 #define LENGTH			(3UL<<30)
-- 
1.7.11.7


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
