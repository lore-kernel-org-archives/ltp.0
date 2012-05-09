Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cyeoh@au1.ibm.com>) id 1SS6IT-0004x9-EK
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 12:47:13 +0000
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SS6IM-00026p-8k
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 12:47:13 +0000
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <cyeoh@au1.ibm.com>;
	Wed, 9 May 2012 12:41:49 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q49CdiO861669578
	for <ltp-list@lists.sourceforge.net>; Wed, 9 May 2012 22:39:44 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	q49Ckjsv026702
	for <ltp-list@lists.sourceforge.net>; Wed, 9 May 2012 22:46:45 +1000
Date: Wed, 9 May 2012 22:16:44 +0930
From: Christopher Yeoh <cyeoh@au1.ibm.com>
Message-ID: <20120509221644.4d5f1819@Gantu>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Simple tests for cross memory attach
 (process_vm_[readv|writev] syscalls)
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

Hi,

Here are some patches which add testcases for cross memory attach (CMA)
functionality which is included in more recent kernels. CMA adds two
new syscalls, process_vm_readv and process_vm_writev.  Man pages for
these two syscalls were added in the man-pages-3.40 release.

The testcases aren't really ready for inclusion as-is, but I thought
they could do with some review now. One issue is that the syscall
wrappers were not included in glibc until glibc 2.15 which not all
distributions have picked up yet. For the testcases to compile I have a
header file with some hard coded syscall numbers included (just for
x86/powerpc atm, but more could be added). These numbers won't change
in the future, but its an obviously ugly workaround.

Is this a show stopper problem? Do I have to wait until more
distributions have picked up glibc 2.15 (or at least backported the
glibc syscall wrappers) before it can be added to LTP? Or should I use
some other workaround - eg detect if the syscalls are defined on the
system and just not attempt to build the test if they aren't?

The testcases are not that extensive yet, just coverage of basic
functionality.

Regards,

Chris

