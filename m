From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sun, 10 Jan 2021 21:04:36 +0800
Subject: [LTP] [RFC PATCH v2 2/2] syscalls/access02.c: Take use of
 TST_EXP_SILENT_PASS
In-Reply-To: <20210110130436.9514-1-yangx.jy@cn.fujitsu.com>
References: <X/R/2VVe1dJxGhHN@yuki.lan>
 <20210110130436.9514-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20210110130436.9514-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current TST_EXP_PASS macro reports the double passed for one subtest:
--------------------------------------------
tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
access02.c:62: TPASS: access(file_f, F_OK) as root passed
access02.c:141: TPASS: access(file_f, F_OK) as root behaviour is correct.
--------------------------------------------

It is just a minor cleanup rather than a fix.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/access/access02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index ff3e7b6f4..19bf87c54 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -59,7 +59,7 @@ static void access_test(struct tcase *tc, const char *user)
 	struct stat stat_buf;
 	char command[64];
 
-	TST_EXP_PASS(access(tc->pathname, tc->mode),
+	TST_EXP_SILENT_PASS(access(tc->pathname, tc->mode),
 	             "access(%s, %s) as %s", tc->pathname, tc->name, user);
 
 	if (!TST_PASS)
-- 
2.21.0



