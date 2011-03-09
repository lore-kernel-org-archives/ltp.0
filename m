Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PxA9T-0007Hn-Bw
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 03:33:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PxA9S-0002tL-Bw
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 03:33:31 +0000
Date: Wed, 9 Mar 2011 11:37:47 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110309033747.GA4731@hpt.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] Per-NUMA control of huge pages
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

There are two new features of hugetlb related to NUMA:
Interaction of Task Memory Policy with Huge Page Allocation/Freeing and
Per Node Hugepages Attributes. Please refer to
Documentation/vm/hugetlbpage.txt in kernel source for details. This
patch try to verify those two features in numa's test.

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 testcases/kernel/numa/numa01.sh |   64 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 151d25b..4e58c66 100644
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -834,6 +834,68 @@ test010()
     tst_resm TPASS "NUMA MIGRATEPAGES policy -TEST10 PASSED !!"
     return 0
 }
+# Function:     test11
+#
+# Description:  - Verification of Interaction of Task Memory Policy with Huge Page Allocation/Freeing
+#
+# Return:       - zero on success.
+#               - non-zero on failure.
+test011()
+{
+    TCID=numa11
+    TST_COUNT=11
+
+    Hugepage_root=$(echo /sys/kernel/mm/hugepages/hugepages-*|tail -n1)
+    Nr_hugepages=$(cat $Hugepage_root/nr_hugepages)
+    Node_nr_hugepages_path="/sys/devices/system/node/node\$COUNTER/hugepages/${Hugepage_root##*/}/nr_hugepages"
+
+    COUNTER=0
+    while [ $COUNTER -lt $max_node ];do
+	Old_nr_hugepages=$(eval cat $Node_nr_hugepages_path)
+	numactl -m $COUNTER echo $[Nr_hugepages+1] > $Hugepage_root/nr_hugepages_mempolicy
+	New_nr_hugepages=$(eval cat $Node_nr_hugepages_path)
+
+	if [ $[Old_nr_hugepages+1] -ne $New_nr_hugepages ]
+	then
+	    tst_resm TFAIL \
+		"Teset #11: NUMA allocate huge page through Memory Policy failed on node #$COUNTER"
+	    return 1
+	fi
+
+	numactl -m $COUNTER echo 1 > $Hugepage_root/nr_hugepages_mempolicy
+	New_nr_hugepages=$(eval cat $Node_nr_hugepages_path)
+
+	if [ $Old_nr_hugepages -ne $New_nr_hugepages ]
+	then
+	    tst_resm TFAIL \
+		"Test #11: NUMA free huge page through Memory Policy failed on node #$COUNTER"
+	    return 1
+	fi
+
+	echo $[Old_nr_hugepages+1] > $(eval echo $Node_nr_hugepages_path)
+	New_nr_hugepages=$(eval cat $Node_nr_hugepages_path)
+
+	if [ $[Old_nr_hugepages+1] -ne $New_nr_hugepages ]
+	then
+	    tst_resm TFAIL \
+		"Test #11: NUMA per node hugepages allocation failed on node #$COUNTER"
+	    return 1
+	fi
+
+	echo $[New_nr_hugepages-1] > $(eval echo $Node_nr_hugepages_path)
+	New_nr_hugepages=$(eval cat $Node_nr_hugepages_path)
+
+	if [ $Old_nr_hugepages -ne $New_nr_hugepages ]
+	then
+	    tst_resm TFAIL \
+		"Test #11: NUMA per node hugepages freeing failed on node #$COUNTER"
+	    return 1
+	fi
+
+	COUNTER=$[COUNTER+1]
+    done
+    tst_resm TPASS "NUMA Interact with Huge Page Allocation/Freeing -TEST11 PASSED !!"
+}
 
 # Function:    main
 #
@@ -843,7 +905,7 @@ test010()
 #              - non-zero on failure.
     #WARNING!! Never use duplicate variables here...
     TCID=numa
-    no_of_test=10	#total no. of testcases
+    no_of_test=11	#total no. of testcases
     no_of_test_failed=0	#total no. of testcases failed
     numa_ret=0		#return value of main script
 
-- 
1.7.1

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
