From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 13:55:06 +0200
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
Message-ID: <20160816115506.GA25201@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we pass struct flock to the F_OFD_XXX fcntl() it will fail with
EINVAL with a 32bit binary. That is because glibc uses fcntl64() by
default but the struct flock uses 32bit off_t for 32bit binaries (unless
_FILE_OFFSET_BITS=64) and kernel always expect flock64 for F_OFD_XXX in
fcntl64(). Hence kernel will read some garbage that is a few bytes after
the 32bit flock structure in this case which will likely end up with the
syscall returning EINVAL.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
---
 man2/fcntl.2 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index f0c1acf..4606709 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -533,7 +533,7 @@ As with traditional advisory locks, the third argument to
 .BR fcntl (),
 .IR lock ,
 is a pointer to an
-.IR flock
+.IR flock64
 structure.
 By contrast with traditional record locks, the
 .I l_pid
@@ -543,7 +543,7 @@ when using the commands described below.
 The commands for working with open file description locks are analogous
 to those used with traditional locks:
 .TP
-.BR F_OFD_SETLK " (\fIstruct flock *\fP)"
+.BR F_OFD_SETLK " (\fIstruct flock64 *\fP)"
 Acquire an open file description lock (when
 .I l_type
 is
@@ -564,7 +564,7 @@ this call returns \-1 and sets
 to
 .BR EAGAIN .
 .TP
-.BR F_OFD_SETLKW " (\fIstruct flock *\fP)"
+.BR F_OFD_SETLKW " (\fIstruct flock64 *\fP)"
 As for
 .BR F_OFD_SETLK ,
 but if a conflicting lock is held on the file, then wait for that lock to be
@@ -578,7 +578,7 @@ set to
 see
 .BR signal (7)).
 .TP
-.BR F_OFD_GETLK " (\fIstruct flock *\fP)"
+.BR F_OFD_GETLK " (\fIstruct flock64 *\fP)"
 On input to this call,
 .I lock
 describes an open file description lock we would like to place on the file.
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
