Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PxE73-0001ex-FF
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 07:47:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PxE72-0008Er-9b
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 07:47:17 +0000
Date: Wed, 9 Mar 2011 15:51:33 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110309075133.GC2997@hpt.nay.redhat.com>
References: <20110309033747.GA4731@hpt.nay.redhat.com>
	<AANLkTingdN-GrnRJ6yQ-qRw-OasXLquVZsaY5B0wQd=q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <AANLkTingdN-GrnRJ6yQ-qRw-OasXLquVZsaY5B0wQd=q@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Per-NUMA control of huge pages
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 08, 2011 at 07:46:39PM -0800, Garrett Cooper wrote:
> On Tue, Mar 8, 2011 at 7:37 PM, Han Pingtian <phan@redhat.com> wrote:
> > There are two new features of hugetlb related to NUMA:
> > Interaction of Task Memory Policy with Huge Page Allocation/Freeing and
> > Per Node Hugepages Attributes. Please refer to
> > Documentation/vm/hugetlbpage.txt in kernel source for details. This
> > patch try to verify those two features in numa's test.
> 
> Use portable shell please.
I have updated it according to your suggestion. Please review. Thanks.
> Thanks,
> -Garrett

-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Per-NUMA-control-of-huge-pages.patch"

From d078e763b33f1bd069f1ff469956c44be549d204 Mon Sep 17 00:00:00 2001
From: Han Pingtian <phan@redhat.com>
Date: Tue, 8 Mar 2011 14:27:05 +0800
Subject: [PATCH] Per-NUMA control of huge pages

There are two new features of hugetlb related to NUMA:
Interaction of Task Memory Policy with Huge Page Allocation/Freeing and
Per Node Hugepages Attributes. Please refer to
Documentation/vm/hugetlbpage.txt in kernel source for details. This
patch try to verify those two features in numa's test.

v1->v2: avoid using 'eval' and '{$..#..}'.

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 testcases/kernel/numa/numa01.sh |   65 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 151d25b..3ff871a 100644
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -834,6 +834,69 @@ test010()
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
+    Node_nr_hugepages_root="/sys/devices/system/node/node"
+    Node_nr_hugepages="/hugepages/$(echo $Hugepage_root | awk -F'/' '{print $NF}')/nr_hugepages"
+
+    COUNTER=0
+    while [ $COUNTER -lt $max_node ];do
+	Old_nr_hugepages=$(cat $Node_nr_hugepages_root$COUNTER/$Node_nr_hugepages)
+	numactl -m $COUNTER echo $[Nr_hugepages+1] > $Hugepage_root/nr_hugepages_mempolicy
+	New_nr_hugepages=$(cat $Node_nr_hugepages_root$COUNTER/$Node_nr_hugepages)
+
+	if [ $[Old_nr_hugepages+1] -ne $New_nr_hugepages ]
+	then
+	    tst_resm TFAIL \
+		"Teset #11: NUMA allocate huge page through Memory Policy failed on node #$COUNTER"
+	    return 1
+	fi
+
+	numactl -m $COUNTER echo 1 > $Hugepage_root/nr_hugepages_mempolicy
+	New_nr_hugepages=$(cat $Node_nr_hugepages_root$COUNTER/$Node_nr_hugepages)
+
+	if [ $Old_nr_hugepages -ne $New_nr_hugepages ]
+	then
+	    tst_resm TFAIL \
+		"Test #11: NUMA free huge page through Memory Policy failed on node #$COUNTER"
+	    return 1
+	fi
+
+	echo $[Old_nr_hugepages+1] > $Node_nr_hugepages_root$COUNTER/$Node_nr_hugepages
+	New_nr_hugepages=$(cat $Node_nr_hugepages_root$COUNTER/$Node_nr_hugepages)
+
+	if [ $[Old_nr_hugepages+1] -ne $New_nr_hugepages ]
+	then
+	    tst_resm TFAIL \
+		"Test #11: NUMA per node hugepages allocation failed on node #$COUNTER"
+	    return 1
+	fi
+
+	echo $[New_nr_hugepages-1] > $Node_nr_hugepages_root$COUNTER/$Node_nr_hugepages
+	New_nr_hugepages=$(cat $Node_nr_hugepages_root$COUNTER/$Node_nr_hugepages)
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
@@ -843,7 +906,7 @@ test010()
 #              - non-zero on failure.
     #WARNING!! Never use duplicate variables here...
     TCID=numa
-    no_of_test=10	#total no. of testcases
+    no_of_test=11	#total no. of testcases
     no_of_test_failed=0	#total no. of testcases failed
     numa_ret=0		#return value of main script
 
-- 
1.7.1


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--k1lZvvs/B4yU6o8G--

