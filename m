Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1YIvuF-0006EY-HV
	for ltp-list@lists.sourceforge.net; Wed, 04 Feb 2015 09:05:55 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YIvuE-00055f-5y
	for ltp-list@lists.sourceforge.net; Wed, 04 Feb 2015 09:05:55 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t14954fW027528
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Feb 2015 17:05:04 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 4 Feb 2015 16:59:46 +0800
Message-ID: <1423040387-2029-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <20150203095709.GB15330@rei.scz.novell.com>
References: <20150203095709.GB15330@rei.scz.novell.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] lib: add SAFE_PWRITE() and SAFE_PREAD()
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/safe_macros.h | 13 +++++++++++++
 lib/safe_macros.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index d832d4f..ed66a0e 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -107,6 +107,12 @@ ssize_t	safe_read(const char *file, const int lineno,
 	safe_read(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
 	    (buf), (nbyte))
 
+ssize_t safe_pread(const char *file, const int lineno, void (*cleanup_fn)(void),
+	    char len_strict, int fildes, void *buf, size_t nbyte, off_t offset);
+#define SAFE_PREAD(cleanup_fn, len_strict, fildes, buf, nbyte)   \
+	safe_pread(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
+	    (buf), (nbyte), (offset))
+
 int	safe_setegid(const char *file, const int lineno,
 	    void (*cleanup_fn)(void), gid_t egid);
 #define SAFE_SETEGID(cleanup_fn, egid)	\
@@ -161,6 +167,13 @@ ssize_t	safe_write(const char *file, const int lineno,
 	safe_write(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
 	    (buf), (nbyte))
 
+ssize_t safe_pwrite(const char *file, const int lineno, void (cleanup_fn)(void),
+	    char len_strict, int fildes, const void *buf, size_t nbyte,
+	    off_t offset);
+#define SAFE_PWRITE(cleanup_fn, len_strict, fildes, buf, nbyte, offset) \
+	safe_pwrite(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
+	    (buf), (nbyte), (offset))
+
 long safe_strtol(const char *file, const int lineno,
 	    void (cleanup_fn)(void), char *str, long min, long max);
 #define SAFE_STRTOL(cleanup_fn, str, min, max) \
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 90885fd..fb28c17 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -252,6 +252,22 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 	return rval;
 }
 
+ssize_t safe_pread(const char *file, const int lineno, void (*cleanup_fn)(void),
+		   char len_strict, int fildes, void *buf, size_t nbyte,
+		   off_t offset)
+{
+	ssize_t rval;
+
+	rval = pread(fildes, buf, nbyte, offset);
+	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: read(%d,%p,%zu, %ld) failed, returned %zd",
+			 file, lineno, fildes, buf, nbyte, offset, rval);
+	}
+
+	return rval;
+}
+
 int safe_setegid(const char *file, const int lineno, void (*cleanup_fn) (void),
                  gid_t egid)
 {
@@ -407,6 +423,22 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 	return rval;
 }
 
+ssize_t safe_pwrite(const char *file, const int lineno,
+		    void (cleanup_fn) (void), char len_strict, int fildes,
+		    const void *buf, size_t nbyte, off_t offset)
+{
+	ssize_t rval;
+
+	rval = pwrite(fildes, buf, nbyte, offset);
+	if ((len_strict == 0 && rval == -1) || (size_t)rval != nbyte) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: pwrite(%d,%p,%zu, %ld) failed",
+			 file, lineno, fildes, buf, rval, offset);
+	}
+
+	return rval;
+}
+
 long safe_strtol(const char *file, const int lineno,
 		 void (cleanup_fn) (void), char *str, long min, long max)
 {
-- 
1.8.3.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
