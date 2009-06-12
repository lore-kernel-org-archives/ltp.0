Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MF6gy-0001zh-UO
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:21:12 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MF6gw-0005z4-W1
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:21:12 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Fri, 12 Jun 2009 18:51:02 +0530
Message-Id: <20090612132102.32046.21700.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Add eventfd2_03 test for eventfd2() syscall [Earlier
	Subject: (testing)improve support for semaphore-like behavior]
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
To: Davide Libenzi <davidel@xmailserver.org>
Cc: ltp-list <ltp-list@lists.sf.net>, Michael Kerrisk <mtk.manpages@gmail.com>, Ulrich Drepper <drepper@redhat.com>

>On Thu, 2009-06-11 at 19:50 -0700, Davide Libenzi wrote:
>On Fri, 12 Jun 2009, Subrata Modak wrote:
> 
> > Hi Davide,
> > 
> > Your had introduced an improvement to support for semaphore-like
> > behavior in eventfd for linux-2.6.30. And also have a small test program
> > envisaged through:
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=bcd0b235bf3808dec5115c381cd55568f63b85f0,
> > http://www.xmailserver.org/eventfd-sem.c,
> > 
> > Would you be willing to share this test program for inclusion in Linux
> > Test Project (http://ltp.sourceforge.net/) under GPLv2 ? If affirmative,
> > can you confirm by replying to this mail with your consent/Sign-off.
> 
> Sure, it's all yours ;)

So, here it goes. The following patch integrates this to LTP.

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com> 
Original-author-and-copyright-holder: Davide Libenzi <davidel@xmailserver.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Ulrich Drepper <drepper@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>
---

--- ltp-full-20090531.orig/runtest/syscalls	2009-06-12 17:03:15.000000000 +0530
+++ ltp-full-20090531/runtest/syscalls	2009-06-12 18:13:49.000000000 +0530
@@ -126,6 +126,7 @@ eventfd01 eventfd01
 
 eventfd2_01 eventfd2_01
 eventfd2_02 eventfd2_02
+eventfd2_03 eventfd2_03
 
 execl01 execl01
 execle01 execle01
--- ltp-full-20090531.orig/testcases/kernel/syscalls/eventfd2/eventfd2_03.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090531/testcases/kernel/syscalls/eventfd2/eventfd2_03.c	2009-06-12 18:17:49.000000000 +0530
@@ -0,0 +1,135 @@
+/*
+ *  eventfd-sem by Davide Libenzi (Simple test for eventfd sempahore)
+ *  Copyright (C) 2009  Davide Libenzi
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Davide Libenzi <davidel@xmailserver.org>
+ *  Reference: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=bcd0b235bf3808dec5115c381cd55568f63b85f0
+ *  Reference: http://www.xmailserver.org/eventfd-sem.c
+ *  eventfd: testing improved support for semaphore-like behavior in linux-2.6.30
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+char *TCID = "eventfd2_02";     /* test program identifier*/
+
+#ifndef EFD_SEMLIKE
+#define EFD_SEMLIKE (1 << 0)
+#endif
+
+#ifndef __NR_eventfd2
+#if defined(__x86_64__)
+#define __NR_eventfd2 290
+#elif defined(__i386__)
+#define __NR_eventfd2 328
+#else
+#error Cannot detect your architecture!
+#endif
+#endif
+
+
+static int eventfd2(int count, int flags) {
+	return syscall(__NR_eventfd2, count, flags);
+}
+
+static void xsem_wait(int fd) {
+	u_int64_t cntr;
+
+	if (read(fd, &cntr, sizeof(cntr)) != sizeof(cntr)) {
+		perror("reading eventfd");
+		exit(1);
+	}
+	fprintf(stdout, "[%u] wait completed on %d: count=%llu\n",
+		getpid(), fd, cntr);
+}
+
+static void xsem_post(int fd, int count) {
+	u_int64_t cntr = count;
+
+	if (write(fd, &cntr, sizeof(cntr)) != sizeof(cntr)) {
+		perror("writing eventfd");
+		exit(1);
+	}
+}
+
+static void sem_player(int fd1, int fd2) {
+	fprintf(stdout, "[%u] posting 1 on %d\n", getpid(), fd1);
+	xsem_post(fd1, 1);
+
+	fprintf(stdout, "[%u] waiting on %d\n", getpid(), fd2);
+	xsem_wait(fd2);
+
+	fprintf(stdout, "[%u] posting 1 on %d\n", getpid(), fd1);
+	xsem_post(fd1, 1);
+
+	fprintf(stdout, "[%u] waiting on %d\n", getpid(), fd2);
+	xsem_wait(fd2);
+
+	fprintf(stdout, "[%u] posting 5 on %d\n", getpid(), fd1);
+	xsem_post(fd1, 5);
+
+	fprintf(stdout, "[%u] waiting 5 times on %d\n", getpid(), fd2);
+	xsem_wait(fd2);
+	xsem_wait(fd2);
+	xsem_wait(fd2);
+	xsem_wait(fd2);
+	xsem_wait(fd2);
+}
+
+static void usage(char const *prg) {
+	fprintf(stderr, "use: %s [-h]\n", prg);
+}
+
+int main (int argc, char **argv) {
+	int c, fd1, fd2, status;
+	pid_t cpid_poster, cpid_waiter;
+
+	while ((c = getopt(argc, argv, "h")) != -1) {
+		switch (c) {
+		default:
+			usage(argv[0]);
+			return 1;
+		}
+	}
+	if ((fd1 = eventfd2(0, EFD_SEMLIKE)) == -1 ||
+	    (fd2 = eventfd2(0, EFD_SEMLIKE)) == -1) {
+		perror("eventfd2");
+		return 1;
+	}
+	if ((cpid_poster = fork()) == 0) {
+		sem_player(fd1, fd2);
+		exit(0);
+	}
+	if ((cpid_waiter = fork()) == 0) {
+		sem_player(fd2, fd1);
+		exit(0);
+	}
+	waitpid(cpid_poster, &status, 0);
+	waitpid(cpid_waiter, &status, 0);
+
+	return 0;
+}
+
+

---
Regards--
Subrata

> 
> - Davide
> 
> 

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
