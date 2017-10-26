From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:37 +0100
Subject: [LTP] [PATCH 08/18] creat08: ensure test directories are created in
	/tmp/
In-Reply-To: <20171026141447.26749-1-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
Message-ID: <20171026141447.26749-9-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Will Deacon <will.deacon@arm.com>

runltp runs tests in the ${LTP_ROOT}/bin directory. If this is NFS
mounted, we can run into problems that need to use setgid. Fix this by
ensuring that creat08 creates directories in /tmp/

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/syscalls/creat/creat08.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
index 284ae5f1a..bd8368e28 100644
--- a/testcases/kernel/syscalls/creat/creat08.c
+++ b/testcases/kernel/syscalls/creat/creat08.c
@@ -63,8 +63,8 @@ int local_flag;
 
 #define MODE_RWX        (S_IRWXU|S_IRWXG|S_IRWXO)
 #define MODE_SGID       (S_ISGID|S_IRWXU|S_IRWXG|S_IRWXO)
-#define DIR_A_TEMP	"testdir.A.%d"
-#define DIR_B_TEMP	"testdir.B.%d"
+#define DIR_A_TEMP	"/tmp/testdir.A.%d"
+#define DIR_B_TEMP	"/tmp/testdir.B.%d"
 #define SETGID		"setgid"
 #define NOSETGID	"nosetgid"
 #define ROOT_SETGID	"root_setgid"
-- 
2.14.2

