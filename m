From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 30 Jul 2019 13:45:32 +0800
Subject: [LTP] [PATCH v3 4/5] m4: remove useless ltp-cgroupstats.m4
In-Reply-To: <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190729144227.GA8824@dell5510>
 <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1564465533-2475-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit ef772539, LTP_CHECK_CGROUPSTATS has been removed. But
testcase still used it. It looks like a mistakenly deletion. Removing
ltp-cgroupstats.m4, check linux/cgroupstats.h in configure.ac.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac          | 1 +
 m4/ltp-cgroupstats.m4 | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)
 delete mode 100644 m4/ltp-cgroupstats.m4

diff --git a/configure.ac b/configure.ac
index 70c6fef5b..6a3952622 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,6 +38,7 @@ AC_CHECK_HEADERS([ \
     linux/can.h \
     linux/dccp.h \
     linux/cryptouser.h \
+    linux/cgroupstats.h \
     linux/genetlink.h \
     linux/keyctl.h \
     linux/if_alg.h \
diff --git a/m4/ltp-cgroupstats.m4 b/m4/ltp-cgroupstats.m4
deleted file mode 100644
index 527f719ac..000000000
--- a/m4/ltp-cgroupstats.m4
+++ /dev/null
@@ -1,8 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Linux Test Project, 2009
-
-AC_DEFUN([LTP_CHECK_CGROUPSTATS],
-[
-AC_CHECK_HEADERS(linux/cgroupstats.h,[LTP_CHECK_CGROUPSTATS_HEADER=yes])
-AC_SUBST(LTP_CHECK_CGROUPSTATS_HEADER)
-])
-- 
2.18.1



