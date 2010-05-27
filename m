Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1OHb77-0006Xn-FJ
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 11:19:01 +0000
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHb73-0001Vi-DI
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 11:19:00 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4RB6e7n008804
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 21:06:40 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4RBA5i91220652
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 21:10:05 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4RBA5ks004503
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 21:10:05 +1000
Message-ID: <4BFE530A.10709@in.ibm.com>
Date: Thu, 27 May 2010 16:40:02 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080209020208030203030201"
Subject: [LTP] [RFC] Timer related syscalls for LTP test
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
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>, iranna.ankad@in.ibm.com

This is a multi-part message in MIME format.
--------------080209020208030203030201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have found a problem with the timer related syscall tests.

The following syscall tests, uses the direct syscall interface to the 
kernel for testing the interface, instead of using the GLIBC interface.

testcases/kernel/syscalls
	\_ timer_getoverrun/
	\_ timer_gettime/

testcases/kernel/timers
	\_ timer_create/
	\_ timer_delete/
	\_ timer_settime/

So they use :
	syscall(__NR_timer_XXXX, args )
for directly using the kernel syscall interface than using the

	timer_xxxxx(args)

provided by the GLIBC. This is completely fine.

But however there is a mismatch in the "timer_t" type defined by the 
Linux kernel and the GNU Libc.

Linux kernel defines it as an int for all architectures.

include/linux/types.h :

typedef __kernel_timer_t timer_t;

arch/powerpc/include/asm/posix_types.h :
typedef int __kernel_timer_t;


Now, the glibc provides a wrapper to the timer related system calls. 
While providing the wrapper, Glibc stores some internal data associated 
with the timer. So it defines the "timer_t" as a pointer (void*) as below:

/usr/include/time.h :

/* Timer ID returned by `timer_create'.  */
typedef __timer_t timer_t;


in /usr/include/bits/types.h :

/* Timer ID returned by `timer_create'.  */
__STD_TYPE __TIMER_T_TYPE __timer_t;

in /usr/include/bits/typesizes.h

#define __TIMER_T_TYPE          void *


So that leads to the definiton of timer_t as void* by glibc. And this 
cannot be changed. But the glibc uses the "proper" typed argument for 
the syscalls it issues by defining a kernel_timer_t.

On 32bit machines the difference is not noticed, since both the timer_t 
in userspace and the kernel space are of the same size. But on 64bit 
machines this is different.

Userspace has a width of 64bit and the kernel has 32bit width. Now, when 
we pass the pointer to timer_t to the kernel, things get complicated and 
on Big endian machines, ppc64, s390x, this leads to a problem. As the 
value kept is not available when we try to dereference it as a 32bit and 
this leads to undesired results like below:

timer_getoverrun01    1  TFAIL  :  Block 1: test 0 FAILED... errno = 22 
:Invalid argument


strace shows :


13017 timer_create(CLOCK_REALTIME, {(nil), SIGALRM, SIGEV_SIGNAL, 
{...}},{0x26e80}) = 0
13017 fstat(1, {st_dev=makedev(0, 11), st_ino=3, st_mode=S_IFCHR|0620,
st_nlink=1, st_uid=0, st_gid=5, st_blksize=1024, st_blocks=0, 
st_rdev=makedev(136, 0), 
st_atime=2010/05/17-15:48:40,st_mtime=2010/05/17-15:48:40, 
st_ctime=2010/05/17-13:15:48}) = 0
13017 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0)= 0x20000028000
13017 write(1, "timer_getoverrun01    0  TINFO  "..., 66) = 66
13017 timer_getoverrun(0x26e80)         = -1 EINVAL (Invalid argument)


So the conclusion is that, if we are using the System calls directly, we 
should use the argument which is compatible with the kernel. We simply 
*cannot* use the glibc definition and the kernel API directly.

I have a patch attached below that fixes this issue.

One more comment regarding the placement of timer_gettime and 
timer_getoverrun syscall tests. I strongly believe they could be moved 
to testcases/kernel/timers/ directory where the rest of the timer 
related syscall tests are placed. If that change is made, we can use the 
definition added in common_timers.h (in the patch) for those tests too, 
instead of defining in each of the tests.


Thanks

Suzuki









--------------080209020208030203030201
Content-Type: text/plain; name="fix-timer_t-definition-for-syscall-tests.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-timer_t-definition-for-syscall-tests.diff"

Signed-off-by: Suzuki K P <suzuki@in.ibm.com>

Fix timer_t argument for timer related direct syscalls.

The tests timer_getoverrun and timer_gettime should be moved to testcases/kernel/timers
directory. If that is done, then we could use the definition in the common_timers.h, like
the other tests.

 /*  Description */
There is a mismatch in the "timer_t" type defined by the Linux kernel and the GNU Libc.

Linux kernel defines it as an int for all architectures.

include/linux/types.h :  

typedef __kernel_timer_t timer_t;

arch/powerpc/include/asm/posix_types.h : 
typedef int __kernel_timer_t;


Now, the glibc provides a wrapper to the timer related system calls. While providing the wrapper, Glibc stores some internal data associated with the timer. So it defines the "timer_t" as a pointer (void*) as below:

/usr/include/time.h :

/* Timer ID returned by `timer_create'.  */
typedef __timer_t timer_t;


in /usr/include/bits/types.h :

/* Timer ID returned by `timer_create'.  */
__STD_TYPE __TIMER_T_TYPE __timer_t;

in /usr/include/bits/typesizes.h

#define __TIMER_T_TYPE          void *


So that leads to the definiton of timer_t as void* by glibc. And this cannot be changed. But the glibc uses the "proper" typed argument for the syscalls it issues by defining a kernel_timer_t.

On 32bit machines the difference is not noticed, since both the timer_t in userspace and the kernel space are of the same size. But on 64bit machines this is different.

Userspace has a width of 64bit and the kernel has 32bit width. Now, when we pass the pointer to timer_t to the kernel, things get complicated and on Big endian machines, ppc64, s390x, this leads to a problem. As the value kept is not available when we try to dereference it as a 32bit and this leads to undesired results

Index: ltp/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c	2009-05-21 18:41:36.000000000 +0000
+++ ltp/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c	2010-05-27 13:46:55.000000000 +0000
@@ -49,6 +49,11 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
+/* timer_t in kernel(int) is different from  Glibc definition(void*).
+ * Use the kernel definition.
+ */
+typedef int kernel_timer_t;
+
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
 extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
