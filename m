Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WkRbt-0001vz-VO
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 05:20:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WkRbs-0004LT-9S
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 05:20:09 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4E5IvtB017246
	for <ltp-list@lists.sourceforge.net>; Wed, 14 May 2014 13:18:57 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 14 May 2014 13:16:39 +0800
Message-ID: <1400044599-22342-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] doc: test-writing-guidelines
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

Add paragraph to describe two new tst_ interfaces: tst_strsig and tst_strerrno.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index bf129a3..7cdaf2f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -435,6 +435,21 @@ Exits the tests, note that this function has no parameters, the PASSES/FAILS
 reported by the 'tst_resm()' interfaces were stored and are used for the exit
 value.
 
+[source,c]
+-------------------------------------------------------------------------------
+const char *tst_strsig(int sig);
+-------------------------------------------------------------------------------
+
+Return the given signal number's corresponding string.
+
+
+[source,c]
+-------------------------------------------------------------------------------
+const char *tst_strerrno(int err);
+-------------------------------------------------------------------------------
+
+Return the given errno number's corresponding string.
+
 
 2.2.3 Test temporary directory
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
1.8.2.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
