From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  7 Dec 2015 10:37:37 +0100
Subject: [LTP] [PATCH] linux_syscall_numbers: add syscall number to output
Message-ID: <f3bd16aa377ac43648722a55fc747fe78a19056e.1449480858.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some tests don't pass __NR_* as argument directly, but use a variable.
Because ltp_syscall is a macro that stringifies "NR" argument we get
output such as: "syscall tests[i].syscall not supported on your arch".

Add syscall number to output as well.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/include/regen.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/include/regen.sh b/testcases/kernel/include/regen.sh
index 9efc4f17cf88..f93f49b7753f 100755
--- a/testcases/kernel/include/regen.sh
+++ b/testcases/kernel/include/regen.sh
@@ -44,7 +44,8 @@ cat << EOF > "${output_pid}"
 	} \\
 	if (__ret == -1 && errno == ENOSYS) { \\
 		tst_brkm(TCONF, CLEANUP, \\
-			"syscall " #NR " not supported on your arch"); \\
+			"syscall(%d) " #NR " not supported on your arch", \\
+			NR); \\
 		errno = ENOSYS; \\
 	} \\
 	__ret; \\
-- 
1.8.3.1

