From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Mar 2020 17:25:20 +0300
Subject: [LTP] [PATCH] proc01: exclude /proc/nfsd/clients/*/ctl
Message-ID: <20200312142520.25842-1-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

"ctl" files are write-only, added in Linux 5.3 with this commit
89c905beccbb ("nfsd: allow forced expiration of NFSv4 clients")

Before the patch:
proc01      1  TFAIL  :  proc01.c:396: read failed: /proc/fs/nfsd/clients/13/ctl: errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/fs/nfsd/unlock_filesystem: known issue: errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/fs/nfsd/unlock_ip: known issue: errno=EINVAL(22): Invalid argument
...

After:
proc01      0  TINFO  :  /proc/fs/nfsd/clients/13/ctl: known issue: errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/fs/nfsd/unlock_filesystem: known issue: errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/fs/nfsd/unlock_ip: known issue: errno=EINVAL(22): Invalid argument
...

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/fs/proc/proc01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index d917591bf..96843695c 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -85,6 +85,7 @@ static const struct mapping known_issues[] = {
 	{"open", "/proc/sal/init/data", EBUSY},
 	{"open", "/proc/sal/mca/data", EBUSY},
 	{"open", "/proc/fs/nfsd/pool_stats", ENODEV},
+	{"read", "/proc/fs/nfsd/clients/*/ctl", EINVAL},
 	{"read", "/proc/acpi/event", EAGAIN},
 	{"read", "/proc/kmsg", EAGAIN},
 	{"read", "/proc/sal/cpe/event", EAGAIN},
-- 
2.20.1

