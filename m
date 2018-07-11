From: Alistair Strachan <astrachan@google.com>
Date: Wed, 11 Jul 2018 09:49:25 -0700
Subject: [LTP] [PATCH] pounder21: Replace {r,}index() with str{r,}chr()
In-Reply-To: <20180711164925.65342-1-astrachan@google.com>
References: <20180703091057.pfvdfxelb2u6cewi@dell5510>
 <20180711164925.65342-1-astrachan@google.com>
Message-ID: <20180711164925.65342-2-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The index() and rindex() functions were removed in POSIX.2008. They are
not implemented by Android's bionic C library for 64-bit platforms.

Use the more portable strchr() and strrchr() functions from C89.

Affects fancy_timed_loop, infinite_loop, run-helper, and timed_loop
targets.

Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 tools/pounder21/fancy_timed_loop.c | 4 ++--
 tools/pounder21/infinite_loop.c    | 4 ++--
 tools/pounder21/run.c              | 6 +++---
 tools/pounder21/timed_loop.c       | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/pounder21/fancy_timed_loop.c b/tools/pounder21/fancy_timed_loop.c
index ac3e204d1..f88be3df8 100644
--- a/tools/pounder21/fancy_timed_loop.c
+++ b/tools/pounder21/fancy_timed_loop.c
@@ -93,14 +93,14 @@ int main(int argc, char *argv[])
 	out = stdout;
 
 	if (use_max_failures) {
-		progname = rindex(argv[7], '/');
+		progname = strrchr(argv[7], '/');
 		if (progname == NULL) {
 			progname = argv[7];
 		} else {
 			progname++;
 		}
 	} else {
-		progname = rindex(argv[5], '/');
+		progname = strrchr(argv[5], '/');
 		if (progname == NULL) {
 			progname = argv[5];
 		} else {
diff --git a/tools/pounder21/infinite_loop.c b/tools/pounder21/infinite_loop.c
index fbe4289ac..e1a0d3dfb 100644
--- a/tools/pounder21/infinite_loop.c
+++ b/tools/pounder21/infinite_loop.c
@@ -78,14 +78,14 @@ int main(int argc, char *argv[])
 	out = stdout;
 
 	if (use_max_failures) {
-		progname = rindex(argv[3], '/');
+		progname = strrchr(argv[3], '/');
 		if (progname == NULL) {
 			progname = argv[3];
 		} else {
 			progname++;
 		}
 	} else {
-		progname = rindex(argv[1], '/');
+		progname = strrchr(argv[1], '/');
 		if (progname == NULL) {
 			progname = argv[1];
 		} else {
diff --git a/tools/pounder21/run.c b/tools/pounder21/run.c
index dec2d3fe7..5f5903c45 100644
--- a/tools/pounder21/run.c
+++ b/tools/pounder21/run.c
@@ -167,7 +167,7 @@ int main(int argc, char *argv[])
 		retcode = process_dir(argv[1]);
 	} else {
 		if (is_executable(argv[1])) {
-			c = rindex(argv[1], '/');
+			c = strrchr(argv[1], '/');
 			c++;
 
 			// Start the test
@@ -495,7 +495,7 @@ static pid_t spawn_test(char *fname)
 			 getenv("POUNDER_LOGDIR"), fname);
 
 		fd = strlen(buf2);
-		for (tmp = (index(buf2, '|') - buf2); tmp < fd; tmp++) {
+		for (tmp = (strchr(buf2, '|') - buf2); tmp < fd; tmp++) {
 			if (buf2[tmp] == '/') {
 				buf2[tmp] = '-';
 			} else if (buf2[tmp] == '|') {
@@ -541,7 +541,7 @@ static pid_t spawn_test(char *fname)
 		snprintf(buf2, TEST_PATH_LEN, "%s/%s", buf, fname);
 
 		// find the location of the last slash
-		last_slash = rindex(buf2, '/');
+		last_slash = strrchr(buf2, '/');
 
 		if (last_slash != NULL) {
 			// copy the filename part into a new buffer
diff --git a/tools/pounder21/timed_loop.c b/tools/pounder21/timed_loop.c
index 51ceac5f2..3dffba0dc 100644
--- a/tools/pounder21/timed_loop.c
+++ b/tools/pounder21/timed_loop.c
@@ -95,14 +95,14 @@ int main(int argc, char *argv[])
 	out = stdout;
 
 	if (use_max_failures) {
-		progname = rindex(argv[4], '/');
+		progname = strrchr(argv[4], '/');
 		if (progname == NULL) {
 			progname = argv[4];
 		} else {
 			progname++;
 		}
 	} else {
-		progname = rindex(argv[2], '/');
+		progname = strrchr(argv[2], '/');
 		if (progname == NULL) {
 			progname = argv[2];
 		} else {
