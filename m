From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:46 +0100
Subject: [LTP] [PATCH 17/18] hotplug/cpu_hotplug: Repopulate cgroup:cpusets
	after testing hotplug
In-Reply-To: <20171026141447.26749-1-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
Message-ID: <20171026141447.26749-18-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: James Morse <james.morse@arm.com>

When LTP is started over ssh, systemd will use cgroups to group all the
tasks started by this session. LTPs cpuhotplug04 will remove all but one
CPU as part of its test.

In the kernel cpuset_hotplug_workfn() is documented thus: "Non-root
cpusets are only affected by offlining". This means cpuhotplug04 will
cause all future tasks to only have one available CPU. cpuhotplug04
effectively looses those CPUs for all users until the next reboot.

This problem has been reported, and was fixed for the unified hierarchy
by be4c9dd7aee5 ("cpuset: enable onlined cpu/node in effective
masks"). Since v3.17, this behaviour could be selected by passing '-o
__DEVEL__sane_behavior' to the cgroup mount.  Linux v4.4 grouped all the
ABI breakage together into a new filesystem: cgroup2, removing the
__DEVEL__sane_behavior flag.

With v226 Systemd can be forced to use cgroup2 by passing
'systemd.unified_cgroup_hierarchy=1' on the kernel command line.

Ubuntu 15.04 ships with systemd v219.

LTP tests that online CPUs must test for the legacy cgroup hierarchy and
update the cpusets for all users/sessions. Add this code the
cpu_online() helper.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 .../cpu_hotplug/include/cpuhotplug_hotplug.sh      | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index 9f856e554..35ec7c86b 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -58,6 +58,39 @@ set_affinity()
     return $?
 }
 
+# repopulate_cpusets()
+#
+# If the legacy cgroup hierarchy is in use, and cpuset is mounted, copy
+# the permitted cpus from the root group, which always has all available
+# cpus and memory, into the other hierarchy nodes. This prevents hotplug
+# tests from losing CPUs, and affecting the results of later tests.
+#
+CPUSET="/sys/fs/cgroup/cpuset"
+repopulate_cpusets()
+{
+	# Only if we have cpusets
+	if [ ! -d ${CPUSET} ] ; then
+		return;
+	fi
+
+	# And then only legacy cpusets
+	if grep --quiet "/sys/fs/cgroup/cpuset[ ]*cgroup2" /proc/mounts ; then
+		return;
+	fi
+
+	# Copy root cpus into system and user slices
+	cat ${CPUSET}/cpuset.cpus > ${CPUSET}/system.slice/cpuset.cpus
+	cat ${CPUSET}/cpuset.cpus > ${CPUSET}/user.slice/cpuset.cpus
+
+	# Fix each session of each user
+	for TUSER in ${CPUSET}/user.slice/user-*.slice ; do
+		cat ${CPUSET}/cpuset.cpus > ${TUSER}/cpuset.cpus
+		for SESSION in ${TUSER}/session-*.scope; do
+			cat ${CPUSET}/cpuset.cpus > ${SESSION}/cpuset.cpus
+		done
+	done
+}
+
 # online_cpu(CPU)
 #
 #  Onlines the given CPU.  Returns a true value if it was able
@@ -77,6 +110,9 @@ online_cpu()
 
     $TIME echo 1 > /sys/devices/system/cpu/cpu${CPU}/online
     RC=$?
+
+    repopulate_cpusets
+
     report_timing "Online cpu ${CPU}"
     return $RC
 }
-- 
2.14.2

