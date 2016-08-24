From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Aug 2016 15:27:59 +0300
Subject: [LTP] [PATCH V2 11/11] waitpid08: test stopped children
In-Reply-To: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1472041679-29759-12-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The whole purpose of WUNTRACED is to help with handling of stopped
children. Therefore, let's expand the scope of testing by making
the children stop before we call waitpid() (similarly to waitpid13).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
No changes since V1.

 testcases/kernel/syscalls/waitpid/waitpid08.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid08.c b/testcases/kernel/syscalls/waitpid/waitpid08.c
index 6c8d3b9..dc29e07 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid08.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid08.c
@@ -43,7 +43,7 @@ static void do_child_1(void)
 
 		pid = SAFE_FORK();
 		if (pid == 0)
-			do_exit(0);
+			do_exit(1);
 
 		fork_kid_pid[i] = pid;
 	}
-- 
1.7.1

