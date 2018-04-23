From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:32 +0200
Subject: [LTP] [RFC PATCH 2/9] testcases: ar: Add TST_NEEDS_CMDS on "ar"
In-Reply-To: <20180423094639.14612-1-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
Message-ID: <20180423094639.14612-3-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

In case "ar" binary is not available, the test will fail.
It should return a TCONF as we just do not have the binary.

This commit adds TST_NEEDS_CMDS macro on "ar". Thanks to that,
it will return "TCONF" and not "FAIL" when "ar" is not available.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/commands/ar/ar01 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/commands/ar/ar01 b/testcases/commands/ar/ar01
index ddab2e0f0..edaa24657 100644
--- a/testcases/commands/ar/ar01
+++ b/testcases/commands/ar/ar01
@@ -22,9 +22,12 @@
 #
 # This is a basic ar command test.
 #
+AR=3D${AR:=3Dar}
 TST_CNT=3D17
 TST_TESTFUNC=3Dtest
 TST_NEEDS_TMPDIR=3D1
+TST_NEEDS_CMDS=3D"$AR"
+
 . tst_test.sh
=20
 test1()
--=20
2.11.0

