From: Steve Muckle <smuckle.linux@gmail.com>
Date: Tue, 24 Apr 2018 18:28:57 -0700
Subject: [LTP] [PATCH] syscalls/swapon03: do not fail if /proc/swaps is
	absent
Message-ID: <20180425012857.15100-1-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the /proc/swaps file is absent the test should be skipped due
to incompatible configuration.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
 testcases/kernel/syscalls/swapon/swapon03.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index d3f73b044fe1..955ac247b6a2 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -328,6 +328,9 @@ static void setup(void)
 
 	tst_require_root();
 
+	if (access("/proc/swaps", F_OK))
+		tst_brkm(TCONF, NULL, "swap not supported by kernel");
+
 	tst_tmpdir();
 
 	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-- 
2.16.1

