From: Basavaraju <basava@linux.vnet.ibm.com>
Date: Thu, 07 Apr 2016 15:06:03 +0530
Subject: [LTP]  [PATCH] cpuset: change default cpuset mount value
Message-ID: <57062A03.70705@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Earlier cpuset is mounted under /dev/cpuset by default. This behaviour is changed in RHEL7.1 and RHEL7.2 Distributions

by default, Now its mounting under /sys/fs/cgroup/cpuset.


[root@localhost ~]# mount | grep cpuset
cgroup on /sys/fs/cgroup/cpuset type cgroup 
(rw,nosuid,nodev,noexec,relatime,cpuset)
[root@localhost ~]#

Signed-off-by: Basavaraju.G<basava@linux.vnet.ibm.com>
Tested-by: Basavaraju.G<basava@linux.vnet.ibm.com>


diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh 
b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index cd7000e..4c5a17b 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -35,7 +35,7 @@ fi
  N_NODES=${N_NODES#*-*}
  N_NODES=$(($N_NODES + 1))

-CPUSET="/dev/cpuset"
+CPUSET="/sys/fs/cgroup/cpuset"
  CPUSET_TMP="/tmp/cpuset_tmp"

  HOTPLUG_CPU="1"


Best Regards,
Basavaraju.G


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160407/c3291688/attachment.html>
