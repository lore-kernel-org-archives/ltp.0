Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lgliang@taco.beaverton.ibm.com>) id 1Qt2pf-0008ED-Bv
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:28:19 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qt2pe-0005c4-8E
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:28:19 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7FBJuO8011892
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 05:19:56 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7FIv98M172088
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 12:57:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p7FCugDR017189
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 06:56:42 -0600
From: Lucy Liang <lgliang@linux.vnet.ibm.com>
Date: Mon, 15 Aug 2011 11:56:33 -0700
Message-Id: <1313434593-7942-7-git-send-email-lgliang@linux.vnet.ibm.com>
In-Reply-To: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
References: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.4.1"
Subject: [LTP] [PATCH 7/7 ver2 w/attachment] Changes to pounder's loop
	procedures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.4.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Modified infinite_loop.c, timed_loop.c, and fancy_timed_loop.c
to include the max failures functionality. These loop procedures
are used to run certain programs repeatedly. The max failures
functionality set an upper bound on the number of times the
programs are allowed to fail before terminating the run entirely.

Signed-off-by: Lucy Liang <lgliang@linux.vnet.ibm.com>
---
 tools/pounder21/fancy_timed_loop.c |   92 +++++++++++++++++++++++++++++-------
 tools/pounder21/infinite_loop.c    |   73 +++++++++++++++++++++++-----
 tools/pounder21/timed_loop.c       |   81 ++++++++++++++++++++++++++------
 3 files changed, 200 insertions(+), 46 deletions(-)


--------------1.7.4.1
Content-Type: text/x-patch;
	name="0007-Changes-to-pounder-s-loop-procedures.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0007-Changes-to-pounder-s-loop-procedures.patch"

