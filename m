Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X2XNv-00010r-OS
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 03:08:31 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X2XNt-0001gE-VP
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 03:08:31 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6338I4S017091
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Jul 2014 11:08:18 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 3 Jul 2014 11:05:16 +0800
Message-ID: <1404356716-20493-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] doc/man3/tst_res.3: fix the wrong description about
	TPASS
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 doc/man3/tst_res.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man3/tst_res.3 b/doc/man3/tst_res.3
index 0754daf..3fc8e79 100644
--- a/doc/man3/tst_res.3
+++ b/doc/man3/tst_res.3
@@ -233,7 +233,7 @@ TCONF
 0040	/* ..1. .... */
 .RE
 .P
-NOTE: \fBTPASS, TRETR, TINFO\fR, and \fBTCONF\fR do not have an effect
+NOTE: \fBTRETR, TINFO\fR, and \fBTCONF\fR do not have an effect
 on the test program exit status.
 .P
 \fBtst_environ()\fR is used to ensure that results reported by this library
-- 
1.8.2.1


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
