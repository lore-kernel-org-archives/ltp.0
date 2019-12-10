From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 10 Dec 2019 21:13:21 +0100
Subject: [LTP] [PATCH 3/3] rpc: Remove <sys/socketvar.h>
In-Reply-To: <20191210201321.1430984-1-petr.vorel@gmail.com>
References: <20191210201321.1430984-1-petr.vorel@gmail.com>
Message-ID: <20191210201321.1430984-4-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

nonstandard <sys/socketvar.h> just includes <sys/socket.h>.

This fixes build on musl.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .../rpc/rpc_createdestroy_svcraw_create/rpc_svcraw_create.c      | 1 -
 .../rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create.c      | 1 -
 .../rpc_createdestroy_svctcp_create/rpc_svctcp_create_stress.c   | 1 -
 .../rpc_createdestroy_svcudp_bufcreate/rpc_svcudp_bufcreate.c    | 1 -
 .../rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create.c      | 1 -
 .../rpc_createdestroy_svcudp_create/rpc_svcudp_create_stress.c   | 1 -
 .../rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c     | 1 -
 .../rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register.c   | 1 -
 .../rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister.c         | 1 -
 .../rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c | 1 -
 .../rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c       | 1 -
 11 files changed, 11 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/rpc_svcraw_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/rpc_svcraw_create.c
index e195c0ea6..004d1fad1 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/rpc_svcraw_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/rpc_svcraw_create.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create.c
index 38eeabbbb..3f1b90aaf 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create_stress.c
index 241ffd736..d465f26f5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create_stress.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/rpc_svcudp_bufcreate.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/rpc_svcudp_bufcreate.c
index 4e9955b7d..24f7142ca 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/rpc_svcudp_bufcreate.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/rpc_svcudp_bufcreate.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create.c
index 97fb875f0..19c2ac11f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create_stress.c
index 3b6b64039..e9f55557f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create_stress.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
index 974c348bb..3778f36bc 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 #include <utmp.h>
 
 //Standard define
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register.c
index 63adef031..99129cf7d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister.c
index b52a33760..8f0b6de68 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
index ea347b444..da3b93022 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
index 1d7151ca5..d0b7a20d4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
@@ -31,7 +31,6 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socketvar.h>
 
 //Standard define
 #define PROCNUM 1
-- 
2.24.0

