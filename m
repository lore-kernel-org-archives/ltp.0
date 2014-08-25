Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XLvGv-0003eo-78
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 14:29:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XLvGt-0001kf-ST
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 14:29:25 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7PET9cm031809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 25 Aug 2014 10:29:17 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Mon, 25 Aug 2014 16:06:46 +0200
Message-Id: <1408975606-7674-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1408099965-15748-1-git-send-email-mmarhefk@redhat.com>
References: <1408099965-15748-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 1/3 v2] lib: Add SAFE_MOUNT()
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
 include/safe_macros.h |  8 ++++++++
 lib/safe_macros.c     | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index 5ee4d42..4648f2a 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -363,6 +363,14 @@ static inline off_t safe_lseek(const char *file, const int lineno,
 #define SAFE_LSEEK(cleanup_fn, fd, offset, whence) \
 	safe_lseek(__FILE__, __LINE__, cleanup_fn, (fd), (offset), (whence))
 
+int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
+	       const char *source, const char *target,
+	       const char *filesystemtype, unsigned long mountflags,
+	       const void *data);
+#define SAFE_MOUNT(cleanup_fn, source, target, filesystemtype, \
+		   mountflags, data) \
+	safe_mount(__FILE__, __LINE__, (cleanup_fn), (source), (target), \
+		   (filesystemtype), (mountflags), (data))
 
 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 76d781f..c949826 100644
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
@@ -675,3 +676,22 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
 
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
