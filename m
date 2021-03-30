From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Tue, 30 Mar 2021 10:18:30 +0800
Subject: [LTP] [PATCH] bugfix for ssetmask01.c
Message-ID: <20210330021830.17402-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mips architecture syscall(69) __NR_ssetmask not supported on your arch.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
---
 include/lapi/syscalls/mips_o32.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index c71a62a35..c2d43b984 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -66,8 +66,8 @@ getppid 64
 getpgrp 65
 setsid 66
 sigaction 67
-sgetmask 68
-ssetmask 69
+sgetmask 4068
+ssetmask 4069
 setreuid 70
 setregid 71
 sigsuspend 72
--
2.20.1



