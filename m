From: Bixuan Cui <cuibixuan@huawei.com>
Date: Tue, 19 Sep 2017 21:04:37 +0800
Subject: [LTP]  [PATCH] syscalls/access01: Set umask value before run case
Message-ID: <1505826277-33027-1-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The case will fail when set the umask to 0077 acquiescently in system.
Because the value of actual mode is 'set value' & ~'default value
for the umask' when create dir.
So add 'umask(0022)' in setup().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/access/access01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index 7a92525..b679832 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -315,6 +315,8 @@ static void setup(void)
 {
 	struct passwd *pw;

+	umask(0022);
+
 	pw = SAFE_GETPWNAM("nobody");

 	uid = pw->pw_uid;
--
2.6.2

