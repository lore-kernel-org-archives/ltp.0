From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Jun 2021 10:23:06 +0200
Subject: [LTP] [PATCH] futex_wake04: avoid tst_ts_from_ns overflow on
 32-bit platforms
In-Reply-To: <20210608132723.255996-1-cascardo@canonical.com>
References: <20210608132723.255996-1-cascardo@canonical.com>
Message-ID: <YMB6aoVvTKJQ6wif@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Good catch, I guess that it would be slightly cleaner to fix the
NSEC_PER_SEC size instead with:

diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
index b783beff4..e50f698d6 100644
--- a/include/lapi/common_timers.h
+++ b/include/lapi/common_timers.h
@@ -12,7 +12,7 @@
 #include "lapi/posix_clocks.h"

 #ifndef NSEC_PER_SEC
-#define NSEC_PER_SEC (1000000000L)
+#define NSEC_PER_SEC (1000000000LL)
 #endif

 static const clock_t clock_list[] = {


What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz
