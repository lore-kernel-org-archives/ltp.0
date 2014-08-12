Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zlang@redhat.com>) id 1XH8kb-0002Qa-Kh
	for ltp-list@lists.sourceforge.net; Tue, 12 Aug 2014 09:52:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XH8kX-0005eW-0O
	for ltp-list@lists.sourceforge.net; Tue, 12 Aug 2014 09:52:17 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7C9q6to021996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Aug 2014 05:52:06 -0400
From: Zorro Lang <zlang@redhat.com>
Date: Tue, 12 Aug 2014 17:52:02 +0800
Message-Id: <1407837122-11337-1-git-send-email-zlang@redhat.com>
Subject: [LTP] [PATCH] [PATCH-V2]fs/fsstress: prevent orphan and zombie
	processes to be left
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

parent use signal handler to deal with SIGTERM, make sure children processes
will be over before parent.
command "killall fsstress; wait;" can be used with this patch.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

I have sent a patch about this last week, but there is no response. Now this 
is Version 2, I modified one place, make sure "kill <parent process>" 
will worked even use "-l 0" option.

Thank you,
Zorro Lang


 testcases/kernel/fs/fsstress/fsstress.c | 40 ++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 2243280..4a8a1c2 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -30,7 +30,11 @@
  * http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/
  */
 
+#include <config.h>
 #include "global.h"
+#ifdef HAVE_SYS_PRCTL_H
+#include <sys/prctl.h>
+#endif
 
 #define XFS_ERRTAG_MAX		17
 
@@ -227,6 +231,7 @@ int no_xfs = 0;
 #else
 int no_xfs = 1;
 #endif
+sig_atomic_t should_stop = 0;
 
 void add_to_flist(int, int, int);
 void append_pathname(pathname_t *, char *);
@@ -273,6 +278,11 @@ void usage(void);
 void write_freq(void);
 void zero_freq(void);
 
+void sg_handler(int signum)
+{
+	should_stop = 1;
+}
+
 int main(int argc, char **argv)
 {
 	char buf[10];
@@ -297,6 +307,7 @@ int main(int argc, char **argv)
 #ifndef NO_XFS
 	xfs_error_injection_t err_inj;
 #endif
+	struct sigaction action;
 
 	errrange = errtag = 0;
 	umask(0);
@@ -389,7 +400,7 @@ int main(int argc, char **argv)
 
 	make_freq_table();
 
-	while ((loopcntr <= loops) || (loops == 0)) {
+	while ((loopcntr <= loops) || (loops == 0) && !should_stop) {
 		if (!dirname) {
 			/* no directory specified */
 			if (!nousage)
@@ -465,17 +476,44 @@ int main(int argc, char **argv)
 #endif
 			close(fd);
 		unlink(buf);
+
+
 		if (nproc == 1) {
 			procid = 0;
 			doproc();
 		} else {
+			setpgid(0, 0);
+			action.sa_handler = sg_handler;
+			sigemptyset(&action.sa_mask);
+			action.sa_flags = 0;
+			if (sigaction(SIGTERM, &action, 0)) {
+				perror("sigaction failed");
+				exit(1);
+			}
+
 			for (i = 0; i < nproc; i++) {
 				if (fork() == 0) {
+
+					action.sa_handler = SIG_DFL;
+					sigemptyset(&action.sa_mask);
+					if (sigaction(SIGTERM, &action, 0))
+						return 1;
+#ifdef HAVE_SYS_PRCTL_H
+					prctl(PR_SET_PDEATHSIG, SIGKILL);
+					if (getppid() == 1) /* parent died already? */
+						return 0;
+#endif
 					procid = i;
 					doproc();
 					return 0;
 				}
 			}
+			while (wait(&stat) > 0 && !should_stop) {
+				continue;
+			}
+			action.sa_flags = SA_RESTART;
+			sigaction(SIGTERM, &action, 0);
+			kill(-getpid(), SIGTERM);
 			while (wait(&stat) > 0)
 				continue;
 		}
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
