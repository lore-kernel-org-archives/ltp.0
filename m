From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 29 Jun 2021 08:27:06 +0100
Subject: [LTP] [PATCH 3/7] meltdown: Set CFLAGS for check targets
In-Reply-To: <20210629072710.23800-1-rpalethorpe@suse.com>
References: <20210629072710.23800-1-rpalethorpe@suse.com>
Message-ID: <20210629072710.23800-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The include set in the CFLAGS is necessary for Sparse to parse the
test source. If a specific target has variables set on it. Then these
won't be available to the corresponding check-target. Usually this is
not a problem because most variables set on a target are just for
linking and the checker doesn't need them.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/cve/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index ddf8b6fe1..7b011b6c9 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -19,6 +19,7 @@ cve-2014-0196:  LDLIBS += -lutil
 endif
 
 meltdown: CFLAGS += -I$(abs_srcdir)/../realtime/include
+check-meltdown: CFLAGS += -I$(abs_srcdir)/../realtime/include
 
 ifneq (,$(filter $(HOST_CPU),x86 x86_64))
 meltdown: CFLAGS += -msse2
-- 
2.31.1

