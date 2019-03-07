From: Jan Baier <jbaier@suse.cz>
Date: Thu,  7 Mar 2019 19:37:28 +0100
Subject: [LTP] [PATCH v2] sysctl01: fix fails on live-patched kernels
Message-ID: <20190307183728.7659-1-jbaier@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

During live-patching, the uname syscall is overridden to reflect the
fact that the kernel has been live-patched. The version string
obtainable through /proc/sys/kernel/version is defined during
compilation and it is not touched by the live-patch. In this case, the
two interfaces can report different kernel versions.

Adjust the string from uname in such cases and remove the tag added
during live-patching.

Signed-off-by: Jan Baier <jbaier@suse.cz>
---
 testcases/kernel/syscalls/sysctl/sysctl01.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git testcases/kernel/syscalls/sysctl/sysctl01.c testcases/kernel/syscalls/sysctl/sysctl01.c
index 70905d806..9b4b1950c 100644
--- testcases/kernel/syscalls/sysctl/sysctl01.c
+++ testcases/kernel/syscalls/sysctl/sysctl01.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) 2019 SUSE.  All Rights Reserved.
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -77,6 +78,19 @@ static void setup(void)
 	/* get kernel name and information */
 	if (uname(&buf) == -1)
 		tst_brk(TBROK | TERRNO, "uname() failed");
+
+	/* revert uname change in case of kGraft/livepatch */
+	char *klp_tag;
+	char *right_brace;
+
+	klp_tag = strstr(buf.version, "/kGraft-");
+	if (!klp_tag)
+		klp_tag = strstr(buf.version, "/lp-");
+	if (klp_tag) {
+		right_brace = strchr(klp_tag, ')');
+		if (right_brace)
+			memmove(klp_tag, right_brace, sizeof(char) * (strlen(right_brace)+1));
+	}
 }
 
 static struct tst_test test = {
-- 
2.21.0

