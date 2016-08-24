From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Aug 2016 15:27:54 +0300
Subject: [LTP] [PATCH V2 06/11] syscalls/waitpid: make reap_children() fail
	if errno is not ECHILD
In-Reply-To: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1472041679-29759-7-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We expect that waitpid() may fail only with EINTR or ECHILD.
All other errno values signal about an error.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
No changes since V1.

 testcases/kernel/syscalls/waitpid/waitpid_common.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid_common.h b/testcases/kernel/syscalls/waitpid/waitpid_common.h
index f5e9519..f724a17 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid_common.h
+++ b/testcases/kernel/syscalls/waitpid/waitpid_common.h
@@ -117,6 +117,9 @@ static int reap_children(pid_t wp_pid, int wp_opts, pid_t *children, int len)
 			if (errno == EINTR)
 				continue;
 
+			if (waitpid_errno_check(errno, ECHILD))
+				return -1;
+
 			break;
 		}
 
-- 
1.7.1

