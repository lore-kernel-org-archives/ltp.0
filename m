Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zlang@redhat.com>) id 1XNGEp-00061h-Om
	for ltp-list@lists.sourceforge.net; Fri, 29 Aug 2014 07:04:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XNGEo-0000W4-0C
	for ltp-list@lists.sourceforge.net; Fri, 29 Aug 2014 07:04:47 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7T74doF030949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Aug 2014 03:04:39 -0400
Received: from dhcp-65-110.nay.redhat.com (dhcp-12-112.nay.redhat.com
	[10.66.12.112])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s7T74b3O005461
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Aug 2014 03:04:38 -0400
Message-ID: <54002604.6000007@redhat.com>
Date: Fri, 29 Aug 2014 15:04:36 +0800
From: Zorro Lang <zlang@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH-V2]fs/fsstress: prevent orphan and zombie processes to
 be left
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
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

Ping ...

I have sent this patch for very long time, but no response until now. If
there are any problems you don't want to merge it, please tell me.

(Re-send this patch again now. )

Thank you,
Zorro Lang


 testcases/kernel/fs/fsstress/fsstress.c | 40
++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c
b/testcases/kernel/fs/fsstress/fsstress.c
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
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
