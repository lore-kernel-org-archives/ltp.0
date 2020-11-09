From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Mon, 9 Nov 2020 07:34:31 -0500
Subject: [LTP] [PATCH] pan/ltp-pan.c: fix file descriptors leaks
Message-ID: <1604925271-4811-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ltp-pan will leak file descriptors of fopen() into the child process
of the test case, fix this problem by using mode "e" for fopen().

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 pan/ltp-pan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 8b9fbe5..25e554f 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -336,7 +336,7 @@ int main(int argc, char **argv)
 		if (!strcmp(logfilename, "-")) {
 			logfile = stdout;
 		} else {
-			if ((logfile = fopen(logfilename, "a+")) == NULL) {
+			if ((logfile = fopen(logfilename, "a+e")) == NULL) {
 				fprintf(stderr,
 					"pan(%s): Error %s (%d) opening log file '%s'\n",
 					panname, strerror(errno), errno,
@@ -453,7 +453,7 @@ int main(int argc, char **argv)
 	}
 
 	if (failcmdfilename) {
-		if (!(failcmdfile = fopen(failcmdfilename, "a+"))) {
+		if (!(failcmdfile = fopen(failcmdfilename, "a+e"))) {
 			fprintf(stderr,
 				"pan(%s): Error %s (%d) opening fail cmd file '%s'\n",
 				panname, strerror(errno), errno,
@@ -463,7 +463,7 @@ int main(int argc, char **argv)
 	}
 
 	if (tconfcmdfilename) {
-		tconfcmdfile = fopen(tconfcmdfilename, "a+");
+		tconfcmdfile = fopen(tconfcmdfilename, "a+e");
 		if (!tconfcmdfile) {
 			fprintf(stderr, "pan(%s): Error %s (%d) opening "
 				"tconf cmd file '%s'\n", panname,
-- 
1.8.3.1



