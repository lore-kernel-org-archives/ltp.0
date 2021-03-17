From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Wed, 17 Mar 2021 12:57:49 +0800
Subject: [LTP] [PATCH v2] runtest/syscalls: Add testcases to test list
Message-ID: <20210317045749.3335-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add syscall test cases to test list.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2: remove mem03 and mmap10.
 runtest/syscalls | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index fe22ae5b6..9d4c57bb2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -44,6 +44,7 @@ bpf_prog03 bpf_prog03
 bpf_prog04 bpf_prog04

 brk01 brk01
+brk02 brk02

 capget01 capget01
 capget02 capget02
@@ -492,6 +493,7 @@ getrlimit02 getrlimit02
 getrlimit03 getrlimit03

 get_mempolicy01 get_mempolicy01
+get_mempolicy02 get_mempolicy02
 get_robust_list01 get_robust_list01

 getrusage01 getrusage01
--
2.17.1

