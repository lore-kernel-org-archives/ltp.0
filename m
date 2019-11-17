From: Petr Vorel <petr.vorel@gmail.com>
Date: Sun, 17 Nov 2019 15:02:20 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] nfsv4/acl: Remove unneeded
 malloc(sizeof(FILE))
Message-ID: <20191117140220.17978-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

FILE incomplete type under musl (comply C11 [1]).
malloc(sizeof(FILE)) is not needed anyway, thus remove.

This fixes build on musl (at least):
acl1.c:51:23: error: invalid application of 'sizeof' to incomplete type 'FILE' {aka 'struct _IO_FILE'}
  fptr = malloc(sizeof(FILE));

Fixes: 618fd23eb ("Initial add of acl testsuite from Bull")

[1] https://www.openwall.com/lists/musl/2019/01/16/1

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/network/nfsv4/acl/acl1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/network/nfsv4/acl/acl1.c b/testcases/network/nfsv4/acl/acl1.c
index bdf0180da..aae9484e5 100644
--- a/testcases/network/nfsv4/acl/acl1.c
+++ b/testcases/network/nfsv4/acl/acl1.c
@@ -48,7 +48,6 @@ int do_file_op(char *filename)
 	result = 0;
 	FILE *fptr;
 	char str[256] = "./";
-	fptr = malloc(sizeof(FILE));
 
 	uid = geteuid();
 	strcat(str, filename);
-- 
2.24.0

