Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UboOa-0007FR-6H
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 08:46:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UboOZ-0002dU-Er
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 08:46:12 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4D8k5DU019003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 May 2013 04:46:06 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Mon, 13 May 2013 16:43:27 +0800
Message-Id: <6e4f2cc0db6d6544478fe24fe00f04755b617119.1368434507.git.zliu@redhat.com>
In-Reply-To: <45b6ebc4e0b5f2848c107c26ba144822bed090a1.1368434507.git.zliu@redhat.com>
References: <45b6ebc4e0b5f2848c107c26ba144822bed090a1.1368434507.git.zliu@redhat.com>
In-Reply-To: <45b6ebc4e0b5f2848c107c26ba144822bed090a1.1368434507.git.zliu@redhat.com>
References: <45b6ebc4e0b5f2848c107c26ba144822bed090a1.1368434507.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2 2/3] mem: introduce clean_node() func
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
