From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Mon,  3 Oct 2016 13:06:46 +0200
Subject: [LTP]  [PATCH] Fix sync_file_range for Mips
Message-ID: <1475492806-9443-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For Mips there is a second argument which is actually a padding.
This can be confirmed in glibc.

---
 testcases/kernel/syscalls/sync_file_range/sync_file_range01.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
index 935786b..ea05195 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
@@ -216,6 +216,11 @@ static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
 	return ltp_syscall(__NR_sync_file_range, fd, (int)(offset >> 32),
 		(int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
 
+/* mips */
+#elif defined(__mips__) && __WORDSIZE == 32
+	return ltp_syscall(__NR_sync_file_range, fd, 0, (int)(offset >> 32),
+		(int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
+
 /* other */
 #else
 	return ltp_syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
-- 
1.9.1

