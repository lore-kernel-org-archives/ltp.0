Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YlSi8-0002IG-P3
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:47:20 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YlSi7-0007kc-Kd
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:47:20 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3O1jxmO025612
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Apr 2015 09:45:59 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Fri, 24 Apr 2015 09:46:37 +0800
Message-ID: <1429840001-4970-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/5] README: fix typos and remove blank lines
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

The location of README,
open_posix_testsuite/conformance/interfaces/sigaction/README

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 .../open_posix_testsuite/conformance/interfaces/sigaction/README    | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/README b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/README
index 62ddec3..06ce6c6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/README
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/README
@@ -1,5 +1,5 @@
-<< First, an explaination for the perl script and the stuff >>
-<< in the template directoy                                 >>
+<< First, an explanation for the perl script and the stuff >>
+<< in the template directory                               >>
 
 I have added a cheezy perl script for generating a bunch of test cases
 where I want to do the same simple operation on each signal.
@@ -16,5 +16,3 @@ with the signal name.
 * Assertion #5: Since almost all of the test cases in this directory assume
                 that this assertion is true, I haven't bothered adding
                 a test case that just test assertion #5.
-
-
-- 
1.9.3


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
