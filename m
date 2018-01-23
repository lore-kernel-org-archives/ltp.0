From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jan 2018 17:46:35 +0800
Subject: [LTP] [PATCH v2] is_fuse: return zore if fs_type is NULL
Message-ID: <20180123094635.17931-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commmit 28507e514c(safe_mount: Do not try mount() syscall for FUSE fs)
involves FUSE fs check in safe_mount(), but we'd better guarantee the "fs_type"
is legal to check in is_fuse() function otherwise system will kill the program.

  cmdline="fanotify06"
  contacts=""
  analysis=exit
  <<<test_output>>>
  tst_test.c:980: INFO: Timeout per run is 0h 10m 00s
  tst_test.c:1025: BROK: Test killed by SIGSEGV!

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/safe_macros.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index c48e436..abdeca0 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -708,6 +708,9 @@ static int is_fuse(const char *fs_type)
 {
 	unsigned int i;
 
+	if (!fs_type)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(fuse_fs_types); i++) {
 		if (!strcmp(fuse_fs_types[i], fs_type))
 			return 1;
-- 
2.9.3

