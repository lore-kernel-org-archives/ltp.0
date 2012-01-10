Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RkSXc-0006oS-TQ
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:38:28 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RkSXc-0004RG-11
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:38:28 +0000
Received: by yhjj51 with SMTP id j51so696570yhj.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jan 2012 19:38:22 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 10 Jan 2012 11:38:12 +0800
Message-Id: <1326166692-18276-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.1"
Subject: [LTP] [PATCH] syscalls/getrusage03: flush stdout to avoid
	duplicated output
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


when executing with `$BIN/runltp` command, getrusage03 puts out
duplicated information due to buffered stdout. Using fflush(stdout) to
solve this issue.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/syscalls/getrusage/getrusage03.c  |    7 +++++++
 .../kernel/syscalls/getrusage/getrusage03_child.c  |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)


--------------1.7.8.1
Content-Type: text/x-patch;
	name="0001-syscalls-getrusage03-flush-stdout-to-avoid-duplicate.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-getrusage03-flush-stdout-to-avoid-duplicate.patch"

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 3ec5284..df25ff0 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -104,6 +104,7 @@ static void inherit_fork(void)
 	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
 	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
 
+	fflush(stdout);
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK|TERRNO, cleanup, "fork #1");
@@ -135,6 +136,7 @@ static void inherit_fork2(void)
 	else
 		tst_resm(TFAIL, "initial.children !~= 100MB");
 
+	fflush(stdout);
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK|TERRNO, cleanup, "fork #2");
@@ -161,6 +163,7 @@ static void fork_malloc(void)
 	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
 	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
 
+	fflush(stdout);
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK|TERRNO, cleanup, "fork #3");
@@ -190,6 +193,7 @@ static void grandchild_maxrss(void)
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
 
+	fflush(stdout);
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK|TERRNO, cleanup, "fork #4");
@@ -225,6 +229,7 @@ static void zombie(void)
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
 	maxrss_init = ru.ru_maxrss;
 
+	fflush(stdout);
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK, cleanup, "fork #5");
@@ -269,6 +274,7 @@ static void sig_ign(void)
 	signal(SIGCHLD, SIG_IGN);
 	maxrss_init = ru.ru_maxrss;
 
+	fflush(stdout);
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK, cleanup, "fork #6");
@@ -306,6 +312,7 @@ static void exec_without_fork(void)
 	maxrss_child = ru.ru_maxrss;
 	tst_resm(TINFO, "initial.self = %ld, initial.children = %ld",
 		    maxrss_self, maxrss_child);
+	fflush(stdout);
 
 	sprintf(str_maxrss_self, "%ld", maxrss_self);
 	sprintf(str_maxrss_child, "%ld", maxrss_child);
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
index a9c1d38..f5d2850 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03_child.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
@@ -87,6 +87,7 @@ int main(int argc, char *argv[])
 			grand_consume_nr = get_long(grand_consume_str);
 			tst_resm(TINFO, "grandchild allocate %ldMB",
 				    grand_consume_nr);
+			fflush(stdout);
 			switch (pid = fork()) {
 			case -1:
 				tst_brkm(TBROK, cleanup, "fork");

--------------1.7.8.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------1.7.8.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.1--



