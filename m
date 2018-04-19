From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Apr 2018 21:55:02 +0200
Subject: [LTP] [RFC PATCH v3 09/10] ima: CRYPTO_LIBS are needed only for
	ima_boot_aggregate
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Message-ID: <20180419195503.7194-10-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/src/Makefile b/testcases/kernel/security/integrity/ima/src/Makefile
index 0f4cf8c12..f7a818578 100644
--- a/testcases/kernel/security/integrity/ima/src/Makefile
+++ b/testcases/kernel/security/integrity/ima/src/Makefile
@@ -24,6 +24,6 @@ top_srcdir		?= ../../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS			+= $(CRYPTO_LIBS) -ldl
+ima_boot_aggregate: LDLIBS += $(CRYPTO_LIBS) -ldl
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.16.3