diff --git a/tools/pounder21/fancy_timed_loop.c b/tools/pounder21/fancy_timed_loop.c
index 35260d8..7f4deb4 100644
--- a/tools/pounder21/fancy_timed_loop.c
+++ b/tools/pounder21/fancy_timed_loop.c
@@ -56,12 +56,32 @@ int main(int argc, char *argv[]) {
 	struct sigaction zig;
 	uid_t uid;
 	gid_t gid;
+	int use_max_failures = 0;
+	int max_failures = 0;
+	int fail_counter = 1;
 
 	if (argc < 5) {
-		printf("Usage: %s time_in_sec uid gid signal command [args]\n", argv[0]);
+		printf("Usage: %s [-m max_failures] time_in_sec uid gid signal command [args]\n", argv[0]);
 		exit(1);
 	}
 
+	//by default, set max_failures to whatever the env variable $MAX_FAILURES is
+        char *max_failures_env = getenv("MAX_FAILURES");
+        max_failures = atoi(max_failures_env);
+
+	//if the -m option is used when calling fancy_timed_loop, override max_failures
+	//specified by $MAX_FAILURES with the given argument instead
+	if (argc > 6 && strcmp(argv[1], "-m") == 0) {
+		if ((max_failures = atoi(argv[2])) >= 0) {
+			use_max_failures = 1;
+		}
+		else {
+			printf("Usage: %s [-m max_failures] time_in_sec uid gid signal command [args]\n", argv[0]);
+			printf("max_failures should be a nonnegative integer\n");
+			exit(1);
+		}
+	}
+
 	tty_fp = fdopen(3, "w+");
 	if (tty_fp == NULL) {
 		tty_fp = fopen("/dev/tty", "w+");
@@ -71,11 +91,21 @@ int main(int argc, char *argv[]) {
 		}
 	}
 
-	progname = rindex(argv[5], '/');
-	if (progname == NULL) {
-		progname = argv[5];
-	} else {
-		progname++;
+	if (use_max_failures) {
+		progname = rindex(argv[7], '/');
+		if (progname == NULL) {
+			progname = argv[7];
+		} else {
+			progname++;
+		}
+	}
+	else {
+		progname = rindex(argv[5], '/');
+		if (progname == NULL) {
+			progname = argv[5];
+		} else {
+			progname++;
+		}
 	}
 
 	/* Set up signals */
@@ -89,12 +119,22 @@ int main(int argc, char *argv[]) {
 	/* set up process groups so that we can kill the
 	 * loop test and descendants easily */
 
-	secs = atoi(argv[1]);
-	alarm(secs);
+	if (use_max_failures) {
+		secs = atoi(argv[3]);
+		alarm(secs);
 
-	the_signal = atoi(argv[4]);
-	uid = atoi(argv[2]);
-	gid = atoi(argv[3]);
+		the_signal = atoi(argv[6]);
+		uid = atoi(argv[4]);
+		gid = atoi(argv[5]);
+	}
+	else {
+		secs = atoi(argv[1]);
+		alarm(secs);
+
+		the_signal = atoi(argv[4]);
+		uid = atoi(argv[2]);
+		gid = atoi(argv[3]);
+	}
 
 	pounder_fprintf(tty_fp, "%s: uid = %d, gid = %d, sig = %d\n",
 		progname, uid, gid, the_signal);
@@ -121,13 +161,24 @@ int main(int argc, char *argv[]) {
 			}
 
 			// run the program
-			if (argc > 3) {
-				stat = execvp(argv[5], &argv[5]);
-			} else {
-				stat = execvp(argv[5], &argv[5]);
+			if (use_max_failures) {
+				if (argc > 5) {
+					stat = execvp(argv[7], &argv[7]);
+				} else {
+					stat = execvp(argv[7], &argv[7]);
+				}
+				
+				perror(argv[7]);
+			}
+			else {	
+				if (argc > 3) {
+					stat = execvp(argv[5], &argv[5]);
+				} else {
+					stat = execvp(argv[5], &argv[5]);
+				}
+
+				perror(argv[5]);
 			}
-
-			perror(argv[5]);
 
 			exit(-1);
 		}
@@ -158,7 +209,12 @@ int main(int argc, char *argv[]) {
 			} else {
 				pounder_fprintf(tty_fp, "%s: %s with code %d.\n",
 					progname, fail_msg, res);
+				if (max_failures > 0) {
+					if (++fail_counter > max_failures) {
+						exit(-1);
+					}
+				}
 			}
 		}
 	}
-}
\ No newline at end of file
+}
diff --git a/tools/pounder21/infinite_loop.c b/tools/pounder21/infinite_loop.c
index 1c67bc8..4d151b1 100644
--- a/tools/pounder21/infinite_loop.c
+++ b/tools/pounder21/infinite_loop.c
@@ -46,12 +46,32 @@ int main(int argc, char *argv[]) {
 	pid_t pid;
 	struct sigaction zig;
 	unsigned int revs = 0;
+	int use_max_failures = 0;
+	int max_failures = 0;
+	int fail_counter = 1;
 
 	if (argc < 2) {
-		printf("Usage: %s command [args]\n", argv[0]);
+		printf("Usage: %s [-m max_failures] command [args]\n", argv[0]);
 		exit(1);
 	}
 
+	//by default, set max_failures to whatever the env variable $MAX_FAILURES is
+        char *max_failures_env = getenv("MAX_FAILURES");
+        max_failures = atoi(max_failures_env);
+
+	//if the -m option is used when calling infinite_loop, override max_failures
+	//specified by $MAX_FAILURES with the given argument instead
+	if (argc > 3 && strcmp(argv[1], "-m") == 0) {
+		if((max_failures = atoi(argv[2])) >= 0) {
+			use_max_failures = 1;
+		}
+		else {
+			printf("Usage: %s [-m max_failures] command [args]\n", argv[0]);
+			printf("max_failures should be a nonnegative integer\n");
+			exit(1);
+		}
+	}
+
 	tty_fp = fdopen(3, "w+");
 	if (tty_fp == NULL) {
 		tty_fp = fopen("/dev/tty", "w+");
@@ -61,11 +81,21 @@ int main(int argc, char *argv[]) {
 		}
 	}
 
-	progname = rindex(argv[1], '/');
-	if (progname == NULL) {
-		progname = argv[1];
-	} else {
-		progname++;
+	if (use_max_failures) {
+		progname = rindex(argv[3], '/');
+		if (progname == NULL) {
+			progname = argv[3];
+		} else {
+			progname++;
+		}
+	}
+	else {
+		progname = rindex(argv[1], '/');
+		if (progname == NULL) {
+			progname = argv[1];
+		} else {
+			progname++;
+		}
 	}
 
 	/* Set up signals */
@@ -86,13 +116,24 @@ int main(int argc, char *argv[]) {
 			}
 
 			// run the program
-			if (argc > 3) {
-				stat = execvp(argv[1], &argv[1]);
-			} else {
-				stat = execvp(argv[1], &argv[1]);
+			if (use_max_failures) {	
+				if (argc > 5) {
+					stat = execvp(argv[3], &argv[3]);
+				} else {
+					stat = execvp(argv[3], &argv[3]);
+				}
+
+				perror(argv[3]);
+			}
+			else {
+				if (argc > 3) {
+					stat = execvp(argv[1], &argv[1]);
+				} else {
+					stat = execvp(argv[1], &argv[1]);
+				}
+
+				perror(argv[1]);
 			}
-
-			perror(argv[1]);
 
 			exit(-1);
 		}
@@ -123,7 +164,13 @@ int main(int argc, char *argv[]) {
 			} else {
 				pounder_fprintf(tty_fp, "%s: %s with code %d.\n",
 					progname, fail_msg, res);
+				if (max_failures > 0) {
+					if(++fail_counter > max_failures) {
+						pounder_fprintf("Reached max number of failures allowed: %d. Aborting.", max_failures);
+						exit(-1);
+					}
+				}
 			}
 		}
 	}
