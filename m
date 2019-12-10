From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 10 Dec 2019 21:13:20 +0100
Subject: [LTP] [PATCH 2/3] rpc: Add missing <string.h>
In-Reply-To: <20191210201321.1430984-1-petr.vorel@gmail.com>
References: <20191210201321.1430984-1-petr.vorel@gmail.com>
Message-ID: <20191210201321.1430984-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes implicit declaration of function error for memcpy(), memset()
and strcmp() (build with -Werror=implicit-function-declaration)

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/network/rpc/basic_tests/rpc01/rpc_server.c             | 1 +
 .../rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c   | 1 +
 .../rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc_dataint.c      | 1 +
 .../rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_dataint.c  | 1 +
 .../rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc.c          | 1 +
 .../rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c      | 1 +
 .../rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c  | 1 +
 .../tirpc_bottomlevel_clnt_call_dataint.c                        | 1 +
 .../tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c | 1 +
 .../tirpc_bottomlevel_clnt_call_scalability.c                    | 1 +
 .../tirpc_expertlevel_clnt_call_complex.c                        | 1 +
 .../tirpc_expertlevel_clnt_call_dataint.c                        | 1 +
 .../tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c | 1 +
 .../tirpc_expertlevel_clnt_call_scalability.c                    | 1 +
 .../tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c  | 1 +
 .../tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c  | 1 +
 .../tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c | 1 +
 .../tirpc_rpcb_rmtcall_scalability.c                             | 1 +
 .../rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c | 1 +
 .../tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c       | 1 +
 .../tirpc_interlevel_clnt_call_complex.c                         | 1 +
 .../tirpc_interlevel_clnt_call_dataint.c                         | 1 +
 .../tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c   | 1 +
 .../tirpc_interlevel_clnt_call_scalability.c                     | 1 +
 .../tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c     | 1 +
 .../tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c    | 1 +
 .../tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c | 1 +
 .../tirpc_rpc_broadcast_exp_dataint.c                            | 1 +
 .../tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c  | 1 +
 .../tirpc_rpc_broadcast_exp_scalability.c                        | 1 +
 .../tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c         | 1 +
 .../tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c         | 1 +
 .../rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c    | 1 +
 .../tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c     | 1 +
 .../rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c      | 1 +
 .../tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c  | 1 +
 .../tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c  | 1 +
 .../tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c | 1 +
 .../tirpc_toplevel_clnt_call_scalability.c                       | 1 +
 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/rpc_svc_1.c | 1 +
 40 files changed, 40 insertions(+)

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
index db5865f94..21a45ffeb 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
@@ -4,6 +4,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <rpc/rpc.h>
 #include "librpc01.h"
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c
index c6a3ba43f..17b960651 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc_dataint.c
index 407ebbef2..149ffccda 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_dataint.c
index 3cfa6b0b2..ca23e9f24 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc.c
index 38e610546..cdec0c081 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c
index 5ea06a0f6..c4860a500 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c
index 84a71178c..e32582364 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <rpc/rpc.h>
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c
index 22d9098ca..514c34588 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include "lapi/rpc.h"
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c
index 708f8c3bb..7c41734f6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c
index 361ce5508..05d25ab04 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c
index fb2dbe0f0..114682768 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c
index 913732484..26644e25e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include "lapi/rpc.h"
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c
index bdce52329..040f0809a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c
index 6c17e70c4..ceedc1901 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c
index c25cec133..d0d1091b4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c
index a0c5471b2..ecb8d3ccd 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include "lapi/rpc.h"
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c
index f61a33bce..8cbe5b992 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c
index 447c7169f..405f9c283 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c
index 167890c96..8473c0414 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c
index d812509bb..00bcc881e 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c
index 945557a76..3464ff23d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c
index 8b9ea2e8c..b9ed6dafa 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include "lapi/rpc.h"
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c
index f960d04d2..8e8bbc2e6 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c
index e7cca3ca3..c40be764c 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c
index f8a9ea135..30ffd931a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include "lapi/rpc.h"
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c
index 3cd02e593..1e773a1b5 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c
index c6a6e2d59..372f7420b 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c
index bd574b154..b358af532 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include "lapi/rpc.h"
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c
index 0a461279a..65189fad3 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c
index a40c2aa33..dea6d82cc 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c
index 6276f2fc7..5a44bf42f 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c
index 780f5a0f4..6ff385175 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include "lapi/rpc.h"
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c
index 376ac0fd2..06ffdd2f4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c
index 73118cbf3..4641da752 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c
index 6b6d500de..b1eb8433d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c
index 9ffb0ba73..2f965e534 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c
index e88663af4..e94f2037d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include "lapi/rpc.h"
 
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c
index 6f333ac3e..2ffaa8219 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <pthread.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c
index d2352b33f..12664fca8 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <pthread.h>
 #include <time.h>
 #include <errno.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/rpc_svc_1.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/rpc_svc_1.c
index 63dd2f161..275774923 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/rpc_svc_1.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/rpc_svc_1.c
@@ -26,6 +26,7 @@
 */
 
 #include <stdio.h>
+#include <string.h>
 #include <rpc/rpc.h>
 #include <utmp.h>
 
-- 
2.24.0

