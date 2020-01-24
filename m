From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 24 Jan 2020 15:56:35 +0100
Subject: [LTP] [PATCH] read_all: skip eeprom and nvmem
Message-ID: <79fee43729701f3a3d46c6cbc26fa3f2402e182e.1579877705.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Big Power9 NV systems are failing to complete the test, as they
spend lot of time on /sys/devices/platform, trying to read dozens
of low level files like eeprom or nvmem. Each adds couple seconds,
eventually pushing test over timeout.

User or system admin is unlikely to ever need to access these
entries, so skip them.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 47f8532231d9..f091f2f64a4d 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -85,6 +85,8 @@ static char *blacklist[] = {
 	NULL, /* reserved for -e parameter */
 	"/sys/power/wakeup_count",
 	"/sys/kernel/debug/*",
+	"/sys/devices/platform/*/eeprom",
+	"/sys/devices/platform/*/nvmem",
 };
 
 static struct tst_option options[] = {
-- 
2.18.1

