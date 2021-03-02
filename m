From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 02 Mar 2021 13:44:19 +0000
Subject: [LTP] [PATCH] mk/lib.mk: Sort wildcard expansion for determinism
Message-ID: <1fa1c796f925bae086f1a6d6ab94c21432419628.camel@linuxfoundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The order of the objects linked into libltp.a varies depending on the
order of the files found on disk. This results in most ltp binaries
differing depending on that order too.

Sort the wildcard expansion of *.c which leads to reproducible binaries.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Index: git/include/mk/lib.mk
===================================================================
--- git.orig/include/mk/lib.mk
+++ git/include/mk/lib.mk
@@ -50,6 +50,7 @@ endif
 MAKE_TARGETS	+= $(LIB)
 
 LIBSRCS		?= $(wildcard $(abs_srcdir)/*.c)
+LIBSRCS		:= $(sort $(LIBSRCS))
 LIBSRCS		:= $(abspath $(LIBSRCS))
 LIBSRCS		:= $(subst $(abs_srcdir)/,,$(wildcard $(LIBSRCS)))
 LIBSRCS		:= $(filter-out $(FILTER_OUT_LIBSRCS),$(LIBSRCS))


