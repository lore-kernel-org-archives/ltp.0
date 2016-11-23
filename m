From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Nov 2016 11:37:02 +0800
Subject: [LTP] [PATCH 3/3] ltp/numa: Rewrite && convert to new library
Message-ID: <1479872222-30020-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/numa01.sh | 1306 +++++++++++++++++----------------------
 1 file changed, 557 insertions(+), 749 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 60dbae5..220c35a 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -1,76 +1,52 @@
 #!/bin/bash
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2007                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-#
-# Author:        Sivakumar Chinnaiah, Sivakumar.C@in.ibm.com
-#
-# History:       July 04 2007 - Created - Sivakumar Chinnaiah.
-#
-# File :         numa01.sh
-#
-# Description:  Test Basic functionality of numactl command.
-#		Test #1: Verifies cpunodebind and membind
-#		Test #2: Verifies preferred node bind for memory allocation
-#		Test #3: Verifies memory interleave on all nodes
-#		Test #4: Verifies physcpubind
-#		Test #5: Verifies localalloc
-#		Test #6: Verifies memory policies on shared memory
-#		Test #7: Verifies numademo
-#		Test #8: Verifies memhog
-#		Test #9: Verifies numa_node_size api
-#		Test #10:Verifies Migratepages
-#		- it uses numastat output which is expected to be in the format
-#                           node0           node1
-#numa_hit                 4280408         4605341
-#numa_miss                      0               0
-#numa_foreign                   0               0
-#interleave_hit             12445           13006
-#local_node               4277766         4566799
-#other_node                  2642           38542
-
-
-
-# Function:     chk_ifexists
-#
-# Description:  - Check if command required for this test exits.
-#
-# Input:        - $1 - calling test case.
-#               - $2 - command that needs to be checked.
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-chk_ifexists()
-{
-    RC=0
-
-    which $2 &>$LTPTMP/tst_numa.err || RC=$?
-    if [ $RC -ne 0 ]
-    then
-        tst_brkm TBROK NULL "$1: command $2 not found."
-    fi
-    return $RC
-}
+##############################################################################
+#                                                                            #
+# Copyright (c) International Business Machines  Corp., 2007                 #
+#               Sivakumar Chinnaiah, Sivakumar.C@in.ibm.com                  #
+# Copyright (c) Linux Test Project, 2016                                     #
+#                                                                            #
+# This program is free software: you can redistribute it and/or modify       #
+# it under the terms of the GNU General Public License as published by       #
+# the Free Software Foundation, either version 3 of the License, or          #
+# (at your option) any later version.                                        #
+#                                                                            #
+# This program is distributed in the hope that it will be useful,            #
+# but WITHOUT ANY WARRANTY; without even the implied warranty of             #
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              #
+# GNU General Public License for more details.                               #
+#                                                                            #
+# You should have received a copy of the GNU General Public License          #
+# along with this program. If not, see <http://www.gnu.org/licenses/>.       #
+#                                                                            #
+##############################################################################
+#                                                                            #
+# Description:  Test Basic functionality of numactl command.                 #
+#               Test #1: Verifies cpunodebind and membind                    #
+#               Test #2: Verifies preferred node bind for memory allocation  #
+#               Test #3: Verifies memory interleave on all nodes             #
+#               Test #4: Verifies physcpubind                                #
+#               Test #5: Verifies localalloc                                 #
+#               Test #6: Verifies memory policies on shared memory           #
+#               Test #7: Verifies numademo                                   #
+#               Test #8: Verifies memhog                                     #
+#               Test #9: Verifies numa_node_size api                         #
+#               Test #10:Verifies Migratepages                               #
+#                                                                            #
+##############################################################################
+
+TST_ID="numa01"
+TST_CNT=10
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_TESTFUNC=test
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_ROOT=1
+
+. tst_test.sh
 
 # Function:     extract_numastat
 #
-# Description:  - extract the value of given row,column from the numastat output .
+# Description:  - extract the value of given row, column from the numastat output.
 #
 # Input:        - $1 - row number.
 #               - $2 - column number.
