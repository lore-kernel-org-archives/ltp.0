From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Nov 2016 12:54:40 +0100
Subject: [LTP] [PATCH v2 2/3] kernel: minor cleanup in fs_bind TODO
In-Reply-To: <20161110115441.17301-1-pvorel@suse.cz>
References: <20161110115441.17301-1-pvorel@suse.cz>
Message-ID: <20161110115441.17301-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/fs/fs_bind/TODO | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/fs/fs_bind/TODO b/testcases/kernel/fs/fs_bind/TODO
index 567a33a..1730148 100644
--- a/testcases/kernel/fs/fs_bind/TODO
+++ b/testcases/kernel/fs/fs_bind/TODO
@@ -1,5 +1,3 @@
-Reuse http://ltp.cvs.sourceforge.net/*checkout*/ltp/ltp/testcases/kernel/containers/check_for_unshare.c to test for unshare (used in nsclone.c) ??
-
 Consider replacing long invocations
 	(replace "$FS_BIND_ROOT/bin/makedir") with something shorter).
 
-- 
2.10.2

