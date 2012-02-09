Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RvRdL-0007s3-DB
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 10:53:47 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RvRdG-0006KG-1J
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 10:53:47 +0000
Received: by daln34 with SMTP id n34so1402526dal.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Feb 2012 02:53:36 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  9 Feb 2012 18:53:04 +0800
Message-Id: <1328784784-16910-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1328775194-10631-1-git-send-email-caspar@casparzhang.com>
References: <1328775194-10631-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH v3] safe_macros: add SAFE_STRTOL
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


usage: SAFE_STRTOL(cleanup_fn, string, min, max);
when no specific range required, min could be LONG_MIN and max could be
LONG_MAX;

return: converted long int type value.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---

v2->v3: fix type of rval; make rval able to reach min & max

 include/safe_macros.h |    5 +++++
 lib/safe_macros.c     |   24 +++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch; name="0001-safe_macros-add-SAFE_STRTOL.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-safe_macros-add-SAFE_STRTOL.patch"

diff --git a/include/safe_macros.h b/include/safe_macros.h
index 12f03ef..fbfe6cd 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -146,5 +146,10 @@ int safe_truncate(const char *file, const int lineno,
 #define SAFE_TRUNCATE(cleanup_fn, fd, length) \
 	safe_truncate(__FILE__, __LINE__, cleanup_fn, (path), (length))
 
+long safe_strtol(const char *file, const int lineno,
+	    void (cleanup_fn)(void), char *str, long min, long max);
+#define SAFE_STRTOL(cleanup_fn, str, min, max) \
+	safe_strtol(__FILE__, __LINE__, cleanup_fn, (str), (min), (max))
+
 #endif
 #endif
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 569952d..406e2c6 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -4,6 +4,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <libgen.h>
+#include <limits.h>
 #include <pwd.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -315,7 +316,7 @@ int safe_ftruncate(const char *file, const int lineno,
 	    void (cleanup_fn)(void), int fd, off_t length)
 {
 	int rval;
-	
+
 	rval = ftruncate(fd, length);
 	if (rval == -1) {
 		tst_brkm(TBROK|TERRNO, cleanup_fn, "ftruncate failed at %s:%d",
@@ -338,3 +339,24 @@ int safe_truncate(const char *file, const int lineno,
 
 	return rval;
 }
+
+long safe_strtol(const char *file, const int lineno,
+	    void (cleanup_fn)(void), char *str, long min, long max)
+{
+	long rval;
+	char *endptr;
+
+	rval = strtol(str, &endptr, 10);
+	if ((errno == ERANGE && (rval == LONG_MAX || rval == LONG_MIN))
+		    || (errno != 0 && rval == 0))
+		tst_brkm(TBROK|TERRNO, cleanup_fn, "strtol failed at %s:%d",
+			 file, lineno);
+	if (rval > max || rval < min)
+		tst_brkm(TBROK, cleanup_fn,
+			 "converted value out of range: %ld - %ld",
+			 min, max);
+	if (endptr == str || (*endptr != '\0' && *endptr != '\n'))
+		tst_brkm(TBROK, cleanup_fn, "Invalid value: %s", str);
+
+	return rval;
+}

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



