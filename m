Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VgnnQ-0003XO-6J
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:40:44 +0000
Received: from mail-pb0-f44.google.com ([209.85.160.44])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VgnnO-0002sI-LI
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:40:44 +0000
Received: by mail-pb0-f44.google.com with SMTP id rp16so1406508pbb.31
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Nov 2013 19:40:36 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Thu, 14 Nov 2013 11:38:32 +0800
Message-Id: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 1/8] ltp-networking: standardize test result
	message
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: linaro-networking@linaro.org

Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
---
 testcases/network/multicast/mc_cmds/mc_cmds        |    9 +++++++--
 testcases/network/multicast/mc_commo/mc_commo      |    8 ++++++--
 testcases/network/multicast/mc_member/mc_member    |    8 ++++++--
 testcases/network/multicast/mc_opts/mc_opts        |    8 ++++++--
 testcases/network/nfs/fsx-linux/fsx.sh             |    7 +++++--
 testcases/network/nfs/nfs01/nfs01                  |    7 +++++--
 testcases/network/nfs/nfs02/nfs02                  |    7 +++++--
 testcases/network/nfs/nfs03/nfs03                  |    7 +++++--
 testcases/network/nfs/nfslock01/nfslock01          |    7 +++++--
 testcases/network/nfs/nfsstat01/nfsstat01          |    7 +++++--
 testcases/network/nfs/nfsstress/nfsstress          |    7 +++++--
 testcases/network/rpc/basic_tests/rpc01/rpc01      |    7 +++++--
 .../network/rpc/basic_tests/rpcinfo/rpcinfo01      |    7 +++++--
 testcases/network/rpc/basic_tests/rup/rup01        |    7 +++++--
 testcases/network/rpc/basic_tests/rusers/rusers01  |    7 +++++--
 15 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index d27f669..9c31844 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -36,6 +36,11 @@ $trace_logic

 TC=mc_cmds
 PING_OUT=/tmp/${TC}_out
+
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1
+
 # Set the LTPROOT variable to the correct path
 # from the ltp/testcases/bin directory or the
 # /ltp/testcases/network/multicast/mc_cmds directory
@@ -188,8 +193,8 @@ end_testcase()
    # Call other cleanup functions
    [ $CLEANUP = "ON" ] && do_cleanup

-   [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-   echo "Test Failed: $@"
+   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+   tst_resm TFAIL "Test Failed: $@"
    exit 1
 }

diff --git a/testcases/network/multicast/mc_commo/mc_commo b/testcases/network/multicast/mc_commo/mc_commo
index 50fa6b9..14dce85 100755
--- a/testcases/network/multicast/mc_commo/mc_commo
+++ b/testcases/network/multicast/mc_commo/mc_commo
@@ -51,6 +51,10 @@ OUTFILE=$TCtmp/mc_commo_out
 NUMLOOPS=${NUMLOOPS:-2}
 INTERFACE=${INTERFACE:-$("$LTPROOT/bin/gethost" `hostname` | grep addresses: | awk '{print $2}')}

