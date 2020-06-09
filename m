From: Vikas Kumar <vikas.kumar2@arm.com>
Date: Tue,  9 Jun 2020 12:46:11 +0530
Subject: [LTP] [PATCH] syscalls/fork14: Fix Buffer overflow
Message-ID: <20200609071611.9467-1-vikas.kumar2@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This change basically avoids the buffer overflow by keeping the check count
to allocation limit
The problem occurs when there is no failure and i == EXTENT, so
pointer_vec[EXTENT] goes beyond the allocated buffer.

Signed-off-by: Vikas Kumar <vikas.kumar2@arm.com>
Reported-by: Amit Kachhap <amit.kachhap@arm.com>
---
 testcases/kernel/syscalls/fork/fork14.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
index a92aa46ad..2a20d9df8 100644
--- a/testcases/kernel/syscalls/fork/fork14.c
+++ b/testcases/kernel/syscalls/fork/fork14.c
@@ -132,6 +132,9 @@ static int fork_test(void)
 		}
 	}
 
+	if (i == EXTENT)
+		i--;
+
 clear_memory_map:
 	for (j = 0; j <= i; j++) {
 		if (pointer_vec[j])
-- 
2.17.1

