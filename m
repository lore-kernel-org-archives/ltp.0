From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Mar 2017 21:28:20 +0100
Subject: [LTP] [PATCH 1/1] rpc: Add missing header
Message-ID: <20170322202820.15989-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

This fixes: implicit declaration of function ‘pmap_unset’.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/rpc/basic_tests/rpc01/rpc_server.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
index db5865f94..6bf219607 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <rpc/rpc.h>
+#include <rpc/pmap_clnt.h>
 #include "librpc01.h"
 
 int debug = 0;
-- 
2.12.0