@@ -79,29 +55,29 @@ chk_ifexists()
 #               - non-zero on failure.
 extract_numastat()
 {
-    RC=0
-
-    # check whether numastat output is changed
-
-    RC=$(awk '
-        { if ( NR == '$2' ){
-            print $1;
-            }
-        }
-        ' $LTPTMP/numalog)
-    if [ $RC != $1 ]
-    then
-	tst_brkm TBROK NULL "numastat o/p seems to be changed, $1 expected to be in the row $2"
-        return 1
-    fi
-
-    RC=$(awk '
-        { if ( NR == '$2' ){
-            print $'$3';
-            }
-        }
-        ' $LTPTMP/numalog)
-    return 0
+	RC=0
+
+	# check whether numastat output is changed
+
+	RC=$(awk '
+	{ if ( NR == '$2' ){
+		print $1;
+		}
+	}
+	' $LTPTMP/numalog)
+	if [ $RC != $1 ]
+	then
+		tst_brk TBROK "numastat o/p seems to be changed, $1 expected to be in the row $2"
+		return 1
+	fi
+
+	RC=$(awk '
+	{ if ( NR == '$2' ){
+		print $'$3';
+		}
+	}
+	' $LTPTMP/numalog)
+	return 0
 }
 
 # Function:     wait_for_update
@@ -110,28 +86,27 @@ extract_numastat()
 #               - $2 - numastat content.
 #
 # Description:  - waiting for numastat update
-#
 wait_for_update()
 {
-    NUMASTAT_PATH="/sys/devices/system/node/node$1/numastat"
-    local loop=0
+	NUMASTAT_PATH="/sys/devices/system/node/node$1/numastat"
+	local loop=0
 
-    while [ $loop -lt 5 ]; do
-        sum_value=0
+	while [ $loop -lt 5 ]; do
+		sum_value=0
 
-        for i in $(seq 200); do
-            det_value=$(grep $2 ${NUMASTAT_PATH} | cut -d ' ' -f 2)
-            sum_value=$((sum_value + det_value))
+		for i in $(seq 200); do
+			det_value=$(grep $2 ${NUMASTAT_PATH} | cut -d ' ' -f 2)
+			sum_value=$((sum_value + det_value))
 
-            sync && tst_sleep 10ms
-        done
+			sync && tst_sleep 10ms
+		done
 
-        if [ $((sum_value/200)) -eq $det_value ]; then
-            return
-        fi
+		if [ $((sum_value/200)) -eq $det_value ]; then
+			return
+		fi
 
-        loop=$((loop+1))
-    done
+		loop=$((loop+1))
+	done
 }
 
 # Function:     comparelog
@@ -145,564 +120,468 @@ wait_for_update()
 # Return:       - difference of arguments on success.
 comparelog()
 {
-
-    if [ $2 -gt $1 ]
-    then
-        RC=$[$2-$1]
-    else
-        RC=0
-    fi
-    return 0
+	if [ $2 -gt $1 ]; then
+		RC=$[$2-$1]
+	else
+		RC=0
+	fi
+	return 0
 }
 
-
-
-# Function: init
+# Function: setup
 #
 # Description:  - Check if command required for this test exits.
 #               - Initialize global variables.
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-init()
+setup()
 {
-    # Initialize global variables.
-    export RC=0
-    export TST_TOTAL=6
-    export TCID="Initnuma"
-    export TST_COUNT=0
-
-    # Page Size
-    page_size=0
-
-    # row definitions, pls see at the top of this file
-    numa_hit=2
-    numa_miss=3
-    numa_foreign=4
-    interleave_hit=5
-    local_node=6
-    other_node=7
-
-    #arguments to memory exercise program support_numa.c
-    PRT_PG_SIZE=1
-    ALLOC_1MB=2
-    PAUSE=3
-
-    # Inititalize cleanup function.
-    trap "cleanup" 0
-
-    # create the temporary directory used by this testcase
-    if [ -z $TMP ]
-    then
-        LTPTMP=/tmp/tst_numa.$$
-    else
-        LTPTMP=$TMP/tst_numa.$$
-    fi
-
-    mkdir -p $LTPTMP &>/dev/null || RC=$?
-    if [ $RC -ne 0 ]
-    then
-         tst_brkm TBROK NULL "INIT: Unable to create temporary directory"
-         return $RC
-    fi
-
-    # check if commands tst_*, numa*, awk exists.
-    chk_ifexists INIT tst_resm   || return $RC
-    chk_ifexists INIT numactl    || return $RC
-    chk_ifexists INIT numastat   || return $RC
-    chk_ifexists INIT awk        || return $RC
-    chk_ifexists INIT cat        || return $RC
-    chk_ifexists INIT kill       || return $RC
-
-    RC=0
-    #Set pagesize
-    support_numa $PRT_PG_SIZE > $LTPTMP/numaarg || RC=$?
-    if [ $RC -ne 0 ]
-    then
-        tst_resm TFAIL "INIT: memory exerciser program support_numa exits abnormally"
-    fi
-    page_size=$(cat $LTPTMP/numaarg)
-
-    tst_resm TINFO "INIT: Numa tests will start now !!"
-}
+	export RC=0
+
+	# Page Size
+	page_size=0
+
+	# row definitions, pls see at the top of this file
+	numa_hit=2
+	numa_miss=3
+	numa_foreign=4
+	interleave_hit=5
+	local_node=6
+	other_node=7
+
+	# arguments to memory exercise program support_numa.c
+	PRT_PG_SIZE=1
+	ALLOC_1MB=2
+	PAUSE=3
+
+	# create the temporary directory used by this testcase
+	if [ -z $TMP ]; then
+		LTPTMP=/tmp/tst_numa.$$
+	else
+		LTPTMP=$TMP/tst_numa.$$
+	fi
 
+	mkdir -p $LTPTMP &>/dev/null || RC=$?
+	if [ $RC -ne 0 ]; then
+		tst_brk TBROK "INIT: Unable to create temporary directory"
+	fi
 
+	# check if commands numa*, awk exists.
+	tst_check_cmds numactl
+	tst_check_cmds numastat
+	tst_check_cmds awk
 
-# Function:     cleanup
-#
-# Description:  - remove temporaty files and directories.
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-cleanup()
-{
-    TCID=exitnuma
-    RC=0
+	RC=0
+	#Set pagesize
+	support_numa $PRT_PG_SIZE > $LTPTMP/numaarg || RC=$?
+	if [ $RC -ne 0 ]; then
+		tst_res TFAIL "INIT: memory exerciser program support_numa exits abnormally"
+	fi
+	page_size=$(cat $LTPTMP/numaarg)
+
+	total_nodes=0       # total no. of numa nodes
+	# all availiable nodes id list
+	nodes_list=`numactl --show | grep nodebind | cut -d ':' -f 2`
+	for node in `echo $nodes_list`; do
+		total_nodes=$[$total_nodes+1]
+	done
+	tst_res TINFO "The system contains $total_nodes nodes: $nodes_list"
+	if [ $total_nodes -le 1 ]; then
+		tst_brk TCONF "your machine does not support numa policy
+		or your machine is not a NUMA machine"
+	fi
 
-    # remove all the temporary files created by this test.
-    tst_resm TINFO "CLEAN: removing $LTPTMP"
-    rm -fr $LTPTMP || RC=$?
-    return $RC
+	tst_res TINFO "INIT: Numa tests will start now !!"
 }
 
+cleanup()
+{
+	# remove all the temporary files created by this test.
+	tst_res TINFO "CLEAN: removing $LTPTMP"
+	rm -fr $LTPTMP
+}
 
-
-# Function:     test01
+# Function:     test1
 #
 # Description:  - Verification of local node and memory affinity
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-test01()
+test1()
 {
-    TCID=numa01
-    TST_COUNT=1
-
-    RC=0                # Return value from commands.
-    Prev_value=0        # extracted from the numastat o/p
-    Curr_value=0	# Current value extracted from numastat o/p
-    Exp_incr=0          # 1 MB/ PAGESIZE
-    col=0
-    MB=$[1024*1024]
-
-    # Increase in numastat o/p is interms of pages
-    Exp_incr=$[$MB/$page_size]
-
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]		#Node number in numastat o/p
-        numastat > $LTPTMP/numalog
-        extract_numastat local_node $local_node $col || return 1
-        Prev_value=$RC
-        numactl --cpunodebind=$node --membind=$node support_numa $ALLOC_1MB
-        numastat > $LTPTMP/numalog
-        extract_numastat local_node $local_node $col || return 1
-        Curr_value=$RC
-        comparelog $Prev_value $Curr_value
-        if [ $RC -lt $Exp_incr ]
-        then
-             tst_resm TFAIL \
-                 "Test #1: NUMA hit and localnode increase in node$node is less than expected"
-            return 1
-        fi
-        COUNTER=$[$COUNTER+1]
-    done
-    tst_resm TPASS "NUMA local node and memory affinity -TEST01 PASSED !!"
-    return 0
+	RC=0                # Return value from commands.
+	Prev_value=0        # extracted from the numastat o/p
+	Curr_value=0	# Current value extracted from numastat o/p
+	Exp_incr=0          # 1 MB/ PAGESIZE
+	col=0
+	MB=$((1024*1024))
+
+	# Increase in numastat o/p is interms of pages
+	Exp_incr=$((MB/page_size))
+
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))		#Node number in numastat o/p
+		numastat > $LTPTMP/numalog
+		extract_numastat local_node $local_node $col || return 1
+		Prev_value=$RC
+		numactl --cpunodebind=$node --membind=$node support_numa $ALLOC_1MB
+		numastat > $LTPTMP/numalog
+		extract_numastat local_node $local_node $col || return 1
+		Curr_value=$RC
+		comparelog $Prev_value $Curr_value
+		if [ $RC -lt $Exp_incr ]; then
+			tst_res TFAIL \
+				"NUMA hit and localnode increase in node$node is less than expected"
+			return 1
+		fi
+		COUNTER=$[$COUNTER+1]
+	done
+
+	tst_res TPASS "NUMA local node and memory affinity -TEST01 PASSED !!"
 }
 
-
-
-# Function:     test02
+# Function:     test2
 #
 # Description:  - Verification of memory allocated from preferred node
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-test02()
+test2()
 {
-    TCID=numa02
-    TST_COUNT=2
-
-    RC=0                # Return value from commands.
-    Prev_value=0        # extracted from the numastat o/p
-    Curr_value=0        # Current value extracted from numastat o/p
-    Exp_incr=0          # 1 MB/ PAGESIZE
-    col=0
-    MB=$[1024*1024]
-
-    # Increase in numastat o/p is interms of pages
-    Exp_incr=$[$MB/$page_size]
-
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-
-	if [ $total_nodes -eq 1 ]
-        then
-            tst_brkm TBROK NULL "Preferred policy cant be applied for a single node machine"
-	    return 1
-	fi
-
-        if [ $COUNTER -eq $total_nodes ]   #wrap up for last node
- 	then
-	    Preferred_node=`echo $nodes_list | cut -d ' ' -f 1`
-	    col=2			#column represents node0 in numastat o/p
-	else
-	    # always next node is preferred node
-	    Preferred_node=`echo $nodes_list | cut -d ' ' -f $[COUNTER+1]`
-	    col=$[$COUNTER+2]              #Preferred Node number in numastat o/p
-	fi
-
-        numastat > $LTPTMP/numalog
-        extract_numastat other_node $other_node $col || return 1
-        Prev_value=$RC
-        numactl --cpunodebind=$node --preferred=$Preferred_node support_numa $ALLOC_1MB
-
-        # In RHEL collection of statistics takes more time
-        wait_for_update $Preferred_node other_node
-
-        numastat > $LTPTMP/numalog
-        extract_numastat other_node $other_node $col || return 1
-        Curr_value=$RC
-        comparelog $Prev_value $Curr_value
-        if [ $RC -lt $Exp_incr ]
-        then
-             tst_resm TFAIL \
-                 "Test #2: NUMA hit and othernode increase in node$node is less than expected"
-            return 1
-        fi
-        COUNTER=$[$COUNTER+1]
-    done
-    tst_resm TPASS "NUMA preferred node policy -TEST02 PASSED !!"
-    return 0
+	RC=0                # Return value from commands.
+	Prev_value=0        # extracted from the numastat o/p
+	Curr_value=0        # Current value extracted from numastat o/p
+	Exp_incr=0          # 1 MB/ PAGESIZE
+	col=0
+	MB=$((1024*1024))
+
+	# Increase in numastat o/p is interms of pages
+	Exp_incr=$((MB/page_size))
+
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+
+		if [ $total_nodes -eq 1 ]; then
+			tst_brk TBROK \
+				"Preferred policy cant be applied for a single node machine"
+		fi
+
+		if [ $COUNTER -eq $total_nodes ]   #wrap up for last node
+		then
+			Preferred_node=`echo $nodes_list | cut -d ' ' -f 1`
+			col=2			   #column represents node0 in numastat o/p
+		else
+			# always next node is preferred node
+			Preferred_node=`echo $nodes_list | cut -d ' ' -f $((COUNTER+1))`
+			col=$((COUNTER+2))         #Preferred Node number in numastat o/p
+		fi
+
+		numastat > $LTPTMP/numalog
+		extract_numastat other_node $other_node $col || return 1
+		Prev_value=$RC
+		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa $ALLOC_1MB
+
+		# In RHEL collection of statistics takes more time
+		wait_for_update $Preferred_node other_node
+
+		numastat > $LTPTMP/numalog
+		extract_numastat other_node $other_node $col || return 1
+		Curr_value=$RC
+		comparelog $Prev_value $Curr_value
+		if [ $RC -lt $Exp_incr ]; then
+			tst_res TFAIL \
+				"NUMA hit and othernode increase in node$node is less than expected"
+			return 1
+		fi
+		COUNTER=$((COUNTER+1))
+	done
+
+	tst_res TPASS "NUMA preferred node policy -TEST02 PASSED !!"
 }
 
-
-# Function:     test03
+# Function:     test3
 #
 # Description:  - Verification of memory interleaved on all nodes
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-test03()
+test3()
 {
-    TCID=numa03
-    TST_COUNT=3
-
-    RC=0                # Return value from commands.
-    Prev_value=0        # extracted from the numastat o/p
-    declare -a parray   # array contains previous value of all nodes
-    Curr_value=0        # Current value extracted from numastat o/p
-    Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-    col=0
-    MB=$[1024*1024]
-
-    # Increase in numastat o/p is interms of pages
-    Exp_incr=$[$MB/$page_size]
-    # Pages will be allocated using round robin on nodes.
-    Exp_incr=$[$Exp_incr/$total_nodes]
-
-    # Check whether the pages are equally distributed among available nodes
-    numastat > $LTPTMP/numalog
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]              #Node number in numastat o/p
-        extract_numastat interleave_hit $interleave_hit $col || return 1
-        Prev_value=$RC
-        parray[$COUNTER]=$Prev_value
-        COUNTER=$[$COUNTER+1]
-    done
-
-    numactl --interleave=all support_numa $ALLOC_1MB
-
-    for node in `echo $nodes_list`; do
-        wait_for_update $node interleave_hit
-    done
-
-    numastat > $LTPTMP/numalog
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]              #Node number in numastat o/p
-        extract_numastat interleave_hit $interleave_hit $col || return 1
-        Curr_value=$RC
-        comparelog ${parray[$COUNTER]} $Curr_value
-        if [ $RC -lt $Exp_incr ]
-        then
-             tst_resm TFAIL \
-                 "Test #3: NUMA interleave hit in node$node is less than expected"
-            return 1
-        fi
-        COUNTER=$[$COUNTER+1]
-    done
-    tst_resm TPASS "NUMA interleave policy -TEST03 PASSED !!"
-    return 0
+	RC=0                # Return value from commands.
+	Prev_value=0        # extracted from the numastat o/p
+	declare -a parray   # array contains previous value of all nodes
+	Curr_value=0        # Current value extracted from numastat o/p
+	Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
+	col=0
+	MB=$((1024*1024))
+
+	# Increase in numastat o/p is interms of pages
+	Exp_incr=$((MB/page_size))
+	# Pages will be allocated using round robin on nodes.
+	Exp_incr=$((Exp_incr/total_nodes))
+
+	# Check whether the pages are equally distributed among available nodes
+	numastat > $LTPTMP/numalog
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))              #Node number in numastat o/p
+		extract_numastat interleave_hit $interleave_hit $col || return 1
+		Prev_value=$RC
+		parray[$COUNTER]=$Prev_value
+		COUNTER=$((COUNTER+1))
+	done
+
+	numactl --interleave=all support_numa $ALLOC_1MB
+
+	for node in `echo $nodes_list`; do
+		wait_for_update $node interleave_hit
+	done
+
+	numastat > $LTPTMP/numalog
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))             #Node number in numastat o/p
+		extract_numastat interleave_hit $interleave_hit $col || return 1
+		Curr_value=$RC
+		comparelog ${parray[$COUNTER]} $Curr_value
+		if [ $RC -lt $Exp_incr ]; then
+			tst_res TFAIL \
+				"NUMA interleave hit in node$node is less than expected"
+			return 1
+		fi
+		COUNTER=$((COUNTER+1))
+	done
+
+	tst_res TPASS "NUMA interleave policy -TEST03 PASSED !!"
 }
 
