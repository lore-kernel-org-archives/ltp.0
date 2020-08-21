From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 21 Aug 2020 18:18:39 +0800
Subject: [LTP] [PATCH] tst_af_alg: fix build error when
 ALG_SET_AEAD_ASSOCLEN undefined
Message-ID: <1598005119-2147-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On older kernel such as 3.10.0-1136.el7.x86_64, compile failed as below:
tst_af_alg.c: In function ?tst_alg_sendmsg?:
tst_af_alg.c:205:21: error: ?ALG_SET_AEAD_ASSOCLEN? undeclared (first use in this function)
   cmsg->cmsg_type = ALG_SET_AEAD_ASSOCLEN;
                     ^
tst_af_alg.c:205:21: note: each undeclared identifier is reported only once for each function it appears in
make: *** [tst_af_alg.o] Error 1

It compile failed because ltp lapi/if_alg.h can't handle fallback logic, so corret it.

The ALG_SET_AEAD_ASSOCLEN flag was introduced since kernel commit af8e80731a
("crypto: af_alg - add user space interface for AEAD") in 2014.

Fixes: 3cbb963abb ("lib/tst_af_alg: add tst_alg_sendmsg()")
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac          |  6 ++++++
 include/lapi/if_alg.h | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 382963d8b..f711ac123 100644
--- a/configure.ac
+++ b/configure.ac
@@ -193,6 +193,12 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
 #include <linux/netfilter_ipv4/ip_tables.h>
 ])
 
+AC_CHECK_TYPES([struct sockaddr_alg, struct af_alg_iv],,,[
+#ifdef HAVE_LINUX_IF_ALG_H
+# include <linux/if_alg.h>
+#endif
+])
+
 # Tools knobs
 
 # Expect
diff --git a/include/lapi/if_alg.h b/include/lapi/if_alg.h
index 5a74df99b..9c04a444c 100644
--- a/include/lapi/if_alg.h
+++ b/include/lapi/if_alg.h
@@ -8,9 +8,10 @@
 
 #ifdef HAVE_LINUX_IF_ALG_H
 #  include <linux/if_alg.h>
-#else
+#endif
 #  include <stdint.h>
 
+#ifndef HAVE_STRUCT_SOCKADDR_ALG
 struct sockaddr_alg {
 	uint16_t	salg_family;
 	uint8_t		salg_type[14];
@@ -18,21 +19,41 @@ struct sockaddr_alg {
 	uint32_t	salg_mask;
 	uint8_t		salg_name[64];
 };
+#endif
 
+#ifndef HAVE_STRUCT_AF_ALG_IV
 struct af_alg_iv {
 	uint32_t	ivlen;
 	uint8_t		iv[0];
 };
+#endif
 
-#define ALG_SET_KEY		1
-#define ALG_SET_IV		2
-#define ALG_SET_OP		3
-#define ALG_SET_AEAD_ASSOCLEN	4
-#define ALG_SET_AEAD_AUTHSIZE	5
+#ifndef ALG_SET_KEY
+# define ALG_SET_KEY		1
+#endif
 
-#define ALG_OP_DECRYPT		0
-#define ALG_OP_ENCRYPT		1
+#ifndef ALG_SET_IV
+# define ALG_SET_IV		2
+#endif
 
-#endif /* !HAVE_LINUX_IF_ALG_H */
+#ifndef ALG_SET_OP
+# define ALG_SET_OP		3
+#endif
+
+#ifndef ALG_SET_AEAD_ASSOCLEN
+# define ALG_SET_AEAD_ASSOCLEN	4
+#endif
+
+#ifndef ALG_SET_AEAD_AUTHSIZE
+# define ALG_SET_AEAD_AUTHSIZE	5
+#endif
+
+#ifndef ALG_OP_DECRYPT
+# define ALG_OP_DECRYPT		0
+#endif
+
+#ifndef ALG_OP_ENCRYPT
+# define ALG_OP_ENCRYPT		1
+#endif
 
 #endif /* IF_ALG_H__ */
-- 
2.23.0



