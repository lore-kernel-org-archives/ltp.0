From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Date: Mon, 20 Aug 2018 15:49:15 -0400
Subject: [LTP]  [PATCH 5/5] acpi_hotplug: Add README
In-Reply-To: <20180820194915.11805-1-msys.mizuma@gmail.com>
References: <20180820194915.11805-1-msys.mizuma@gmail.com>
Message-ID: <20180820194915.11805-6-msys.mizuma@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 testcases/kernel/hotplug/acpi_hotplug/README | 80 ++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 testcases/kernel/hotplug/acpi_hotplug/README

diff --git a/testcases/kernel/hotplug/acpi_hotplug/README b/testcases/kernel/hotplug/acpi_hotplug/README
new file mode 100644
index 000000000..cec78e19f
--- /dev/null
+++ b/testcases/kernel/hotplug/acpi_hotplug/README
@@ -0,0 +1,80 @@
+ACPI based CPU and Memory hotplug testing
+=========================================
+
+Assumption
+----------
+* The system has two or more ACPI container devices. The HID is 'ACPI0004'.
+* The CPU (HID: ACPI0007) and memory (HID: PNP0C80) belong to the ACPI
+container device. For example of the structure in sysfs is as follows.
+
+[source]
+--------------
+/sys/devices/LNXSYSTM:00/device:00/ACPI0004:03/
+├── ACPI0007:168
+├── ACPI0007:169
+...
+├── PNP0C80:06
+├── PNP0C80:07
+...
+--------------
+
+* The memory has Hot Pluggable affinity in Memory Affinity Structure, SRAT.
+If the memory has Hot Pluggable affinity, you can see the following 'hotplug'
+keyword in dmesg.
+
+[source]
+--------------
+SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
+SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
+--------------
+* The memory is marked as 'Movable' which is available when movable_node
+kernel option is set.
+
+* There are one or more memory node in the container device and the memory
+node has 'Movable zone' only, not mixed the other zones. You can check
+such memory node from /proc/pagetypeinfo or /proc/zoneinfo. The example
+of /proc/pagetypeinfo is as follows.
+
+[source]
+--------------
+Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
+Node    3, zone  Movable, type    Unmovable      0      0      0      0      0      0      0      0      0      0      0
+Node    3, zone  Movable, type      Movable      0      0      1      0      1      1      0      1      1      0  16382
+Node    3, zone  Movable, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
+Node    3, zone  Movable, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
+Node    3, zone  Movable, type          CMA      0      0      0      0      0      0      0      0      0      0      0
+Node    3, zone  Movable, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
+
+Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic          CMA      Isolate
+Node 3, zone  Movable            0        32768            0            0            0            0
+--------------
+
+Test case description
+---------------------
+
+ACPIHOTPLUG_01.sh
+~~~~~~~~~~~~~~~~
+
+Test1
+^^^^^
+Verifies hot-removing the memory.
+
+Test2
+^^^^^
+Verifies hot-removing the CPU.
+
+Test3
+^^^^^
+Verifies hot-removing the ACPI container device.
+
+Test4
+^^^^^
+Verifies hot-adding the ACPI container device.
+
+Test5
+^^^^^
+Verifies hot-adding the CPU.
+
+Test6
+^^^^^
+Verifies hot-adding the memory.
-- 
2.18.0