-
-
-# Function:     test04
+# Function:     test4
 #
 # Description:  - Verification of physical cpu bind
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-test04()
+test4()
 {
+	no_of_cpus=0	#no. of cpu's exist
+	run_on_cpu=0
+	running_on_cpu=0
+
+	no_of_cpus=$(tst_ncpus)
+	# not sure whether cpu's can't be in odd number
+	run_on_cpu=$(($((no_of_cpus+1))/2))
+	numactl --physcpubind=$run_on_cpu support_numa $PAUSE & #just waits for sigint
+	pid=$!
+	var=`awk '{ print $2 }' /proc/$pid/stat`
+	while [ $var = '(numactl)' ]; do
+		var=`awk '{ print $2 }' /proc/$pid/stat`
+	done
+	# Warning !! 39 represents cpu number, on which process pid is currently running and
+	# this may change if Some more fields are added in the middle, may be in future
+	running_on_cpu=$(awk '{ print $39; }' /proc/$pid/stat)
+	if [ $running_on_cpu -ne $run_on_cpu ]; then
+		tst_res TFAIL \
+			"Process running on cpu$running_on_cpu but expected to run on cpu$run_on_cpu"
+		return 1
+	fi
+	RC=0
+	kill -9 $pid || RC=$?
+	if [ $RC -ne 0 ]; then
+		tst_brk TBROK "Kill on process $pid fails"
+	fi
 
-    TCID=numa04
-    TST_COUNT=4
-
-    no_of_cpus=0	#no. of cpu's exist
-    run_on_cpu=0
-    running_on_cpu=0
-
-    no_of_cpus=$(tst_ncpus)
-    # not sure whether cpu's can't be in odd number
-    run_on_cpu=$[$[$no_of_cpus+1]/2]
-    numactl --physcpubind=$run_on_cpu support_numa $PAUSE & #just waits for sigint
-    pid=$!
-    var=`awk '{ print $2 }' /proc/$pid/stat`
-    while [ $var = '(numactl)' ]; do
-        var=`awk '{ print $2 }' /proc/$pid/stat`
-    done
-    # Warning !! 39 represents cpu number, on which process pid is currently running and
-    # this may change if Some more fields are added in the middle, may be in future
-    running_on_cpu=$(awk '{ print $39; }' /proc/$pid/stat)
-    if [ $running_on_cpu -ne $run_on_cpu ]
-    then
-	 tst_resm TFAIL \
-	     "Test #4: Process running on cpu$running_on_cpu but expected to run on cpu$run_on_cpu"
-	 return 1
-    fi
-    RC=0
-    kill -INT $pid || RC=$?
-    if [ $RC -ne 0 ]
-    then
-        tst_brkm TBROK NULL "Kill on process $pid fails"
-    fi
-    tst_resm TPASS "NUMA phycpubind policy -TEST04 PASSED !!"
-    return 0
+	tst_res TPASS "NUMA phycpubind policy -TEST04 PASSED !!"
 }
 
