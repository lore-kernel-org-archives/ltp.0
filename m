From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Jun 2016 17:28:54 +0300
Subject: [LTP] [PATCH 6/8] network/nfs/nfsflock: clenaup & use test_net
	library
In-Reply-To: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
References: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1466432936-3099-7-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add new test configurations and remove not used nfs_flock_frk.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.nfs                                 |    9 ++-
 testcases/network/.gitignore                    |    1 -
 testcases/network/nfs/nfslock01/nfs_flock_frk.c |   39 ------
 testcases/network/nfs/nfslock01/nfslock01       |  155 ++++++-----------------
 4 files changed, 44 insertions(+), 160 deletions(-)
 delete mode 100644 testcases/network/nfs/nfslock01/nfs_flock_frk.c

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 81d75aa..9898f1b 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -47,7 +47,14 @@ nfs4_ipv6_05 nfs05 -6 -v 4 -t tcp
 nfs41_ipv6_05 nfs05 -6 -v 4.1 -t tcp
 nfs42_ipv6_05 nfs05 -6 -v 4.2 -t tcp
 
-nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
+nfslock3_01 nfslock01 -v 3 -t udp
+nfslock4_01 nfslock01 -v 4 -t tcp
+nfslock41_01 nfslock01 -v 4.1 -t tcp
+nfslock42_01 nfslock01 -v 4.2 -t tcp
+nfslock3_ipv6_01 nfslock01 -6 -v 3 -t udp
+nfslock4_ipv6_01 nfslock01 -6 -v 4 -t tcp
+nfslock41_ipv6_01 nfslock01 -6 -v 4.1 -t tcp
+nfslock42_ipv6_01 nfslock01 -6 -v 4.2 -t tcp
 
 nfsstat3_01 nfsstat01
 
diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index ca4e0f3..2260475 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -19,7 +19,6 @@
 /nfs/nfs_fsstress/fsstress
 /nfs/nfslock01/nfs_flock
 /nfs/nfslock01/nfs_flock_dgen
-/nfs/nfslock01/nfs_flock_frk
 /nfsv4/acl/acl1
 /nfsv4/locks/locktests
 /rpc/basic_tests/rpc01/rpc1
diff --git a/testcases/network/nfs/nfslock01/nfs_flock_frk.c b/testcases/network/nfs/nfslock01/nfs_flock_frk.c
deleted file mode 100644
index 234da9f..0000000
--- a/testcases/network/nfs/nfslock01/nfs_flock_frk.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * This program starts processes one and two simultaneously.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-
-int main(int argc, char **argv)
-{
-	pid_t pid;
-	char *Prog;
-
-	if (argc != 3) {
-		fprintf(stderr, "Usage: %s <process> <datafile>\n", argv[0]);
-		exit(2);
-	}
-
-	Prog = strrchr(argv[1], '/');
-	Prog++;
-
-	if ((pid = fork()) < 0) {
-		printf("Failed in forking, Errno = %d", errno);
-		exit(2);
-	} else if (pid == 0) {	/* child */
-		execl(argv[1], Prog, "0", argv[2], NULL);
-	} else {		/* parent */
-		execl(argv[1], Prog, "1", argv[2], NULL);
-	}
-
-	/*if (waitpid(pid, NULL, 0) != pid)
-	   printf("Failed in waitpid, Errno = %d", errno);
-	 */
-	exit(0);
-}
diff --git a/testcases/network/nfs/nfslock01/nfslock01 b/testcases/network/nfs/nfslock01/nfslock01
index 8485d85..f480da8 100755
--- a/testcases/network/nfs/nfslock01/nfslock01
+++ b/testcases/network/nfs/nfslock01/nfslock01
@@ -1,152 +1,69 @@
 #!/bin/sh
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2001
 #
-#   Copyright (c) International Business Machines  Corp., 2001
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-#  FILE   : nfslock
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 #  PURPOSE:
 #           Two processes open FLOCK_IDATA file simultaneously
 #           each one locks odd and even lines of the file simultaneously
 #           and fill them with '0's and '1's. After they find eof, the
 #           datafiles are compared.
-#
-#  HISTORY:
-#    04/25/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#***********************************************************************
 
-#Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
+TCID=nfslock
+TST_TOTAL=1
+TST_CLEANUP="nfs_cleanup"
 
-$trace_logic
+. nfs_lib.sh
+. test_net.sh
 
-TC=nfslock
-TCbin=${TCbin:=`pwd`}
-TCtmp=${TCtmp:=$TCbin/$TC$$}
-TCsrc=${TCsrc:=$TCbin}
-TClog=${TClog:=$TCtmp}
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
-
-mkdir $TCtmp >/dev/null 2>&1
-
-CLEANUP=${CLEANUP:=ON}
 LUSER=${LUSER:=root}
 
