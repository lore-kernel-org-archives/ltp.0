From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 14 Jan 2021 10:18:48 +0800
Subject: [LTP] [PATCH v3 2/2] cpuset_inherit: Remove redundant cpu_string
 assignment
In-Reply-To: <1610590728-15813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <X/8ehCeZbWs6TIA4@yuki.lan>
 <1610590728-15813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1610590728-15813-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since the previous patch has got this string from "/sys/devices/system/cpu/online"
file, we don't need to assign value for cpu_string here. Remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh     | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
index 73eed2cb9..650972d4b 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
@@ -106,11 +106,6 @@ inherit_test()
 test_cpus()
 {
 	cfile_name="cpus"
-	num=$((nr_cpus-1))
-	cpu_string="0-$num"
-	if [ $nr_cpus -eq 1 ]; then
-		cpu_string="0"
-	fi
 	while read inherit cpus result
 	do
 		inherit_test "$CPUSET/1/cpuset.cpus" "$inherit" "$cpus" "$result"
-- 
2.23.0



