From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 13 Apr 2021 15:50:04 +0200
Subject: [LTP] [PATCH] read_all: limit per cpu nodes to first ten cpus
Message-ID: <f776dd1a02dc16efa8aa80bbe6f9b55186dc82cd.1618321799.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some per cpu sysfs entries have high lock contention and when
this is combined with systems which have many CPUs (meaning they
also have many per cpu sysfs entries) the test spends most of
time on these nodes and occasionally also hits timeout.

For example, these entries are largest contributor on HPE Apollo 70
(aarch64, 256 CPUs):
  /sys/kernel/tracing/per_cpu/cpu247/*
  /sys/devices/system/cpu/cpu239/acpi_cppc/*

To preserve some coverage, add a blacklist rule that will ignore
"cpu" nodes with 2 or more digits.

Before:
  real    4m47.747s
  user    0m0.885s
  sys     5m47.909s

After:
  real    0m42.696s
  user    0m0.911s
  sys     0m4.759s

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 79c6b93fad73..a4123220afbe 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -87,6 +87,7 @@ static char *blacklist[] = {
 	"/sys/kernel/debug/*",
 	"/sys/devices/platform/*/eeprom",
 	"/sys/devices/platform/*/nvmem",
+	"/sys/*/cpu??*(?)/*",	/* cpu* entries with 2 or more digits */
 };
 
 static int queue_pop(struct queue *q, char *buf)
-- 
2.18.1

