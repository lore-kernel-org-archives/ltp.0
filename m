From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Thu,  5 Oct 2017 13:35:15 +0200
Subject: [LTP] [PATCH] sync_file_range: add little endian support for mips
Message-ID: <1507203315-22351-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 testcases/kernel/syscalls/sync_file_range/sync_file_range01.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
index 0a9fb8e..cebb919 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
@@ -218,8 +218,13 @@ static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
 
 /* mips */
 #elif defined(__mips__) && __WORDSIZE == 32
+#if __BYTE_ORDER == __BIG_ENDIAN
 	return ltp_syscall(__NR_sync_file_range, fd, 0, (int)(offset >> 32),
 		(int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+	return ltp_syscall(__NR_sync_file_range, fd, 0, (int)offset,
+		(int)(offset >> 32), (int)nbytes, (int)(nbytes >> 32), flags);
+#endif
 
 /* other */
 #else
-- 
1.9.1

