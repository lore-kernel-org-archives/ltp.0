From: Li Wang <liwang@redhat.com>
Date: Sat, 9 May 2020 11:50:13 +0800
Subject: [LTP] [PATCH V2 16/17] syscalls/utimensat: Migrate to new test
 framework
In-Reply-To: <e03c9d77116e9f7f2b6a179644aab18bd9ece9e1.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <e03c9d77116e9f7f2b6a179644aab18bd9ece9e1.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2eNPdvn=g-Br5euJ=qnOJi4KraUcpLmM1RZD+iN_K7FpA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

On Fri, May 8, 2020 at 12:28 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> This gets rid of the test script and updates the utimensat01.c file to
> handle most of the tests covered earlier (apart from testing the same
> for files owned by root, as the test is run as root right now).
>

Since we have removed the utimensat01_test.sh script, the Makefile,
runtest/syscalls should be updated too.
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1600,7 +1600,7 @@ utime06 utime06
 utimes01 utimes01

 # Introduced from Kernel 2.6.22 onwards
-utimensat01 utimensat_tests.sh
+utimensat01 utimensat01

 vfork01 vfork01
 vfork02 vfork02
diff --git a/testcases/kernel/syscalls/utimensat/Makefile
b/testcases/kernel/syscalls/utimensat/Makefile
index 69cab8dbc..044619fb8 100644
--- a/testcases/kernel/syscalls/utimensat/Makefile
+++ b/testcases/kernel/syscalls/utimensat/Makefile
@@ -5,8 +5,4 @@ top_srcdir              ?= ../../../..

 include $(top_srcdir)/include/mk/testcases.mk

-vpath %.c $(srcdir):$(top_srcdir)/lib
-
-INSTALL_TARGETS                := utimensat_tests.sh
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200509/3d8982e1/attachment-0001.htm>