+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1
+
 this_file=${0##*/}
 trap "interrupt_test" 2

@@ -195,8 +199,8 @@ end_testcase()
    # Call other cleanup functions
    [ $CLEANUP = "ON" ] && do_cleanup

-   [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-   echo "Test Failed: $@"
+   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+   tst_resm TFAIL "Test Failed: $@"
    exit 1
 }

diff --git a/testcases/network/multicast/mc_member/mc_member b/testcases/network/multicast/mc_member/mc_member
index 0e79cdb..6801ebf 100755
--- a/testcases/network/multicast/mc_member/mc_member
+++ b/testcases/network/multicast/mc_member/mc_member
@@ -50,6 +50,10 @@ GLIST=${GLIST:-$TCsrc/ManyGroups}
 TooManyGLIST=${TooManyGLIST:-$TCsrc/TooManyGroups}
 ERRFILE=${ERRFILE:-$TCtmp/errors}

+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1
+
 this_file=${0##*/}
 trap "interrupt_test" 2

@@ -183,8 +187,8 @@ end_testcase()
    # Call other cleanup functions
    [ $CLEANUP = "ON" ] && do_cleanup

-   [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-   echo "Test Failed: $@"
+   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+   tst_resm TFAIL "Test Failed: $@"
    exit 1
 }

diff --git a/testcases/network/multicast/mc_opts/mc_opts b/testcases/network/multicast/mc_opts/mc_opts
index 41e1d68..a029f1e 100755
--- a/testcases/network/multicast/mc_opts/mc_opts
+++ b/testcases/network/multicast/mc_opts/mc_opts
@@ -49,6 +49,10 @@ EXECUTABLES=${EXECUTABLES:-"opts opts_e"}
 NUMLOOPS=${NUMLOOPS:-10}
 IPADDR=${IPADDR:-$("$LTPROOT/bin/gethost" `hostname`| grep address |awk '{ print $2 }')}

+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1
+
 this_file=${0##*/}
 trap "interrupt_test" 2

@@ -138,8 +142,8 @@ end_testcase()
    # Call other cleanup functions
    [ $CLEANUP = "ON" ] && do_cleanup

-   [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-   echo "Test Failed: $@"
+   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+   tst_resm TFAIL "Test Failed: $@"
    exit 1
 }

diff --git a/testcases/network/nfs/fsx-linux/fsx.sh b/testcases/network/nfs/fsx-linux/fsx.sh
index 9d94166..fddaf03 100755
--- a/testcases/network/nfs/fsx-linux/fsx.sh
+++ b/testcases/network/nfs/fsx-linux/fsx.sh
@@ -51,6 +51,9 @@ TCdat=${TCdat:=$TCbin}
 TCsrc=${TCsrc:=$TCbin}
 TCtmp=${TCtmp:=$TCbin/$TC$$}
 TCdump=${TCdump:=$TCbin}
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 # If CLEANUP is not set; set it to "ON"
 CLEANUP=${CLEANUP:="ON"}
@@ -177,8 +180,8 @@ $trace_logic
  rsh -n $RHOST "rm -rf $TESTDIR"
     fi

-    [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-    echo "Test Failed: $@"
+    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+    tst_resm TFAIL "Test Failed: $@"
     exit 1
 }

diff --git a/testcases/network/nfs/nfs01/nfs01 b/testcases/network/nfs/nfs01/nfs01
index 924f2c2..1a942c4 100755
--- a/testcases/network/nfs/nfs01/nfs01
+++ b/testcases/network/nfs/nfs01/nfs01
@@ -48,6 +48,9 @@ TCdat=${TCdat:=$TCbin}
 TCsrc=${TCsrc:=$TCbin}
 TCtmp=${TCtmp:=$TCbin/$TC$$}
 TCdump=${TCdump:=$TCbin}
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 # If CLEANUP is not set; set it to "ON"
 CLEANUP=${CLEANUP:="ON"}
@@ -187,8 +190,8 @@ $trace_logic
 		 rsh -n $RHOST "rm -rf $TESTDIR"
     fi

-    [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-    echo "Test Failed: $@"
+    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+    tst_resm TFAIL "Test Failed: $@"
     exit 1
 }

diff --git a/testcases/network/nfs/nfs02/nfs02 b/testcases/network/nfs/nfs02/nfs02
index c655678..ab0e3c7 100755
--- a/testcases/network/nfs/nfs02/nfs02
+++ b/testcases/network/nfs/nfs02/nfs02
@@ -46,6 +46,9 @@ TCbin=${TCbin:=`pwd`}
 TCdat=${TCdat:=$TCbin/datafiles}
 TCsrc=${TCsrc:=$TCbin}
 TCtmp=${TCtmp:=$TCbin/$TC$$}
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 PID=$$

@@ -221,8 +224,8 @@ $trace_logic
        do_cleanup
     fi

-    [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-    echo "Test Failed: $@"
+    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+    tst_resm TFAIL "Test Failed: $@"
     exit 1
 }

diff --git a/testcases/network/nfs/nfs03/nfs03 b/testcases/network/nfs/nfs03/nfs03
index 80a4cbd..445c6ae 100755
--- a/testcases/network/nfs/nfs03/nfs03
+++ b/testcases/network/nfs/nfs03/nfs03
@@ -49,6 +49,9 @@ TCsrc=${TCsrc:=$TCbin}
 TCtmp=${TCtmp:=$TCbin/$TC$$}
 TCdump=${TCdump:=$TCbin}
 RHOST=${RHOST:=`hostname | awk {'print $1'}`}
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 PID=$$

@@ -411,8 +414,8 @@ $trace_logic

     fi

-    [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-    echo "Test Failed: $@"
+    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+    tst_resm TFAIL "Test Failed: $@"
     exit 1
 }

diff --git a/testcases/network/nfs/nfslock01/nfslock01 b/testcases/network/nfs/nfslock01/nfslock01
index 1e40073..8485d85 100755
--- a/testcases/network/nfs/nfslock01/nfslock01
+++ b/testcases/network/nfs/nfslock01/nfslock01
@@ -42,6 +42,9 @@ TCbin=${TCbin:=`pwd`}
 TCtmp=${TCtmp:=$TCbin/$TC$$}
 TCsrc=${TCsrc:=$TCbin}
 TClog=${TClog:=$TCtmp}
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 mkdir $TCtmp >/dev/null 2>&1

@@ -129,8 +132,8 @@ end_testcase()
      do_cleanup
    fi

-   [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-   echo "Test Failed: $@"
+   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+   tst_resm TFAIL "Test Failed: $@"
    exit 1
 }

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
index 9d52a45..0b68f7d 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01
+++ b/testcases/network/nfs/nfsstat01/nfsstat01
@@ -49,6 +49,9 @@ CLEANUP=${CLEANUP:="ON"}
 VERSION=${VERSION:=2}
 TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
 NFS_TYPE=${NFS_TYPE:nfs}
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 if [ "x$NFS_TYPE" != "xnfs4" ]; then
     OPTS=${OPTS:="-o vers=$VERSION "}
@@ -236,8 +239,8 @@ $trace_logic
        do_cleanup
     fi

-    [ $? = 0 ] && { echo "Test PASS"; exit 0; }
-    echo "Test FAIL: $@"
+    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+    tst_resm TFAIL "Test Failed: $@"
     exit 1
 }

diff --git a/testcases/network/nfs/nfsstress/nfsstress b/testcases/network/nfs/nfsstress/nfsstress
index 7f0006b..0826e57 100755
--- a/testcases/network/nfs/nfsstress/nfsstress
+++ b/testcases/network/nfs/nfsstress/nfsstress
@@ -49,6 +49,9 @@ TCsrc=${TCsrc:=$TCbin}
 TCtmp=${TCtmp:=$TCbin/$TC$$}
 TCdump=${TCdump:=$TCbin}
 RHOST=${RHOST:=`hostname|awk {'print $1'}`}
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 # Setting the NFS to version 2 with UDP by default
 PID=$$
@@ -192,8 +195,8 @@ $trace_logic
 		 rsh -n $RHOST "rm -rf $TESTDIR"
     fi

-    [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-    echo "Test Failed: $@"
+    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+    tst_resm TFAIL "Test Failed: $@"
     exit 1
 }

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01 b/testcases/network/rpc/basic_tests/rpc01/rpc01
index ef97a95..fd236b1 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01
@@ -43,6 +43,9 @@ NUMLOOPS=${NUMLOOPS:=3}
 RHOST=${RHOST:=`hostname`}
 CLEANUP=${CLEANUP:="ON"}
 DATAFILES=${DATAFILES:="file.1 file.2"}
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 #=============================================================================
 # FUNCTION NAME:        do_test
@@ -115,8 +118,8 @@ end_testcase()
    $trace_logic
    echo "$this_file: doing $0."

-   [ $# = 0 ] && { echo "Test Successful"; exit 0; }
-   echo "Test Failed: $@"
+   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+   tst_resm TFAIL "Test Failed: $@"
    exit 1
 }

diff --git a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01 b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
index 11bdaca..7f8104f 100755
--- a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
+++ b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
@@ -65,6 +65,9 @@ LUSER=${LUSER:=root}
 RHOST=${RHOST:=`hostname`}
 CLEANUP=${CLEANUP:="ON"}
 PID=0
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 #=============================================================================
 # FUNCTION NAME:        do_test
@@ -273,8 +276,8 @@ end_testcase()
      do_cleanup
    fi

-   [ $# = 0 ] && { echo "Test Successfull"; exit 0; }
-   echo "Test Failed: $@"
+   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+   tst_resm TFAIL "Test Failed: $@"
    exit 1
 }

diff --git a/testcases/network/rpc/basic_tests/rup/rup01 b/testcases/network/rpc/basic_tests/rup/rup01
index 229a03f..5845528 100755
--- a/testcases/network/rpc/basic_tests/rup/rup01
+++ b/testcases/network/rpc/basic_tests/rup/rup01
@@ -54,6 +54,9 @@ LUSER=${LUSER:=root}
 RHOST=${RHOST:=`hostname`}
 CLEANUP=${CLEANUP:="ON"}
 PID=0
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 #=============================================================================
 # FUNCTION NAME:        do_test
@@ -158,8 +161,8 @@ end_testcase()
      do_cleanup
    fi

-   [ $# = 0 ] && { echo "Test Successfull"; exit 0; }
-   echo "Test Failed: $@"
+   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+   tst_resm TFAIL "Test Failed: $@"
    exit 1
 }

diff --git a/testcases/network/rpc/basic_tests/rusers/rusers01 b/testcases/network/rpc/basic_tests/rusers/rusers01
index 13c884a..0b28c9e 100755
--- a/testcases/network/rpc/basic_tests/rusers/rusers01
+++ b/testcases/network/rpc/basic_tests/rusers/rusers01
@@ -55,6 +55,9 @@ LUSER=${LUSER:=root}
 RHOST=${RHOST:=`hostname`}
 CLEANUP=${CLEANUP:="ON"}
 PID=0
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1

 #=============================================================================
 # FUNCTION NAME:        do_test
@@ -152,8 +155,8 @@ end_testcase()
      do_cleanup
    fi

-   [ $# = 0 ] && { echo "Test Successfull"; exit 0; }
-   echo "Test Failed: $@"
+   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+   tst_resm TFAIL "Test Failed: $@"
    exit 1
 }

--
1.7.9.5


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
