From: Petr Vorel <petr.vorel@gmail.com>
Date: Sun, 17 Nov 2019 15:26:43 +0100
Subject: [LTP] [COMMITTED][PATCH 2/2] rpc: Replace bcopy() with memcpy()
In-Reply-To: <20191117142643.26210-1-petr.vorel@gmail.com>
References: <20191117142643.26210-1-petr.vorel@gmail.com>
Message-ID: <20191117142643.26210-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

bcopy() is deprecated.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .../rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c  | 3 ++-
 .../rpc_clnttcp_create_limits.c                                | 3 ++-
 .../rpc_clnttcp_create_performance.c                           | 3 ++-
 .../rpc_clnttcp_create_stress.c                                | 3 ++-
 .../rpc_clntudp_bufcreate.c                                    | 1 +
 .../rpc_clntudp_bufcreate_limits.c                             | 1 +
 .../rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c  | 1 +
 .../rpc_clntudp_create_performance.c                           | 1 +
 .../rpc_clntudp_create_stress.c                                | 1 +
 9 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c
index e849468de..a83dd6005 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
@@ -61,7 +62,7 @@ int main(int argn, char *argc[])
 		exit(-1);
 	}
 
-	bcopy(hp->h_addr, (caddr_t) & server_addr.sin_addr, hp->h_length);
+	memcpy((caddr_t) & server_addr.sin_addr, hp->h_addr, hp->h_length);
 	server_addr.sin_family = AF_INET;
 	server_addr.sin_port = 0;
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits.c
index 8c1800bc2..3bc2ae7df 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
@@ -72,7 +73,7 @@ int main(int argn, char *argc[])
 		exit(-1);
 	}
 
-	bcopy(hp->h_addr, (caddr_t) & server_addr.sin_addr, hp->h_length);
+	memcpy((caddr_t) & server_addr.sin_addr, hp->h_addr, hp->h_length);
 	server_addr.sin_family = AF_INET;
 	server_addr.sin_port = 0;
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_performance.c
index 0df43db53..f9dda4711 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_performance.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/time.h>
 #include <rpc/rpc.h>
 #include <netdb.h>
@@ -112,7 +113,7 @@ int main(int argn, char *argc[])
 		exit(5);
 	}
 
-	bcopy(hp->h_addr, (caddr_t) & server_addr.sin_addr, hp->h_length);
+	memcpy((caddr_t) & server_addr.sin_addr, hp->h_addr, hp->h_length);
 	server_addr.sin_family = AF_INET;
 	server_addr.sin_port = 0;
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress.c
index 384a00d99..51d641292 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
@@ -65,7 +66,7 @@ int main(int argn, char *argc[])
 		exit(-1);
 	}
 
-	bcopy(hp->h_addr, (caddr_t) & server_addr.sin_addr, hp->h_length);
+	memcpy((caddr_t) & server_addr.sin_addr, hp->h_addr, hp->h_length);
 	server_addr.sin_family = AF_INET;
 	server_addr.sin_port = 0;
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate.c
index 285eb21b8..bbcecfecc 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits.c
index 1f2690ae4..a0182db87 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c
index faa8ef639..91f5b275d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_performance.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_performance.c
index 2722730c3..a8df6050f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_performance.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_performance.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/time.h>
 #include <rpc/rpc.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress.c
index 974f5fb76..1cbe1e8f8 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-- 
2.24.0

