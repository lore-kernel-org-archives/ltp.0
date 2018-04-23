From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:39 +0200
Subject: [LTP] [RFC PATCH 9/9] testcases: cpuset: Check if "getconf" is
	available
In-Reply-To: <20180423094639.14612-1-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
Message-ID: <20180423094639.14612-10-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

The "getconf" binary is used by cpuset_regression_test.sh
and may not be installed in the system. The test will fail
but it is a misconfiguration so let's use "tst_check_cmds"
to check if this binary is available and return a TCONF error
if not.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/kernel/controllers/cpuset/cpuset_regression_test.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh =
b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index 4a104a3ad..96a57955c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -34,6 +34,8 @@ setup()
 		tst_brkm TCONF "Test must be run with kernel 3.18.0 or newer"
 	fi
=20
+	tst_check_cmds "getconf"
+
 	local cpu_num=3D$(getconf _NPROCESSORS_ONLN)
 	if [ $cpu_num -lt 2 ]; then
 		tst_brkm TCONF "We need 2 cpus at least to have test"
--=20
2.11.0