-
-
-# Function:     test05
+# Function:     test5
 #
 # Description:  - Verification of local node allocation
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-test05()
+test5()
 {
-    TCID=numa05
-    TST_COUNT=5
-
-    RC=0                # Return value from commands.
-    Prev_value=0        # extracted from the numastat o/p
-    Curr_value=0        # Current value extracted from numastat o/p
-    Exp_incr=0          # 1 MB/ PAGESIZE
-    col=0
-    MB=$[1024*1024]
-
-    # Increase in numastat o/p is interms of pages
-    Exp_incr=$[$MB/$page_size]
-
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]               #Node number in numastat o/p
-        numastat > $LTPTMP/numalog
-        extract_numastat local_node $local_node $col || return 1
-        Prev_value=$RC
-        numactl --cpunodebind=$node --localalloc support_numa $ALLOC_1MB
-        numastat > $LTPTMP/numalog
-        extract_numastat local_node $local_node $col || return 1
-        Curr_value=$RC
-        comparelog $Prev_value $Curr_value
-        if [ $RC -lt $Exp_incr ]
-        then
-             tst_resm TFAIL \
-                 "Test #5: NUMA hit and localnode increase in node$node is less than expected"
-            return 1
-        fi
-        COUNTER=$[$COUNTER+1]
-    done
-    tst_resm TPASS "NUMA local node allocation -TEST05 PASSED !!"
-    return 0
+	RC=0                # Return value from commands.
+	Prev_value=0        # extracted from the numastat o/p
+	Curr_value=0        # Current value extracted from numastat o/p
+	Exp_incr=0          # 1 MB/ PAGESIZE
+	col=0
+	MB=$((1024*1024))
+
+	# Increase in numastat o/p is interms of pages
+	Exp_incr=$((MB/page_size))
+
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))               #Node number in numastat o/p
+		numastat > $LTPTMP/numalog
+		extract_numastat local_node $local_node $col || return 1
+		Prev_value=$RC
+		numactl --cpunodebind=$node --localalloc support_numa $ALLOC_1MB
+		numastat > $LTPTMP/numalog
+		extract_numastat local_node $local_node $col || return 1
+		Curr_value=$RC
+		comparelog $Prev_value $Curr_value
+		if [ $RC -lt $Exp_incr ]; then
+			tst_res TFAIL \
+				"NUMA hit and localnode increase in node$node is less than expected"
+			return 1
+		fi
+		COUNTER=$((COUNTER+1))
+	done
+
+	tst_res TPASS "NUMA local node allocation -TEST05 PASSED !!"
 }
 
