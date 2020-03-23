From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 23 Mar 2020 23:49:32 +0100
Subject: [LTP] [PATCH 2/3] accept4: Remove fallback definitions
In-Reply-To: <20200323224933.2613658-1-petr.vorel@gmail.com>
References: <20200323224933.2613658-1-petr.vorel@gmail.com>
Message-ID: <20200323224933.2613658-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

They're already defined in lapi/fcntl.h.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/accept4/accept4_01.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index a596b9b1a..55aa210ae 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -25,13 +25,6 @@
 
 #define PORT_NUM 33333
 
-#ifndef SOCK_CLOEXEC
-# define SOCK_CLOEXEC    O_CLOEXEC
-#endif
-#ifndef SOCK_NONBLOCK
-# define SOCK_NONBLOCK   O_NONBLOCK
-#endif
-
 static const char *variant_desc[] = {
 	"libc accept4()",
 	"__NR_accept4 syscall",
-- 
2.25.1

