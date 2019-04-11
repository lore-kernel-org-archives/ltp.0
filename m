From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Apr 2019 01:31:13 +0200
Subject: [LTP] [RFC PATCH 1/3] cve/cve-2014-0196: Don't use libutil for
	Android
In-Reply-To: <20190411233115.32744-1-pvorel@suse.cz>
References: <20190411233115.32744-1-pvorel@suse.cz>
Message-ID: <20190411233115.32744-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

as it's not available for it.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/cve/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 6dc401cff..da44fff60 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -27,7 +27,11 @@ cve-2016-7117:	CFLAGS += -pthread
 cve-2016-7117:	LDLIBS += -lrt
 
 cve-2014-0196:  CFLAGS += -pthread
-cve-2014-0196:  LDLIBS += -lrt -lutil
+cve-2014-0196:  LDLIBS += -lrt
+
+ifneq ($(ANDROID),1)
+cve-2014-0196:  LDLIBS += -lutil
+endif
 
 cve-2017-2671:	CFLAGS += -pthread
 cve-2017-2671:	LDLIBS += -lrt
-- 
2.20.1

