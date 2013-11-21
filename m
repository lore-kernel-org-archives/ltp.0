Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VjVuS-0003w6-Rl
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 15:11:12 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 90EB2A678C
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Nov 2013 16:11:04 +0100 (CET)
Date: Thu, 21 Nov 2013 16:10:45 +0100
From: chrubis@suse.cz
Message-ID: <20131121151044.GA27253@rei.nue.novell.com>
References: <20131120095902.GB30274@quack.suse.cz>
	<20131120122505.GB2168@rei.nue.novell.com>
	<20131120203951.GE30274@quack.suse.cz>
	<20131120214857.GA1106@rei.my-cloud.eu>
	<20131120224313.GH30274@quack.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20131120224313.GH30274@quack.suse.cz>
Subject: Re: [LTP] fanotify tests
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
I've fixed a last few issues in the code, added gitignore file and
pushed, see comments bellow and the diff.

There is a bug in ltp_syscall() implementation that calls callback if
fanotify syscalls are not compiled in the kernel and that results in the
TWARN in the return value. I will look into this one and fix it.

Also fanotify syscalls don't have a man pages :( Where do I find a
documentation for it?

> +/*
> + * fanotify testcase common definitions.
> + *
> + * Copyright (c) 2012 Linux Test Project.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + * Jan Kara, November 2013
> + */
> +
> +#ifndef	_FANOTIFY_H
> +#define	_FANOTIFY_H
> +
> +/* fanotify(7) wrappers */
> +
> +#define	myfanotify_init(flags, event_f_flags) \
> +	syscall(__NR_fanotify_init, flags, event_f_flags)
> +
> +#define	myfanotify_mark(fd, flags, mask, dfd, pathname)	\
> +	syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname)
> +
> +#endif /* _FANOTIFY_H */

Same problem as with the underscore functions, these are just too close
to format glibc uses.

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> new file mode 100644
> index 000000000000..b7682f4b9c3a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -0,0 +1,320 @@
> +/*
> + * Copyright (c) 2013 SUSE.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + * Started by Jan Kara <jack@suse.cz>
> + *
> + * DESCRIPTION
> + *     Check that fanotify permission events work
> + */
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/fcntl.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <sys/syscall.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "linux_syscall_numbers.h"
> +#include "fanotify.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "fanotify03";
> +int TST_TOTAL = 3;
> +
> +#if defined(HAVE_SYS_FANOTIFY_H)
> +#include <sys/fanotify.h>
> +
> +#define EVENT_MAX 1024
> +/* size of the event structure, not counting name */
> +#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
> +/* reasonable guess as to size of 1024 events */
> +#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +#define BUF_SIZE 256
> +static char fname[BUF_SIZE];
> +static char buf[BUF_SIZE];
> +static int fd_notify;

          ^ this must be volatile
	    otherwise newer compilers
	    will miscompile the main loop
	    as it's changed from the signal
	    handler