-
-
-# Function:     test06
+# Function:     test6
 #
 # Description:  - Verification of shared memory interleaved on all nodes
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-test06()
+test6()
 {
-    TCID=numa06
-    TST_COUNT=6
-
-    RC=0                # Return value from commands.
-    Prev_value=0        # extracted from the numastat o/p
-    declare -a parray   # array contains previous value of all nodes
-    Curr_value=0        # Current value extracted from numastat o/p
-    Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-    col=0
-    MB=$[1024*1024]
-
-    # Increase in numastat o/p is interms of pages
-    Exp_incr=$[$MB/$page_size]
-    # Pages will be allocated using round robin on nodes.
-    Exp_incr=$[$Exp_incr/$total_nodes]
-
-    # Check whether the pages are equally distributed among available nodes
-    numastat > $LTPTMP/numalog
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]              #Node number in numastat o/p
-        extract_numastat numa_hit $numa_hit $col || return 1
-        Prev_value=$RC
-        parray[$COUNTER]=$Prev_value
-        COUNTER=$[$COUNTER+1]
-    done
-
-    numactl --length=1M --file /dev/shm/numa_shm --interleave=all --touch
-
-    for node in `echo $nodes_list`; do
-        wait_for_update $node numa_hit
-    done
-
-    numastat > $LTPTMP/numalog
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]              #Node number in numastat o/p
-        extract_numastat numa_hit $numa_hit $col || return 1
-        Curr_value=$RC
-        comparelog ${parray[$COUNTER]} $Curr_value
-        if [ $RC -lt $Exp_incr ]
-        then
-             tst_resm TFAIL \
-                 "Test #6: NUMA numa_hit for shm file numa_shm in node$node is less than expected"
-            return 1
-        fi
-        COUNTER=$[$COUNTER+1]
-    done
-    tst_resm TPASS "NUMA interleave policy on shared memory -TEST06 PASSED !!"
-    RC=0
-    rm -r /dev/shm/numa_shm || RC=$?
-    if [ $RC -ne 0 ]
-    then
-	tst_resm TINFO "Test #6: Failed removing shared memory file numa_shm"
-        return 1
-    fi
-    return 0
+	RC=0                # Return value from commands.
+	Prev_value=0        # extracted from the numastat o/p
+	declare -a parray   # array contains previous value of all nodes
+	Curr_value=0        # Current value extracted from numastat o/p
+	Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
+	col=0
+	MB=$((1024*1024))
+
+	# Increase in numastat o/p is interms of pages
+	Exp_incr=$((MB/page_size))
+	# Pages will be allocated using round robin on nodes.
+	Exp_incr=$((Exp_incr/total_nodes))
+
+	# Check whether the pages are equally distributed among available nodes
+	numastat > $LTPTMP/numalog
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))              #Node number in numastat o/p
+		extract_numastat numa_hit $numa_hit $col || return 1
+		Prev_value=$RC
+		parray[$COUNTER]=$Prev_value
+		COUNTER=$((COUNTER+1))
+	done
+
+	numactl --length=1M --file /dev/shm/numa_shm --interleave=all --touch
+
+	for node in `echo $nodes_list`; do
+		wait_for_update $node numa_hit
+	done
+
+	numastat > $LTPTMP/numalog
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))              #Node number in numastat o/p
+		extract_numastat numa_hit $numa_hit $col || return 1
+		Curr_value=$RC
+		comparelog ${parray[$COUNTER]} $Curr_value
+		if [ $RC -lt $Exp_incr ]; then
+			tst_res TFAIL \
+				"NUMA numa_hit for shm file numa_shm in node$node is less than expected"
+			return 1
+		fi
+		COUNTER=$((COUNTER+1))
+	done
+
+	tst_res TPASS "NUMA interleave policy on shared memory -TEST06 PASSED !!"
+	RC=0
+	rm -r /dev/shm/numa_shm || RC=$?
+	if [ $RC -ne 0 ]; then
+		tst_res TFAIL "Failed removing shared memory file numa_shm"
+	fi
 }
 
