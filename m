From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Mar 2017 13:29:19 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/access02: Fix test with busybox
Message-ID: <20170331112919.19425-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The problem here is that system executes '/bin/sh -c foo' then shell
tries to execute the filename but kernel does not recognize the
excutable format (of an empty file) hence libc fallbacks to
execvp('/bin/sh', argv[0], foo, ...) and because the filename in argv[0]
is passed as executable name it causes busybox return "applet does not
exist" error.

Hence we write "!/bin/sh" shebang to the executable file which tells the
shell that this is a shell script and we avoid running the execvp() in
the first place.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reported-by: Laurent GONZALEZ <ltp@gezedo.com>
---
 testcases/kernel/syscalls/access/access02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index 779e81a..86e0342 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -187,6 +187,7 @@ static void setup(void)
 	SAFE_TOUCH(FNAME_R, 0444, NULL);
 	SAFE_TOUCH(FNAME_W, 0222, NULL);
 	SAFE_TOUCH(FNAME_X, 0555, NULL);
+	SAFE_FILE_PRINTF(FNAME_X, "#!/bin/sh\n");
 
 	SAFE_SYMLINK(FNAME_F, SNAME_F);
 	SAFE_SYMLINK(FNAME_R, SNAME_R);
-- 
2.10.2

