Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YiIhk-0004tf-8U
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 08:29:52 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YiIhj-0001cB-DA
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 08:29:52 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t3F8TjQS010601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Apr 2015 08:29:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t3F8Tjcc015240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Apr 2015 08:29:45 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t3F8TjLp032221
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Apr 2015 08:29:45 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Apr 2015 11:32:22 +0300
Message-Id: <1429086742-30655-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1429086742-30655-1-git-send-email-alexey.kodanev@oracle.com>
References: <1429086742-30655-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] lib/safe_creat: add const qualifier to path name
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
Cc: vasily.isaenko@oracle.com

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/safe_macros.h |    2 +-
 lib/safe_macros.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index 7d4f1f9..0e7651d 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -45,7 +45,7 @@ int	safe_close(const char *file, const int lineno,
 	safe_close(__FILE__, __LINE__, (cleanup_fn), (fildes))
 
 int	safe_creat(const char *file, const int lineno,
-	    void (*cleanup_fn)(void), char *pathname, mode_t mode);
+	    void (*cleanup_fn)(void), const char *pathname, mode_t mode);
 #define SAFE_CREAT(cleanup_fn, pathname, mode)	\
 	safe_creat(__FILE__, __LINE__, cleanup_fn, (pathname), (mode))
 
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 9c0ba8d..a3d997c 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -66,7 +66,7 @@ safe_close(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 int
 safe_creat(const char *file, const int lineno, void (*cleanup_fn) (void),
-	   char *pathname, mode_t mode)
+	   const char *pathname, mode_t mode)
 {
 	int rval;
 
-- 
1.7.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