> +static pid_t child_pid;
> +
> +static unsigned long long event_set[EVENT_MAX];
> +static unsigned int event_resp[EVENT_MAX];
> +
> +static char event_buf[EVENT_BUF_LEN];
> +
> +static void generate_events(void)
> +{
> +	int fd;
> +
> +	/*
> +	 * generate sequence of events
> +	 */
> +	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
> +		exit(1);
> +	if (write(fd, fname, 1) == -1)
> +		exit(2);
> +
> +	lseek(fd, 0, SEEK_SET);
> +	if (read(fd, buf, BUF_SIZE) != -1)
> +		exit(3);
> +
> +	if (close(fd) == -1)
> +		exit(4);
> +}
> +
> +static void child_handler(int tmp)
> +{
> +	/*
> +	 * Close notification fd so that we cannot block while reading
> +	 * from it
> +	 */
> +	close(fd_notify);
> +	fd_notify = -1;
> +}
> +
> +static void run_child(void)
> +{
> +	struct sigaction child_action;
> +
> +	child_action.sa_handler = child_handler;
> +	sigemptyset(&child_action.sa_mask);
> +	child_action.sa_flags = SA_NOCLDSTOP;
> +
> +	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "sigaction(SIGCHLD, &child_action, NULL) failed");
> +	}
> +
> +	switch (child_pid = fork()) {
> +	case 0:
> +		/* Child will generate events now */
> +		close(fd_notify);
> +		generate_events();
> +		exit(0);
> +	case -1:
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
> +	}
> +}
> +
> +static void check_child(void)
> +{
> +	struct sigaction child_action;
> +	int child_ret;
> +
> +	child_action.sa_handler = SIG_IGN;
> +	sigemptyset(&child_action.sa_mask);
> +	child_action.sa_flags = SA_NOCLDSTOP;
> +	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "sigaction(SIGCHLD, &child_action, NULL) failed");
> +	}
> +	if (waitpid(-1, &child_ret, 0) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +				 "waitpid(-1, &child_ret, 0) failed");
> +	}
> +
> +	if (WIFSIGNALED(child_ret)) {
> +		tst_resm(TFAIL, "child exited due to signal %d",
> +			 WTERMSIG(child_ret));
> +	} else if (WIFEXITED(child_ret)) {
> +		if (WEXITSTATUS(child_ret) == 0)
> +			tst_resm(TPASS, "child exited correctly");
> +		else
> +			tst_resm(TFAIL, "child exited with status %d",
> +				 WEXITSTATUS(child_ret));
> +	} else
> +		tst_resm(TFAIL, "child exited for unknown reason (status %d)",
> +			 child_ret);
> +}
> +

...

> +	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		/* Check ONLYDIR on a directory */
> +		CHECK_MARK(".", FAN_MARK_ONLYDIR, 0, NULL);
> +
> +		/* Check ONLYDIR without a directory */
> +		CHECK_MARK(fname, FAN_MARK_ONLYDIR, -1, NULL);
> +
> +		/* Check DONT_FOLLOW for a symlink */
> +		CHECK_MARK(sname, FAN_MARK_DONT_FOLLOW, 0, test_open_symlink);
> +
> +		/* Check without DONT_FOLLOW for a symlink */
> +		CHECK_MARK(sname, 0, 0, test_open_file);
> +
> +		/* Verify FAN_MARK_FLUSH destroys all inode marks */
> +		if (myfanotify_mark(fd_notify, FAN_MARK_ADD,
> +		    		    FAN_OPEN, AT_FDCWD, fname) < 0) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
> +			    "AT_FDCWD, '%s') failed", fd_notify, fname);
> +		}
> +		if (myfanotify_mark(fd_notify, FAN_MARK_ADD,
> +		    		    FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
> +			    "FAN_ONDIR, AT_FDCWD, '%s') failed", fd_notify,
> +			    dir);
> +		}
> +		open_file(fname);
> +		verify_event(S_IFREG);
> +		open_dir(dir);
> +		verify_event(S_IFDIR);
> +		if (myfanotify_mark(fd_notify, FAN_MARK_FLUSH,
> +		    		    0, AT_FDCWD, ".") < 0) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +			    "fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
> +			    "AT_FDCWD, '.') failed", fd_notify);

There were a few spaces before tabs that git complained about, I've
fixed these as well.

> +		}
> +
> +		open_dir(dir);
> +		verify_no_event();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +

-- 
Cyril Hrubis
chrubis@suse.cz

--opJtzjQTFsWo+cga
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fixes.patch"

diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0130a53..218ec0c 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1004,3 +1004,7 @@
 /writev/writev04
 /writev/writev05
 /writev/writev06
+/fanotify/fanotify01
+/fanotify/fanotify02
+/fanotify/fanotify03
+/fanotify/fanotify04
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 436e67d..a4c2a8f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -25,8 +25,8 @@
  * Jan Kara, November 2013
  */
 
