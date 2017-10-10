From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 10 Oct 2017 09:52:50 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/setrlimit02.c: Add a test for EFAULT
In-Reply-To: <20171009142304.GB25633@rei.lan>
References: <20171009142304.GB25633@rei.lan>
Message-ID: <1507600371-29126-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit02.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit02.c b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
index 633279c..d1781ec 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit02.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
@@ -18,7 +18,11 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
- * Testcase to test the different errnos set by setrlimit(2) system call.
+ * DESCRIPTION
+ *  1) Test for EINVAL when resource is invalid.
+ *  2) Test for EFAULT when rlim points outside the accessible address space.
+ *  3) Test for EPERM when an unprivileged process tries to increase the
+ *     hard limit.
  */
 #include <pwd.h>
 #include <errno.h>
@@ -33,6 +37,7 @@ static struct tcase {
 	int exp_errno;
 } tcases[] = {
 	{-1, &rlim, EINVAL},
+	{RLIMIT_NOFILE, (void *) -1, EFAULT},
 	{RLIMIT_NOFILE, &rlim, EPERM}
 };
 
-- 
1.8.3.1



