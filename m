From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  2 Aug 2019 17:04:43 +0200
Subject: [LTP] [PATCH v2 2/4] utils/ffsb: Add missing fhstat() signature +
 includes
In-Reply-To: <20190802150445.10984-1-pvorel@suse.cz>
References: <20190802150445.10984-1-pvorel@suse.cz>
Message-ID: <20190802150445.10984-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Need for build with -Werror-implicit-function-declaration

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
To be hones I'd rather delete this The Flexible Filesystem Benchmark
(FFSB) (in utils/ffsb-6.0-rc2). Does anyone uses it?
If kept, I'd prefer to have it as a separate project in [1]

I probably have asked before and there is a paper from 2012 suggesting
that someone used it 7 years ago [2][3]. There is also a fork, with just a
few patches, no development now [4].

[1] https://github.com/linux-test-project/ffsb
[2] https://elinux.org/images/f/f7/FFSB_and_IOzone-_File_system_Benchmarking_Tools%2C_Features_and_Internals.pdf
[3] https://www.youtube.com/watch?v=jFhrteWcahI
[4] https://github.com/FFSB-Prime/ffsb

 utils/ffsb-6.0-rc2/fh.h      | 2 ++
 utils/ffsb-6.0-rc2/fileops.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/utils/ffsb-6.0-rc2/fh.h b/utils/ffsb-6.0-rc2/fh.h
index 23a198bb8..29410c7ce 100644
--- a/utils/ffsb-6.0-rc2/fh.h
+++ b/utils/ffsb-6.0-rc2/fh.h
@@ -19,6 +19,7 @@
 #define _FH_H_
 
 #include <inttypes.h>
+#include "ffsb_thread.h"
 
 struct ffsb_thread;
 struct ffsb_fs;
@@ -29,6 +30,7 @@ int fhopencreate(char *, struct ffsb_thread *, struct ffsb_fs *);
 int fhopenappend(char *, struct ffsb_thread *, struct ffsb_fs *);
 
 void fhread(int, void *, uint64_t, struct ffsb_thread *, struct ffsb_fs *);
+void fhstat(char *name, ffsb_thread_t * ft, ffsb_fs_t * fs);
 
 /* can only write up to size_t bytes at a time, so size is a uint32_t */
 void fhwrite(int, void *, uint32_t, struct ffsb_thread *, struct ffsb_fs *);
diff --git a/utils/ffsb-6.0-rc2/fileops.c b/utils/ffsb-6.0-rc2/fileops.c
index 3212c18b2..72e133a13 100644
--- a/utils/ffsb-6.0-rc2/fileops.c
+++ b/utils/ffsb-6.0-rc2/fileops.c
@@ -30,6 +30,7 @@
 #include "ffsb.h"
 #include "fileops.h"
 #include "ffsb_op.h"
+#include "ffsb_thread.h"
 
 static void do_stats(struct timeval *start, struct timeval *end,
 		     ffsb_thread_t * ft, ffsb_fs_t * fs, syscall_t sys)
-- 
2.22.0

