From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Mar 2020 19:27:04 +0100
Subject: [LTP] [PATCH] open_posix_testsuite: Enable the testsuite
In-Reply-To: <CAEemH2f5sMfOX5XjEOr8cmLRwu+YzMziEwRFPAegG+FAURi90A@mail.gmail.com>
References: <1584430400-47359-1-git-send-email-zou_wei@huawei.com>
 <CAEemH2f5sMfOX5XjEOr8cmLRwu+YzMziEwRFPAegG+FAURi90A@mail.gmail.com>
Message-ID: <20200317182704.GB10442@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Do we really need to enable the open_posix_testsuite explicitly? By
> default, LTP uses "--with-open-posix-testsuite" as the configure parameter
> to enabling it, is that work for you?

Even if we wanted to enable openposix by default, which may be a good
idea, we should change the default in configure.ac instead with:

diff --git a/configure.ac b/configure.ac
index c9ec39fce..0f2488617 100644
--- a/configure.ac
+++ b/configure.ac
@@ -256,7 +256,7 @@ AC_ARG_WITH([open-posix-testsuite],
   [AC_HELP_STRING([--with-open-posix-testsuite],
     [compile and install the open posix testsuite])],
   [with_open_posix_testsuite=$withval],
-  [with_open_posix_testsuite=no]
+  [with_open_posix_testsuite=yes]
 )
 if test "x$with_open_posix_testsuite" = xyes; then
     AC_SUBST([WITH_OPEN_POSIX_TESTSUITE],["yes"])

-- 
Cyril Hrubis
chrubis@suse.cz
