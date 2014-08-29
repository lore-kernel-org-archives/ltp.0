Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XNLCR-0000KZ-Sl
	for ltp-list@lists.sourceforge.net; Fri, 29 Aug 2014 12:22:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XNLCQ-00030U-L1
	for ltp-list@lists.sourceforge.net; Fri, 29 Aug 2014 12:22:39 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7TCMWTp015679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Aug 2014 08:22:32 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s7TCMUQf000705
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Aug 2014 08:22:31 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Fri, 29 Aug 2014 14:22:11 +0200
Message-Id: <1409314931-11656-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1408099965-15748-1-git-send-email-mmarhefk@redhat.com>
References: <1408099965-15748-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 1/3 v3] lib: Added SAFE_MOUNT() and SAFE_UMOUNT()
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

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 include/safe_macros.h | 15 ++++++++++++++-
 lib/safe_macros.c     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index abd5f6e..d832d4f 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -226,6 +226,20 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
 #define SAFE_RENAME(cleanup_fn, oldpath, newpath) \
 	safe_rename(__FILE__, __LINE__, (cleanup_fn), (oldpath), (newpath))
 
+int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
+	       const char *source, const char *target,
+	       const char *filesystemtype, unsigned long mountflags,
+	       const void *data);
+#define SAFE_MOUNT(cleanup_fn, source, target, filesystemtype, \
+		   mountflags, data) \
+	safe_mount(__FILE__, __LINE__, (cleanup_fn), (source), (target), \
+		   (filesystemtype), (mountflags), (data))
+
+int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
+		const char *target);
+#define SAFE_UMOUNT(cleanup_fn, target) \
+	safe_umount(__FILE__, __LINE__, (cleanup_fn), (target))
+
 /*
  * following functions are inline because the behaviour may depend on
  * -D_FILE_OFFSET_BITS=64 -DOFF_T=__off64_t compile flags
@@ -354,7 +368,6 @@ static inline off_t safe_lseek(const char *file, const int lineno,
 #define SAFE_LSEEK(cleanup_fn, fd, offset, whence) \
 	safe_lseek(__FILE__, __LINE__, cleanup_fn, (fd), (offset), (whence))
 
-
 static inline int safe_getrlimit(const char *file, const int lineno,
 	void (cleanup_fn)(void), int resource, struct rlimit *rlim)
 {
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 05cbebd..90885fd 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -4,6 +4,7 @@
 #include <sys/resource.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <sys/mount.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
@@ -643,3 +644,38 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
 
 	return rval;
 }
+
+int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
+	       const char *source, const char *target,
+	       const char *filesystemtype, unsigned long mountflags,
+	       const void *data)
+{
+	int rval;
+
+	rval = mount(source, target, filesystemtype, mountflags, data);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: mount(%s, %s, %s, %lu, %p) failed",
+			 file, lineno, source, target, filesystemtype,
+			 mountflags, data);
+	}
+
+	return rval;
+}
+
+int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
+		const char *target)
+{
+	int rval;
+
+	rval = umount(target);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: umount(%s) failed",
+			 file, lineno, target);
+	}
+
+	return rval;
+}
-- 
1.8.3.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
