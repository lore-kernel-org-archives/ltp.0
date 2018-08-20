From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Date: Mon, 20 Aug 2018 15:49:10 -0400
Subject: [LTP] [PATCH 0/5] acpi_hotplug: Add new test for ACPI based cpu and
	memory hotplug
Message-ID: <20180820194915.11805-1-msys.mizuma@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This patch series to add new test for ACPI based cpu and memory hotplug.

Currently, this test assumes the following environment:
- The system has two or more ACPI0004 container devices
  and the container devices are online.
- The CPU and memory belongs to the container device.
- The memory has Hot Pluggable affinity in Memory Affinity
  Structure, SRAT.
- The memory is marked as 'Movable' which is available when
  movable_node kernel option is set.
- There are one or more memory node in the container device and the memory node
  has 'Movable zone' only, not mixed the other zones.

Masayoshi Mizuma (5):
  acpi_hotplug: Add library file for ACPI based cpu and memory hotplug
  acpi_hotplug: Add ACPI based cpu and memory hotplug testing
  acpi_hotplug: Add ACPIHOTPLUG_01.sh under runtest
  acpi_hotplug: Add Makefile
  acpi_hotplug: Add README

 runtest/acpi_hotplug                          |   1 +
 .../hotplug/acpi_hotplug/ACPIHOTPLUG_01.sh    |  92 ++++++
 .../hotplug/acpi_hotplug/ACPIHOTPLUG_lib.sh   | 310 ++++++++++++++++++
 .../kernel/hotplug/acpi_hotplug/Makefile      |  26 ++
 testcases/kernel/hotplug/acpi_hotplug/README  |  80 +++++
 5 files changed, 509 insertions(+)
 create mode 100644 runtest/acpi_hotplug
 create mode 100755 testcases/kernel/hotplug/acpi_hotplug/ACPIHOTPLUG_01.sh
 create mode 100755 testcases/kernel/hotplug/acpi_hotplug/ACPIHOTPLUG_lib.sh
 create mode 100644 testcases/kernel/hotplug/acpi_hotplug/Makefile
 create mode 100644 testcases/kernel/hotplug/acpi_hotplug/README

-- 
2.18.0

