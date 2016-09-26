From: Zorro Lang <zlang@redhat.com>
Date: Mon, 26 Sep 2016 21:19:49 +0800
Subject: [LTP] [PATCH v4] runltp: add -R option for randomize test order
Message-ID: <1474895989-1117-1-git-send-email-zlang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Generally we write test entries into runtests/${testfile}, then
runltp reads and runs lines sequentially everytime, nearly no one
will change the test order.

Recently we find bugs by change the test order=EF=BC=8Cdifferent test
combination maybe find more bugs. So I add this new option -R to
randomize test order.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

V2 use 'sort -R' to instead of 'randlines.awk'.
V3 remove change log and someone useless comment
V4 turn to "sort ... -o ${TMP}/alltests"

Thanks,
Zorro

 runltp | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/runltp b/runltp
index bb2e5d8..1037389 100755
--- a/runltp
+++ b/runltp
@@ -153,6 +153,7 @@ usage()
     -p              Human readable format logfiles.
     -q              Print less verbose output to screen.
     -r LTPROOT      Fully qualified path where testsuite is installed.
+    -R              Randomize test order.
     -s PATTERN      Only run test cases which match PATTERN.
     -S SKIPFILE     Skip tests specified in SKIPFILE
     -t DURATION     Execute the testsuite for given duration. Examples:
@@ -213,12 +214,13 @@ main()
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
@@ -410,6 +412,8 @@ main()
=20
         r)  LTPROOT=3D$OPTARG;;
=20
+        R)  RANDOMRUN=3D1;;
+
         s)  TAG_RESTRICT_STRING=3D$OPTARG;;
=20
 	S)  case $OPTARG in
@@ -740,6 +744,10 @@ main()
          done
     fi
=20
+    if [ "$RANDOMRUN" !=3D "0" ]; then
+        sort -R ${TMP}/alltests -o ${TMP}/alltests
+    fi
+
     [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
     PAN_COMMAND=3D"${LTPROOT}/bin/ltp-pan $QUIET_MODE -e -S $INSTANCES $DU=
RATION -a $$ \
     -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE=
 $TCONFCMDFILE"
--=20
2.7.4