-- 
cyeoh@au.ibm.com
diff --git a/testcases/kernel/syscalls/process_vm_readv/Makefile b/testcases/kernel/syscalls/process_vm_readv/Makefile
new file mode 100644
index 0000000..e0806a7
--- /dev/null
+++ b/testcases/kernel/syscalls/process_vm_readv/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2012
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/process_vm_readv/process_vm.h b/testcases/kernel/syscalls/process_vm_readv/process_vm.h
new file mode 100755
index 0000000..bc69e45
--- /dev/null
+++ b/testcases/kernel/syscalls/process_vm_readv/process_vm.h
@@ -0,0 +1,48 @@
+#ifndef _PROCESS_VM_H
+#define _PROCESS_VM_H
+
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#if defined(i386)
+#define __NR_process_vm_readv 347
+#define __NR_process_vm_writev 348
+
+
+#elif defined(_ARCH_PPC)
+#define __NR_process_vm_readv 351
+#define __NR_process_vm_writev 352
+
+
+#else
+#error "Need to define syscall numbers for process_vm_readv and process_vm_writev for this architecture "
+#endif
+
+
+
+inline ssize_t process_vm_readv(pid_t pid, 
+				const struct iovec  *lvec, 
+				unsigned long liovcnt,
+				const struct iovec *rvec,
+				unsigned long riovcnt,
+				unsigned long flags)
+{
+  return syscall(__NR_process_vm_readv, pid, lvec, liovcnt, rvec, riovcnt, flags);
+}
+
+ssize_t process_vm_writev(pid_t pid, 
+			  const struct iovec  *lvec, 
+			  unsigned long liovcnt,
+			  const struct iovec *rvec,
+			  unsigned long riovcnt,
+			  unsigned long flags)
+{
+  return syscall(__NR_process_vm_writev, pid, lvec, liovcnt, rvec, riovcnt, flags);
+}
+
+
+
+#endif /* _PROCESS_VM_H */
diff --git a/testcases/kernel/syscalls/process_vm_readv/process_vm_readv01.c b/testcases/kernel/syscalls/process_vm_readv/process_vm_readv01.c
new file mode 100644
index 0000000..1d387bd
--- /dev/null
+++ b/testcases/kernel/syscalls/process_vm_readv/process_vm_readv01.c
@@ -0,0 +1,172 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) International Business Machines  Corp., 2012                 */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/******************************************************************************/
+
+/******************************************************************************/
+/*                                                                            */
+/* File:        process_vm_readv01.c                                          */
+/*                                                                            */
+/* Description: Test the process_vm_readv syscall                             */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   process_vm_readv01                                            */
+/*                                                                            */
+/* Test Assertion                                                             */
+/* and  Strategy: Allocates memory, initialises it and then                   */
+/*   fork-execs a child to call process_vm_readv and read from the same       */
+/*   memory location. The child then verifies it process_vm_readv             */
+/*   returned the correct data                                                */
+/*                                                                            */
+/* Author:      Christopher Yeoh yeohc@au1.ibm.com                            */
+/*                                                                            */
+/* History:     Created - May 2  2012 - Chris Yeoh yeohc@au1.ibm.com          */
+/*                                                                            */
+/*                                                                            */
+/******************************************************************************/
+
+/* Standard Include Files */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+
+/* Harness Specific Include Files. */
+#include "test.h"
+#include "usctest.h"
+
+#include "process_vm.h"
+
+/* Local Defines */
+#if !defined(TRUE) && !defined(FALSE)
+#define TRUE  1
+#define FALSE 0
+#endif
+
+#define TEST_STRING "THIS IS A TEST"
+
+/* Extern Global Variables */
+extern int  Tst_count;               /* counter for tst_xxx routines.         */
+extern char *TESTDIR;                /* temporary dir created by tst_tmpdir() */
+
+/* Global Variables */
+char *TCID     = "process_vm_readv_test01"; /* test program identifier.          */
+int  TST_TOTAL = 1;                  /* total number of tests in this file.   */
+
+/******************************************************************************/
+/*                                                                            */
+/* Function:    main                                                          */
+/*                                                                            */
+/******************************************************************************/
+int
+main(int   argc,    /* number of command line parameters                      */
+     char **argv)   /* pointer to the array of the command line parameters.   */
+{
+    if (argc==1) {
+	/* setup target */
+	char *tst_string = TEST_STRING;
+	char *foo;
+	pid_t pid, ppid;
+
+	/* Setup target memory */
+
+	foo = malloc(strlen(tst_string)+1);
+	strcpy(foo, tst_string);
+
+	ppid = getpid();
+	pid = fork();
+    
+	/* Fork/exec child to look at parent's memory
+	   using process_vm_readv */
+	if (pid==0) {
+	    /* child */
+	    char *s_pid, *s_pointer, *s_size;
+	    asprintf(&s_pid, "%i", ppid);
+	    asprintf(&s_pointer, "%p", foo);
+	    asprintf(&s_size, "%i", strlen(foo)+1);
+
+	    execlp(argv[0], argv[0], s_pid, s_pointer, s_size, (char*)NULL);
+
+	} else {
+	    /* parent */
+	    int status;
+	    if (wait(&status) != pid) {
+		tst_brkm(TBROK, NULL, "Wait failed");
+	    }
+      
+	    if (WIFEXITED(status) && WEXITSTATUS(status)==0) {
+		tst_resm(TPASS, "process_vm_readv test passed\n");
+	    } else {
+		tst_resm(TFAIL, "process_vm_readv test failed\n");
+	    }
+	    tst_exit();
+	}
+    } else if (argc==4) {
+	/* Read from target */
+	int val;
+	pid_t pid;
+	void *addr;
+	unsigned long len;
+	char buf[1000];
+	struct iovec local;
+	struct iovec remote;
+
+	pid = atoi(argv[1]);
+	sscanf(argv[2], "%p", &addr);
+	len = atol(argv[3]);
+
+	local.iov_base = buf;
+	local.iov_len = len;
+	remote.iov_base = addr;
+	remote.iov_len = len;
+
+	val = process_vm_readv(pid, &local, 1, &remote, 1, 0);
+
+	if (val!=len) {
+	    perror("process_vm_readv failed"); 
+	    printf("error code: %i\n", errno);
+	    exit(1);
+	} else {
+	    if (strcmp(TEST_STRING, buf) == 0) {
+		printf("Test passed\n");
+		exit(0);
+	    } else {
+		printf("Test failed, received (expected \"%s\")\n", TEST_STRING);
+    
+		int i;
+		printf("%i %i\n", strlen(TEST_STRING), strlen(buf));
+		for (i=0; i<len; i++) {
+		    printf("%x %c ", buf[i], buf[i]);
+		}
+		printf("\n");
+		exit(1);
+	    }
+	}
+    } else {
+	printf("Internal error %i\n", argc);
+	exit(2);
+    }
+
+    exit(0);
+}
diff --git a/testcases/kernel/syscalls/process_vm_readv/process_vm_readv02.c b/testcases/kernel/syscalls/process_vm_readv/process_vm_readv02.c
new file mode 100644
index 0000000..6a9a324
--- /dev/null
+++ b/testcases/kernel/syscalls/process_vm_readv/process_vm_readv02.c
@@ -0,0 +1,258 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) International Business Machines  Corp., 2012                 */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/******************************************************************************/
+
+/******************************************************************************/
+/*                                                                            */
+/* File:        process_vm_readv02.c                                          */
+/*                                                                            */
+/* Description: Test the process_vm_readv syscall                             */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   process_vm_readv02                                            */
+/*                                                                            */
+/* Test Assertion                                                             */
+/* and  Strategy: malloc a number of randomly sized chunks of memory          */
+/*  and initialise them. Fork-exec a child which calls process_vm_readv with  */
+/*  the remote iovecs initialised to the original process memory locations    */
+/*  and the local iovecs initialised to randomly sized and allocated local    */
+/*  memory locations. The child verifies that the data copied is correct.     */
+/*                                                                            */
+/* Author:      Christopher Yeoh yeohc@au1.ibm.com                            */
+/*                                                                            */
+/* History:     Created - May 2  2012 - Chris Yeoh yeohc@au1.ibm.com          */
+/*                                                                            */
+/*                                                                            */
+/******************************************************************************/
+
+/* Standard Include Files */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+
+/* Harness Specific Include Files. */
+#include "test.h"
+#include "usctest.h"
+
+#include "process_vm.h"
+
+/* Local Defines */
+#if !defined(TRUE) && !defined(FALSE)
+#define TRUE  1
+#define FALSE 0
+#endif
+
+#define TEST_STRING "THIS IS A TEST"
+
+/* Extern Global Variables */
+extern int  Tst_count;               /* counter for tst_xxx routines.         */
+extern char *TESTDIR;                /* temporary dir created by tst_tmpdir() */
+
+/* Global Variables */
+char *TCID     = "process_vm_readv_test02"; /* test program identifier.          */
+int  TST_TOTAL = 1;                  /* total number of tests in this file.   */
+
+/******************************************************************************/
+/*                                                                            */
+/* Function:    main                                                          */
+/*                                                                            */
+/******************************************************************************/
+int
+main(int   argc,    /* number of command line parameters                      */
+     char **argv)   /* pointer to the array of the command line parameters.   */
+{
+  if (argc==1) {
+    /* setup target */
+    pid_t pid, ppid;
+    char **foo;
+    int buffer_size = 100000;
+    int num_iovecs = 10;
+    int buffer_left;
+    int new_buf_size;
+    int count;
+    int *buf_sizes;
+    int i,j;
+
+    /* Setup target memory */
+    ppid = getpid();
+    pid = fork();
+
+
+    srand(time(NULL));
+
+    buffer_left = buffer_size;
+
+
+    /* Generate random sized buffers */
+    foo = malloc(num_iovecs * sizeof(char *));
+    if (foo==NULL) {
+      perror("Malloc failed");
+      tst_brkm(TBROK, NULL, "Out of memory");
+    }
+    buf_sizes = malloc(num_iovecs * sizeof(int *));
+  
+    for (i=0; i<num_iovecs-1; i++) {
+      new_buf_size = rand() % (buffer_left / 2) + 1;
+      foo[i] = (char *)malloc(new_buf_size);
+      if (foo[i]==(char *)NULL) {
+	perror("Malloc failed");
+	tst_brkm(TBROK, NULL, "Out of memory");
+      }
+      buf_sizes[i] = new_buf_size;
+      buffer_left -= new_buf_size;
+    }
+    buf_sizes[num_iovecs-1] = buffer_left;
+    foo[num_iovecs-1] = malloc(buffer_left);
+    if (foo[num_iovecs-1]==NULL) {
+      perror("Malloc failed");
+      tst_brkm(TBROK, NULL, "Out of memory");
+    }
+
+    /* Initialise buffers */
+    count = 0;
+    for (i=0; i<num_iovecs; i++) {
+      for (j=0; j<buf_sizes[i]; j++, count++) {
+	foo[i][j] = count % 256;
+      }
+    }
+
+    /* Fork/exec child to look at parent's memory
+       using process_vm_readv */
+    if (pid==0) {
+      /* child */
+      char *child_argv[num_iovecs*2 + 4];
+
+      asprintf(&child_argv[0], "%s", argv[0]);
+      asprintf(&child_argv[1], "%i", ppid);
+      asprintf(&child_argv[2], "%i", num_iovecs);
+
+      for (i=0; i<num_iovecs; i++) {
+	asprintf(&child_argv[i*2+3], "%p", foo[i]);
+	asprintf(&child_argv[i*2+4], "%i", buf_sizes[i]);
+      }
+      child_argv[num_iovecs*2+3] = NULL;
+      execvp(argv[0], child_argv);
+
+    } else {
+      /* parent */
+      int status;
+      if (wait(&status) != pid) {
+	tst_brkm(TBROK, NULL, "Wait failed");
+      }
+      
+      if (WIFEXITED(status) && WEXITSTATUS(status)==0) {
+	tst_resm(TPASS, "process_vm_readv test passed\n");
+      } else {
+	tst_resm(TFAIL, "process_vm_readv test failed\n");
+      }
+      tst_exit();
+    }
+  } else if (argc>3) {
+    /* Read from target */
+#define NUM_LOCAL_VECS 4
+    int val;
+    int pid;
+    int j;
+    struct iovec local[NUM_LOCAL_VECS];
+    struct iovec *remote;
+    unsigned long num_iovecs;
+    int i;
+    int rcv_buf_size;
+    int rcv_buf_size_total = 0;
+    int rcv_buf_size_left;
+
+    srand(time(NULL));
+
+    pid = atoi(argv[1]);
+    num_iovecs = atol(argv[2]);
+
+    remote = malloc(num_iovecs * sizeof(struct iovec));
+    if (remote==NULL) {
+      perror("malloc failed");
+      exit(1);
+    }
+  
+    for (i=3, j=0; i<num_iovecs*2 + 3; i+=2, j++) {
+      if (i>=argc-1) {
+	printf("Insufficient number of arguments %i %lu\n", i, num_iovecs);
+	exit(1);
+      }
+    
+      sscanf(argv[i], "%p", &remote[j].iov_base);
+      remote[j].iov_len = atol(argv[i+1]);
+      rcv_buf_size_total += remote[j].iov_len;
+    }
+
+    rcv_buf_size_left = rcv_buf_size_total;
+
+    for (j=0; j<NUM_LOCAL_VECS-1; j++) {
+      rcv_buf_size = rand() % (rcv_buf_size_left / 2) + 1;
+      local[j].iov_base = malloc(rcv_buf_size);
+      local[j].iov_len = rcv_buf_size;
+      rcv_buf_size_left -= rcv_buf_size;
+    }
+    local[NUM_LOCAL_VECS-1].iov_base = malloc(rcv_buf_size_left);
+    local[NUM_LOCAL_VECS-1].iov_len = rcv_buf_size_left;
+
+
+    val = process_vm_readv(pid, local, NUM_LOCAL_VECS, remote, num_iovecs, 0);
+
+    if (val!=rcv_buf_size_total) {
+      perror("process_vm_readv failed"); 
+      printf("error code: %i\n", errno);
+      exit(1);
+    } else {
+      int i;
+      int num_errors = 0;
+      int count = 0;
+
+      for (i=0; i<NUM_LOCAL_VECS; i++) {
+	for (j=0; j<local[i].iov_len; j++, count++) {
+	  if (((unsigned char *)local[i].iov_base)[j] != count % 256) {
+	    printf("Expected %i, got %i for byte %i\n",
+		   count % 256, ((char*)local[i].iov_base)[j], count);
+	    num_errors++;
+	  }
+	}
+      }
+	
+      if (num_errors) {
+	printf("*************** %i incorrect bytes\n", num_errors);
+	exit(1);
+      } else {
+	printf("Test succeeded\n");
+	exit(0);
+      }
+
+    }
+
+  } else {
+    printf("Internal error %i\n", argc);
+    exit(2);
+  }
+
+  exit(0);
+}
diff --git a/testcases/kernel/syscalls/process_vm_writev/Makefile b/testcases/kernel/syscalls/process_vm_writev/Makefile
new file mode 100644
index 0000000..e0806a7
--- /dev/null
+++ b/testcases/kernel/syscalls/process_vm_writev/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2012
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/process_vm_writev/process_vm.h b/testcases/kernel/syscalls/process_vm_writev/process_vm.h
new file mode 100755
index 0000000..bc69e45
--- /dev/null
+++ b/testcases/kernel/syscalls/process_vm_writev/process_vm.h
@@ -0,0 +1,48 @@
+#ifndef _PROCESS_VM_H
+#define _PROCESS_VM_H
+
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#if defined(i386)
+#define __NR_process_vm_readv 347
+#define __NR_process_vm_writev 348
+
+
+#elif defined(_ARCH_PPC)
+#define __NR_process_vm_readv 351
+#define __NR_process_vm_writev 352
+
+
+#else
+#error "Need to define syscall numbers for process_vm_readv and process_vm_writev for this architecture "
+#endif
+
+
+
+inline ssize_t process_vm_readv(pid_t pid, 
+				const struct iovec  *lvec, 
+				unsigned long liovcnt,
+				const struct iovec *rvec,
+				unsigned long riovcnt,
+				unsigned long flags)
+{
+  return syscall(__NR_process_vm_readv, pid, lvec, liovcnt, rvec, riovcnt, flags);
+}
+
+ssize_t process_vm_writev(pid_t pid, 
+			  const struct iovec  *lvec, 
+			  unsigned long liovcnt,
+			  const struct iovec *rvec,
+			  unsigned long riovcnt,
+			  unsigned long flags)
+{
+  return syscall(__NR_process_vm_writev, pid, lvec, liovcnt, rvec, riovcnt, flags);
+}
+
+
+
+#endif /* _PROCESS_VM_H */
diff --git a/testcases/kernel/syscalls/process_vm_writev/process_vm_writev01.c b/testcases/kernel/syscalls/process_vm_writev/process_vm_writev01.c
new file mode 100644
index 0000000..ebb44fe
--- /dev/null
+++ b/testcases/kernel/syscalls/process_vm_writev/process_vm_writev01.c
@@ -0,0 +1,196 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) International Business Machines  Corp., 2012                 */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/******************************************************************************/
+
+/******************************************************************************/
+/*                                                                            */
+/* File:        process_vm_writev01.c                                         */
+/*                                                                            */
+/* Description: Test the process_vm_writev syscall                            */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   process_vm_writev01                                           */
+/*                                                                            */
+/* Test Assertion                                                             */
+/* and  Strategy: The test allocates a chunk of memory and fork-execs a child */
+/*   to call process_vm_writev to write known data into the parent process    */
+/*   The parent waits for the child to exit and verifies that the data        */
+/*   by the child is as expected                                              */
+/*                                                                            */
+/* Author:      Christopher Yeoh yeohc@au1.ibm.com                            */
+/*                                                                            */
+/* History:     Created - May 2  2012 - Chris Yeoh yeohc@au1.ibm.com          */
+/*                                                                            */
+/*                                                                            */
+/******************************************************************************/
+
+/* Standard Include Files */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+
+/* Harness Specific Include Files. */
+#include "test.h"
+#include "usctest.h"
+
+#include "process_vm.h"
+
+/* Local Defines */
+#if !defined(TRUE) && !defined(FALSE)
+#define TRUE  1
+#define FALSE 0
+#endif
+
+#define DEFAULT_CHAR 53
+#define PADDING_SIZE 10
+
+/* Extern Global Variables */
+extern int  Tst_count;               /* counter for tst_xxx routines.         */
+extern char *TESTDIR;                /* temporary dir created by tst_tmpdir() */
+
+/* Global Variables */
+char *TCID     = "process_vm_writev_test01"; /* test program identifier.          */
+int  TST_TOTAL = 1;                  /* total number of tests in this file.   */
+
+/******************************************************************************/
+/*                                                                            */
+/* Function:    main                                                          */
+/*                                                                            */
+/******************************************************************************/
+int
+main(int   argc,    /* number of command line parameters                      */
+     char **argv)   /* pointer to the array of the command line parameters.   */
+{
+  if (argc==1) {
+    /* setup target */
+    unsigned char *foo;
+    pid_t pid, ppid;
+    int buffer_size = 100000;
+    int i;
+
+    /* Setup target memory */
+    foo = malloc(buffer_size);
+    if (foo==NULL) {
+      perror("Malloc failed");
+      exit(1);
+    }
+
+    for (i=0; i<buffer_size; i++) {
+      foo[i] = DEFAULT_CHAR;
+    }
+
+    ppid = getpid();
+    pid = fork();
+    
+    /* Fork/exec child to write into parent's memory
+       using process_vm_writev */
+    if (pid==0) {
+      /* child */
+      char *s_pid, *s_pointer, *s_size;
+      asprintf(&s_pid, "%i", ppid);
+      asprintf(&s_pointer, "%p", foo);
+      asprintf(&s_size, "%i", buffer_size);
+
+      execlp(argv[0], argv[0], s_pid, s_pointer, s_size, (char*)NULL);
+
+    } else {
+      /* parent */
+      int status;
+      int num_errors = 0;
+      if (wait(&status) != pid) {
+	tst_brkm(TBROK, NULL, "Wait failed");
+      }
+      
+      if (WIFEXITED(status) && WEXITSTATUS(status)==0) {
+	for (i=0; i<buffer_size; i++) {
+	  if (foo[i] != i % 256) {
+	    printf("Expected %i, got %i for byte %i\n",
+		   i % 256, foo[i], i);
+	    num_errors++;
+	  }
+	}
+
+	if (num_errors==0) {
+	  tst_resm(TPASS, "process_vm_writev test passed\n");
+	} else {
+	  tst_resm(TFAIL, "process_vm_writev test failed\n");
+	}
+      } else {
+	  tst_resm(TFAIL, "process_vm_writev test failed\n");
+      }
+      tst_exit();
+    }
+  } else if (argc==4) {
+    /* Write to target */
+    int val;
+    int pid;
+    char *addr;
+    unsigned long len;
+    unsigned char *buf;
+    int j, i;
+    struct iovec local, remote;
+
+    pid = atoi(argv[1]);
+    sscanf(argv[2], "%p", &addr);
+    len = atol(argv[3]);
+
+    buf = malloc(len + PADDING_SIZE * 2);
+    if (buf==NULL) {
+      perror("malloc failed\n");
+      printf("Failed to allocate %lu bytes\n", len + PADDING_SIZE * 2);
+      exit(1);
+    }
+
+    for (j=0; j<len + PADDING_SIZE*2; j++) {
+      buf[j] = DEFAULT_CHAR;
+    }
+
+    for (i=0; i<len; i++) {
+      buf[i + PADDING_SIZE] = i % 256;
+    }
+
+    local.iov_base = buf + PADDING_SIZE;
+    local.iov_len = len;
+    remote.iov_base = addr;
+    remote.iov_len = len;
+
+    val = process_vm_writev(pid, &local, 1, &remote, 1, 0);
+
+    if (val!=len) {
+      perror("copy_from_to failed"); 
+      printf("error code: %i\n", errno);
+      exit(1);
+    } else {
+    }
+    
+  } else {
+    printf("Internal error %i\n", argc);
+    exit(2);
+  }
+
+  exit(0);
+
+}


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
