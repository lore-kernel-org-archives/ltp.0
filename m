From: aidengao <aiden.gaoyuan@gmail.com>
Date: Mon, 27 Jul 2020 16:44:01 +0000
Subject: [LTP] [PATCH 1/3] hotplug/memory_hotplug: Handle NULL returned by
 strtok_r when parsing inputs
Message-ID: <20200727164403.1177686-1-aiden.gaoyuan@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: aidengao <aidengao@google.com>

In the original version of memtoy, it uses strtok_r(args, " ", &nextarg)
to split string. When strtok_r finds the last substring to be split,
it will set nextarg to NULL rather than let it point to '\0'.
In this case, if it wants to do something else to nextarg like calling
strspn(nextarg, " "), it will throw an error.
Add NULL check for nextarg to fix this error.

Signed-off-by: Yuan Gao <aiden.gaoyuan@gmail.com>
---
 .../kernel/hotplug/memory_hotplug/commands.c  | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index e31743bd3..2e8972c1c 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -61,6 +61,11 @@
 
 static char *whitespace = " \t";
 
+inline char *get_next_arg(char *args, char *nextarg)
+{
+	return nextarg ? nextarg + strspn(nextarg, whitespace) : args + strlen(args);
+}
+
 /*
  * =========================================================================
  */
@@ -146,7 +151,7 @@ static int get_range(char *args, range_t * range, char **nextarg)
 		range->offset = get_scaled_value(args, "offset");
 		if (range->offset == BOGUS_SIZE)
 			return CMD_ERROR;
-		args = nextarg + strspn(nextarg, whitespace);
+		args = get_next_arg(args, nextarg);
 
 		/*
 		 * <length> ... only if offset specified
@@ -160,7 +165,7 @@ static int get_range(char *args, range_t * range, char **nextarg)
 					return CMD_ERROR;
 			} else
 				range->length = 0;	/* map to end of file */
-			args = nextarg + strspn(nextarg, whitespace);
+			args = get_next_arg(args, nextarg);
 		}
 	}
 
@@ -669,7 +674,7 @@ static int anon_seg(char *args)
 	range.length = get_scaled_value(args, "size");
 	if (range.length == BOGUS_SIZE)
 		return CMD_ERROR;
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	if (*args != '\0') {
 		segflag = get_shared(args);
@@ -699,7 +704,7 @@ static int file_seg(char *args)
 	if (!required_arg(args, "<path-name>"))
 		return CMD_ERROR;
 	pathname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
@@ -757,7 +762,7 @@ static int touch_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
@@ -788,7 +793,7 @@ static int unmap_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	if (!segment_unmap(segname))
 		return CMD_ERROR;
@@ -812,7 +817,7 @@ static int map_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
@@ -856,7 +861,7 @@ static int mbind_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
@@ -871,7 +876,7 @@ static int mbind_seg(char *args)
 	if (policy < 0)
 		return CMD_ERROR;
 
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 	if (*args == '+') {
 		flags = get_mbind_flags(++args, &nextarg);
 		if (flags == -1)
@@ -914,7 +919,7 @@ static int shmem_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	if (!required_arg(args, "<size>"))
 		return CMD_ERROR;
@@ -922,7 +927,7 @@ static int shmem_seg(char *args)
 	range.length = get_scaled_value(args, "size");
 	if (range.length == BOGUS_SIZE)
 		return CMD_ERROR;
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	if (!segment_register(SEGT_SHM, segname, &range, MAP_SHARED))
 		return CMD_ERROR;
@@ -954,7 +959,7 @@ static int where_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
-- 
2.28.0.rc0.142.g3c755180ce-goog

