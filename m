From: Michael Moese <mmoese@suse.de>
Date: Wed, 26 Sep 2018 10:36:57 +0200
Subject: [LTP] [PATCH] add confXXXXX-directories to gitignore
Message-ID: <20180926083657.18807-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running the configure-script, a directory called confXXXXX is left
int the treee, always resulting in dirty working tree.
Adding this to .gitignore will get rid of these untracked files.

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index b838efd59..903d616b1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -21,6 +21,7 @@ autom4te.cache
 /config.mk
 /config.status
 /config.sub
+/conf*/
 /install-sh
 /missing
 /include/config.h
-- 
2.19.0

