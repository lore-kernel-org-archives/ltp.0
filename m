From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 May 2019 16:31:35 +0200
Subject: [LTP] [PATCH v4] syscalls/copy_file_range: add/restructured
	tests
In-Reply-To: <20190506201948.GA9828@dell5510>
References: <20190506105457.22350-1-camann@suse.com>
 <1ef7d8ee-ae31-b44c-71e6-7d09da55eda2@suse.com>
 <20190506201948.GA9828@dell5510>
Message-ID: <20190520143135.GA27341@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian, Cyril,

Before applying (with following diff), just 2 questions:

./copy_file_range02
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
copy_file_range.h:30: INFO: Testing libc copy_file_range()
copy_file_range.h:47: CONF: libc copy_file_range() not supported!
1) I know I was the one who asked to use .test_variants, but it probably does
not make sense to use it until glibc (or some other libc) adds copy_file_range()
wrapper.

tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
copy_file_range.h:33: INFO: Testing tst copy_file_range()
copy_file_range01.c:194: PASS: copy_file_range completed all 144 copy jobs successfully!



2) Glibc adds internal implementation of copy_file_range(), used as fallback
when kernel < 4.5 (which brought copy_file_range()) [1]. I guess there is no way
to use it explicitly :(.

Kind regards,
Petr

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=bad7a0c81f501fbbcc79af9eaa4b8254441c4a1f;hp=6cb86fd21ca6fdfc31042cda8c37f96c46b8a4da

diff --git configure.ac configure.ac
index 1d825dc1e..5dc85728a 100644
--- configure.ac
+++ configure.ac
@@ -60,6 +60,7 @@ AC_CHECK_HEADERS([ \
 ])
 
 AC_CHECK_FUNCS([ \
+    copy_file_range \
     epoll_pwait \
     execveat \
     fallocate \
@@ -198,7 +199,6 @@ LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_CAPABILITY_SUPPORT
 LTP_CHECK_CC_WARN_OLDSTYLE
 LTP_CHECK_CLONE_SUPPORTS_7_ARGS
-LTP_CHECK_COPY_FILE_RANGE
 LTP_CHECK_CRYPTO
 LTP_CHECK_FIDEDUPE
 LTP_CHECK_FORTIFY_SOURCE
diff --git m4/ltp-copy_file_range.m4 m4/ltp-copy_file_range.m4
deleted file mode 100644
index 2d87e8900..000000000
--- m4/ltp-copy_file_range.m4
+++ /dev/null
@@ -1,7 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2019 SUSE LLC
-dnl Author: Christian Amann <camann@suse.com>
-
-AC_DEFUN([LTP_CHECK_COPY_FILE_RANGE],[
-AC_CHECK_FUNCS(copy_file_range,,)
-])
diff --git testcases/kernel/syscalls/copy_file_range/copy_file_range.h testcases/kernel/syscalls/copy_file_range/copy_file_range.h
index d2ef1348b..b6d132978 100644
--- testcases/kernel/syscalls/copy_file_range/copy_file_range.h
+++ testcases/kernel/syscalls/copy_file_range/copy_file_range.h
@@ -44,7 +44,7 @@ static int sys_copy_file_range(int fd_in, loff_t *off_in,
 		return copy_file_range(fd_in, off_in,
 				fd_out, off_out, len, flags);
 #else
-		tst_brk(TCONF, "libc copy_file_range() not supported!");
+		tst_brk(TCONF, "libc copy_file_range() not supported");
 #endif
 		break;
 	case 1:
diff --git testcases/kernel/syscalls/copy_file_range/copy_file_range03.c testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
index 18e411af2..253eb57ad 100644
--- testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
+++ testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
@@ -45,7 +45,7 @@ static void verify_copy_file_range_timestamp(void)
 	if (timestamp == updated_timestamp)
 		tst_brk(TFAIL, "copy_file_range did not update timestamp.");
 
-	tst_res(TPASS, "copy_file_range sucessfully updated the timestamp!");
+	tst_res(TPASS, "copy_file_range sucessfully updated the timestamp");
 }
 
 static void cleanup(void)
