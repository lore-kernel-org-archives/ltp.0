Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1SHt6K-00063B-Ve
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 08:40:28 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SHt6E-0004O3-TJ
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 08:40:28 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q3B8eHEe001401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Apr 2012 01:40:17 -0700 (PDT)
From: Kang Kai <kai.kang@windriver.com>
Date: Wed, 11 Apr 2012 16:40:22 +0800
Message-ID: <1334133622-24512-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] aio_cancel/3-1: increase BUF_SIZE
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

When do aio_cancel, all the aio_write operations have finished on some
platforms. That cause the case return UNRESOLVED. So increase the BUF_SIZE
to delay aio_write finish that make one aio_write operation can be
cancelled at least.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/aio_cancel/3-1.c        |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
index 5b09d47..ebaa468 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
@@ -44,7 +44,7 @@
 #define TNAME "aio_cancel/3-1.c"
 
 #define BUF_NB		128
-#define BUF_SIZE	1024
+#define BUF_SIZE	(1024 * 1024)
 
 static volatile int countdown = BUF_NB;
 static volatile int canceled = 0;
-- 
1.7.5.4


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
