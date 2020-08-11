From: Yuan Gao <aiden.gaoyuan@gmail.com>
Date: Tue, 11 Aug 2020 18:06:04 +0000
Subject: [LTP] [PATCH v2 1/3] hotplug/memory_hotplug: Handle NULL returned
 by strtok_r when parsing inputs
Message-ID: <20200811180604.4073173-1-aiden.gaoyuan@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In the original version of memtoy, it uses strtok_r(args, " ", &nextarg)
to split string. When strtok_r finds the last substring to be split,
it will set nextarg to NULL rather than let it point to '\0'.
In this case, if it wants to do something else to nextarg like calling
strspn(nextarg, " "), it will throw an error.
Add NULL check for nextarg to fix this error.

Change from v1
1. Replace strlen() with strnlen()

Signed-off-by: Yuan Gao <aiden.gaoyuan@gmail.com>
---
 .../kernel/hotplug/memory_hotplug/commands.c  | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index e31743bd3..e3438e132 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -50,6 +50,7 @@
 
 #define CMD_SUCCESS 0
 #define CMD_ERROR   1
+#define CMDBUFSZ 256
 
 #ifndef __NR_migrate_pages
 #define __NR_migrate_pages 0
@@ -61,6 +62,11 @@
 
 static char *whitespace = " \t";
 
+inline char *get_next_arg(char *args, char *nextarg)
+{
+	return nextarg ? nextarg + strspn(nextarg, whitespace) : args + strnlen(args, CMDBUFSZ);
+}
+
 /*
  * =========================================================================
  */
@@ -146,7 +152,7 @@ static int get_range(char *args, range_t * range, char **nextarg)
 		range->offset = get_scaled_value(args, "offset");
 		if (range->offset == BOGUS_SIZE)
 			return CMD_ERROR;
-		args = nextarg + strspn(nextarg, whitespace);
+		args = get_next_arg(args, nextarg);
 
 		/*
 		 * <length> ... only if offset specified
@@ -160,7 +166,7 @@ static int get_range(char *args, range_t * range, char **nextarg)
 					return CMD_ERROR;
 			} else
 				range->length = 0;	/* map to end of file */
-			args = nextarg + strspn(nextarg, whitespace);
+			args = get_next_arg(args, nextarg);
 		}
 	}
 
@@ -669,7 +675,7 @@ static int anon_seg(char *args)
 	range.length = get_scaled_value(args, "size");
 	if (range.length == BOGUS_SIZE)
 		return CMD_ERROR;
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	if (*args != '\0') {
 		segflag = get_shared(args);
@@ -699,7 +705,7 @@ static int file_seg(char *args)
 	if (!required_arg(args, "<path-name>"))
 		return CMD_ERROR;
 	pathname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
@@ -757,7 +763,7 @@ static int touch_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
@@ -788,7 +794,7 @@ static int unmap_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	if (!segment_unmap(segname))
 		return CMD_ERROR;
@@ -812,7 +818,7 @@ static int map_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
@@ -856,7 +862,7 @@ static int mbind_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
@@ -871,7 +877,7 @@ static int mbind_seg(char *args)
 	if (policy < 0)
 		return CMD_ERROR;
 
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 	if (*args == '+') {
 		flags = get_mbind_flags(++args, &nextarg);
 		if (flags == -1)
@@ -914,7 +920,7 @@ static int shmem_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	if (!required_arg(args, "<size>"))
 		return CMD_ERROR;
@@ -922,7 +928,7 @@ static int shmem_seg(char *args)
 	range.length = get_scaled_value(args, "size");
 	if (range.length == BOGUS_SIZE)
 		return CMD_ERROR;
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	if (!segment_register(SEGT_SHM, segname, &range, MAP_SHARED))
 		return CMD_ERROR;
@@ -954,7 +960,7 @@ static int where_seg(char *args)
 	if (!required_arg(args, "<seg-name>"))
 		return CMD_ERROR;
 	segname = strtok_r(args, whitespace, &nextarg);
-	args = nextarg + strspn(nextarg, whitespace);
+	args = get_next_arg(args, nextarg);
 
 	/*
 	 * offset, length are optional
@@ -1107,7 +1113,6 @@ static int help_me(char *args)
 /*
  * =========================================================================
  */
-#define CMDBUFSZ 256
 
 static bool unique_abbrev(char *cmd, size_t clen, struct command *cmdp)
 {
-- 
2.28.0.236.gb10cc79966-goog