-}
\ No newline at end of file
+}
diff --git a/tools/pounder21/timed_loop.c b/tools/pounder21/timed_loop.c
index e2fe6a7..8e2d536 100644
--- a/tools/pounder21/timed_loop.c
+++ b/tools/pounder21/timed_loop.c
@@ -58,12 +58,32 @@ int main(int argc, char *argv[]) {
 	pid_t pid;
 	unsigned int revs = 0;
 	struct sigaction zig;
+	int use_max_failures = 0;
+	int max_failures = 0;
+	int fail_counter = 1;
 
 	if (argc < 3) {
-		printf("Usage: %s time_in_sec command [args]\n", argv[0]);
+		printf("Usage: %s [-m max_failures] time_in_sec command [args]\n", argv[0]);
 		exit(1);
 	}
 
+	//by default, set max_failures to whatever the env variable $MAX_FAILURES is
+        char *max_failures_env = getenv("MAX_FAILURES");
+        max_failures = atoi(max_failures_env);
+
+	//if the -m option is used when calling timed_loop, override max_failures
+	//specified by $MAX_FAILURES with the given argument instead
+	if (argc > 4 && strcmp(argv[1], "-m") == 0) {
+		if ((max_failures = atoi(argv[2])) >= 0) {	
+			use_max_failures = 1;
+		}
+		else {
+			printf("Usage: %s [-m max_failures] time_in_sec command [args]\n", argv[0]);
+			printf("max_failures should be a nonnegative integer\n");
+			exit(1);
+		}
+	}
+
 	tty_fp = fdopen(3, "w+");
 	if (tty_fp == NULL) {
 		tty_fp = fopen("/dev/tty", "w+");
@@ -73,11 +93,21 @@ int main(int argc, char *argv[]) {
 		}
 	}
 
-	progname = rindex(argv[2], '/');
-	if (progname == NULL) {
-		progname = argv[2];
-	} else {
-		progname++;
+	if (use_max_failures) {
+		progname = rindex(argv[4], '/');
+		if (progname == NULL) {
+			progname = argv[4];
+		} else {
+			progname++;
+		}
+	}
+	else {
+		progname = rindex(argv[2], '/');
+		if (progname == NULL) {
+			progname = argv[2];
+		} else {
+			progname++;
+		}
 	}
 
 	/* Set up signals */
@@ -91,7 +121,12 @@ int main(int argc, char *argv[]) {
 	/* set up process groups so that we can kill the
 	 * loop test and descendants easily */
 
-	secs = atoi(argv[1]);
+	if (use_max_failures) {
+		secs = atoi(argv[3]);
+	}
+	else {
+		secs = atoi(argv[1]);
+	}
 	alarm(secs);
 
 	while (1) {
@@ -103,13 +138,24 @@ int main(int argc, char *argv[]) {
 			}
 
 			// run the program
-			if (argc > 3) {
-				stat = execvp(argv[2], &argv[2]);
-			} else {
-				stat = execvp(argv[2], &argv[2]);
+			if (use_max_failures) {
+				if (argc > 5) {
+					stat = execvp(argv[4], &argv[4]);
+				} else {
+					stat = execvp(argv[4], &argv[4]);
+				}
+
+				perror(argv[4]);
+			}
+			else {
+				if (argc > 3) {
+					stat = execvp(argv[2], &argv[2]);
+				} else {
+					stat = execvp(argv[2], &argv[2]);
+				}
+
+				perror(argv[2]);
 			}
-
-			perror(argv[2]);
 
 			exit(-1);
 		}
@@ -133,14 +179,19 @@ int main(int argc, char *argv[]) {
 			if (res == 0) {
 				pounder_fprintf(tty_fp, "%s: %s.\n", progname, pass_msg);
 			} else if (res < 0 || res == 255) {
-				pounder_fprintf(tty_fp, "%s: %s with code %d.\n",
+				pounder_fprintf(tty_fp, "CHECK %s: %s with code %d.\n",
 					progname, abort_msg, res);
 				exit(-1);
 				// FIXME: add test to blacklist
 			} else {
 				pounder_fprintf(tty_fp, "%s: %s with code %d.\n",
 					progname, fail_msg, res);
+				if (max_failures > 0) {
+					if (++fail_counter > max_failures) {
+						exit(-1);
+					}
+				}
 			}
 		}
 	}
-}
\ No newline at end of file
+}

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.4.1--



