From: Yi Zhao <yi.zhao@windriver.com>
Date: Mon, 22 Jul 2019 16:57:24 +0800
Subject: [LTP] [PATCH] *.sh: convert hardcoded python2 to python3
Message-ID: <1563785844-28983-1-git-send-email-yi.zhao@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We had converted python2 to python3 for all *.py in commit
5a8408bc32f0eada5cbf65ac63d5cd2410f95249. But there are still hardcoded
python2 in some scripts. Convert these python2 to python3.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 testcases/kernel/power_management/runpwtests05.sh          |  2 +-
 .../kernel/power_management/runpwtests_exclusive01.sh      |  2 +-
 .../kernel/power_management/runpwtests_exclusive02.sh      |  2 +-
 .../kernel/power_management/runpwtests_exclusive03.sh      |  2 +-
 .../kernel/power_management/runpwtests_exclusive04.sh      |  2 +-
 .../kernel/power_management/runpwtests_exclusive05.sh      |  2 +-
 testcases/network/nfsv4/acl/runtest                        | 14 +++++++-------
 testcases/realtime/func/pi-tests/run_auto.sh               |  6 +++---
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
index 8a7d0f6..43e234d 100755
--- a/testcases/kernel/power_management/runpwtests05.sh
+++ b/testcases/kernel/power_management/runpwtests05.sh
@@ -35,7 +35,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python
+tst_test_cmds python3
 
 if ! grep sched_debug -qw /proc/cmdline ; then
 	tst_brkm TCONF "Kernel cmdline parameter 'sched_debug' needed," \
diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
index ec78319..9fefcbf 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive01.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive01.sh
@@ -35,7 +35,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python
+tst_test_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
index e107fce..2cd0ecb 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive02.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive02.sh
@@ -33,7 +33,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python
+tst_test_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
index 490344b..ab3a5d1 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive03.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive03.sh
@@ -35,7 +35,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python
+tst_test_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
index 978ca02..438ef60 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive04.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive04.sh
@@ -27,7 +27,7 @@ export TST_TOTAL=2
 # Checking test environment
 check_kervel_arch
 
-tst_test_cmds python
+tst_test_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
index a0dad58..3a9afdb 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive05.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive05.sh
@@ -35,7 +35,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python
+tst_test_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/network/nfsv4/acl/runtest b/testcases/network/nfsv4/acl/runtest
index d2e1b4c..a859e85 100755
--- a/testcases/network/nfsv4/acl/runtest
+++ b/testcases/network/nfsv4/acl/runtest
@@ -22,7 +22,7 @@ do
 done
 
 #  creation of users on the remote machine (removed only at the end of the tests)
-rsh -n $REMOTEHOST python $PWD/create_users.py -u 50 -g 50
+rsh -n $REMOTEHOST python3 $PWD/create_users.py -u 50 -g 50
 
 echo "Starting ACL testing"
 
@@ -51,19 +51,19 @@ echo "Basic tests finished"
 
 echo "LONG ACL TEST"
 echo "creating necessary users and groups"
-python create_users.py -u 50 -g 50
+python3 create_users.py -u 50 -g 50
 echo "creating necessary users and groups on the remote host"
 mkdir $NFSMNTDIR/lacl-testdir
-python test_long_acl.py -l $MAXLENGTH -p $NFSMNTDIR/lacl-testdir
+python3 test_long_acl.py -l $MAXLENGTH -p $NFSMNTDIR/lacl-testdir
 rm -rf $NFSMNTDIR/lacl-testdir
 echo "Long ACL test OK with $MAXLENGTH entries"
 echo "ACL STRESSING TEST"
-python setacl_stress.py -n 100 -u $USER_NB -g $GRP_NB -f $FILE_NB -p $NFSMNTDIR
+python3 setacl_stress.py -n 100 -u $USER_NB -g $GRP_NB -f $FILE_NB -p $NFSMNTDIR
 
 # remove local an remote users
-python cleanusers.py
-python cleangroups.py
-rsh -n $REMOTEHOST python $PWD/cleanusers.py
+python3 cleanusers.py
+python3 cleangroups.py
+rsh -n $REMOTEHOST python3 $PWD/cleanusers.py
 
 echo "Test OK"
 
diff --git a/testcases/realtime/func/pi-tests/run_auto.sh b/testcases/realtime/func/pi-tests/run_auto.sh
index d130260..2779885 100755
--- a/testcases/realtime/func/pi-tests/run_auto.sh
+++ b/testcases/realtime/func/pi-tests/run_auto.sh
@@ -15,15 +15,15 @@ $SCRIPTS_DIR/run_c_files.sh $profile testpi-0
 
 export LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-1.log"
 $SCRIPTS_DIR/run_c_files.sh $profile testpi-1
-PYTHONPATH=../../  python parse-testpi1.py $LOG_FILE 2>&1 | tee -a $LOG_FILE
+PYTHONPATH=../../  python3 parse-testpi1.py $LOG_FILE 2>&1 | tee -a $LOG_FILE
 
 export LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-2.log"
 $SCRIPTS_DIR/run_c_files.sh $profile testpi-2
-PYTHONPATH=../../  python parse-testpi2.py $LOG_FILE 2>&1 | tee -a $LOG_FILE
+PYTHONPATH=../../  python3 parse-testpi2.py $LOG_FILE 2>&1 | tee -a $LOG_FILE
 
 export LOG_FILE="$LOG_DIR/$LOG_FORMAT-testpi-4.log"
 $SCRIPTS_DIR/run_c_files.sh $profile testpi-4
-PYTHONPATH=../../  python parse-testpi1.py $LOG_FILE 2>&1 | tee -a $LOG_FILE
+PYTHONPATH=../../  python3 parse-testpi1.py $LOG_FILE 2>&1 | tee -a $LOG_FILE
 
 
 export LOG_FILE=""
-- 
2.7.4

