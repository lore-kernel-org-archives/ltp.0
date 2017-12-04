From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:55 +0000
Subject: [LTP] [PATCH v3 12/12] hotplug/cpu_hotplug: Remove bashism disown
	from kill_pid()
In-Reply-To: <20171204163655.8838-1-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
Message-ID: <20171204163655.8838-13-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: James Morse <james.morse@arm.com>

disown is a bashism not present in dash. kill_pid() already sends the
process SIGKILL.

Remove the "disown" to allow running in shells that don't support
disown.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
index 2d0166cc6..7dd0ebaae 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
@@ -74,7 +74,6 @@ pid_is_valid()
 kill_pid()
 {
     PID=$1
-    disown $PID
     kill -9 $PID > /dev/null 2>&1
 }
 
-- 
2.15.0