-# Function:     test07
+# Function:     test7
 #
 # Description:  - Verification of numademo
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-test07()
+test7()
 {
-    TCID=numa07
-    TST_COUNT=7
-
-    RC=0                # Return value from commands.
-    Prev_value=0        # extracted from the numastat o/p
-    declare -a parray   # array contains previous value of all nodes
-    Curr_value=0        # Current value extracted from numastat o/p
-    Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-    col=0
-    msize=1000
-    KB=1024
-    # Increase in numastat o/p is interms of pages
-     Exp_incr=$[($KB * $msize)/$page_size]
-    # Pages will be allocated using round robin on nodes.
-    Exp_incr=$[$Exp_incr/$total_nodes]
-
-    # Check whether the pages are equally distributed among available nodes
-    numastat > $LTPTMP/numalog
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]              #Node number in numastat o/p
-        extract_numastat interleave_hit $interleave_hit $col || return 1
-        Prev_value=$RC
-        parray[$COUNTER]=$Prev_value
-        COUNTER=$[$COUNTER+1]
-    done
-
-    numademo -c ${msize}k > $LTPTMP/demolog
-
-    for node in `echo $nodes_list`; do
-        wait_for_update $node interleave_hit
-    done
-
-    numastat > $LTPTMP/numalog
-    COUNTER=1
-    x=0
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]              #Node number in numastat o/p
-        extract_numastat interleave_hit $interleave_hit $col || return 1
-        Curr_value=$RC
-         comparelog ${parray[$COUNTER]} $Curr_value
-        counter=$[$counter+1]
-        if [ $RC -le $Exp_incr ]
-        then
-            x=1
-            break;
-        fi
-        COUNTER=$[$COUNTER+1]
-    done
-    if [ $x -eq 0 ]
-    then
-        tst_resm TPASS "NUMADEMO policies  -TEST07 PASSED !!"
-        return 0
-    else
-        tst_resm TFAIL "Test #7: NUMA interleave hit is less than expected"
-    return 1
-    fi
+	RC=0                # Return value from commands.
+	Prev_value=0        # extracted from the numastat o/p
+	declare -a parray   # array contains previous value of all nodes
+	Curr_value=0        # Current value extracted from numastat o/p
+	Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
+	col=0
+	msize=1000
+	KB=1024
+	# Increase in numastat o/p is interms of pages
+	Exp_incr=$(($((KB * msize))/page_size))
+	# Pages will be allocated using round robin on nodes.
+	Exp_incr=$((Exp_incr/total_nodes))
+
+	# Check whether the pages are equally distributed among available nodes
+	numastat > $LTPTMP/numalog
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))              #Node number in numastat o/p
+		extract_numastat interleave_hit $interleave_hit $col || return 1
+		Prev_value=$RC
+		parray[$COUNTER]=$Prev_value
+		COUNTER=$((COUNTER+1))
+	done
+
+	numademo -c ${msize}k > $LTPTMP/demolog
+
+	for node in `echo $nodes_list`; do
+		wait_for_update $node interleave_hit
+	done
+
+	numastat > $LTPTMP/numalog
+	COUNTER=1
+	x=0
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))              #Node number in numastat o/p
+		extract_numastat interleave_hit $interleave_hit $col || return 1
+		Curr_value=$RC
+		comparelog ${parray[$COUNTER]} $Curr_value
+		counter=$((counter+1))
+		if [ $RC -le $Exp_incr ]; then
+			x=1
+			break;
+		fi
+		COUNTER=$((COUNTER+1))
+	done
+	if [ $x -eq 0 ]; then
+		tst_res TPASS "NUMADEMO policies  -TEST07 PASSED !!"
+	else
+		tst_res TFAIL "NUMA interleave hit is less than expected"
+	fi
 }
 
