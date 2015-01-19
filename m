Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lijinyue@huawei.com>) id 1YD8UH-0008Oq-5m
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 09:19:09 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YD8UA-00064p-EX
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 09:19:09 +0000
From: Li Jinyue <lijinyue@huawei.com>
Date: Mon, 19 Jan 2015 08:36:52 +0000
Message-ID: <1421656612-15165-1-git-send-email-lijinyue@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] controllers: disallow attaching kthreadd or
	PF_THREAD_BOUND threads to cgroups on kernel > 3.4.0
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
To: ltp-list@lists.sourceforge.net
Cc: dingguofu@huawei.com, zhanyongming@huawei.com

For kernel commit c4c27fbdda4e8ba87806c415b6d15266b07bce4b,
disallow attaching kthreadd or PF_THREAD_BOUND threads to cgroups.

So, we kindly avoid to attach these threads in cgroup tests.

Signed-off-by: Li Jinyue <lijinyue@huawei.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 30476bd..30fffb6 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -186,6 +186,16 @@ case $attach_operation in
 	do
 		cur_pid=`sed -n "$i""p" $TMPFILE`
 		if [ -e /proc/$cur_pid/ ];then
+			#For kernel 3.4.0 and higher,kernel disallow attaching kthreadd or
+			#PF_THREAD_BOUND threads to cgroups.
+			#kernel commit: c4c27fbdda4e8ba87806c415b6d15266b07bce4b
+			tst_kvercmp 3 4 0
+			if [ $? -ne 0 ]; then
+				thread_flag=`cat /proc/$cur_pid/stat | awk '{print $9}'`
+				if [ $cur_pid -eq 2 -o $((${thread_flag}&0x04000000)) -eq 67108864 ];then
+					continue
+				fi
+			fi
 			do_echo 1 1 "$cur_pid" /dev/cgroup/subgroup_1/tasks
 		fi
 	done
-- 
1.8.2.2


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
