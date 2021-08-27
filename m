From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 27 Aug 2021 06:13:08 +0100
Subject: [LTP] [PATCH 2/3] bpf: Mention CAP_BPF in required privs and add
 fallback definition
In-Reply-To: <20210827051309.28521-1-rpalethorpe@suse.com>
References: <20210827051309.28521-1-rpalethorpe@suse.com>
Message-ID: <20210827051309.28521-2-rpalethorpe@suse.com>
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
index 6e9cd498c..72957a487 100644
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

