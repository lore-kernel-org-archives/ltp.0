From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 31 Aug 2021 10:10:04 +0100
Subject: [LTP] [PATCH v2 3/4] bpf: Mention CAP_BPF in required privs and add
 fallback definition
In-Reply-To: <20210831091005.25361-1-rpalethorpe@suse.com>
References: <YSz36VZ18+N4YsM/@yuki>
 <20210831091005.25361-1-rpalethorpe@suse.com>
Message-ID: <20210831091005.25361-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We don't need CAP_SYS_ADMIN most of the time. bpf() can be called with
only CAP_BPF even when unprivileged_bpf_disable > 0. When
unprivileged_bpf_disable == 0, CAP_BPF also allows more features Vs. no
privileges at all.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/capability.h                  | 4 ++++
 testcases/kernel/syscalls/bpf/bpf_common.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index c6470f389..8cabd0f28 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -44,6 +44,10 @@
 # define CAP_SYS_RESOURCE     24
 #endif
 
+#ifndef CAP_BPF
+# define CAP_BPF              39
+#endif
+
 #ifndef CAP_TO_INDEX
 # define CAP_TO_INDEX(x)     ((x) >> 5)
 #endif
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index aac235cac..3afa6c51e 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -40,7 +40,7 @@ int bpf_map_create(union bpf_attr *const attr)
 		if (errno == EPERM) {
 			tst_res(TCONF, "Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled");
 			tst_brk(TCONF | TERRNO,
-				"bpf() requires CAP_SYS_ADMIN on this system");
+				"bpf() requires CAP_SYS_ADMIN or CAP_BPF on this system");
 		} else {
 			tst_brk(TBROK | TERRNO, "Failed to create array map");
 		}
-- 
2.31.1

