From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:33 +0200
Subject: [LTP] [RFC PATCH 3/9] testcases: file: Add TST_NEEDS_CMDS on readelf
In-Reply-To: <20180423094639.14612-1-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
Message-ID: <20180423094639.14612-4-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

This test is using "readelf" binary that can be
unavailable on the system.
Instead of failing, it should return a TCONF.

This is what this commit is doing by adding "readelf"
in TST_NEEDS_CMDS macro.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/commands/file/file01.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/fi=
le01.sh
index e04b32e86..b72760e9f 100755
--- a/testcases/commands/file/file01.sh
+++ b/testcases/commands/file/file01.sh
@@ -28,6 +28,8 @@ TST_CNT=3D20
 TST_SETUP=3Dsetup
 TST_TESTFUNC=3Ddo_test
 TST_NEEDS_TMPDIR=3D1
+TST_NEEDS_CMDS=3D"readelf"
+
 . tst_test.sh
=20
 setup()
--=20
2.11.0

