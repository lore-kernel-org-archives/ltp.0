Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Wmh0s-0001Uv-H9
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 10:11:14 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wmh0r-0001rE-CT
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 10:11:14 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4KAB6UB027841
	for <ltp-list@lists.sourceforge.net>; Tue, 20 May 2014 18:11:06 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Tue, 20 May 2014 18:10:20 +0800
Message-ID: <1400580620-15769-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] lib: safe_stdio.c,
	tst_virt.c: delete the redundant code
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

Since tst_brkm() can break remaining test cases, the code
after this function is redundant.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 lib/safe_stdio.c | 1 -
 lib/tst_virt.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/lib/safe_stdio.c b/lib/safe_stdio.c
index 3463659..e202386 100644
--- a/lib/safe_stdio.c
+++ b/lib/safe_stdio.c
@@ -32,7 +32,6 @@ FILE *safe_fopen(const char *file, const int lineno, void (cleanup_fn)(void),
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "%s:%d: fopen(%s,%s) failed",
 			 file, lineno, path, mode);
-		return NULL;
 	}
 
 	return f;
diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 0141c3d..d1f1e74 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -49,5 +49,4 @@ int tst_is_virt(int virt_type)
 		return is_xen();
 	}
 	tst_brkm(TBROK, NULL, "invalid virt_type flag: %d", virt_type);
-	return 0;
 }
-- 
1.9.0


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
