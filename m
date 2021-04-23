From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Fri, 23 Apr 2021 17:59:29 +0800
Subject: [LTP] [PATCH] syscalls/getdents01: Add close() and open() at the
 end of run()
Message-ID: <20210423095929.5280-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the test run with the option of '-i', we need call close
and open at the end of run(), otherwist the test will fail,as follows:

$ getdents01 -i 2

tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
getdents.h:148: TINFO: Testing the SYS_getdents syscall
getdents01.c:109: TINFO: Found '.'
getdents01.c:109: TINFO: Found '..'
getdents01.c:109: TINFO: Found 'symlink'
getdents01.c:109: TINFO: Found 'file'
getdents01.c:109: TINFO: Found 'dir'
getdents01.c:149: TPASS: All entries found
getdents01.c:97: TFAIL: getdents failed - returned end of directory
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
getdents.h:151: TINFO: Testing the SYS_getdents64 syscall
getdents01.c:109: TINFO: Found '.'
getdents01.c:109: TINFO: Found '..'
getdents01.c:109: TINFO: Found 'dir'
getdents01.c:109: TINFO: Found 'symlink'
getdents01.c:109: TINFO: Found 'file'
getdents01.c:149: TPASS: All entries found
getdents01.c:97: TFAIL: getdents failed - returned end of directory
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
getdents.h:157: TCONF: libc getdents() is not implemented
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
getdents.h:162: TINFO: Testing libc getdents64()
getdents01.c:109: TINFO: Found '.'
getdents01.c:109: TINFO: Found '..'
getdents01.c:109: TINFO: Found 'dir'
getdents01.c:109: TINFO: Found 'symlink'
getdents01.c:109: TINFO: Found 'file'
getdents01.c:149: TPASS: All entries found
getdents01.c:97: TFAIL: getdents failed - returned end of directory

Summary:
passed   3
failed   3
broken   0
skipped  1
warnings 0

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/getdents/getdents01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index ef8f4e864..7982691a6 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -92,6 +92,9 @@ static void run(void)
 	} while (rval > 0);

 	check_flags();
+
+	SAFE_CLOSE(fd);
+	fd = SAFE_OPEN(".", O_RDONLY|O_DIRECTORY);
 }

 static void reset_flags(void)
--
2.17.1

