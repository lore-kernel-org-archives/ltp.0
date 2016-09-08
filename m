From: Zorro Lang <zlang@redhat.com>
Date: Thu,  8 Sep 2016 20:53:22 +0800
Subject: [LTP] [PATCH] runltp: add -R option for randomize test order
Message-ID: <1473339202-3047-1-git-send-email-zlang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Generally we write test entries into runtests/${testfile}, then
runltp reads and runs lines sequentially everytime, nearly no one
will change the test order.

Recently we find bugs by change the test order=EF=BC=8Cdifferent test
combination maybe find more bugs. So I add this new feature to
randomize test order.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 Makefile      |  2 +-
 randlines.awk | 43 +++++++++++++++++++++++++++++++++++++++++++
 runltp        | 14 +++++++++++++-
 3 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 randlines.awk

diff --git a/Makefile b/Makefile
index 297f8e7..f6a56a7 100644
--- a/Makefile
+++ b/Makefile
@@ -163,7 +163,7 @@ clean:: $(CLEAN_TARGETS)
 $(foreach tgt,$(MAKE_TARGETS) include-all lib-all $(filter-out clean_insta=
ll_dir,$(CLEAN_TARGETS)) $(INSTALL_TARGETS) include-install lib-install,$(e=
val $(call target_to_dir_dep_mapping,$(tgt))))
=20
 BINDIR_INSTALL_SCRIPTS	:=3D execltp
-SRCDIR_INSTALL_SCRIPTS	:=3D IDcheck.sh runalltests.sh runltp runltplite.sh=
 ver_linux
+SRCDIR_INSTALL_SCRIPTS	:=3D IDcheck.sh runalltests.sh runltp runltplite.sh=
 ver_linux randlines.awk
 SRCDIR_INSTALL_READONLY	:=3D Version
 SRCDIR_INSTALL_TARGETS	:=3D $(SRCDIR_INSTALL_SCRIPTS) $(SRCDIR_INSTALL_REA=
DONLY)
=20
diff --git a/randlines.awk b/randlines.awk
new file mode 100644
index 0000000..39f34cd
--- /dev/null
+++ b/randlines.awk
@@ -0,0 +1,43 @@
+#######################################################################
+# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Zorro Lang <zlang@redhat.com>
+#
+#######################################################################
+
+# randomize all lines of stdin
+
+function randomize(array, N) {
+	for(i =3D 0; i < N; i++) {
+		j =3D int(rand()*N)
+		if ( i !=3D j) {
+			tmp =3D array[i]
+			array[i] =3D array[j]
+			array[j] =3D tmp
+		}
+	}
+	return
+}
+
+{
+	array[NR] =3D $0
+}
+
+END {
+	srand()
+	randomize(array, NR)
+	for(i =3D 0; i < NR; i++) printf("%s\n", array[i])
+}
diff --git a/runltp b/runltp
index bb2e5d8..1f44b1f 100755
--- a/runltp
+++ b/runltp
@@ -64,6 +64,8 @@
 #               - Added capability for default Log file generation
 #		Aug 17 2009 - Modified - Subrata Modak
 #		- Added Fault Injection generation Capability through -F Option
+#		Sep 08 2016 - Modified - Zorro Lang
+#		- Added randomize test order capability through -R Option
 #
 ##########################################################################=
#######
=20
@@ -153,6 +155,7 @@ usage()
     -p              Human readable format logfiles.
     -q              Print less verbose output to screen.
     -r LTPROOT      Fully qualified path where testsuite is installed.
+    -R              Randomize test order.
     -s PATTERN      Only run test cases which match PATTERN.
     -S SKIPFILE     Skip tests specified in SKIPFILE
     -t DURATION     Execute the testsuite for given duration. Examples:
@@ -213,12 +216,13 @@ main()
     local EMAIL_TO=3D""
     local TAG_RESTRICT_STRING=3D""
     local PAN_COMMAND=3D""
+    local RANDOMRUN=3D0
     local DEFAULT_FILE_NAME_GENERATION_TIME=3D`date +"%Y_%m_%d-%Hh_%Mm_%Ss=
"`
     local scenfile=3D
=20
     version_date=3D$(cat "$LTPROOT/Version")
=20
-    while getopts a:c:C:T:d:D:f:F:ehi:I:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B:=
z:Z: arg
+    while getopts a:c:C:T:d:D:f:F:ehi:I:K:g:l:m:M:Nno:pqr:Rs:S:t:T:w:x:b:B=
:z:Z: arg
     do  case $arg in
         a)  EMAIL_TO=3D$OPTARG
             ALT_EMAIL_OUT=3D1;;
@@ -410,6 +414,8 @@ main()
=20
         r)  LTPROOT=3D$OPTARG;;
=20
+        R)  RANDOMRUN=3D1;;
+
         s)  TAG_RESTRICT_STRING=3D$OPTARG;;
=20
 	S)  case $OPTARG in
@@ -740,6 +746,12 @@ main()
          done
     fi
=20
+    # randomize alltests
+    if [ "$RANDOMRUN" !=3D "0" ]; then
+       awk -f ${LTPROOT}/randlines.awk ${TMP}/alltests > ${TMP}/alltests.t=
emp
+       cat ${TMP}/alltests.temp > ${TMP}/alltests
+    fi
+
     [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
     PAN_COMMAND=3D"${LTPROOT}/bin/ltp-pan $QUIET_MODE -e -S $INSTANCES $DU=
RATION -a $$ \
     -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE=
 $TCONFCMDFILE"
--=20
2.7.4

