From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Feb 2017 12:10:38 +0100
Subject: [LTP] [PATCH 1/1] rusers.h is unused and not available for
	uClibc-ng / libtirpc
Message-ID: <20170216111038.28293-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Erico Nunes <nunes.erico@gmail.com>

Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
This fix for uClibc-ng from from buildroot [1] is valid, we should accept it.
https://git.busybox.net/buildroot/plain/package/ltp-testsuite/0004-rusers.h-is-unused-and-not-available-for-uClibc-ng-l.patch
---
 .../tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/rpc_auth_destroy.c    | 1 -
 .../rpc_suite/rpc/rpc_auth_authnone_create/rpc_authnone_create.c         | 1 -
 .../rpc_suite/rpc/rpc_auth_authunix_create/rpc_authunix_create.c         | 1 -
 .../rpc/rpc_auth_authunix_create_default/rpc_authunix_create_default.c   | 1 -
 .../rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c  | 1 -
 .../rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits.c     | 1 -
 .../rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress.c     | 1 -
 .../rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate.c      | 1 -
 .../rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits.c   | 1 -
 .../rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c  | 1 -
 .../rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress.c     | 1 -
 11 files changed, 11 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/rpc_auth_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/rpc_auth_destroy.c
index 7f157e192..728c0232d 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/rpc_auth_destroy.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/rpc_auth_destroy.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/rpc_authnone_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/rpc_authnone_create.c
index d9a31113d..8d80a5ec2 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/rpc_authnone_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/rpc_authnone_create.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/rpc_authunix_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/rpc_authunix_create.c
index cabffc7fa..a4d1d6fb1 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/rpc_authunix_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/rpc_authunix_create.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/rpc_authunix_create_default.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/rpc_authunix_create_default.c
index 4f10466f1..863aec794 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/rpc_authunix_create_default.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/rpc_authunix_create_default.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c
index 290f357dc..e849468de 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits.c
index 55bac16ee..8c1800bc2 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress.c
index 09d1bf98d..384a00d99 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate.c
index 3e153064e..285eb21b8 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits.c
index a7030a264..1f2690ae4 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c
index 06f4740eb..faa8ef639 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress.c
index ca38aa0a5..974f5fb76 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress.c
@@ -30,7 +30,6 @@
 #include <time.h>
 #include <rpc/rpc.h>
 #include <sys/socket.h>
-#include <rpcsvc/rusers.h>
 #include <utmp.h>
 #include <sys/time.h>
 #include <netdb.h>
-- 
2.11.0

