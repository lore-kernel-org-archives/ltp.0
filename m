From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:36 +0200
Subject: [LTP] [RFC PATCH 6/9] testcases: wc: Add "unrecognized option" as
	TCONF
In-Reply-To: <20180423094639.14612-1-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
Message-ID: <20180423094639.14612-7-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

In case we are using Busybox, for example, some options
may not available and leads to a test failure.
This commit adds "unrecognized option" parsing to return the
test as a TCONF and not FAIL anymore.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/commands/wc/wc01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/wc/wc01.sh b/testcases/commands/wc/wc01.sh
index e72819c51..74d69e254 100755
--- a/testcases/commands/wc/wc01.sh
+++ b/testcases/commands/wc/wc01.sh
@@ -40,7 +40,7 @@ wc_test()
=20
 	eval $wc_cmd > temp 2>&1
 	if [ $? -ne 0 ]; then
-		grep -q -E "unknown option|invalid option" temp
+		grep -q -E "unknown option|invalid option|unrecognized option" temp
 		if [ $? -eq 0 ]; then
 			tst_res TCONF "$wc_cmd not supported."
 		else
--=20
2.11.0

