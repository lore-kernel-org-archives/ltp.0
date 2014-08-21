Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XKTgO-0005AM-Ra
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 14:49:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XKTgN-0004Ur-Hc
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 14:49:44 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7LEnauW008932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Aug 2014 10:49:36 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7LEnZhS030410
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Aug 2014 10:49:36 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Aug 2014 16:49:32 +0200
Message-Id: <6ba0b8b6c7864f4608c263f59e75aeb1f5fe8030.1408632251.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] lib/rmobj: avoid using lstat
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

rmobj() is failing for _64 version of testcases, which use large
files, where it hits EOVERFLOW in lstat():

open12      0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmp/opexIqjV3) failed:
       lstat(/tmp/opexIqjV3/large_file) failed; errno=75:
       Value too large for defined data type

Avoid using any *stat functions, instead try to open "obj"
with open(O_DIRECTORY | O_NOFOLLOW,..). If it succeeds,
we know we are dealing with directory, otherwise assume
it's a file or symlink.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/rmobj.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/rmobj.c b/lib/rmobj.c
index 9b6a643..9322fa9 100644
--- a/lib/rmobj.c
+++ b/lib/rmobj.c
@@ -84,6 +84,7 @@
 #include <limits.h>		/* for PATH_MAX */
 #include <sys/types.h>		/* for opendir(), readdir(), closedir(), stat() */
 #include <sys/stat.h>		/* for [l]stat() */
+#include <fcntl.h>
 #include <dirent.h>		/* for opendir(), readdir(), closedir() */
 #include <unistd.h>		/* for rmdir(), unlink() */
 #include "rmobj.h"
@@ -98,19 +99,13 @@ int rmobj(char *obj, char **errmsg)
 	char dirobj[PATH_MAX];	/* object inside directory to modify */
 	struct stat statbuf;	/* used to hold stat information */
 	static char err_msg[1024];	/* error message */
+	int fd;
 
 	/* Determine the file type */
-	if (lstat(obj, &statbuf) < 0) {
-		if (errmsg != NULL) {
-			sprintf(err_msg, "lstat(%s) failed; errno=%d: %s",
-				obj, errno, SYSERR);
-			*errmsg = err_msg;
-		}
-		return -1;
-	}
 
-	/* Take appropriate action, depending on the file type */
-	if ((statbuf.st_mode & S_IFMT) == S_IFDIR) {
+	fd = open(obj, O_DIRECTORY | O_NOFOLLOW);
+	if (fd != -1) {
+		close(fd);
 		/* object is a directory */
 
 		/* Do NOT perform the request if the directory is "/" */
-- 
1.7.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
