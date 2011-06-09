Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ratbert.chuang@gmail.com>) id 1QUWLz-0008Q9-Gj
	for ltp-list@lists.sourceforge.net; Thu, 09 Jun 2011 03:56:21 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QUWLy-0007JU-EN
	for ltp-list@lists.sourceforge.net; Thu, 09 Jun 2011 03:56:19 +0000
Received: by pxi15 with SMTP id 15so806563pxi.33
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jun 2011 20:56:12 -0700 (PDT)
From: Po-Yu Chuang <ratbert.chuang@gmail.com>
Date: Thu,  9 Jun 2011 11:56:24 +0800
Message-Id: <1307591784-1735-1-git-send-email-ratbert.chuang@gmail.com>
Subject: [LTP] [PATCH] gzip_tests.sh: fix error message typo
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
Cc: Po-Yu Chuang <ratbert@faraday-tech.com>

From: Po-Yu Chuang <ratbert@faraday-tech.com>


Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
---
 testcases/commands/gzip/gzip_tests.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/gzip/gzip_tests.sh
index 99cafa4..5dba859 100755
--- a/testcases/commands/gzip/gzip_tests.sh
+++ b/testcases/commands/gzip/gzip_tests.sh
@@ -265,7 +265,7 @@ test02()
     if [ $RC -ne 0 ]
 	then
 		tst_brk TBROK $LTPTMP/tst_gzip.err NULL \
-		"Test #2: uncompressing directory $LTPTMP/tst_gzip.tmp failed.  Reason"
+		"Test #2: compressing directory $LTPTMP/tst_gzip.tmp failed.  Reason"
 		return $RC
 	fi
 
-- 
1.6.3.3


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