-# Function:     test08
+# Function:     test8
 #
 # Description:  - Verification of memhog with interleave policy
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-test08()
+test8()
 {
-    TCID=numa08
-    TST_COUNT=8
-
-    RC=0                # Return value from commands.
-    Prev_value=0        # extracted from the numastat o/p
-    declare -a parray   # array contains previous value of all nodes
-    Curr_value=0        # Current value extracted from numastat o/p
-    Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
-    col=0
-    MB=$[1024*1024]
-
-    # Increase in numastat o/p is interms of pages
-    Exp_incr=$[$MB/$page_size]
-    # Pages will be allocated using round robin on nodes.
-    Exp_incr=$[$Exp_incr/$total_nodes]
-
-    # Check whether the pages are equally distributed among available nodes
-    numastat > $LTPTMP/numalog
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]              #Node number in numastat o/p
-        extract_numastat interleave_hit $interleave_hit $col || return 1
-        Prev_value=$RC
-        parray[$COUNTER]=$Prev_value
-        COUNTER=$[$COUNTER+1]
-    done
-    numactl --interleave=all memhog 1MB
-
-    for node in `echo $nodes_list`; do
-        wait_for_update $node interleave_hit
-    done
-
-    numastat > $LTPTMP/numalog
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-        col=$[$COUNTER+1]              #Node number in numastat o/p
-        extract_numastat interleave_hit $interleave_hit $col || return 1
-        Curr_value=$RC
-        comparelog ${parray[$COUNTER]} $Curr_value
-        if [ $RC -lt $Exp_incr ]
-        then
-             tst_resm TFAIL \
-                 "Test #8: NUMA interleave hit in node$node is less than expected"
-            return 1
-        fi
-        COUNTER=$[$COUNTER+1]
-    done
-    tst_resm TPASS "NUMA MEMHOG policy -TEST08 PASSED !!"
-    return 0
+	RC=0                # Return value from commands.
+	Prev_value=0        # extracted from the numastat o/p
+	declare -a parray   # array contains previous value of all nodes
+	Curr_value=0        # Current value extracted from numastat o/p
+	Exp_incr=0          # 1 MB/ (PAGESIZE*num_of_nodes)
+	col=0
+	MB=$((1024*1024))
+
+	# Increase in numastat o/p is interms of pages
+	Exp_incr=$((MB/$page_size))
+	# Pages will be allocated using round robin on nodes.
+	Exp_incr=$((Exp_incr/total_nodes))
+
+	# Check whether the pages are equally distributed among available nodes
+	numastat > $LTPTMP/numalog
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))              #Node number in numastat o/p
+		extract_numastat interleave_hit $interleave_hit $col || return 1
+		Prev_value=$RC
+		parray[$COUNTER]=$Prev_value
+		COUNTER=$((COUNTER+1))
+	done
+	numactl --interleave=all memhog 1MB
+
+	for node in `echo $nodes_list`; do
+		wait_for_update $node interleave_hit
+	done
+
+	numastat > $LTPTMP/numalog
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+		col=$((COUNTER+1))              #Node number in numastat o/p
+		extract_numastat interleave_hit $interleave_hit $col || return 1
+		Curr_value=$RC
+		comparelog ${parray[$COUNTER]} $Curr_value
+		if [ $RC -lt $Exp_incr ]; then
+			tst_res TFAIL \
+				"NUMA interleave hit in node$node is less than expected"
+			return 1
+		fi
+		COUNTER=$((COUNTER+1))
+	done
+
+	tst_res TPASS "NUMA MEMHOG policy -TEST08 PASSED !!"
 }
 
 # Function:     hardware cheking with numa_node_size api
@@ -721,150 +600,79 @@ test08()
 #                 0:  10  20
 #                 1:  20  10
 #
-# Return:       - zero on success.
-#               - non-zero on failure.
-#
-test09()
+test9()
 {
-    TCID=numa09
-    TST_COUNT=9
-
-    RC=0                # Return value from commands.
-    Prev_value=0        # extracted from the numastat o/p
-    Curr_value=0        # Current value extracted from numastat o/p
-    Exp_incr=0          # 1 MB/ PAGESIZE
-    col=0
-    MB=$[1024*1024]
-    # Increase in numastat o/p is interms of pages
-    Exp_incr=$[$MB/$page_size]
-
-    numactl --hardware > $LTPTMP/avail_nodes
-    RC=$(awk '{ if ( NR == 1 ) {print $1;} }' $LTPTMP/avail_nodes)
-    if [ $RC = "available:" ]
-    then
-
-        RC=$(awk '{ if ( NR == 1 ) {print $3;} }' $LTPTMP/avail_nodes)
-        if [ $RC = "nodes" ]
-        then
-           RC=$(awk '{ if ( NR == 1 ) {print $2;} }' $LTPTMP/avail_nodes)
-
-        tst_resm TPASS "NUMA policy on lib NUMA_NODE_SIZE API -TEST09 PASSED !!"
-        else
-                tst_resm TINFO "Test #9: Failed with numa policy"
-        fi
-    else
-        tst_resm TINFO "Test #9: Failed with numa policy"
-    fi
+	RC=0                # Return value from commands.
+	Prev_value=0        # extracted from the numastat o/p
+	Curr_value=0        # Current value extracted from numastat o/p
+	Exp_incr=0          # 1 MB/ PAGESIZE
+	col=0
+	MB=$((1024*1024))
+	# Increase in numastat o/p is interms of pages
+	Exp_incr=$((MB/$page_size))
+
+	numactl --hardware > $LTPTMP/avail_nodes
+	RC=$(awk '{ if ( NR == 1 ) {print $1;} }' $LTPTMP/avail_nodes)
+	if [ $RC = "available:" ]; then
+		RC=$(awk '{ if ( NR == 1 ) {print $3;} }' $LTPTMP/avail_nodes)
+		if [ $RC = "nodes" ]; then
+			RC=$(awk '{ if ( NR == 1 ) {print $2;} }' $LTPTMP/avail_nodes)
+			tst_res TPASS "NUMA policy on lib NUMA_NODE_SIZE API -TEST09 PASSED !!"
+		else
+			tst_res TFAIL "Failed with numa policy"
+		fi
+	else
+		tst_res TFAIL "Failed with numa policy"
+	fi
 }
