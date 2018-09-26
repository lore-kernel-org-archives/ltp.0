From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Wed, 26 Sep 2018 11:15:45 -0300
Subject: [LTP] [PATCH v2] statx: fix compile errors
In-Reply-To: <20180919044813.22875-1-liwang@redhat.com>
References: <20180919044813.22875-1-liwang@redhat.com>
Message-ID: <20180926141545.3396-1-cascardo@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

struct statx is only defined in sys/stat.h when _GNU_SOURCE is defined.
The testcases do define _GNU_SOURCE, but not the m4 struct check.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 m4/ltp-statx.m4 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/m4/ltp-statx.m4 b/m4/ltp-statx.m4
index 44303d3..5f79a94 100644
--- a/m4/ltp-statx.m4
+++ b/m4/ltp-statx.m4
@@ -23,6 +23,11 @@ dnl
 AC_DEFUN([LTP_CHECK_STATX],[
 AC_CHECK_FUNCS(statx,,,[[#include <sys/stat.h>]])
 AC_CHECK_HEADER(linux/fs.h,,,)
-AC_CHECK_TYPES([struct statx],,,[[#include <sys/stat.h>]])
-AC_CHECK_TYPES([struct statx_timestamp],,,[[#include <sys/stat.h>]])
+AC_CHECK_TYPES([struct statx],,,[[
+	#define _GNU_SOURCE
+	#include <sys/stat.h>
+]])
+AC_CHECK_TYPES([struct statx_timestamp],,,[[
+	#define _GNU_SOURCE
+	#include <sys/stat.h>]])
 ])
-- 
2.17.1

