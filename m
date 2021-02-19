From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Feb 2021 08:59:06 +0100
Subject: [LTP] [PATCH 1/1] cve-2015-3290: Add -fomit-frame-pointer
Message-ID: <20210219075906.23914-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Which is not enabled by default on some toolchains.

Fixes: #313

Reported-by: Patrick McCarty <patrick.mccarty@intel.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested manually, but sure going through CI as well
https://travis-ci.org/github/pevik/ltp/builds/759603151

 testcases/cve/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index da44fff60..63b1d7525 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -45,6 +45,6 @@ endif
 cve-2017-17052:	CFLAGS += -pthread
 cve-2017-17053:	CFLAGS += -pthread
 
-cve-2015-3290:	CFLAGS += -pthread
+cve-2015-3290:	CFLAGS += -pthread -fomit-frame-pointer
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.30.0

