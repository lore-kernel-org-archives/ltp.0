From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Fri, 13 Jul 2018 11:09:33 +0200
Subject: [LTP] [PATCH v3 2/2] testcases: Replace "getconf" by "tst_getconf"
In-Reply-To: <20180713090933.11409-1-mylene.josserand@bootlin.com>
References: <20180713090933.11409-1-mylene.josserand@bootlin.com>
Message-ID: <20180713090933.11409-3-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Now that tst_getconf is available to use "sysconf()" function
instead of relying on the application "getconf", let's convert
all the tests to it.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 testcases/commands/du/du01.sh                                    | 2 +-
 testcases/commands/mkswap/mkswap01.sh                            | 2 +-
 testcases/kernel/controllers/cpuset/cpuset_regression_test.sh    | 2 +-
 testcases/kernel/controllers/memcg/control/memcg_control_test.sh | 2 +-
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh       | 4 ++--
 testcases/kernel/numa/numa01.sh                                  | 2 +-
 testcases/lib/test.sh                                            | 4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index ed1df568f..c75068255 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -73,7 +73,7 @@ du_test()
 }
=20
 block_size=3D512
-page_size=3D$(getconf PAGESIZE)
+page_size=3D$(tst_getconf PAGESIZE)
 if [ "$page_size" -lt 1024 ]; then
 	tst_brk TBROK "Page size < 1024"
 fi
diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mks=
wap/mkswap01.sh
index 5ead4cdc5..341d48c08 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -29,7 +29,7 @@ setup()
 {
 	UUID=3D`uuidgen`
=20
-	PAGE_SIZE=3D`getconf PAGE_SIZE`
+	PAGE_SIZE=3D`tst_getconf PAGESIZE`
=20
 	# Here get the size of the device and align it down to be the
 	# multiple of $PAGE_SIZE and use that as the size for testing.
diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh =
b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index 4a104a3ad..72a2a944c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -34,7 +34,7 @@ setup()
 		tst_brkm TCONF "Test must be run with kernel 3.18.0 or newer"
 	fi
=20
-	local cpu_num=3D$(getconf _NPROCESSORS_ONLN)
+	local cpu_num=3D$(tst_getconf _NPROCESSORS_ONLN)
 	if [ $cpu_num -lt 2 ]; then
 		tst_brkm TCONF "We need 2 cpus@least to have test"
 	fi
diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.=
sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
index 1d158729c..4d9f1bb5d 100644
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -41,7 +41,7 @@ export TST_COUNT=3D0
 export TMP=3D${TMP:-/tmp}
 cd $TMP
=20
-PAGE_SIZE=3D$(getconf PAGESIZE)
+PAGE_SIZE=3D$(tst_getconf PAGESIZE)
=20
 TOT_MEM_LIMIT=3D$PAGE_SIZE
 ACTIVE_MEM_LIMIT=3D$PAGE_SIZE
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/t=
estcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 6a6af853b..cd16dc685 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -29,9 +29,9 @@ if [ "x$(grep -w memory /proc/cgroups | cut -f4)" !=3D "x=
1" ]; then
 	tst_brkm TCONF "Kernel does not support the memory resource controller"
 fi
=20
-PAGESIZE=3D$(getconf PAGESIZE)
+PAGESIZE=3D$(tst_getconf PAGESIZE)
 if [ $? -ne 0 ]; then
-	tst_brkm TBROK "getconf PAGESIZE failed"
+	tst_brkm TBROK "tst_getconf PAGESIZE failed"
 fi
=20
 HUGEPAGESIZE=3D$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01=
.sh
index da2f80ddd..327fa2f1f 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -75,7 +75,7 @@ check_for_support_numa()
 setup()
 {
 	export MB=3D$((1024*1024))
-	export PAGE_SIZE=3D$(getconf PAGE_SIZE)
+	export PAGE_SIZE=3D$(tst_getconf PAGESIZE)
 	export HPAGE_SIZE=3D$(awk '/Hugepagesize:/ {print $2}' /proc/meminfo)
=20
 	total_nodes=3D0
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index bce9893a9..650712181 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -421,9 +421,9 @@ fi
 if [ "$TST_NEEDS_CHECKPOINTS" =3D "1" ]; then
 	LTP_IPC_PATH=3D"/dev/shm/ltp_${TCID}_$$"
=20
-	LTP_IPC_SIZE=3D$(getconf PAGESIZE)
+	LTP_IPC_SIZE=3D$(tst_getconf PAGESIZE)
 	if [ $? -ne 0 ]; then
-		tst_brkm TBROK "getconf PAGESIZE failed"
+		tst_brkm TBROK "tst_getconf PAGESIZE failed"
 	fi
=20
 	ROD_SILENT dd if=3D/dev/zero of=3D"$LTP_IPC_PATH" bs=3D"$LTP_IPC_SIZE" co=
unt=3D1
--=20
2.11.0

