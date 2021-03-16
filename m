From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 16 Mar 2021 17:06:46 +0800
Subject: [LTP] [PATCH] runtest/syscalls: Add testcases to test list
Message-ID: <20210316090646.10061-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add syscall test cases to test list.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index fe22ae5b6..292768be1 100644
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
@@ -695,6 +697,8 @@ mbind02 mbind02
 mbind03 mbind03
 mbind04 mbind04

+mem03 mem03
+
 memset01 memset01
 memcmp01 memcmp01
 memcpy01 memcpy01
@@ -751,6 +755,7 @@ mmap06 mmap06
 mmap07 mmap07
 mmap08 mmap08
 mmap09 mmap09
+mmap10 mmap10
 mmap12 mmap12
 mmap13 mmap13
 mmap14 mmap14
--
2.17.1

