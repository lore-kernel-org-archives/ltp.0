From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 03:11:37 +0000
Subject: [LTP] [PATCH 1/11] bind/bind02: Testcase failed when no root user
	run it
Message-ID: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_require_root() to testcase for setegid().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/bind/bind02.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind02.c b/testcases/kernel/syscalls/bind/bind02.c
index 721f525..3dc5652 100644
--- a/testcases/kernel/syscalls/bind/bind02.c
+++ b/testcases/kernel/syscalls/bind/bind02.c
@@ -127,6 +127,8 @@ int main(int argc, char *argv[])
 	 * Linux doesn't have that limitation apparently. */
 	char *username = NULL;
 
+	tst_require_root();
+
 	if (argc != 2) {
 		tst_resm(TINFO, "Defaulting to user nobody");
 		username = strdup(nobody_uid);
-- 
1.6.0.2

