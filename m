Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1ZRcOG-0003s2-6h
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 08:37:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRcOF-0001de-7D
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 08:37:04 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 2C8FF2F3
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Aug 2015 08:36:57 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp12-104.nay.redhat.com
	[10.66.12.104] (may be forged))
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t7I8amis026359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Aug 2015 04:36:55 -0400
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Aug 2015 16:36:45 +0800
Message-Id: <1439887006-17985-2-git-send-email-liwang@redhat.com>
In-Reply-To: <1439887006-17985-1-git-send-email-liwang@redhat.com>
References: <1439887006-17985-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH 2/3] ltp/pounder: Don't let the testing log output to
	/dev/tty
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

During the pounder21 test, it gives many errors like:

./pounder: line 262: /dev/tty: No such device or address
./pounder: line 263: /dev/tty: No such device or address

After google '/dev/tty', got this description:

/dev/tty is the controlling terminal for the current process, if there is such a terminal.
Do ps -a and look for /dev/tty. If it doesn't appear then that process doesn't have a
controlling terminal.  It is quite normal for there to be no controlling terminal. So if
there is no device associated with it then the kernel will just ignore anything you send
to that file. It only cares if it has attached a device (possibly pseudo) to that node. If
it does care, and echoing is on, then anything you send to the (special) file will be echoed.

The second part may be related to the login shell. Check in /etc/passwd and make sure that
you really do start bash for the user you are logging in as. Using /bin/sh instead is a likely cause.
So do grep username /etc/passwd and look for the path to the program that is launched at the end of
the text line. If its /bin/sh then you have the wrong shell. What you should have is /bin/bash.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 tools/pounder21/Install              |  2 +-
 tools/pounder21/fancy_timed_loop.c   |  2 +-
 tools/pounder21/infinite_loop.c      |  2 +-
 tools/pounder21/pounder              | 14 +++++++-------
 tools/pounder21/test_scripts/memtest |  2 +-
 tools/pounder21/timed_loop.c         |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/pounder21/Install b/tools/pounder21/Install
index bf13528..6fb3a8f 100755
--- a/tools/pounder21/Install
+++ b/tools/pounder21/Install
@@ -65,7 +65,7 @@ done
 # Set up optdir
 mkdir -p "$POUNDER_OPTDIR"
 if [ ! -d "$POUNDER_OPTDIR" ]; then
-	echo "Could not create $POUNDER_OPTDIR; aborting." > /dev/tty
+	echo "Could not create $POUNDER_OPTDIR; aborting."
 	exit 1
 fi
 
diff --git a/tools/pounder21/fancy_timed_loop.c b/tools/pounder21/fancy_timed_loop.c
index cf8580e..50305c3 100644
--- a/tools/pounder21/fancy_timed_loop.c
+++ b/tools/pounder21/fancy_timed_loop.c
@@ -92,7 +92,7 @@ int main(int argc, char *argv[])
 
 	tty_fp = fdopen(3, "w+");
 	if (tty_fp == NULL) {
-		tty_fp = fopen("/dev/tty", "w+");
+		tty_fp = fdopen(STDOUT_FILENO, "w+");
 		if (tty_fp == NULL) {
 			perror("stdout");
 			exit(2);
diff --git a/tools/pounder21/infinite_loop.c b/tools/pounder21/infinite_loop.c
index d78b442..804dd2e 100644
--- a/tools/pounder21/infinite_loop.c
+++ b/tools/pounder21/infinite_loop.c
@@ -77,7 +77,7 @@ int main(int argc, char *argv[])
 
 	tty_fp = fdopen(3, "w+");
 	if (tty_fp == NULL) {
-		tty_fp = fopen("/dev/tty", "w+");
+		tty_fp = fdopen(STDOUT_FILENO, "w+");
 		if (tty_fp == NULL) {
 			perror("stdout");
 			exit(2);
diff --git a/tools/pounder21/pounder b/tools/pounder21/pounder
index c3defcf..caf60d3 100755
--- a/tools/pounder21/pounder
+++ b/tools/pounder21/pounder
@@ -201,8 +201,8 @@ shift `expr $OPTIND - 1`
 
 # Are we already running?
 if [ -f "$POUNDER_PIDFILE" ]; then
-	echo "File $POUNDER_PIDFILE exists; pounder may already be running." > /dev/tty
-	echo "Either run 'pounder -k' to stop all tests, or remove it." > /dev/tty
+	echo "File $POUNDER_PIDFILE exists; pounder may already be running."
+	echo "Either run 'pounder -k' to stop all tests, or remove it."
 	exit 1
 fi
 
@@ -225,21 +225,21 @@ fi
 # Set up log directory
 mkdir -p "$POUNDER_LOGDIR" 2> /dev/null
 if [ ! -d "$POUNDER_LOGDIR" ]; then
-	echo "Could not create $POUNDER_LOGDIR; aborting." > /dev/tty
+	echo "Could not create $POUNDER_LOGDIR; aborting."
 	exit 1
 fi
 
 # Set up dir for optional components
 mkdir -p "$POUNDER_OPTDIR"
 if [ ! -d "$POUNDER_OPTDIR" ]; then
-	echo "Could not create $POUNDER_OPTDIR; aborting." > /dev/tty
+	echo "Could not create $POUNDER_OPTDIR; aborting."
 	exit 1
 fi
 
 # Set up tmpdir
 mkdir -p "$POUNDER_TMPDIR"
 if [ ! -d "$POUNDER_TMPDIR" ]; then
-	echo "Could not create $POUNDER_TMPDIR; aborting." > /dev/tty
+	echo "Could not create $POUNDER_TMPDIR; aborting."
 	exit 1
 fi
 
@@ -259,8 +259,8 @@ fi
 export > "$POUNDER_LOGDIR/environment"
 
 echo "Starting $POUNDER_VERSION"
-echo "STARTING TESTS." > /dev/tty
-echo "To kill all tests, run 'pounder -k' or press ^C."> /dev/tty
+echo "STARTING TESTS."
+echo "To kill all tests, run 'pounder -k' or press ^C."
 
 # Handle the duration thing...
 function kill_after {
diff --git a/tools/pounder21/test_scripts/memtest b/tools/pounder21/test_scripts/memtest
index c040147..e212bde 100755
--- a/tools/pounder21/test_scripts/memtest
+++ b/tools/pounder21/test_scripts/memtest
@@ -22,7 +22,7 @@
 
 # Can we find the script?
 if [ ! -f "$POUNDER_OPTDIR/memtest.sh" ]; then
-	echo "Can't find memtest.sh; did you run Install?" > /dev/tty
+	echo "Can't find memtest.sh; did you run Install?"
 	exit -1
 fi
 
diff --git a/tools/pounder21/timed_loop.c b/tools/pounder21/timed_loop.c
index 966c08a..0cd7305 100644
--- a/tools/pounder21/timed_loop.c
+++ b/tools/pounder21/timed_loop.c
@@ -94,7 +94,7 @@ int main(int argc, char *argv[])
 
 	tty_fp = fdopen(3, "w+");
 	if (tty_fp == NULL) {
-		tty_fp = fopen("/dev/tty", "w+");
+		tty_fp = fdopen(STDOUT_FILENO, "w+");
 		if (tty_fp == NULL) {
 			perror("stdout");
 			exit(2);
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
