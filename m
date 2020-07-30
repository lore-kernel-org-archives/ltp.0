From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 30 Jul 2020 11:26:37 +0200
Subject: [LTP] [PATCH 1/1] semctl: Fix 32 bit build
Message-ID: <20200730092637.487-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since dfe45f3cf libltpnewipc started to depend on safe macros from
libltp.a, thus order for linking must be -lltpnewipc -lltp.

Default order (where -lltp goes first) caused build failures on 32 bit:

cd testcases/kernel/syscalls/ipc/semctl
gcc -m32 -Wformat -Werror=format-security -Werror=implicit-function-declaration -Werror=return-type -fno-common -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -I../../../../../include -I../../../../../include -I../../../../../include/old/ -m32 -L../../../../../libs/libltpipc -L../../../../../libs/libltpnewipc -L../../../../../lib  semctl08.c  -lltp -lltpnewipc -o semctl08
/usr/bin/ld: ../../../../../libs/libltpnewipc/libltpnewipc.a(libnewipc.o): in function `probe_free_addr':
libs/libltpnewipc/libnewipc.c:79: undefined reference to `safe_shmget'
/usr/bin/ld: libs/libltpnewipc/libnewipc.c:81: undefined reference to `safe_shmat'
/usr/bin/ld: libs/libltpnewipc/libnewipc.c:82: undefined reference to `safe_shmdt'
/usr/bin/ld: libs/libltpnewipc/libnewipc.c:83: undefined reference to `safe_shmctl'

NOTE: other uses of -lltpnewipc (msg{ctl,get,snd}, shm{at,ctl})
are not affected.

Fixes: dfe45f3cf ("libs/libltpnewipc: Use safe macros")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

Reason why I don't push this fix directly is that
I wonder why msg{ctl,get,snd}, shm{at,ctl} aren't affected and whether
we can avoid directly specifying -lltp.

Kind regards,
Petr

 testcases/kernel/syscalls/ipc/semctl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
index 99971a7db..2559b4c28 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -8,6 +8,6 @@ LTPLIBS = ltpipc ltpnewipc
 include $(top_srcdir)/include/mk/testcases.mk
 
 semctl01 semctl02 semctl03 semctl04 semctl05 semctl06 semctl07: LDLIBS += -lltpipc
-semctl08: LDLIBS += -lltpnewipc
+semctl08: LDLIBS = -lltpnewipc -lltp
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.27.0

