From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 28 Aug 2019 18:14:14 +0800
Subject: [LTP] [PATCH 1/2] runtest/syscalls: add set_mempolicy*
Message-ID: <1566987255-3010-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit 55ee8a5ad ("syscalls: Add set_mempolicy numa tests"),
these cases have been added into runtests/numa, but forget to add it
in runtest/syscalls.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index c41ba2a0d..1694ef147 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1177,6 +1177,11 @@ setitimer01 setitimer01
 setitimer02 setitimer02
 setitimer03 setitimer03
 
+set_mempolicy01 set_mempolicy01
+set_mempolicy02 set_mempolicy02
+set_mempolicy03 set_mempolicy03
+set_mempolicy04 set_mempolicy04
+
 setns01 setns01
 setns02 setns02
 
-- 
2.18.1



