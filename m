Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WwnEM-0007ko-AC
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 06:50:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WwnEK-0006er-EX
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 06:50:54 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5H6oiHV025051
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 14:50:44 +0800
Message-ID: <1402987815.3433.8.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 17 Jun 2014 14:50:15 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] runtest/mm: fix mmap10 with -c option
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
To: ltp-list <ltp-list@lists.sourceforge.net>

We have removed -c option: commit 1dbf0b4a70c0ef7c849a0b3cd42da2c3874f9432

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/mm | 1 -
 1 file changed, 1 deletion(-)

diff --git a/runtest/mm b/runtest/mm
index 28151b5..131bc3d 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -59,7 +59,6 @@ mmap10_1 mmap10 -a
 mmap10_2 mmap10 -s
 mmap10_3 mmap10 -a -s
 mmap10_4 mmap10 -a -s -i 60
-mmap10_5 mmap10 -a -s -c 200
 
 ksm01 ksm01
 ksm01_1 ksm01 -u 128
-- 
1.9.3




------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
