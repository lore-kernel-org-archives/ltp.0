From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:48 +0000
Subject: [LTP] [PATCH 28/31] rt_sigaction.h: Use sighandler_t instead of
	__sighandler_t
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-28-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When _GNU_SOURCE is used then both typedefs are same and using
sighandler_t makes it work on musl too

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 include/lapi/rt_sigaction.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index 3a5a763..870918c 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -34,7 +34,7 @@
 #define INVAL_SA_PTR ((void *)-1)
 
 struct kernel_sigaction {
-	__sighandler_t k_sa_handler;
+	sighandler_t k_sa_handler;
 	unsigned long sa_flags;
 	void (*sa_restorer) (void);
 	sigset_t sa_mask;
-- 
2.7.0

