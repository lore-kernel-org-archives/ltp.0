From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 4 Mar 2020 17:54:15 +0800
Subject: [LTP] [PATCH] bpf_common.h: Use errno instead of TST_ERR
Message-ID: <1583315655-3307-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since it doesn't call TEST, TST_ERR is always equal to 0.
Use errno instead of it.

Fixes: 5d3a2ec8cf0d ("Fix BPF test program loading issue")
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/bpf/bpf_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index 1db91e29a..fd299b73d 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -36,7 +36,7 @@ int bpf_map_create(union bpf_attr *attr)
 		TST_RETVAL_GE0);
 
 	if (ret == -1) {
-		if (TST_ERR == EPERM) {
+		if (errno == EPERM) {
 			tst_res(TCONF, "Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled");
 			tst_brk(TCONF | TERRNO,
 				"bpf() requires CAP_SYS_ADMIN on this system");
-- 
2.18.0