-#ifndef	_FANOTIFY_H
-#define	_FANOTIFY_H
+#ifndef	__FANOTIFY_H__
+#define	__FANOTIFY_H__
 
 /* fanotify(7) wrappers */
 
@@ -36,4 +36,4 @@
 #define	myfanotify_mark(fd, flags, mask, dfd, pathname)	\
 	syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname)
 
-#endif /* _FANOTIFY_H */
+#endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 4d24681..c92388d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -357,9 +357,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (close(fd_notify) == -1) {
+	if (close(fd_notify) == -1)
 		tst_resm(TWARN, "close(%d) failed", fd_notify);
-	}
 
 	TEST_CLEANUP;
 	tst_rmdir();
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 2d5096b..d9caf6e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -245,9 +245,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (close(fd_notify) == -1) {
+	if (close(fd_notify) == -1)
 		tst_resm(TWARN, "close(%d) failed", fd_notify);
-	}
 
 	TEST_CLEANUP;
 	tst_rmdir();
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index b7682f4..1e0e5f8 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -61,7 +61,7 @@ static void cleanup(void);
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
-static int fd_notify;
+static volatile int fd_notify;
 
 static pid_t child_pid;
 
@@ -150,9 +150,10 @@ static void check_child(void)
 		else
 			tst_resm(TFAIL, "child exited with status %d",
 				 WEXITSTATUS(child_ret));
-	} else
+	} else {
 		tst_resm(TFAIL, "child exited for unknown reason (status %d)",
 			 child_ret);
+	}
 }
 
 int main(int ac, char **av)
@@ -302,9 +303,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd_notify != -1 && close(fd_notify) == -1) {
+	if (fd_notify != -1 && close(fd_notify) == -1)
 		tst_resm(TWARN, "close(%d) failed", fd_notify);
-	}
 
 	TEST_CLEANUP;
 	tst_rmdir();
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 1e4549c..8835c96 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -101,7 +101,7 @@ static void check_mark(char *file, unsigned long long flag, char *flagstr,
 		if (myfanotify_mark(fd_notify, FAN_MARK_REMOVE | flag,
 				    FAN_OPEN, AT_FDCWD, file) < 0) {
 			tst_brkm(TBROK | TERRNO, cleanup,
-		    	    "fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
+			    "fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
 			    "FAN_OPEN, AT_FDCWD, '%s') failed",
 			    fd_notify, flagstr, file);
 		}
@@ -224,13 +224,13 @@ int main(int ac, char **av)
 
 		/* Verify FAN_MARK_FLUSH destroys all inode marks */
 		if (myfanotify_mark(fd_notify, FAN_MARK_ADD,
-		    		    FAN_OPEN, AT_FDCWD, fname) < 0) {
+				    FAN_OPEN, AT_FDCWD, fname) < 0) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
 			    "AT_FDCWD, '%s') failed", fd_notify, fname);
 		}
 		if (myfanotify_mark(fd_notify, FAN_MARK_ADD,
-		    		    FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
+				    FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
 			    "FAN_ONDIR, AT_FDCWD, '%s') failed", fd_notify,
@@ -241,7 +241,7 @@ int main(int ac, char **av)
 		open_dir(dir);
 		verify_event(S_IFDIR);
 		if (myfanotify_mark(fd_notify, FAN_MARK_FLUSH,
-		    		    0, AT_FDCWD, ".") < 0) {
+				    0, AT_FDCWD, ".") < 0) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 			    "fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
 			    "AT_FDCWD, '.') failed", fd_notify);
@@ -288,9 +288,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (close(fd_notify) == -1) {
+	if (close(fd_notify) == -1)
 		tst_resm(TWARN, "close(%d) failed", fd_notify);
-	}
 
 	TEST_CLEANUP;
 	tst_rmdir();

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
--opJtzjQTFsWo+cga
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--opJtzjQTFsWo+cga--

