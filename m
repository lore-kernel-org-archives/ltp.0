Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XIF8W-0002xm-NM
	for ltp-list@lists.sourceforge.net; Fri, 15 Aug 2014 10:53:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XIF8V-0004zD-7r
	for ltp-list@lists.sourceforge.net; Fri, 15 Aug 2014 10:53:32 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7FArN3l018565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Aug 2014 06:53:24 -0400
Received: from cc-vtoe5.lab.eng.brq.redhat.com
	(cc-vtoe5.lab.eng.brq.redhat.com [10.34.74.39])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s7FArMYY012634
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Aug 2014 06:53:23 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Fri, 15 Aug 2014 12:52:43 +0200
Message-Id: <1408099965-15748-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 1/3] lib: Add SAFE_MOUNT()
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
 include/safe_macros.h |  9 +++++++++
 lib/safe_macros.c     | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index a79c4ad..e1c2fd1 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -271,5 +271,14 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
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
 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index eefacae..7e49b36 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -784,3 +784,22 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
 
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
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
