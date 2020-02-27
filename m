From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 27 Feb 2020 13:28:13 +0100
Subject: [LTP] [PATCH] syscalls/bpf: bump RLIMIT_MEMLOCK limit
Message-ID: <fa386b967db52665ca84150a59058d0f601ca051.1582806435.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some bpf array types reserve space according to number of
possible CPUs. This is running into limits on a ppc64le with
64k pages and NR_CPUS==2048:
    84 bpf_map01(1049142):   <-bpf_map_init_from_attr
    89 bpf_map01(1049142):   ->bpf_map_charge_init mem={.pages=0, .user=0x0} size=208456
    94 bpf_map01(1049142):   <-bpf_map_charge_init return=0xffffffffffffffff

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/bpf/bpf_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
index 1dbbd5f25635..d36a2b09ffd9 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.h
+++ b/testcases/kernel/syscalls/bpf/bpf_common.h
@@ -6,7 +6,7 @@
 #ifndef LTP_BPF_COMMON_H
 #define LTP_BPF_COMMON_H
 
-#define BPF_MEMLOCK_ADD (256*1024)
+#define BPF_MEMLOCK_ADD (2*1024*1024)
 
 void rlimit_bump_memlock(void);
 int bpf_map_create(union bpf_attr *attr);
-- 
2.18.1

