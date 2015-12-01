From: Li Jin <King.lijin@huawei.com>
Date: Tue, 1 Dec 2015 16:13:46 +0800
Subject: [LTP] [V2][PATCH] Fix wrong pattern used by fnmatch in test case
	proc01.c
Message-ID: <1448957626-155721-1-git-send-email-King.lijin@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A single "*" can not be used to match the any string in fnmatch.
Therefore, fnmatch() in proc01.c should use pattern ipv6/conf/?*/stable_secret
to replace /ipv6/conf/*/stable_secret to check the known issue string such as
/proc/sys/net/ipv6/conf/all/stable_secret.

Signed-off-by: Li Jin <King.lijin@huawei.com>
---

Notes:
    v1 --> v2
    
    1. /proc/sys/net/ipv6/conf/[a-z]*/stable_secret -->
       /proc/sys/net/ipv6/conf/?*/stable_secret

 testcases/kernel/fs/proc/proc01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 2825b51..c1f1164 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -107,7 +107,7 @@ static const struct mapping known_issues[] = {
 	{"read", "/proc/fs/nfsd/.getfs", EINVAL},
 	{"read", "/proc/fs/nfsd/.getfd", EINVAL},
 	{"read", "/proc/self/net/rpc/use-gss-proxy", EAGAIN},
-	{"read", "/proc/sys/net/ipv6/conf/*/stable_secret", EIO},
+	{"read", "/proc/sys/net/ipv6/conf/?*/stable_secret", EIO},
 	{"", "", 0}
 };
 
-- 
1.9.1