@@ -120,7 +125,7 @@
 int main(int ac, char **av) {
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
-	timer_t created_timer_id;
+	kernel_timer_t created_timer_id;
         struct sigevent ev;
 	
         /* parse standard options */
Index: ltp/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c	2009-05-21 18:43:48.000000000 +0000
+++ ltp/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c	2010-05-27 13:47:25.000000000 +0000
@@ -48,6 +48,11 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
+/* timer_t in kernel(int) is different from  Glibc definition(void*).
+ * Use the kernel definition.
+ */
+typedef int kernel_timer_t;
+
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
 extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
@@ -122,7 +127,7 @@
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
 
-        timer_t created_timer_id;
+        kernel_timer_t created_timer_id;
         struct sigevent ev;
         struct itimerspec spec;
 
Index: ltp/testcases/kernel/timers/timer_delete/timer_delete02.c
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_delete/timer_delete02.c	2009-12-06 20:53:44.000000000 +0000
+++ ltp/testcases/kernel/timers/timer_delete/timer_delete02.c	2010-05-27 14:01:21.000000000 +0000
@@ -84,7 +84,7 @@
 {
 	int lc;		/* loop counter */
 	char *msg;	/* message returned from parse_opts */
-	timer_t timer_id;
+	kernel_timer_t timer_id;
 
 	/* parse standard options */
 	if ((msg = parse_opts (ac, av, (option_t *) NULL, NULL)) !=
Index: ltp/testcases/kernel/timers/timer_delete/timer_delete03.c
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_delete/timer_delete03.c	2009-12-06 20:53:44.000000000 +0000
+++ ltp/testcases/kernel/timers/timer_delete/timer_delete03.c	2010-05-27 14:01:35.000000000 +0000
@@ -73,7 +73,7 @@
 #include "usctest.h"
 #include "common_timers.h"
 
-#define INVALID_ID ((timer_t)-1)
+#define INVALID_ID ((kernel_timer_t)-1)
 
 static void setup();
 
Index: ltp/testcases/kernel/timers/timer_create/timer_create02.c
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_create/timer_create02.c	2010-05-19 06:19:20.000000000 +0000
+++ ltp/testcases/kernel/timers/timer_create/timer_create02.c	2010-05-27 14:00:08.000000000 +0000
@@ -86,7 +86,7 @@
 {
 	int lc, i, j;		/* loop counter */
 	char *msg;			/* message returned from parse_opts */
-	timer_t created_timer_id;	/* holds the returned timer_id */
+	kernel_timer_t created_timer_id;	/* holds the returned timer_id */
 	char *message[3] = {
 		"SIGEV_SIGNAL",
 		"NULL",
Index: ltp/testcases/kernel/timers/timer_create/timer_create03.c
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_create/timer_create03.c	2009-12-06 20:53:44.000000000 +0000
+++ ltp/testcases/kernel/timers/timer_create/timer_create03.c	2010-05-27 14:00:47.000000000 +0000
@@ -100,7 +100,7 @@
 {
 	int lc, i;			/* loop counter */
 	char *msg;			/* message returned from parse_opts */
-	timer_t created_timer_id;	/* holds the returned timer_id */
+	kernel_timer_t created_timer_id;	/* holds the returned timer_id */
 	char *message[] = {
 		"SIGEV_SIGNAL",
 		"NULL",
Index: ltp/testcases/kernel/timers/timer_create/timer_create04.c
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_create/timer_create04.c	2009-12-06 20:53:44.000000000 +0000
+++ ltp/testcases/kernel/timers/timer_create/timer_create04.c	2010-05-27 14:01:05.000000000 +0000
@@ -111,7 +111,7 @@
 {
 	int lc, i;			/* loop counter */
 	char *msg;			/* message returned from parse_opts */
-	timer_t timer_id, *temp_id;	/* stores the returned timer_id */
+	kernel_timer_t timer_id, *temp_id;	/* stores the returned timer_id */
 	struct sigevent *temp_ev;	/* used for bad address test case */
 
 	clockid_t clocks[6] = {
@@ -158,7 +158,7 @@
 
 			switch (i) {
 			case 2: /* make the timer_id bad address */
-				temp_id = (timer_t *) -1;
+				temp_id = (kernel_timer_t *) -1;
 				break;
 			case 3:
 				/* make the event bad address */
@@ -167,7 +167,7 @@
 			case 4:
 				/* Produce an invalid timer_id address. */
 				if(tst_kvercmp(2, 6, 12) >= 0)
-					temp_id = (timer_t *) -1;
+					temp_id = (kernel_timer_t *) -1;
 				break;
 			case 5:
 				/* Produce an invalid event address. */
Index: ltp/testcases/kernel/timers/timer_settime/timer_settime02.c
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_settime/timer_settime02.c	2009-12-06 20:53:44.000000000 +0000
+++ ltp/testcases/kernel/timers/timer_settime/timer_settime02.c	2010-05-27 14:01:53.000000000 +0000
@@ -81,7 +81,7 @@
 extern int Tst_count;		/* Test Case counter for tst_* routines */
 
 static struct itimerspec new_set, old_set, *old_temp;
-static timer_t timer;
+static kernel_timer_t timer;
 static int flag;
 
 int
Index: ltp/testcases/kernel/timers/timer_settime/timer_settime03.c
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_settime/timer_settime03.c	2009-12-06 20:53:44.000000000 +0000
+++ ltp/testcases/kernel/timers/timer_settime/timer_settime03.c	2010-05-27 14:02:03.000000000 +0000
@@ -81,7 +81,7 @@
 extern int Tst_count;		/* Test Case counter for tst_* routines */
 
 static struct itimerspec new_set, old_set, *old_temp, *new_temp;
-static timer_t timer, tim;
+static kernel_timer_t timer, tim;
 
 static int exp_enos[] = {EINVAL, EFAULT, 0};
 
@@ -168,7 +168,7 @@
 		break;
 	case 3:
 		/* make timer_id invalid */
-		tim = (timer_t)-1;
+		tim = (kernel_timer_t)-1;
 		new_set.it_value.tv_nsec = 0;
 		break;
 	case 4:
Index: ltp/testcases/kernel/timers/include/common_timers.h
===================================================================
--- ltp.orig/testcases/kernel/timers/include/common_timers.h	2010-05-19 06:19:20.000000000 +0000
+++ ltp/testcases/kernel/timers/include/common_timers.h	2010-05-27 14:02:50.000000000 +0000
@@ -63,4 +63,9 @@
 #include <time.h>
 #include <unistd.h>
 
+/* timer_t in kernel(int) is different from  Glibc definition(void*).
+ * Use the kernel definition for syscall tests
+ */
+typedef int kernel_timer_t;
+
 #endif

--------------080209020208030203030201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--------------080209020208030203030201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080209020208030203030201--

