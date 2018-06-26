From: Alistair Strachan <astrachan@google.com>
Date: Tue, 26 Jun 2018 09:45:52 -0700
Subject: [LTP] [PATCH] cpuset: Work around a clang compiler warning
Message-ID: <20180626164552.90133-1-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The clang compiler will warn about pasting a C string literal and an
int, suggesting that array indexing should be used instead:

testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c:143:3: error:
 adding 'int' to a string does not append to the string
 [-Werror,-Wstring-plus-int]
  while_each_childdir(SYS_CPU_DIR, "/", c_relpath,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
testcases/kernel/controllers/cpuset/cpuset_lib/common.h:54:13: note:
 expanded from macro 'while_each_childdir'
  p_relpath + start); \
  ~~~~~~~~~~^~~~~~~
testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c:143:3: note:
 use array indexing to silence this warning

This seems like a strange warning, but the suggestion has no effect on
code generation or readability, so change it to keep clang happy.

Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 testcases/kernel/controllers/cpuset/cpuset_lib/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/common.h b/testcases/kernel/controllers/cpuset/cpuset_lib/common.h
index bd347413c..28e948e63 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/common.h
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/common.h
@@ -51,7 +51,7 @@
 		start = 1;						\
 									\
 	snprintf(fullpath, sizeof(fullpath), "%s%s", basepath,		\
-		p_relpath + start);					\
+		 &p_relpath[start]);					\
 	pathlen = strlen(fullpath);					\
 									\
 	if ((dp = opendir(fullpath)) == NULL)				\
