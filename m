Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1N0dNO-0003By-CV
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 15:45:26 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N0dNG-0005wm-37
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 15:45:26 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 93052128D41EE
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2009 17:45:12 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1N0dN9-0006w5-00
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 17:45:11 +0200
Date: Wed, 21 Oct 2009 02:27:27 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u15p2kmscfnueu@debian>
Subject: [LTP] [PATCH] Printf-style format string warnings (TEST_RETURN
	related)
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091021002727.9Vkxbn97UhKslGR7sN-aya6ACLZzSDU8vJxh4keqTqc@z>

Hello,

this patch fixes some printf-format string warnings, concerning the TEST_RETURN variable. TEST_RETURN is declared as "long", so it is advisable to use "%ld" in printf format string to avoid undefined behaviour.

Note that this patch is not complete - it fixes the warnings in files near the beginning of the alphabet only.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../kernel/syscalls/fadvise/posix_fadvise01.c      |    2 +-
 .../kernel/syscalls/fadvise/posix_fadvise02.c      |    4 +-
 .../kernel/syscalls/fadvise/posix_fadvise03.c      |    4 +-
 .../kernel/syscalls/fadvise/posix_fadvise04.c      |    4 +-
 testcases/kernel/syscalls/fchmod/fchmod01.c        |    2 +-
 testcases/kernel/syscalls/fchmod/fchmod06.c        |    2 +-
 testcases/kernel/syscalls/fchown/fchown01.c        |    2 +-
 testcases/kernel/syscalls/fchown/fchown04.c        |    2 +-
 testcases/kernel/syscalls/fcntl/fcntl02.c          |    2 +-
 testcases/kernel/syscalls/fcntl/fcntl03.c          |    2 +-
 testcases/kernel/syscalls/fcntl/fcntl04.c          |    2 +-
 testcases/kernel/syscalls/fcntl/fcntl05.c          |    2 +-
 testcases/kernel/syscalls/fcntl/fcntl08.c          |    2 +-
 testcases/kernel/syscalls/fcntl/fcntl09.c          |    4 +-
 testcases/kernel/syscalls/fcntl/fcntl10.c          |    4 +-
 testcases/kernel/syscalls/fcntl/fcntl22.c          |    2 +-
 testcases/kernel/syscalls/fcntl/fcntl23.c          |    4 +-
 testcases/kernel/syscalls/fcntl/fcntl24.c          |    4 +-
 testcases/kernel/syscalls/fcntl/fcntl25.c          |    4 +-
 testcases/kernel/syscalls/fcntl/fcntl26.c          |    4 +-
 testcases/kernel/syscalls/fdatasync/fdatasync02.c  |    2 +-
 testcases/kernel/syscalls/fork/fork01.c            |    4 +-
 testcases/kernel/syscalls/fpathconf/fpathconf01.c  |    2 +-
 testcases/kernel/syscalls/fstatfs/fstatfs01.c      |    2 +-
 testcases/kernel/syscalls/fsync/fsync01.c          |    2 +-
 .../syscalls/get_robust_list/get_robust_list01.c   |   28 ++++++++++----------
 .../syscalls/getdomainname/getdomainname01.c       |    2 +-
 testcases/kernel/syscalls/getegid/getegid01.c      |    2 +-
 testcases/kernel/syscalls/getegid/getegid02.c      |    4 +-
 testcases/kernel/syscalls/geteuid/geteuid01.c      |    2 +-
 testcases/kernel/syscalls/getgid/getgid01.c        |    2 +-
 testcases/kernel/syscalls/getgid/getgid03.c        |    4 +-
 .../kernel/syscalls/gethostname/gethostname01.c    |    2 +-
 testcases/kernel/syscalls/getpgrp/getpgrp01.c      |    2 +-
 testcases/kernel/syscalls/getpid/getpid01.c        |    2 +-
 testcases/kernel/syscalls/getppid/getppid01.c      |    2 +-
 .../kernel/syscalls/getpriority/getpriority01.c    |    2 +-
 .../kernel/syscalls/getpriority/getpriority02.c    |    2 +-
 testcases/kernel/syscalls/getrusage/getrusage01.c  |    2 +-
 testcases/kernel/syscalls/getrusage/getrusage02.c  |    2 +-
 .../kernel/syscalls/getsockname/getsockname01.c    |    2 +-
 .../kernel/syscalls/getsockopt/getsockopt01.c      |    2 +-
 testcases/kernel/syscalls/gettid/gettid01.c        |    2 +-
 testcases/kernel/syscalls/getuid/getuid01.c        |    2 +-
 testcases/kernel/syscalls/getuid/getuid02.c        |    6 ++--
 testcases/kernel/syscalls/getuid/getuid03.c        |    6 ++--
 testcases/kernel/syscalls/io_cancel/io_cancel01.c  |    6 ++--
 .../kernel/syscalls/io_destroy/io_destroy01.c      |    6 ++--
 .../kernel/syscalls/io_getevents/io_getevents01.c  |    6 ++--
 testcases/kernel/syscalls/io_setup/io_setup01.c    |   14 +++++-----
 testcases/kernel/syscalls/io_submit/io_submit01.c  |   24 ++++++++--------
 testcases/kernel/syscalls/ioperm/ioperm02.c        |    2 +-
 testcases/kernel/syscalls/iopl/iopl01.c            |    2 +-
 testcases/kernel/syscalls/iopl/iopl02.c            |    2 +-
 testcases/kernel/syscalls/lchown/lchown02.c        |    2 +-
 testcases/kernel/syscalls/link/link02.c            |    4 +-
 testcases/kernel/syscalls/link/link03.c            |    4 +-
 testcases/kernel/syscalls/link/link04.c            |    2 +-
 testcases/kernel/syscalls/link/link05.c            |    4 +-
 testcases/kernel/syscalls/link/link06.c            |    2 +-
 testcases/kernel/syscalls/link/link07.c            |    2 +-
 testcases/kernel/syscalls/listen/listen01.c        |    2 +-
 testcases/kernel/syscalls/llseek/llseek02.c        |    2 +-
 testcases/kernel/syscalls/lseek/lseek02.c          |    2 +-
 testcases/kernel/syscalls/lseek/lseek03.c          |    2 +-
 testcases/kernel/syscalls/lseek/lseek04.c          |    2 +-
 testcases/kernel/syscalls/lseek/lseek05.c          |    2 +-
 testcases/kernel/syscalls/lseek/lseek06.c          |    2 +-
 testcases/kernel/syscalls/lseek/lseek08.c          |    2 +-
 testcases/kernel/syscalls/lseek/lseek09.c          |    2 +-
 testcases/kernel/syscalls/lseek/lseek10.c          |    2 +-
 testcases/kernel/syscalls/lstat/lstat01.c          |    2 +-
 testcases/kernel/syscalls/lstat/lstat02.c          |    2 +-
 testcases/kernel/syscalls/madvise/madvise01.c      |    2 +-
 testcases/kernel/syscalls/madvise/madvise02.c      |    2 +-
 testcases/kernel/syscalls/madvise/madvise03.c      |    2 +-
 testcases/kernel/syscalls/mlock/mlock01.c          |    2 +-
 testcases/kernel/syscalls/mlock/mlock02.c          |    2 +-
 testcases/kernel/syscalls/times/times01.c          |    2 +-
 testcases/kernel/syscalls/wait/wait02.c            |    2 +-
 80 files changed, 135 insertions(+), 135 deletions(-)

diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index 1b0fc91..10fe2de 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -122,7 +122,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "call succeeded expectedly");
 			} else {
 				tst_resm(TFAIL,
-					 "unexpected return value - %d : %s, advise %d - "
+					 "unexpected return value - %ld : %s, advise %d - "
 					 "expected %d",
 					 TEST_RETURN,
 					 strerror(TEST_RETURN),
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
index 3c4ff42..53f6563 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
@@ -126,11 +126,11 @@ int main(int ac, char **av)
 			   "On error, an error number is returned." */
 			if (TEST_RETURN == TC[i].error) {
 				tst_resm(TPASS, "expected failure - "
-					 "returned value = %d : %s",
+					 "returned value = %ld : %s",
 					 TEST_RETURN, strerror(TEST_RETURN));
 			} else {
 				tst_resm(TFAIL,
-					 "unexpected returnd value - %d : %s - "
+					 "unexpected returnd value - %ld : %s - "
 					 "expected %d", TEST_RETURN,
 					 strerror(TEST_RETURN), TC[i].error);
 			}
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index 3d4b663..37e32bd 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -151,12 +151,12 @@ int main(int ac, char **av)
 			if (TEST_RETURN == expected_error) {
 				tst_resm(TPASS,
 					 "expected failure - "
-					 "returned value = %d, advise = %d : %s",
+					 "returned value = %ld, advise = %d : %s",
 					 TEST_RETURN,
 					 advise, strerror(TEST_RETURN));
 			} else {
 				tst_resm(TFAIL,
-					 "unexpected return value - %d : %s, advise %d - "
+					 "unexpected return value - %ld : %s, advise %d - "
 					 "expected %d",
 					 TEST_RETURN,
 					 strerror(TEST_RETURN),
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
index 406c0c8..8b132b4 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
@@ -132,11 +132,11 @@ int main(int ac, char **av)
 			   "On error, an error number is returned." */
 			if (TEST_RETURN == TC[i].error) {
 				tst_resm(TPASS, "expected failure - "
-					 "returned value = %d : %s",
+					 "returned value = %ld : %s",
 					 TEST_RETURN, strerror(TEST_RETURN));
 			} else {
 				tst_resm(TFAIL,
-					 "unexpected return value - %d : %s - "
+					 "unexpected return value - %ld : %s - "
 					 "expected %d", TEST_RETURN,
 					 strerror(TEST_RETURN), TC[i].error);
 			}
diff --git a/testcases/kernel/syscalls/fchmod/fchmod01.c b/testcases/kernel/syscalls/fchmod/fchmod01.c
index 14b60d6..11ac224 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod01.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod01.c
@@ -172,7 +172,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "fchmod(%s, 0700) returned %d",
+				tst_resm(TPASS, "fchmod(%s, 0700) returned %ld",
 					 fname, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index 4cb589b..47c2df6 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -188,7 +188,7 @@ int main(int ac, char **av)
 						 Test_cases[ind].exp_errno);
 				}
 			} else {
-				tst_resm(TFAIL, "fchmod() returned %d, expected"
+				tst_resm(TFAIL, "fchmod() returned %ld, expected"
 					 " -1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 			}
diff --git a/testcases/kernel/syscalls/fchown/fchown01.c b/testcases/kernel/syscalls/fchown/fchown01.c
index c1b2e96..f68de62 100644
--- a/testcases/kernel/syscalls/fchown/fchown01.c
+++ b/testcases/kernel/syscalls/fchown/fchown01.c
@@ -167,7 +167,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* Perform functional verification here */
 				tst_resm(TPASS,
-					 "fchown(Fd, geteuid(), getegid()) returned %d",
+					 "fchown(Fd, geteuid(), getegid()) returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index 0980d44..d87d386 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
@@ -185,7 +185,7 @@ int main(int ac, char **av)
 						 Test_cases[ind].exp_errno);
 				}
 			} else {
-				tst_resm(TFAIL, "fchown() returned %d, expected"
+				tst_resm(TFAIL, "fchown() returned %ld, expected"
 					 " -1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 			}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl02.c b/testcases/kernel/syscalls/fcntl/fcntl02.c
index 8bf856a..f149c86 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl02.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl02.c
@@ -177,7 +177,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "fcntl(%s, F_DUPFD, 0) returned %d",
+					 "fcntl(%s, F_DUPFD, 0) returned %ld",
 					 fname, TEST_RETURN);
 			}
 			if (close(TEST_RETURN) == -1) {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl03.c b/testcases/kernel/syscalls/fcntl/fcntl03.c
index 06810a5..1c2b5bd 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl03.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl03.c
@@ -177,7 +177,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "fcntl(%s, F_GETFD, 0) returned %d",
+					 "fcntl(%s, F_GETFD, 0) returned %ld",
 					 fname, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl04.c b/testcases/kernel/syscalls/fcntl/fcntl04.c
index cd824de..ae3f7f2 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl04.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl04.c
@@ -177,7 +177,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "fcntl(%s, F_GETFL, 0) returned %d",
+					 "fcntl(%s, F_GETFL, 0) returned %ld",
 					 fname, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl05.c b/testcases/kernel/syscalls/fcntl/fcntl05.c
index 75042bd..d03ea83 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl05.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl05.c
@@ -179,7 +179,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "fcntl(%s, F_GETLK, &flocks) returned %d",
+					 "fcntl(%s, F_GETLK, &flocks) returned %ld",
 					 fname, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl08.c b/testcases/kernel/syscalls/fcntl/fcntl08.c
index cedb677..ae26cfa 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl08.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl08.c
@@ -173,7 +173,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "fcntl(%s, F_SETFL, %d) returned %d",
+					 "fcntl(%s, F_SETFL, %d) returned %ld",
 					 fname, arg, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl09.c b/testcases/kernel/syscalls/fcntl/fcntl09.c
index cbd5446..c894fa9 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl09.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl09.c
@@ -183,7 +183,7 @@ int main(int ac, char **av)
 				if (STD_FUNCTIONAL_TEST) {
 					/* No Verification test, yet... */
 					tst_resm(TPASS,
-						 "fcntl(%s, F_SETLK, &flocks) flocks.l_type = %s returned %d",
+						 "fcntl(%s, F_SETLK, &flocks) flocks.l_type = %s returned %ld",
 						 fname,
 						 type ? "F_RDLCK" : "F_WRLCK",
 						 TEST_RETURN);
@@ -211,7 +211,7 @@ int main(int ac, char **av)
 				if (STD_FUNCTIONAL_TEST) {
 					/* No Verification test, yet... */
 					tst_resm(TPASS,
-						 "fcntl(%s, F_SETLK, &flocks) flocks.l_type = F_UNLCK returned %d",
+						 "fcntl(%s, F_SETLK, &flocks) flocks.l_type = F_UNLCK returned %ld",
 						 fname, TEST_RETURN);
 				}
 			}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl10.c b/testcases/kernel/syscalls/fcntl/fcntl10.c
index d2ead6b..5495d7c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl10.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl10.c
@@ -183,7 +183,7 @@ int main(int ac, char **av)
 				if (STD_FUNCTIONAL_TEST) {
 					/* No Verification test, yet... */
 					tst_resm(TPASS,
-						 "fcntl(%s, F_SETLKW, &flocks) flocks.l_type = %s returned %d",
+						 "fcntl(%s, F_SETLKW, &flocks) flocks.l_type = %s returned %ld",
 						 fname,
 						 type ? "F_RDLCK" : "F_WRLCK",
 						 TEST_RETURN);
@@ -211,7 +211,7 @@ int main(int ac, char **av)
 				if (STD_FUNCTIONAL_TEST) {
 					/* No Verification test, yet... */
 					tst_resm(TPASS,
-						 "fcntl(%s, F_SETLKW, &flocks) flocks.l_type = F_UNLCK returned %d",
+						 "fcntl(%s, F_SETLKW, &flocks) flocks.l_type = F_UNLCK returned %ld",
 						 fname, TEST_RETURN);
 				}
 			}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl22.c b/testcases/kernel/syscalls/fcntl/fcntl22.c
index 6a8f038..1f1958a 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl22.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl22.c
@@ -134,7 +134,7 @@ int main(int ac, char **av)
 
 			/* Check return code from fcntl(2) */
 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "fcntl() returned %d,"
+				tst_resm(TFAIL, "fcntl() returned %ld,"
 					 "expected -1, errno=%d", TEST_RETURN,
 					 exp_enos[0]);
 			} else {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl23.c b/testcases/kernel/syscalls/fcntl/fcntl23.c
index 240e51e..bd98d3f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl23.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl23.c
@@ -163,13 +163,13 @@ int main(int ac, char **av)
 				TEST(fcntl(fd, F_GETLEASE));
 				if (TEST_RETURN != F_RDLCK)
 					tst_resm(TFAIL,
-						 "fcntl(%s, F_GETLEASE) did not return F_RDLCK, returned %d",
+						 "fcntl(%s, F_GETLEASE) did not return F_RDLCK, returned %ld",
 						 fname, TEST_RETURN);
 				else {
 					TEST(fcntl(fd, F_SETLEASE, F_UNLCK));
 					if (TEST_RETURN != 0)
 						tst_resm(TFAIL,
-							 "fcntl(%s, F_SETLEASE, F_UNLCK) did not return 0, returned %d",
+							 "fcntl(%s, F_SETLEASE, F_UNLCK) did not return 0, returned %ld",
 							 fname, TEST_RETURN);
 					else
 						tst_resm(TPASS,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl24.c b/testcases/kernel/syscalls/fcntl/fcntl24.c
index af0e814..87da1f1 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl24.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl24.c
@@ -175,13 +175,13 @@ int main(int ac, char **av)
 				TEST(fcntl(fd, F_GETLEASE));
 				if (TEST_RETURN != F_WRLCK)
 					tst_resm(TFAIL,
-						 "fcntl(%s, F_GETLEASE) did not return F_WRLCK, returned %d",
+						 "fcntl(%s, F_GETLEASE) did not return F_WRLCK, returned %ld",
 						 fname, TEST_RETURN);
 				else {
 					TEST(fcntl(fd, F_SETLEASE, F_UNLCK));
 					if (TEST_RETURN != 0)
 						tst_resm(TFAIL,
-							 "fcntl(%s, F_SETLEASE, F_UNLCK) did not return 0, returned %d",
+							 "fcntl(%s, F_SETLEASE, F_UNLCK) did not return 0, returned %ld",
 							 fname, TEST_RETURN);
 					else
 						tst_resm(TPASS,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl25.c b/testcases/kernel/syscalls/fcntl/fcntl25.c
index 6e2adc6..35a7c60 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl25.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl25.c
@@ -176,13 +176,13 @@ int main(int ac, char **av)
 				TEST(fcntl(fd, F_GETLEASE));
 				if (TEST_RETURN != F_WRLCK)
 					tst_resm(TFAIL,
-						 "fcntl(%s, F_GETLEASE) did not return F_WRLCK, returned %d",
+						 "fcntl(%s, F_GETLEASE) did not return F_WRLCK, returned %ld",
 						 fname, TEST_RETURN);
 				else {
 					TEST(fcntl(fd, F_SETLEASE, F_UNLCK));
 					if (TEST_RETURN != 0)
 						tst_resm(TFAIL,
-							 "fcntl(%s, F_SETLEASE, F_UNLCK) did not return 0, returned %d",
+							 "fcntl(%s, F_SETLEASE, F_UNLCK) did not return 0, returned %ld",
 							 fname, TEST_RETURN);
 					else
 						tst_resm(TPASS,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl26.c b/testcases/kernel/syscalls/fcntl/fcntl26.c
index df22063..ba3c975 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl26.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl26.c
@@ -176,13 +176,13 @@ int main(int ac, char **av)
 				TEST(fcntl(fd, F_GETLEASE));
 				if (TEST_RETURN != F_WRLCK)
 					tst_resm(TFAIL,
-						 "fcntl(%s, F_GETLEASE) did not return F_WRLCK, returned %d",
+						 "fcntl(%s, F_GETLEASE) did not return F_WRLCK, returned %ld",
 						 fname, TEST_RETURN);
 				else {
 					TEST(fcntl(fd, F_SETLEASE, F_UNLCK));
 					if (TEST_RETURN != 0)
 						tst_resm(TFAIL,
-							 "fcntl(%s, F_SETLEASE, F_UNLCK) did not return 0, returned %d",
+							 "fcntl(%s, F_SETLEASE, F_UNLCK) did not return 0, returned %ld",
 							 fname, TEST_RETURN);
 					else
 						tst_resm(TPASS,
diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync02.c b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
index 33152d7..2c0d352 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync02.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
@@ -142,7 +142,7 @@ int main(int argc, char **argv)
 					 TEST_ERRNO);
 			} else {
 				tst_resm(TFAIL, "Unexpected results for %s ; "
-					 "returned %d (expected %d), errno %d "
+					 "returned %ld (expected %d), errno %d "
 					 "(expected %d)", tdat[testno].desc,
 					 TEST_RETURN, EXP_RET_VAL,
 					 TEST_ERRNO, tdat[testno].experrno);
diff --git a/testcases/kernel/syscalls/fork/fork01.c b/testcases/kernel/syscalls/fork/fork01.c
index 8edef8b..c057728 100644
--- a/testcases/kernel/syscalls/fork/fork01.c
+++ b/testcases/kernel/syscalls/fork/fork01.c
@@ -178,7 +178,7 @@ void parent_pid()
 			child_id = atoi(tmp_line);
 			if (TEST_RETURN != child_id) {
 				tst_resm(TFAIL,
-					 "child reported a pid of %d. parent received %d from fork()",
+					 "child reported a pid of %d. parent received %ld from fork()",
 					 child_id, TEST_RETURN);
 			} else {
 				tst_resm(TPASS,
@@ -246,7 +246,7 @@ int main(int ac, char **av)
 		} else {
 			/* parent */
 			if (STD_FUNCTIONAL_TEST) {
-				tst_resm(TPASS, "fork() returned %d",
+				tst_resm(TPASS, "fork() returned %ld",
 					 TEST_RETURN);
 			}
 			/* wait for the child to complete */
diff --git a/testcases/kernel/syscalls/fpathconf/fpathconf01.c b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
index 3441d0d..ab65b9e 100644
--- a/testcases/kernel/syscalls/fpathconf/fpathconf01.c
+++ b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
@@ -200,7 +200,7 @@ int main(int ac, char **av)
 				if (STD_FUNCTIONAL_TEST) {
 					/* No Verification test, yet... */
 					tst_resm(TPASS,
-						 "fpathconf(fd, %s) returned %d",
+						 "fpathconf(fd, %s) returned %ld",
 						 args[i].define_tag,
 						 TEST_RETURN);
 				}
diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs01.c b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
index 998db81..446cdd1 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs01.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
@@ -182,7 +182,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "fstatfs(%d, &stats, sizeof(struct statfs), 0) returned %d",
+					 "fstatfs(%d, &stats, sizeof(struct statfs), 0) returned %ld",
 					 fd, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/fsync/fsync01.c b/testcases/kernel/syscalls/fsync/fsync01.c
index c0f4b6d..e33169a 100644
--- a/testcases/kernel/syscalls/fsync/fsync01.c
+++ b/testcases/kernel/syscalls/fsync/fsync01.c
@@ -181,7 +181,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "fsync(%s) returned %d", fname,
+				tst_resm(TPASS, "fsync(%s) returned %ld", fname,
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index a379734..15569a8 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -110,17 +110,17 @@ int main(int argc, char **argv)
 		if (TEST_RETURN) {
 			if (TEST_ERRNO == EFAULT)
 				tst_resm(TPASS,
-					 "get_robust_list: retval = %d (expected %d), "
+					 "get_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, EFAULT);
 			else
 				tst_resm(TFAIL,
-					 "get_robust_list: retval = %d (expected %d), "
+					 "get_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, EFAULT);
 		} else {
 			tst_resm(TFAIL,
-				 "get_robust_list: retval = %d (expected %d), "
+				 "get_robust_list: retval = %ld (expected %d), "
 				 "errno = %d (expected %d)", TEST_RETURN, -1,
 				 TEST_ERRNO, EFAULT);
 		}
@@ -132,17 +132,17 @@ int main(int argc, char **argv)
 		if (TEST_RETURN) {
 			if (TEST_ERRNO == EFAULT)
 				tst_resm(TPASS,
-					 "get_robust_list: retval = %d (expected %d), "
+					 "get_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, EFAULT);
 			else
 				tst_resm(TFAIL,
-					 "get_robust_list: retval = %d (expected %d), "
+					 "get_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, EFAULT);
 		} else {
 			tst_resm(TFAIL,
-				 "get_robust_list: retval = %d (expected %d), "
+				 "get_robust_list: retval = %ld (expected %d), "
 				 "errno = %d (expected %d)", TEST_RETURN, -1,
 				 TEST_ERRNO, EFAULT);
 		}
@@ -160,17 +160,17 @@ int main(int argc, char **argv)
 		if (TEST_RETURN) {
 			if (TEST_ERRNO == ESRCH)
 				tst_resm(TPASS,
-					 "get_robust_list: retval = %d (expected %d), "
+					 "get_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, ESRCH);
 			else
 				tst_resm(TFAIL,
-					 "get_robust_list: retval = %d (expected %d), "
+					 "get_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, ESRCH);
 		} else {
 			tst_resm(TFAIL,
-				 "get_robust_list: retval = %d (expected %d), "
+				 "get_robust_list: retval = %ld (expected %d), "
 				 "errno = %d (expected %d)", TEST_RETURN, -1,
 				 TEST_ERRNO, ESRCH);
 		}
@@ -194,17 +194,17 @@ int main(int argc, char **argv)
 		if (TEST_RETURN) {
 			if (TEST_ERRNO == EPERM)
 				tst_resm(TPASS,
-					 "get_robust_list: retval = %d (expected %d), "
+					 "get_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, EPERM);
 			else
 				tst_resm(TFAIL,
-					 "get_robust_list: retval = %d (expected %d), "
+					 "get_robust_list: retval = %ld (expected %d), "
 					 "errno = %d (expected %d)",
 					 TEST_RETURN, -1, TEST_ERRNO, EPERM);
 		} else {
 			tst_resm(TFAIL,
-				 "get_robust_list: retval = %d (expected %d), "
+				 "get_robust_list: retval = %ld (expected %d), "
 				 "errno = %d (expected %d)", TEST_RETURN, -1,
 				 TEST_ERRNO, EPERM);
 		}
@@ -224,12 +224,12 @@ int main(int argc, char **argv)
 
 		if (TEST_RETURN == 0) {
 			tst_resm(TPASS,
-				 "get_robust_list: retval = %d (expected %d), "
+				 "get_robust_list: retval = %ld (expected %d), "
 				 "errno = %d (expected %d)", TEST_RETURN, 0,
 				 TEST_ERRNO, 0);
 		} else {
 			tst_resm(TFAIL,
-				 "get_robust_list: retval = %d (expected %d), "
+				 "get_robust_list: retval = %ld (expected %d), "
 				 "errno = %d (expected %d)", TEST_RETURN, 0,
 				 TEST_ERRNO, 0);
 		}
diff --git a/testcases/kernel/syscalls/getdomainname/getdomainname01.c b/testcases/kernel/syscalls/getdomainname/getdomainname01.c
index a567328..fac4a68 100644
--- a/testcases/kernel/syscalls/getdomainname/getdomainname01.c
+++ b/testcases/kernel/syscalls/getdomainname/getdomainname01.c
@@ -109,7 +109,7 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "getdomainname() Failed, errno = %d :"
 				 " %s", TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
-			tst_resm(TPASS, "getdomainname() returned %d ",
+			tst_resm(TPASS, "getdomainname() returned %ld ",
 				 TEST_RETURN);
 		}
 
diff --git a/testcases/kernel/syscalls/getegid/getegid01.c b/testcases/kernel/syscalls/getegid/getegid01.c
index 3a9907a..f081e9f 100644
--- a/testcases/kernel/syscalls/getegid/getegid01.c
+++ b/testcases/kernel/syscalls/getegid/getegid01.c
@@ -180,7 +180,7 @@ int main(int ac, char **av)
 		if (STD_FUNCTIONAL_TEST) {
 			/* No Verification test, yet... */
 			tst_resm(TPASS,
-				 "getegid -  Get effective group id. returned %d",
+				 "getegid -  Get effective group id. returned %ld",
 				 TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/getegid/getegid02.c b/testcases/kernel/syscalls/getegid/getegid02.c
index b8f4041..be0578f 100644
--- a/testcases/kernel/syscalls/getegid/getegid02.c
+++ b/testcases/kernel/syscalls/getegid/getegid02.c
@@ -116,10 +116,10 @@ int main(int ac, char **av)
 			} else {
 				if (pwent->pw_gid != TEST_RETURN) {
 					tst_resm(TFAIL, "getegid() return value"
-						 " %d unexpected - expected %d",
+						 " %ld unexpected - expected %d",
 						 TEST_RETURN, pwent->pw_gid);
 				} else {
-					tst_resm(TPASS, "effective group id %d "
+					tst_resm(TPASS, "effective group id %ld "
 						 "is correct", TEST_RETURN);
 				}
 			}
diff --git a/testcases/kernel/syscalls/geteuid/geteuid01.c b/testcases/kernel/syscalls/geteuid/geteuid01.c
index ea4d0f2..85560bf 100644
--- a/testcases/kernel/syscalls/geteuid/geteuid01.c
+++ b/testcases/kernel/syscalls/geteuid/geteuid01.c
@@ -178,7 +178,7 @@ int main(int ac, char **av)
 		if (STD_FUNCTIONAL_TEST) {
 			/* No Verification test, yet... */
 			tst_resm(TPASS,
-				 "geteuid -  Get effective user id. returned %d",
+				 "geteuid -  Get effective user id. returned %ld",
 				 TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/getgid/getgid01.c b/testcases/kernel/syscalls/getgid/getgid01.c
index e16aba3..f400dd6 100644
--- a/testcases/kernel/syscalls/getgid/getgid01.c
+++ b/testcases/kernel/syscalls/getgid/getgid01.c
@@ -171,7 +171,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "getgid() returned %d",
+				tst_resm(TPASS, "getgid() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/getgid/getgid03.c b/testcases/kernel/syscalls/getgid/getgid03.c
index 548e638..90fdb49 100644
--- a/testcases/kernel/syscalls/getgid/getgid03.c
+++ b/testcases/kernel/syscalls/getgid/getgid03.c
@@ -115,10 +115,10 @@ int main(int ac, char **av)
 			} else {
 				if (pwent->pw_gid != TEST_RETURN) {
 					tst_resm(TFAIL, "getgid() return value "
-						 "%d unexpected - expected %d",
+						 "%ld unexpected - expected %d",
 						 TEST_RETURN, pwent->pw_gid);
 				} else {
-					tst_resm(TPASS, "group id %d returned "
+					tst_resm(TPASS, "group id %ld returned "
 						 "correctly", TEST_RETURN);
 				}
 			}
diff --git a/testcases/kernel/syscalls/gethostname/gethostname01.c b/testcases/kernel/syscalls/gethostname/gethostname01.c
index c7e1162..6697188 100644
--- a/testcases/kernel/syscalls/gethostname/gethostname01.c
+++ b/testcases/kernel/syscalls/gethostname/gethostname01.c
@@ -176,7 +176,7 @@ int main(int ac, char **av)
 		if (STD_FUNCTIONAL_TEST) {
 			/* No Verification test, yet... */
 			tst_resm(TPASS,
-				 "gethostname -  Get host name returned %d",
+				 "gethostname -  Get host name returned %ld",
 				 TEST_RETURN);
 		}
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/getpgrp/getpgrp01.c b/testcases/kernel/syscalls/getpgrp/getpgrp01.c
index a5f505a..df57ac8 100644
--- a/testcases/kernel/syscalls/getpgrp/getpgrp01.c
+++ b/testcases/kernel/syscalls/getpgrp/getpgrp01.c
@@ -170,7 +170,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "getpgrp() returned %d",
+				tst_resm(TPASS, "getpgrp() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index ccb2020..a2a7a05 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -168,7 +168,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "getpid() returned %d",
+				tst_resm(TPASS, "getpid() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/getppid/getppid01.c b/testcases/kernel/syscalls/getppid/getppid01.c
index 976aa10..8eac75c 100644
--- a/testcases/kernel/syscalls/getppid/getppid01.c
+++ b/testcases/kernel/syscalls/getppid/getppid01.c
@@ -170,7 +170,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "getppid() returned %d",
+				tst_resm(TPASS, "getppid() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/getpriority/getpriority01.c b/testcases/kernel/syscalls/getpriority/getpriority01.c
index 9c5e099..607c97d 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority01.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority01.c
@@ -126,7 +126,7 @@ int main(int ac, char **av)
 					 strerror(TEST_ERRNO));
 			} else {
 				tst_resm(TPASS, "getpriority(%d, 0) returned "
-					 "%d priority value",
+					 "%ld priority value",
 					 which, TEST_RETURN);
 			}
 		}		/* End of TEST CASE LOOPING */
diff --git a/testcases/kernel/syscalls/getpriority/getpriority02.c b/testcases/kernel/syscalls/getpriority/getpriority02.c
index 6a3ffe3..0aacb6c 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority02.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority02.c
@@ -162,7 +162,7 @@ int main(int ac, char **av)
 						 Test_cases[ind].exp_errno);
 				}
 			} else {
-				tst_resm(TFAIL, "getpriority() returned %d, "
+				tst_resm(TFAIL, "getpriority() returned %ld, "
 					 "expected -1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 			}
diff --git a/testcases/kernel/syscalls/getrusage/getrusage01.c b/testcases/kernel/syscalls/getrusage/getrusage01.c
index 7d2ae26..5e878a4 100755
--- a/testcases/kernel/syscalls/getrusage/getrusage01.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage01.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "TEST Passed");
 			} else {
 				tst_resm(TFAIL, "test Failed,"
-					 "getrusage() returned %d"
+					 "getrusage() returned %ld"
 					 " errno = %d : %s", TEST_RETURN,
 					 TEST_ERRNO, strerror(TEST_ERRNO));
 			}
diff --git a/testcases/kernel/syscalls/getrusage/getrusage02.c b/testcases/kernel/syscalls/getrusage/getrusage02.c
index 935f120..d45bf0c 100755
--- a/testcases/kernel/syscalls/getrusage/getrusage02.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage02.c
@@ -136,7 +136,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "TEST Passed");
 			} else {
 				tst_resm(TFAIL, "test Failed,"
-					 "getrusage() returned %d"
+					 "getrusage() returned %ld"
 					 " errno = %d : %s", TEST_RETURN,
 					 TEST_ERRNO, strerror(TEST_ERRNO));
 			}
diff --git a/testcases/kernel/syscalls/getsockname/getsockname01.c b/testcases/kernel/syscalls/getsockname/getsockname01.c
index 638d95a..eaef170 100644
--- a/testcases/kernel/syscalls/getsockname/getsockname01.c
+++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
@@ -133,7 +133,7 @@ int main(int argc, char *argv[])
 			    (TEST_RETURN < 0 &&
 			     TEST_ERRNO != tdat[testno].experrno)) {
 				tst_resm(TFAIL, "%s ; returned"
-					 " %d (expected %d), errno %d (expected"
+					 " %ld (expected %d), errno %d (expected"
 					 " %d)", tdat[testno].desc,
 					 TEST_RETURN, tdat[testno].retval,
 					 TEST_ERRNO, tdat[testno].experrno);
diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt01.c b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
index b2a5ad7..2b7118c 100644
--- a/testcases/kernel/syscalls/getsockopt/getsockopt01.c
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
@@ -160,7 +160,7 @@ int main(int argc, char *argv[])
 			    (TEST_RETURN < 0 &&
 			     TEST_ERRNO != tdat[testno].experrno)) {
 				tst_resm(TFAIL, "%s ; returned"
-					 " %d (expected %d), errno %d (expected"
+					 " %ld (expected %d), errno %d (expected"
 					 " %d)", tdat[testno].desc,
 					 TEST_RETURN, tdat[testno].retval,
 					 TEST_ERRNO, tdat[testno].experrno);
diff --git a/testcases/kernel/syscalls/gettid/gettid01.c b/testcases/kernel/syscalls/gettid/gettid01.c
index 4dd5445..3d81ddc 100644
--- a/testcases/kernel/syscalls/gettid/gettid01.c
+++ b/testcases/kernel/syscalls/gettid/gettid01.c
@@ -77,7 +77,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "gettid() returned %d",
+				tst_resm(TPASS, "gettid() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/getuid/getuid01.c b/testcases/kernel/syscalls/getuid/getuid01.c
index 35b9b5b..6f1d5aa 100644
--- a/testcases/kernel/syscalls/getuid/getuid01.c
+++ b/testcases/kernel/syscalls/getuid/getuid01.c
@@ -171,7 +171,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "getuid() returned %d",
+				tst_resm(TPASS, "getuid() returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/getuid/getuid02.c b/testcases/kernel/syscalls/getuid/getuid02.c
index e353d45..74fad34 100644
--- a/testcases/kernel/syscalls/getuid/getuid02.c
+++ b/testcases/kernel/syscalls/getuid/getuid02.c
@@ -83,17 +83,17 @@ int main(int ac, char **av)
 			pwent = getpwuid(TEST_RETURN);
 			if (pwent == NULL) {
 				tst_resm(TFAIL, "geteuid() returned unexpected "
-					 "value %d", TEST_RETURN);
+					 "value %ld", TEST_RETURN);
 			} else if (!UID_SIZE_CHECK(pwent->pw_uid)) {
 				tst_brkm(TBROK,
 					 cleanup,
-					 "uid(%d) is too large for testing geteuid16",
+					 "uid(%ld) is too large for testing geteuid16",
 					 TEST_RETURN);
 			} else {
 				if (pwent->pw_uid != TEST_RETURN) {
 					tst_resm(TFAIL, "getpwuid() value, %d, "
 						 "does not match geteuid() "
-						 "value, %d", pwent->pw_uid,
+						 "value, %ld", pwent->pw_uid,
 						 TEST_RETURN);
 				} else {
 					tst_resm(TPASS, "values from geteuid()"
diff --git a/testcases/kernel/syscalls/getuid/getuid03.c b/testcases/kernel/syscalls/getuid/getuid03.c
index b016907..1f32186 100644
--- a/testcases/kernel/syscalls/getuid/getuid03.c
+++ b/testcases/kernel/syscalls/getuid/getuid03.c
@@ -85,18 +85,18 @@ int main(int ac, char **av)
 			pwent = getpwuid(TEST_RETURN);
 			if (pwent == NULL) {
 				tst_resm(TFAIL, "getuid() returned unexpected "
-					 "value %d", TEST_RETURN);
+					 "value %ld", TEST_RETURN);
 			} else if (!UID_SIZE_CHECK(pwent->pw_uid)) {
 				tst_brkm(TBROK,
 					 cleanup,
-					 "uid(%d) is too large for testing getuid16",
+					 "uid(%ld) is too large for testing getuid16",
 					 TEST_RETURN);
 			  
 			} else {
 				if (pwent->pw_uid != TEST_RETURN) {
 					tst_resm(TFAIL, "getpwuid() value, %d, "
 						 "does not match getuid() "
-						 "value, %d", pwent->pw_uid,
+						 "value, %ld", pwent->pw_uid,
 						 TEST_RETURN);
 				} else {
 					tst_resm(TPASS, "values from getuid()"
diff --git a/testcases/kernel/syscalls/io_cancel/io_cancel01.c b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
index 183d047..e077f77 100644
--- a/testcases/kernel/syscalls/io_cancel/io_cancel01.c
+++ b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
@@ -110,11 +110,11 @@ int main(int argc, char **argv)
 
 		if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %d : %s", TEST_RETURN,
+				 "returned value = %ld : %s", TEST_RETURN,
 				 strerror(-1 * TEST_RETURN));
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
-				 "expected %d", TEST_RETURN, expected_return);
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
+				 "expected %ld", TEST_RETURN, expected_return);
 		}
 
 		/*
diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy01.c b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
index e6dc25e..0395e0d 100644
--- a/testcases/kernel/syscalls/io_destroy/io_destroy01.c
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
@@ -102,11 +102,11 @@ ERRORS
 			tst_resm(TFAIL, "call succeeded unexpectedly");
 		} else if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %d : %s", TEST_RETURN,
+				 "returned value = %ld : %s", TEST_RETURN,
 				 strerror(-1 * TEST_RETURN));
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
-				 "expected %d", TEST_RETURN, expected_return);
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
+				 "expected %ld", TEST_RETURN, expected_return);
 		}
 
 		/*
diff --git a/testcases/kernel/syscalls/io_getevents/io_getevents01.c b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
index 963b7b6..fe4160f 100644
--- a/testcases/kernel/syscalls/io_getevents/io_getevents01.c
+++ b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
@@ -110,11 +110,11 @@ int main(int argc, char **argv)
 
 		if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %d : %s", TEST_RETURN,
+				 "returned value = %ld : %s", TEST_RETURN,
 				 strerror(-1 * TEST_RETURN));
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
-				 "expected %d", TEST_RETURN, expected_return);
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
+				 "expected %ld", TEST_RETURN, expected_return);
 		}
 		/*
 		   EFAULT Either events or timeout is an invalid pointer.
diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
index d7057ae..2bf9e29 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup01.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
@@ -100,7 +100,7 @@ int main(int argc, char **argv)
 			tst_resm(TPASS, "call succeeded expectedly");
 			io_destroy(ctx);
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
 				 "expected %d", TEST_RETURN, expected_return);
 		}
 
@@ -122,10 +122,10 @@ int main(int argc, char **argv)
 			io_destroy(ctx);
 		} else if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %d : %s", TEST_RETURN,
+				 "returned value = %ld : %s", TEST_RETURN,
 				 strerror(-1 * TEST_RETURN));
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
 				 "expected %d", TEST_RETURN, expected_return);
 		}
 
@@ -137,10 +137,10 @@ int main(int argc, char **argv)
 			io_destroy(ctx);
 		} else if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %d : %s", TEST_RETURN,
+				 "returned value = %ld : %s", TEST_RETURN,
 				 strerror(-1 * TEST_RETURN));
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
 				 "expected %d", TEST_RETURN, expected_return);
 		}
 
@@ -155,10 +155,10 @@ int main(int argc, char **argv)
 			io_destroy(ctx);
 		} else if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %d : %s", TEST_RETURN,
+				 "returned value = %ld : %s", TEST_RETURN,
 				 strerror(-1 * TEST_RETURN));
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
 				 "expected %d", TEST_RETURN, expected_return);
 		}
 
diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index f7524a5..a4c87f2 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -112,11 +112,11 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "call succeeded unexpectedly");
 		} else if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %d : %s", (-1 * TEST_RETURN),
+				 "returned value = %ld : %s", (-1 * TEST_RETURN),
 				 strerror(-1 * TEST_RETURN));
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
-				 "expected %d", TEST_RETURN, expected_return);
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
+				 "expected %ld", TEST_RETURN, expected_return);
 		}
 
 		/*
@@ -128,11 +128,11 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "call succeeded unexpectedly");
 		} else if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %d : %s", (-1 * TEST_RETURN),
+				 "returned value = %ld : %s", (-1 * TEST_RETURN),
 				 strerror(-1 * TEST_RETURN));
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
-				 "expected %d", TEST_RETURN, expected_return);
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
+				 "expected %ld", TEST_RETURN, expected_return);
 		}
 
 		/* Special case EFAULT or EINVAL (indetermination)
@@ -150,13 +150,13 @@ int main(int argc, char **argv)
 			} else if (TEST_RETURN == expected_fault
 				   || TEST_RETURN == expected_inval) {
 				tst_resm(TPASS, "expected failure - "
-					 "returned value = %d : %s",
+					 "returned value = %ld : %s",
 					 (-1 * TEST_RETURN),
 					 strerror(-1 * TEST_RETURN));
 			} else {
 				tst_resm(TFAIL,
-					 "unexpected returned value - %d - "
-					 "expected %d(%s) or %d(%s)",
+					 "unexpected returned value - %ld - "
+					 "expected %ld(%s) or %ld(%s)",
 					 TEST_RETURN, expected_fault,
 					 strerror(-1 * expected_fault),
 					 expected_inval,
@@ -182,11 +182,11 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "call succeeded unexpectedly");
 		} else if (TEST_RETURN == expected_return) {
 			tst_resm(TPASS, "expected failure - "
-				 "returned value = %d : %s", (-1 * TEST_RETURN),
+				 "returned value = %ld : %s", (-1 * TEST_RETURN),
 				 strerror(-1 * TEST_RETURN));
 		} else {
-			tst_resm(TFAIL, "unexpected returned value - %d - "
-				 "expected %d", TEST_RETURN, expected_return);
+			tst_resm(TFAIL, "unexpected returned value - %ld - "
+				 "expected %ld", TEST_RETURN, expected_return);
 		}
 
 		/*
diff --git a/testcases/kernel/syscalls/ioperm/ioperm02.c b/testcases/kernel/syscalls/ioperm/ioperm02.c
index 735e889..333557c 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm02.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
@@ -152,7 +152,7 @@ int main(int ac, char **av)
 					 TEST_ERRNO);
 			} else {
 				tst_resm(TFAIL, "Unexpected results for %s ; "
-					 "returned %d (expected %d), errno %d "
+					 "returned %ld (expected %d), errno %d "
 					 "(expected errno  %d)",
 					 test_cases[i].desc,
 					 TEST_RETURN, EXP_RET_VAL,
diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
index fa19dae..0a6bbd8 100644
--- a/testcases/kernel/syscalls/iopl/iopl01.c
+++ b/testcases/kernel/syscalls/iopl/iopl01.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 					 TEST_ERRNO, strerror(TEST_ERRNO));
 			} else {
 				tst_resm(TPASS, "iopl() passed for level %d, "
-					 "returned %d", level, TEST_RETURN);
+					 "returned %ld", level, TEST_RETURN);
 			}
 		}
 	}			/* End for TEST_LOOPING */
diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
index be044ea..b1572c9 100644
--- a/testcases/kernel/syscalls/iopl/iopl02.c
+++ b/testcases/kernel/syscalls/iopl/iopl02.c
@@ -149,7 +149,7 @@ int main(int ac, char **av)
 					 TEST_ERRNO);
 			} else {
 				tst_resm(TFAIL, "Unexpected results for %s ; "
-					 "returned %d (expected %d), errno %d "
+					 "returned %ld (expected %d), errno %d "
 					 "(expected errno  %d)",
 					 test_cases[i].desc,
 					 TEST_RETURN, EXP_RET_VAL,
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index d91b7fc..69a1f3d 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -209,7 +209,7 @@ int main(int ac, char **av)
 						 Test_cases[ind].exp_errno);
 				}
 			} else {
-				tst_resm(TFAIL, "lchown() returned %d, "
+				tst_resm(TFAIL, "lchown() returned %ld, "
 					 "expected -1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 			}
diff --git a/testcases/kernel/syscalls/link/link02.c b/testcases/kernel/syscalls/link/link02.c
index ea3f9bb..e2c09a6 100644
--- a/testcases/kernel/syscalls/link/link02.c
+++ b/testcases/kernel/syscalls/link/link02.c
@@ -186,11 +186,11 @@ int main(int ac, char **av)
 				    fbuf.st_nlink == lbuf.st_nlink)
 
 					tst_resm(TPASS,
-						 "link(%s, %s) returned %d and link cnts match",
+						 "link(%s, %s) returned %ld and link cnts match",
 						 Fname, Lname, TEST_RETURN);
 				else {
 					tst_resm(TFAIL,
-						 "link(%s, %s) returned %d, stat link cnts do not match %d %d",
+						 "link(%s, %s) returned %ld, stat link cnts do not match %d %d",
 						 Fname, Lname, TEST_RETURN,
 						 fbuf.st_nlink, lbuf.st_nlink);
 				}
diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
index 712bc5c..5b4b612 100644
--- a/testcases/kernel/syscalls/link/link03.c
+++ b/testcases/kernel/syscalls/link/link03.c
@@ -233,7 +233,7 @@ int main(int ac, char **av)
 				    (fbuf.st_nlink != lbuf.st_nlink)) {
 
 					tst_resm(TFAIL,
-						 "link(%s, %s[1-%d]) ret %d for %d files, stat values do not match %d %d",
+						 "link(%s, %s[1-%d]) ret %ld for %d files, stat values do not match %d %d",
 						 Fname, Basename, nlinks,
 						 TEST_RETURN, nlinks,
 						 fbuf.st_nlink, lbuf.st_nlink);
@@ -242,7 +242,7 @@ int main(int ac, char **av)
 			}
 			if (cnt >= nlinks) {
 				tst_resm(TPASS,
-					 "link(%s, %s[1-%d]) ret %d for %d files, stat linkcounts match %d",
+					 "link(%s, %s[1-%d]) ret %ld for %d files, stat linkcounts match %d",
 					 Fname, Basename, nlinks, TEST_RETURN,
 					 nlinks, fbuf.st_nlink);
 			}
diff --git a/testcases/kernel/syscalls/link/link04.c b/testcases/kernel/syscalls/link/link04.c
index c6aa40f..e8dd31e 100644
--- a/testcases/kernel/syscalls/link/link04.c
+++ b/testcases/kernel/syscalls/link/link04.c
@@ -276,7 +276,7 @@ int main(int ac, char **av)
 					Tst_count++;
 			} else {
 				tst_resm(TFAIL,
-					 "link(<%s>, <%s>) returned %d, expected -1, errno:%d",
+					 "link(<%s>, <%s>) returned %ld, expected -1, errno:%d",
 					 desc1, desc2, TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 			}
diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
index ca55455..056408c 100644
--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -216,7 +216,7 @@ int main(int ac, char **av)
 				    (fbuf.st_nlink != lbuf.st_nlink)) {
 
 					tst_resm(TFAIL,
-						 "link(%s, %s[1-%d]) ret %d for %d files, stat values do not match %d %d",
+						 "link(%s, %s[1-%d]) ret %ld for %d files, stat values do not match %d %d",
 						 Fname, Basename, nlinks,
 						 TEST_RETURN, nlinks,
 						 fbuf.st_nlink, lbuf.st_nlink);
@@ -225,7 +225,7 @@ int main(int ac, char **av)
 			}
 			if (cnt >= nlinks) {
 				tst_resm(TPASS,
-					 "link(%s, %s[1-%d]) ret %d for %d files, stat linkcounts match %d",
+					 "link(%s, %s[1-%d]) ret %ld for %d files, stat linkcounts match %d",
 					 Fname, Basename, nlinks, TEST_RETURN,
 					 nlinks, fbuf.st_nlink);
 			}
diff --git a/testcases/kernel/syscalls/link/link06.c b/testcases/kernel/syscalls/link/link06.c
index fe76d1b..8f2a42f 100644
--- a/testcases/kernel/syscalls/link/link06.c
+++ b/testcases/kernel/syscalls/link/link06.c
@@ -136,7 +136,7 @@ int main(int ac, char **av)
 
 		/* Check return code from link(2) */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "link() returned %d,"
+			tst_resm(TFAIL, "link() returned %ld,"
 				 "expected -1, errno=%d", TEST_RETURN,
 				 exp_enos[0]);
 		} else {
diff --git a/testcases/kernel/syscalls/link/link07.c b/testcases/kernel/syscalls/link/link07.c
index f2ca9a9..5b2f8e5 100644
--- a/testcases/kernel/syscalls/link/link07.c
+++ b/testcases/kernel/syscalls/link/link07.c
@@ -143,7 +143,7 @@ int main(int ac, char **av)
 
 		/* Check return code from link(2) */
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "link() returned %d,"
+			tst_resm(TFAIL, "link() returned %ld,"
 				 "expected -1, errno=%d", TEST_RETURN,
 				 exp_enos[0]);
 		} else {
diff --git a/testcases/kernel/syscalls/listen/listen01.c b/testcases/kernel/syscalls/listen/listen01.c
index 2133956..ac52e24 100644
--- a/testcases/kernel/syscalls/listen/listen01.c
+++ b/testcases/kernel/syscalls/listen/listen01.c
@@ -114,7 +114,7 @@ int main(int argc, char *argv[])
 			    (TEST_RETURN < 0 &&
 			     TEST_ERRNO != tdat[testno].experrno)) {
 				tst_resm(TFAIL, "%s ; returned"
-					 " %d (expected %d), errno %d (expected"
+					 " %ld (expected %d), errno %d (expected"
 					 " %d)", tdat[testno].desc,
 					 TEST_RETURN, tdat[testno].retval,
 					 TEST_ERRNO, tdat[testno].experrno);
diff --git a/testcases/kernel/syscalls/llseek/llseek02.c b/testcases/kernel/syscalls/llseek/llseek02.c
index 0788f83..3afe98c 100644
--- a/testcases/kernel/syscalls/llseek/llseek02.c
+++ b/testcases/kernel/syscalls/llseek/llseek02.c
@@ -167,7 +167,7 @@ int main(int ac, char **av)
 
 			/* check return code of llseek(2) */
 			if (TEST_RETURN != (loff_t) - 1) {
-				tst_resm(TFAIL, "llseek() returned %d, expected"
+				tst_resm(TFAIL, "llseek() returned %ld, expected"
 					 " -1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 				continue;
diff --git a/testcases/kernel/syscalls/lseek/lseek02.c b/testcases/kernel/syscalls/lseek/lseek02.c
index 916444f..e3ba730 100644
--- a/testcases/kernel/syscalls/lseek/lseek02.c
+++ b/testcases/kernel/syscalls/lseek/lseek02.c
@@ -187,7 +187,7 @@ int main(int ac, char **av)
 
 		} else {
 
-			tst_resm(TFAIL, "lseek(-1, 1, SEEK_SET) returned %d",
+			tst_resm(TFAIL, "lseek(-1, 1, SEEK_SET) returned %ld",
 				 TEST_RETURN);
 		}
 
diff --git a/testcases/kernel/syscalls/lseek/lseek03.c b/testcases/kernel/syscalls/lseek/lseek03.c
index f024f5f..37b60ab 100644
--- a/testcases/kernel/syscalls/lseek/lseek03.c
+++ b/testcases/kernel/syscalls/lseek/lseek03.c
@@ -215,7 +215,7 @@ But SIGSYS signal was NOT received.", fname, whence, TEST_ERRNO, strerror
 					Tst_count++;
 			} else {
 
-				tst_resm(TFAIL, "lseek(%s, 1, %d) returned %d",
+				tst_resm(TFAIL, "lseek(%s, 1, %d) returned %ld",
 					 fname, whence, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/lseek/lseek04.c b/testcases/kernel/syscalls/lseek/lseek04.c
index a3e4287..1115d8c 100644
--- a/testcases/kernel/syscalls/lseek/lseek04.c
+++ b/testcases/kernel/syscalls/lseek/lseek04.c
@@ -184,7 +184,7 @@ int main(int ac, char **av)
 		} else {
 
 			tst_resm(TFAIL,
-				 "lseek(fifofd, 1, SEEK_SET) returned %d",
+				 "lseek(fifofd, 1, SEEK_SET) returned %ld",
 				 TEST_RETURN);
 		}
 
diff --git a/testcases/kernel/syscalls/lseek/lseek05.c b/testcases/kernel/syscalls/lseek/lseek05.c
index dd5ab6e..e8d8300 100644
--- a/testcases/kernel/syscalls/lseek/lseek05.c
+++ b/testcases/kernel/syscalls/lseek/lseek05.c
@@ -185,7 +185,7 @@ int main(int ac, char **av)
 		} else {
 
 			tst_resm(TFAIL,
-				 "lseek(pipefd, 1, SEEK_SET) returned %d",
+				 "lseek(pipefd, 1, SEEK_SET) returned %ld",
 				 TEST_RETURN);
 		}
 
diff --git a/testcases/kernel/syscalls/lseek/lseek06.c b/testcases/kernel/syscalls/lseek/lseek06.c
index b90a047..748f816 100644
--- a/testcases/kernel/syscalls/lseek/lseek06.c
+++ b/testcases/kernel/syscalls/lseek/lseek06.c
@@ -135,7 +135,7 @@ int main(int ac, char **av)
 			 */
 			if (TEST_RETURN != OFFSET) {
 				tst_resm(TFAIL, "lseek() returned incorrect "
-					 "value %d, expected %d",
+					 "value %ld, expected %d",
 					 TEST_RETURN, OFFSET);
 				continue;
 			}
diff --git a/testcases/kernel/syscalls/lseek/lseek08.c b/testcases/kernel/syscalls/lseek/lseek08.c
index 56867d1..2b34270 100644
--- a/testcases/kernel/syscalls/lseek/lseek08.c
+++ b/testcases/kernel/syscalls/lseek/lseek08.c
@@ -135,7 +135,7 @@ int main(int ac, char **av)
 			 */
 			if (TEST_RETURN != file_size) {
 				tst_resm(TFAIL, "lseek() returned incorrect "
-					 "value %d, expected %d",
+					 "value %ld, expected %d",
 					 TEST_RETURN, file_size);
 				continue;
 			}
diff --git a/testcases/kernel/syscalls/lseek/lseek09.c b/testcases/kernel/syscalls/lseek/lseek09.c
index e7c012b..d44b5a0 100644
--- a/testcases/kernel/syscalls/lseek/lseek09.c
+++ b/testcases/kernel/syscalls/lseek/lseek09.c
@@ -140,7 +140,7 @@ int main(int ac, char **av)
 			 */
 			if (TEST_RETURN != 3) {
 				tst_resm(TFAIL, "lseek() returned incorrect "
-					 "value %d, expected 4", TEST_RETURN);
+					 "value %ld, expected 4", TEST_RETURN);
 				continue;
 			}
 			/*
diff --git a/testcases/kernel/syscalls/lseek/lseek10.c b/testcases/kernel/syscalls/lseek/lseek10.c
index 5765e5a..681e4e1 100644
--- a/testcases/kernel/syscalls/lseek/lseek10.c
+++ b/testcases/kernel/syscalls/lseek/lseek10.c
@@ -171,7 +171,7 @@ int main(int ac, char **av)
 
 			/* check return code of lseek(2) */
 			if (TEST_RETURN != (off_t) - 1) {
-				tst_resm(TFAIL, "lseek() returned %d, expected "
+				tst_resm(TFAIL, "lseek() returned %ld, expected "
 					 "-1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 				continue;
diff --git a/testcases/kernel/syscalls/lstat/lstat01.c b/testcases/kernel/syscalls/lstat/lstat01.c
index be10f69..b0b47ef 100644
--- a/testcases/kernel/syscalls/lstat/lstat01.c
+++ b/testcases/kernel/syscalls/lstat/lstat01.c
@@ -177,7 +177,7 @@ int main(int ac, char **av)
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
-					 "lstat(%s, &statter) returned %d",
+					 "lstat(%s, &statter) returned %ld",
 					 symlnk, TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/lstat/lstat02.c b/testcases/kernel/syscalls/lstat/lstat02.c
index 23b583e..de7e82d 100644
--- a/testcases/kernel/syscalls/lstat/lstat02.c
+++ b/testcases/kernel/syscalls/lstat/lstat02.c
@@ -191,7 +191,7 @@ int main(int ac, char **av)
 
 			/* Check return code from lstat(2) */
 			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "lstat(2) returned %d, expected"
+				tst_resm(TFAIL, "lstat(2) returned %ld, expected"
 					 " -1, errno:%d", TEST_RETURN,
 					 Test_cases[ind].exp_errno);
 				continue;
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index ee9f727..f37d49d 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -254,7 +254,7 @@ void check_and_print(char *advice)
 	if (TEST_RETURN == -1) {
 		tst_resm(TFAIL,
 			 "madvise test for %s failed with "
-			 "return = %d, errno = %d : %s",
+			 "return = %ld, errno = %d : %s",
 			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
 	} else if (STD_FUNCTIONAL_TEST) {
 		tst_resm(TPASS, "madvise test for %s PASSED", advice);
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 6198f5c..4f0a837 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -340,6 +340,6 @@ void check_and_print(int expected_errno)
 		}
 	} else {
 		tst_resm(TFAIL, "madvise failed, expected "
-			 "return value = -1, got %d", TEST_RETURN);
+			 "return value = -1, got %ld", TEST_RETURN);
 	}
 }
diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
index 89adc16..2527865 100644
--- a/testcases/kernel/syscalls/madvise/madvise03.c
+++ b/testcases/kernel/syscalls/madvise/madvise03.c
@@ -284,7 +284,7 @@ void check_and_print(char *advice)
 	if (TEST_RETURN == -1) {
 		tst_resm(TFAIL,
 			 "madvise test for %s failed with "
-			 "return = %d, errno = %d : %s",
+			 "return = %ld, errno = %d : %s",
 			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
 	} else if (STD_FUNCTIONAL_TEST) {
 		tst_resm(TPASS, "madvise test for %s PASSED", advice);
diff --git a/testcases/kernel/syscalls/mlock/mlock01.c b/testcases/kernel/syscalls/mlock/mlock01.c
index 9b1585d..5fd2b43 100644
--- a/testcases/kernel/syscalls/mlock/mlock01.c
+++ b/testcases/kernel/syscalls/mlock/mlock01.c
@@ -125,7 +125,7 @@ int main(int ac, char **av)
 			if (TEST_RETURN == -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
 				tst_resm(TFAIL, "mlock(%p, %d) Failed with "
-					 "return=%d, errno=%d : %s",
+					 "return=%ld, errno=%d : %s",
 					 TC[i].addr, TC[i].len,
 					 TEST_RETURN, TEST_ERRNO,
 					 strerror(TEST_ERRNO));
diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index cf058b7..a869705 100644
--- a/testcases/kernel/syscalls/mlock/mlock02.c
+++ b/testcases/kernel/syscalls/mlock/mlock02.c
@@ -137,7 +137,7 @@ int main(int ac, char **av)
 			} else {
 				tst_brkm(TFAIL, cleanup,
 					 "mlock() Failed, expected "
-					 "return value=-1, got %d",
+					 "return value=-1, got %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/times/times01.c b/testcases/kernel/syscalls/times/times01.c
index b732a32..a5a7a94 100644
--- a/testcases/kernel/syscalls/times/times01.c
+++ b/testcases/kernel/syscalls/times/times01.c
@@ -171,7 +171,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "times(&mytimes) returned %d",
+				tst_resm(TPASS, "times(&mytimes) returned %ld",
 					 TEST_RETURN);
 			}
 		}
diff --git a/testcases/kernel/syscalls/wait/wait02.c b/testcases/kernel/syscalls/wait/wait02.c
index 77716f3..3ba47e2 100644
--- a/testcases/kernel/syscalls/wait/wait02.c
+++ b/testcases/kernel/syscalls/wait/wait02.c
@@ -182,7 +182,7 @@ int main(int ac, char **av)
 	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
-				tst_resm(TPASS, "wait(&ret_code) returned %d",
+				tst_resm(TPASS, "wait(&ret_code) returned %ld",
 					 TEST_RETURN);
 			}
 		}
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
