From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Fri, 13 Jul 2018 15:46:18 +0200
Subject: [LTP] [PATCH] testcases: cve-2017-2671: Set attempts according to
	cpus
Message-ID: <20180713134618.29552-1-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

This test tries to run commands with 0x8000 attempts.
In a slow system platform, it leads to a failure
because of a timeout even when it is configured with
LTP_TIMEOUT_MUL=3D10.

This commit adds a way to configure the number of attempts
according to the number of CPUs.
In case of 1 CPU and a slow platform, using 0x2000 attempts
with a LTP_TIMEOUT_MUL=3D3 make the test pass.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/cve/cve-2017-2671.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index b0471bfff..a56bb45a8 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -49,7 +49,7 @@
=20
 #include "tst_fuzzy_sync.h"
=20
-#define ATTEMPTS 0x80000
+#define ATTEMPTS 0x2000
 #define PING_SYSCTL_PATH "/proc/sys/net/ipv4/ping_group_range"
=20
 static int sockfd;
@@ -109,9 +109,13 @@ static void *connect_b(void * param LTP_ATTRIBUTE_UNUS=
ED)
=20
 static void run(void)
 {
-	int i;
+	int i, total_cpus;
=20
-	for (i =3D 0; i < ATTEMPTS; i++) {
+	total_cpus =3D tst_ncpus();
+	if (total_cpus > 4)
+		total_cpus =3D 4;
+
+	for (i =3D 0; i < ATTEMPTS * total_cpus; i++) {
 		SAFE_CONNECT(sockfd,
 			     (struct sockaddr *)&iaddr, sizeof(iaddr));
=20
--=20
2.11.0

