From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  5 Jul 2017 17:34:18 +0300
Subject: [LTP] [PATCH 2/2] cpuhotplug05.sh: bring up the cpu after testing
In-Reply-To: <1499265258-25521-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1499265258-25521-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1499265258-25521-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test case leaves the cpu offline. This patch is to fix it.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index 731144c..e3f727b 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -36,6 +36,7 @@ EOF
 do_clean()
 {
 	pid_is_valid ${SAR_PID} && kill_pid ${SAR_PID}
+	online_cpu "$CPU_TO_TEST"
 }
 
 get_field()
-- 
1.7.1

