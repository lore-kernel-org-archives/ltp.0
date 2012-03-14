Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7hAJ-0001aa-Ps
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 05:54:27 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1S7hAI-00023u-Ba
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 05:54:27 +0000
Received: by ghbz2 with SMTP id z2so1737307ghb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Mar 2012 22:54:20 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Wed, 14 Mar 2012 13:53:03 +0800
Message-Id: <1331704383-21085-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH] hugetlb/hugemmap02: remove hugemmap02
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


hugemmap02 testcase is broken. It is not implemented as designed, the
hugemmap succeeded in both 32bit and 64bit. Also the design is not clear
enough, so it's difficult to fix it. Remove it for now.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 runtest/hugetlb |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0001-hugetlb-hugemmap02-remove-hugemmap02.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-hugetlb-hugemmap02-remove-hugemmap02.patch"

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 3fdc366..2134bf9 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,5 +1,6 @@
 hugemmap01 hugemmap01
-hugemmap02 hugemmap02
+# test is broken by design
+#hugemmap02 hugemmap02
 hugemmap03 hugemmap03 -I2
 hugemmap04 hugemmap04
 hugemmap05 hugemmap05
@@ -21,4 +22,3 @@ hugeshmget01 hugeshmget01 -i 10
 hugeshmget02 hugeshmget02 -i 10
 hugeshmget03 hugeshmget03 -i 10
 hugeshmget05 hugeshmget05 -i 10
-

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



