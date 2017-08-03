From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Aug 2017 15:52:32 +0200
Subject: [LTP] [COMMITTED] [PATCH 8/9] lapi/{vmsplice.h, splice.h,
	tee.h}: Switch to tst_syscall()
In-Reply-To: <20170803135233.13676-1-chrubis@suse.cz>
References: <20170803135233.13676-1-chrubis@suse.cz>
Message-ID: <20170803135233.13676-8-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Now that all splice tests are converted.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/splice.h   | 2 +-
 include/lapi/tee.h      | 2 +-
 include/lapi/vmsplice.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/lapi/splice.h b/include/lapi/splice.h
index ffc0fd6d0..8ac8bd47f 100644
--- a/include/lapi/splice.h
+++ b/include/lapi/splice.h
@@ -28,7 +28,7 @@
 ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
 	loff_t *off_out, size_t len, unsigned int flags)
 {
-	return ltp_syscall(__NR_splice, fd_in, off_in,
+	return tst_syscall(__NR_splice, fd_in, off_in,
 		fd_out, off_out, len, flags);
 }
 #endif
diff --git a/include/lapi/tee.h b/include/lapi/tee.h
index fe79a8f0a..1d9819581 100644
--- a/include/lapi/tee.h
+++ b/include/lapi/tee.h
@@ -26,7 +26,7 @@
 #if !defined(HAVE_TEE)
 ssize_t tee(int fd_in, int fd_out, size_t len, unsigned int flags)
 {
-	return ltp_syscall(__NR_tee, fd_in, fd_out, len, flags);
+	return tst_syscall(__NR_tee, fd_in, fd_out, len, flags);
 }
 #endif
 
diff --git a/include/lapi/vmsplice.h b/include/lapi/vmsplice.h
index 5842d1749..d8b710fdd 100644
--- a/include/lapi/vmsplice.h
+++ b/include/lapi/vmsplice.h
@@ -30,7 +30,7 @@
 ssize_t vmsplice(int fd, const struct iovec *iov,
 	         unsigned long nr_segs, unsigned int flags)
 {
-	return ltp_syscall(__NR_vmsplice, fd, iov, nr_segs, flags);
+	return tst_syscall(__NR_vmsplice, fd, iov, nr_segs, flags);
 }
 #endif
 
-- 
2.13.0

