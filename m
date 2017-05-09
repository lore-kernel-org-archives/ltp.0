From: Helge Deller <deller@gmx.de>
Date: Tue, 9 May 2017 23:03:26 +0200
Subject: [LTP] [PATCH v2] SAFE_READLINK() should return zero-terminated
 target buffer
Message-ID: <20170509210326.GA18553@ls3530.fritz.box>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to the man(2) page of readlink(), a null byte is not appended
to the target buffer. So applications need to make sure that the target
buffer is zero-initialized, otherwise random bytes at the end of the
returned string may exist.

Currently all users of SAFE_READLINK() get it wrong. This include the
openat03, getcwd03 and open14 testcases which pass a temporary,
un-initialized on-stack buffer to readlink().

This patch fixes SAFE_READLINK to always return a zero-terminated string
and thus fixes the the failure of getcwd03 on the hppa/parisc
architecture (and probably others).

Signed-off-by: Helge Deller <deller@gmx.de>

--
Changes in v2 patch:
- dron't append NUL when tst_brkm() will be called later on.
- changed setting NUL from 0 to '\0'


diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index bffc5a1..a6b4ff7 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -411,6 +411,13 @@ ssize_t safe_readlink(const char *file, const int lineno,
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "%s:%d: readlink(%s,%p,%zu) failed",
 			 file, lineno, path, buf, bufsize);
+	} else {
+		/* readlink does not append a NUL byte to the buffer.
+		 * Add it now. */
+		if ((size_t) rval < bufsize)
+			buf[rval] = '\0';
+		else
+			buf[bufsize-1] = '\0';
 	}
 
 	return rval;
