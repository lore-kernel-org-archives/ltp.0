From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:37 +0200
Subject: [LTP] [RFC PATCH 7/9] testcases: df: Add "--printf" option as
	needed commands
In-Reply-To: <20180423094639.14612-1-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
Message-ID: <20180423094639.14612-8-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

In case Busybox is used with minimal configuration, the option
"--printf" is not available so the test is failing.

Add this option in the needed commands to return a TCONF
if it is not available.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/commands/df/df01.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index fbf1e2f2a..147620020 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -26,6 +26,8 @@ TST_PARSE_ARGS=3Dparse_args
 TST_NEEDS_ROOT=3D1
 TST_NEEDS_TMPDIR=3D1
 TST_NEEDS_DEVICE=3D1
+TST_NEEDS_CMDS=3D"stat --printf=3D%f"
+
 . tst_test.sh
=20
 usage()
--=20
2.11.0

