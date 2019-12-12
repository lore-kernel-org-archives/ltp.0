From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Dec 2019 13:35:03 +0100
Subject: [LTP] [PATCH 1/2] statx07: add fsid= to exports
Message-ID: <cd51199b87580a138fa9c7669e61bdb7611ab204.1576154034.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Not all filesystems are stored on devices, and not all filesystems
have UUIDs. tmpfs is one of them, which lead to test failing:
    /tmp/XRzHSG/server requires fsid= for NFS export

Fixes: #622
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/statx/statx07.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 997e81ad843a..a18f253bc7d4 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -133,8 +133,8 @@ static void setup(void)
 	snprintf(server_path, sizeof(server_path), ":%s/%s", cwd, SERV_PATH);
 
 	snprintf(cmd, sizeof(cmd),
-		 "exportfs -i -o no_root_squash,rw,sync,no_subtree_check *%.1024s",
-		 server_path);
+		 "exportfs -i -o no_root_squash,rw,sync,no_subtree_check,fsid=%d *%.1024s",
+		 getpid(), server_path);
 	exported = 1;
 
 	ret = tst_system(cmd);
-- 
1.8.3.1

