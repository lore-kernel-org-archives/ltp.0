From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Dec 2019 13:35:04 +0100
Subject: [LTP] [PATCH 2/2] statx07: handle ETIMEDOUT when rpcbind.socket is
 not started
In-Reply-To: <cd51199b87580a138fa9c7669e61bdb7611ab204.1576154034.git.jstancek@redhat.com>
References: <cd51199b87580a138fa9c7669e61bdb7611ab204.1576154034.git.jstancek@redhat.com>
Message-ID: <853f6938da5d133800dc6bf1d490937b50c2e059.1576154034.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Recent Fedora distros (kernel-5.3.7-301.fc31.x86_64,
nfs-utils-2.4.1-1.rc1.fc31.x86_64), by default don't start rpcbind
service, where rpcbind.socket is a dependency.

This leads to test failing with ETIMEDOUT:
  # ./statx07
  tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
  statx07.c:149: BROK: mount() nfs failed: ETIMEDOUT (110)

  # systemctl start rpcbind.socket
  # ./statx07
  tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
  statx07.c:148: CONF: nfs server not set up?: EOPNOTSUPP (95)

Watch for ETIMEDOUT as well.

Fixes: #622
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/statx/statx07.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index a18f253bc7d4..ec1cdd19087b 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -144,7 +144,8 @@ static void setup(void)
 		tst_brk(TBROK | TST_ERR, "failed to exportfs");
 
 	if (mount(server_path, CLI_PATH, "nfs", 0, "addr=127.0.0.1")) {
-		if (errno == EOPNOTSUPP || errno == ECONNREFUSED)
+		if (errno == EOPNOTSUPP || errno == ECONNREFUSED
+			|| errno == ETIMEDOUT)
 			tst_brk(TCONF | TERRNO, "nfs server not set up?");
 		tst_brk(TBROK | TERRNO, "mount() nfs failed");
 	}
-- 
1.8.3.1