-FLOCK_DATA=$TClog/nfs_flock_data
-FLOCK_IDATA=$TClog/nfs_flock_idata
-FLOCK_ODATA=$TClog/nfs_flock_odata
-
-FLOCK_EXEC=$TCsrc/nfs_flock
-FLOCK_DGEN=$TCsrc/nfs_flock_dgen
-FLOCK_FRK=$TCsrc/nfs_flock_frk
-
-#----------------------------------------------------------------------
-# FUNCTION: do_setup
-# PURPOSE:  To create the necessary files to carry out the test
-# INPUT:    None.
-# OUTPUT:   None.
-#----------------------------------------------------------------------
 do_setup()
 {
-$trace_logic
-   echo "doing Setup"
+	nfs_setup
 
-   $FLOCK_DGEN $FLOCK_DATA 63 16384 0
-   $FLOCK_DGEN $FLOCK_ODATA 63 16384 1
+	tst_resm TINFO "creating test files"
+	ROD nfs_flock_dgen flock_data 63 16384 0
+	ROD nfs_flock_dgen flock_odata 63 16384 1
 
-   [ `wc -c $FLOCK_DATA | awk '{print $1}'` -ne 1048576 ] && { \
-      echo "abort - could not create $FLOCK_DATA"; exit 99; }
-   [ `wc -c $FLOCK_ODATA | awk '{print $1}'` -ne 1048576 ] && { \
-      echo "abort - could not create $FLOCK_ODATA"; exit 99; }
-}
+	[ "$(wc -c flock_data | awk '{print $1}')" -ne 1048576 ] && \
+		tst_brkm TBROK "could not create 'flock_data'"
 
-#----------------------------------------------------------------------
-# FUNCTION: do_cleanup
-# PURPOSE:  To delete all the files created to run this test.
-# INPUT:    None.
-# OUTPUT:   None.
-#----------------------------------------------------------------------
-do_cleanup()
-{
-$trace_logic
-   sleep 5
-   rm -rf $TCtmp
+	[ "$(wc -c flock_odata | awk '{print $1}')" -ne 1048576 ] && \
+		tst_brkm TBROK "could not create 'flock_odata'"
 }
 
-#----------------------------------------------------------------------
-# FUNCTION: do_test
-# PURPOSE:  Perform the necessary steps to complete the test.
-# INPUT:    None.
-# OUPUT:    Error messages are logged if any of the tests fail.
-#----------------------------------------------------------------------
 do_test()
 {
-$trace_logic
-   echo "Testing locking"
+	tst_resm TINFO "Testing locking"
 
-   cp $FLOCK_DATA $FLOCK_IDATA
+	ROD cp flock_data flock_idata
 
-   echo "locking $FLOCK_IDATA file and writing data"
-   $FLOCK_FRK $FLOCK_EXEC $FLOCK_IDATA
-   [ $? = 0 ] || end_testcase "Errors in do_test $TC"
-   sleep 1
-   diff $FLOCK_ODATA $FLOCK_IDATA > /dev/null 2>&1
-   [ $? = 0 ] || end_testcase "$FLOCK_ODATA is different than $FLOCK_IDATA"
+	tst_resm TINFO "locking 'flock_idata' file and writing data"
 
-}
+	nfs_flock 0 flock_idata &
+	nfs_flock 1 flock_idata &
+	wait
 
-#=============================================================================
-# FUNCTION NAME:        end_testcase
-#
-# FUNCTION DESCRIPTION: Clean up
-#
-# PARAMETERS:           string, IF AND ONLY IF the testcase fails
-#
-# RETURNS:              None.
-#=============================================================================
+	ROD diff flock_odata flock_idata > /dev/null 2>&1
 
-end_testcase()
-{
-   $trace_logic
-   echo "$this_file: doing $0."
-   if [ "$CLEANUP" = "ON" ]; then
-     do_cleanup
-   fi
-
-   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-   tst_resm TFAIL "Test Failed: $@"
-   exit 1
+	tst_resm TPASS "'flock_odata' and 'flock_idata' have the same content"
 }
 
-
-#----------------------------------------------------------------------
-# FUNCTION: MAIN
-# PURPOSE:  To invoke the functions to perform the tasks described in
-#           the prologue.
-# INPUT:    None.
-# OUTPUT:   A testcase run log with the results of the execution of this
-#           test.
-#----------------------------------------------------------------------
-
 do_setup
+
 do_test
-end_testcase
+
+tst_exit
-- 
1.7.1

