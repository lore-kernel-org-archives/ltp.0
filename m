From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:34 +0200
Subject: [LTP] [RFC PATCH 4/9] testcases: tar: Add TST_NEEDS_CMDS on gzip
	and bzip
In-Reply-To: <20180423094639.14612-1-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
Message-ID: <20180423094639.14612-5-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Add TST_NEEDS_CMDS to return a TCONF in case "gzip"
and "bzip2" binaries are not available on the system.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/commands/tar/tar_tests.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/commands/tar/tar_tests.sh b/testcases/commands/tar/t=
ar_tests.sh
index 7ac18a4e5..946e9c7b1 100755
--- a/testcases/commands/tar/tar_tests.sh
+++ b/testcases/commands/tar/tar_tests.sh
@@ -27,6 +27,8 @@
 TST_CNT=3D6
 TST_TESTFUNC=3Ddo_test
 TST_NEEDS_TMPDIR=3D1
+TST_NEEDS_CMDS=3D"gzip bzip2"
+
 . tst_test.sh
=20
 TAR_FILES=3D"file1 file2 file3"
--=20
2.11.0

