From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 22 Jun 2021 12:35:12 +0100
Subject: [LTP] [PATCH 6/8] shmat01: Fix uninitialized var error
In-Reply-To: <20210622113514.22284-1-rpalethorpe@suse.com>
References: <20210622113514.22284-1-rpalethorpe@suse.com>
Message-ID: <20210622113514.22284-7-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The compiler is confused by SAFE_WAITPID which it thinks will return
after an error. Setting status to zero silences the error.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index f75914799..606bdd154 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -82,7 +82,7 @@ static void verify_shmat(unsigned int n)
 {
 	int *addr;
 	pid_t pid;
-	int status;
+	int status = 0;
 	struct shmid_ds buf;
 
 	struct test_case_t *tc = &tcases[n];
-- 
2.31.1

