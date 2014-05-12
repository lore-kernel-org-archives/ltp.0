Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WjrWs-0005Qk-O9
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 14:48:34 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WjrWs-0001cr-13
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 14:48:34 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Mon, 12 May 2014 16:48:12 +0200
Message-ID: <1399906092-28901-3-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <1399906092-28901-1-git-send-email-mats.liljegren@enea.com>
References: <1399906092-28901-1-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] safe_stdio: Error messages in new format
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

safe_macros.c introduced a new format of error messages using the following
syntax:
<file>:<line> <function>(<parameters>) failed <optional extra message>

This patch will introduce this format to safe_stdio.c as well.

Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
---
 lib/safe_stdio.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/safe_stdio.c b/lib/safe_stdio.c
index b61daa5..47966c5 100644
--- a/lib/safe_stdio.c
+++ b/lib/safe_stdio.c
@@ -30,7 +30,8 @@ FILE *safe_fopen(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (f == NULL) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "fopen(%s) failed at %s:%d", path, file, lineno);
+			 "%s:%d: fopen(%s,%s) failed",
+			 file, lineno, path, mode);
 		return NULL;
 	}
 
@@ -46,7 +47,7 @@ int safe_fclose(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (ret) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "fclose failed at %s:%d", file, lineno);
+			 "%s:%d: fclose(%p) failed", file, lineno, f);
 	}
 
 	return ret;
@@ -64,7 +65,7 @@ int safe_asprintf(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (ret < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "asprintf failed at %s:%d", file, lineno);
+			 "%s:%d: asprintf(%s,...) failed", file, lineno, fmt);
 	}
 
 	return ret;
-- 
1.7.10.4


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
