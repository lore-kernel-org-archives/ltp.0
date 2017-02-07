From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  7 Feb 2017 10:56:55 +0100
Subject: [LTP] [COMMITTED][PATCH] quotactl02: flags for Q_XQUOTA{ON,
	OFF} is 32bit int
Message-ID: <15e9701e3cb8c79bfec874ddc2ee2f920d7aecee.1486461207.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes failure on ppc64 big endian systems:
  quotactl02.c:163: FAIL: quotactl() failed to turn off xfs quota and get xfs quota off status: EEXIST
  quotactl02.c:163: FAIL: quotactl() failed to turn on xfs quota and get xfs quota on status: EINVAL
  quotactl02.c:136: PASS: quoactl() succeeded to set and get xfs disk quota limits

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/quotactl/quotactl02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 97e784480f2b..d3bd94624a8a 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -52,7 +52,7 @@ static struct fs_disk_quota set_dquota = {
 	.d_rtb_softlimit = 1000,
 	.d_fieldmask = FS_DQ_RTBSOFT
 };
-static unsigned short qflag = XFS_QUOTA_UDQ_ENFD;
+static uint32_t qflag = XFS_QUOTA_UDQ_ENFD;
 static const char mntpoint[] = "mnt_point";
 
 static struct t_case {
-- 
1.8.3.1

