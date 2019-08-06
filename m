From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  6 Aug 2019 11:10:39 +0200
Subject: [LTP] [PATCH 1/2] syscalls/copy_file_range02: Improve error message
Message-ID: <20190806091040.26448-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changing error message as 255 exit code occurs on some systems
not only for "command not find" (usual ENOENT from execve())
but also for swapon failure:
swapon: /tmp/5Q4kqc/file_swap: swapon failed: Invalid argument
copy_file_range02.c:89: CONF: swapon binary not installed

+ improve info message for syscall tests

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/copy_file_range/copy_file_range.h   | 2 +-
 testcases/kernel/syscalls/copy_file_range/copy_file_range02.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
index c7f423e45..24e08e390 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
@@ -41,7 +41,7 @@ static void syscall_info(void)
 		tst_res(TINFO, "Testing libc copy_file_range()");
 		break;
 	case 1:
-		tst_res(TINFO, "Testing tst copy_file_range()");
+		tst_res(TINFO, "Testing __NR_copy_file_range syscall");
 	}
 }
 
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index 26bfa008a..472dffdc6 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -86,7 +86,7 @@ static int run_command(char *command, char *option, char *file)
 	case 0:
 	return 0;
 	case 255:
-		tst_res(TCONF, "%s binary not installed", command);
+		tst_res(TCONF, "%s binary not installed or failed", command);
 	return 1;
 	default:
 		tst_res(TCONF, "%s exited with %i", command, ret);
-- 
2.22.0