+
 # Function:     test10
 #
 # Description:  - Verification of migratepages
 #
 # Return:       - zero on success.
 #               - non-zero on failure.
-test010()
+test10()
 {
-    TCID=numa10
-    TST_COUNT=10
-    RC=0
-    Prev_value=0
-    Curr_value=0
-
-    COUNTER=1
-    for node in `echo $nodes_list`; do
-
-        if [ $total_nodes -eq 1 ]
-        then
-            tst_brkm TBROK NULL "Preferred policy cant be applied for a single node machine"
-            return 1
-        fi
-
-        if [ $COUNTER -eq $total_nodes ]; then
-            Preferred_node=`echo $nodes_list | cut -d ' ' -f 1`
-            col=2
-        else
-            Preferred_node=`echo $nodes_list | cut -d ' ' -f $[$COUNTER+1]`
-            col=$[$COUNTER+2]
-        fi
-
-        numastat > $LTPTMP/numalog
-        extract_numastat other_node $other_node $col || return 1
-        Prev_value=$RC
-        numactl --preferred=$node support_numa $PAUSE &
-        pid=$!
-        migratepages $pid $node $Preferred_node
-        numastat > $LTPTMP/numalog
-        extract_numastat other_node $other_node $col || return 1
-        Curr_value=$RC
-        kill -INT $pid
-        if [ $RC -lt $Prev_value ]; then
-             tst_resm TFAIL \
-                 "Test #10: NUMA migratepages is not working fine"
-            return 1
-        fi
-        COUNTER=$[$COUNTER+1]
-    done
-    tst_resm TPASS "NUMA MIGRATEPAGES policy -TEST10 PASSED !!"
-    return 0
+	RC=0
+	Prev_value=0
+	Curr_value=0
+
+	COUNTER=1
+	for node in `echo $nodes_list`; do
+
+		if [ $total_nodes -eq 1 ]; then
+			tst_brk TBROK \
+				"Preferred policy cant be applied for a single node machine"
+		fi
+
+		if [ $COUNTER -eq $total_nodes ]; then
+			Preferred_node=`echo $nodes_list | cut -d ' ' -f 1`
+			col=2
+		else
+			Preferred_node=`echo $nodes_list | cut -d ' ' -f $[$COUNTER+1]`
+			col=$((COUNTER+2))
+		fi
+
+		numastat > $LTPTMP/numalog
+		extract_numastat other_node $other_node $col || return 1
+		Prev_value=$RC
+		numactl --preferred=$node support_numa $PAUSE &
+		pid=$!
+		migratepages $pid $node $Preferred_node
+		numastat > $LTPTMP/numalog
+		extract_numastat other_node $other_node $col || return 1
+		Curr_value=$RC
+		kill -9 $pid
+		if [ $RC -lt $Prev_value ]; then
+			tst_res TFAIL \
+				"NUMA migratepages is not working fine"
+			return 1
+		fi
+		COUNTER=$((COUNTER+1))
+	done
+
+	tst_res TPASS "NUMA MIGRATEPAGES policy -TEST10 PASSED !!"
 }
 
-# Function:    main
-#
-# Description: - Execute all tests and report results.
-#
-# Exit:        - zero on success
-#              - non-zero on failure.
-    #WARNING!! Never use duplicate variables here...
-    TCID=numa
-    no_of_test=10	#total no. of testcases
-    no_of_test_failed=0	#total no. of testcases failed
-    numa_ret=0		#return value of main script
-
-    init_ret=0
-    init || init_ret=$?
-    if [ $init_ret -ne 0 ]
-    then
-        tst_resm TFAIL "INIT NUMA FAILED !!"
-        exit $RC
-    fi
-
-    total_nodes=0       # total no. of numa nodes
-    # all availiable nodes id list
-    nodes_list=`numactl --show | grep nodebind | cut -d ':' -f 2`
-    for node in `echo $nodes_list`; do
-        total_nodes=$[$total_nodes+1]
-    done
-    tst_resm TINFO "The system contains $total_nodes nodes: $nodes_list"
-    if [ $total_nodes -le 1 ]; then
-        tst_resm TCONF "your machine does not support numa policy or
-                        your machine is not a NUMA machine"
-        exit 0
-    fi
-
-    # call each testcases sequentially
-    COUNT=1
-    while [  $COUNT -le $no_of_test ]; do
-	call_test=$(echo test0$COUNT)
-        func_ret=0
-	$call_test || func_ret=$?
-        if [ $func_ret -ne 0 ]
-        then
-            no_of_test_failed=$[$no_of_test_failed+1]
-        fi
-        COUNT=$[$COUNT+1]
-    done
-
-    TCID=numa
-    TST_COUNT=0
-
-    if [ $no_of_test_failed -ne 0 ]
-    then
-        numa_ret=1	#set return value to non-zero if any one of the testcas got failed
-        tst_resm TINFO "A total of $no_of_test_failed numa testcases FAILED !!"
-    else
-        numa_ret=0
-        tst_resm TINFO "All numa testcases PASSED !!"
-    fi
-
-exit $numa_ret
-
+tst_run
-- 
1.8.3.1

