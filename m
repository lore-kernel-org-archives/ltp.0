From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 8 Mar 2021 11:34:28 +0800
Subject: [LTP] [PATCH] proc01: Add /proc/dirty/dirty_list to known_issues
Message-ID: <20210308033428.20924-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When we open the file /proc/dirty/dirty_list directly, it will return -1 and
set the errno to ENOMEM.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/fs/proc/proc01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 96441d153..5ccac9c4d 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -85,6 +85,7 @@ static const struct mapping known_issues[] = {
 	{"open", "/proc/sal/init/data", EBUSY},
 	{"open", "/proc/sal/mca/data", EBUSY},
 	{"open", "/proc/fs/nfsd/pool_stats", ENODEV},
+	{"open", "/proc/dirty/dirty_list", ENOMEM},
 	{"read", "/proc/fs/nfsd/clients/*/ctl", EINVAL},
 	{"read", "/proc/acpi/event", EAGAIN},
 	{"read", "/proc/kmsg", EAGAIN},
--
2.17.1

