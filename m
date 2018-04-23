From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:38 +0200
Subject: [LTP] [RFC PATCH 8/9] testcases: test.sh: Check if "getconf" is
	available
In-Reply-To: <20180423094639.14612-1-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
Message-ID: <20180423094639.14612-9-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

In case TST_NEEDS_CHECKPOINTS is set to 1, the "getconf"
binary is used. This binary may not be installed in the system
and it will return a FAIL. Instead, add a check on this binary
to return "TCONF" in that case.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/lib/test.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index bce9893a9..b27dbf4ab 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -421,6 +421,8 @@ fi
 if [ "$TST_NEEDS_CHECKPOINTS" =3D "1" ]; then
 	LTP_IPC_PATH=3D"/dev/shm/ltp_${TCID}_$$"
=20
+	tst_check_cmds "getconf"
+
 	LTP_IPC_SIZE=3D$(getconf PAGESIZE)
 	if [ $? -ne 0 ]; then
 		tst_brkm TBROK "getconf PAGESIZE failed"
--=20
2.11.0

