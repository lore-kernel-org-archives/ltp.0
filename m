Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7Jod-00054R-St
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:31 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7Joc-0005Lk-PS
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:31 +0000
Received: by mail-pz0-f47.google.com with SMTP id o14so271995dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:30 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:43 +0800
Message-Id: <1331614605-30347-10-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 09/11] hugetlb/lib: cleanup codes
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
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


1) removed unnecessary header files in hugetlb/lib
2) removed unnecessary functions in hugetlb/lib
3) code clean-ups for Makefiles and libs

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/Makefile |    1 -
 testcases/kernel/mem/hugetlb/lib/ipcmsg.h      |   58 ----------
 testcases/kernel/mem/hugetlb/lib/ipcsem.h      |   60 -----------
 testcases/kernel/mem/hugetlb/lib/ipcshm.h      |   28 +++---
 testcases/kernel/mem/hugetlb/lib/libipc.c      |  136 +++++-------------------
 5 files changed, 39 insertions(+), 244 deletions(-)
 delete mode 100644 testcases/kernel/mem/hugetlb/lib/ipcmsg.h
 delete mode 100644 testcases/kernel/mem/hugetlb/lib/ipcsem.h


--------------1.7.8.4
Content-Type: text/x-patch; name="0009-hugetlb-lib-cleanup-codes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0009-hugetlb-lib-cleanup-codes.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 601755a..15ae693 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -23,7 +23,6 @@
 top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 
 LIBMEMDIR		:= ../../lib
 LIBMEM			:= $(LIBMEMDIR)/libmem.a
diff --git a/testcases/kernel/mem/hugetlb/lib/ipcmsg.h b/testcases/kernel/mem/hugetlb/lib/ipcmsg.h
deleted file mode 100644
index bb928db..0000000
--- a/testcases/kernel/mem/hugetlb/lib/ipcmsg.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-/*
- * ipcmsg.h - common definitions for the IPC message tests.
- */
-
-#ifndef __IPCMSG_H
-#define __IPCMSG_H	1
-
-#include <errno.h>
-#include <sys/ipc.h>
-#include <sys/msg.h>
-
-#include "test.h"
-#include "usctest.h"
-
-void cleanup(void);
-void setup(void);
-
-#define MSG_RD  0400            /* read permission for the queue */
-#define MSG_WR  0200            /* write permission for the queue */
-#define MSG_RW	MSG_RD | MSG_WR
-
-#define MSGSIZE	1024		/* a resonable size for a message */
-#define MSGTYPE 1		/* a type ID for a message */
-
-typedef struct mbuf {		/* a generic message structure */
-	long mtype;
-	char mtext[MSGSIZE + 1];  /* add 1 here so the message can be 1024   */
-} MSGBUF;			  /* characters long with a '\0' termination */
-
-key_t msgkey;                   /* the ftok() generated message key */
-
-void check_root();
-void init_buf(MSGBUF *, int, int);
-void rm_queue(int);
-
-int getipckey();
-int getuserid(char *);
-
-#endif /* ipcmsg.h */
diff --git a/testcases/kernel/mem/hugetlb/lib/ipcsem.h b/testcases/kernel/mem/hugetlb/lib/ipcsem.h
deleted file mode 100644
index 63baf5f..0000000
--- a/testcases/kernel/mem/hugetlb/lib/ipcsem.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-/*
- * ipcsem.h - common definitions for the IPC semaphore tests
- */
-
-#ifndef __IPCSEM_H
-#define __IPCSEM_H
-
-#include <errno.h>
-#include <sys/ipc.h>
-#include <sys/sem.h>
-
-
-#include "test.h"
-#include "usctest.h"
-
-void cleanup(void);
-void setup(void);
-
-#define SEM_RD	0400
-#define SEM_ALT	0200
-#define SEM_RA	SEM_RD | SEM_ALT
-
-#define PSEMS	10		/* a reasonable value for the number of */
-				/* "primitive semaphores" per ID 	*/
-
-key_t semkey;			/* an IPC key generated by ftok() */
-
-union semun {
-	int val;			/* value for SETVAL */
-	struct semid_ds *buf;		/* buffer for IPC_STAT & IPC_SET */
-	unsigned short *array;		/* array for GETALL & SETALL */
-	struct seminfo *ipc_buf;	/* buffer for IPC_INFO */
-};
-
-void rm_sema(int sem_id);
-void check_root();
-
-int getipckey();
-int getuserid(char *);
-
-#endif /* ipcsem.h */
diff --git a/testcases/kernel/mem/hugetlb/lib/ipcshm.h b/testcases/kernel/mem/hugetlb/lib/ipcshm.h
index 1e9edbe..29a65db 100644
--- a/testcases/kernel/mem/hugetlb/lib/ipcshm.h
+++ b/testcases/kernel/mem/hugetlb/lib/ipcshm.h
@@ -24,35 +24,35 @@
 #ifndef __IPCSHM_H
 #define __IPCSHM_H
 
-#include <errno.h>
-#include <wait.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
+#include <errno.h>
+#include <wait.h>
 #include "test.h"
 #include "usctest.h"
 
-void cleanup(void);
-void setup(void);
-
 #define SHM_RD	0400
 #define SHM_WR	0200
-#define SHM_RW	SHM_RD | SHM_WR
+#define SHM_RW	(SHM_RD|SHM_WR)
 
 #ifndef SHM_HUGETLB
-#define SHM_HUGETLB   04000    /* segment is mapped via hugetlb */
+#define SHM_HUGETLB	04000	/* segment is mapped via hugetlb */
 #endif
 
+/*
+ * to get the lower nine permission bits
+ * from shmid_ds.ipc_perm.mode
+ */
+#define MODE_MASK	0x01FF
 
-#define MODE_MASK	0x01FF			/* to get the lower nine permission bits */
-						/* from shmid_ds.ipc_perm.mode		 */
-
-key_t shmkey;					/* an IPC key generated by ftok() */
+key_t shmkey;			/* an IPC key generated by ftok() */
 
+int getipckey(void);
+int getuserid(char *user);
 void rm_shm(int shm_id);
-void check_root();
 
-int getipckey();
-int getuserid(char*);
+void cleanup(void);
+void setup(void);
 
 char *nr_opt;
 int sflag;
diff --git a/testcases/kernel/mem/hugetlb/lib/libipc.c b/testcases/kernel/mem/hugetlb/lib/libipc.c
index cc3ca02..2120770 100644
--- a/testcases/kernel/mem/hugetlb/lib/libipc.c
+++ b/testcases/kernel/mem/hugetlb/lib/libipc.c
@@ -19,7 +19,7 @@
 
 /*
  * NAME
- *	libmsg.c
+ *	libipc.c
  *
  * DESCRIPTION
  *	common routines for the IPC system call tests.
@@ -27,28 +27,23 @@
  *	The library contains the following routines:
  *
  *	getipckey()
- *	rm_queue()
- *	init_buf()
- *	rm_sema()
- *	check_root()
  *	getuserid()
  *	rm_shm()
+ *	help()
  */
 
-#include "ipcmsg.h"
-#include "ipcsem.h"
-
-#include <pwd.h>
-#include <sys/timeb.h>
+#include <sys/types.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
+#include <sys/timeb.h>
+#include <pwd.h>
+#include "ipcshm.h"
 
 /*
  * getipckey() - generates and returns a message key used by the "get"
  *		 calls to create an IPC resource.
  */
-int
-getipckey()
+int getipckey(void)
 {
 	const char a = 'a';
 	int ascii_a = (int)a;
@@ -57,10 +52,9 @@ getipckey()
 	key_t ipc_key;
 	struct timeb time_info;
 
-	if (NULL == (curdir = getcwd(curdir, size))) {
-		tst_brkm(TBROK, cleanup, "Can't get current directory "
-			 "in getipckey()");
-	}
+	curdir = getcwd(curdir, size);
+	if (curdir == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "getcwd(curdir)");
 
 	/*
 	 * Get a Sys V IPC key
@@ -74,125 +68,45 @@ getipckey()
 	 * number is the millisecond value that is set in the timeb
 	 * structure after calling ftime().
 	 */
-	(void)ftime(&time_info);
+	ftime(&time_info);
 	srandom((unsigned int)time_info.millitm);
 
-	if ((ipc_key = ftok(curdir, ascii_a + random()%26)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't get msgkey from ftok()");
-	}
-
-	return(ipc_key);
-}
-
-/*
- * rm_queue() - removes a message queue.
- */
-void
-rm_queue(int queue_id)
-{
-	if (queue_id == -1) {		/* no queue to remove */
-		return;
-	}
+	ipc_key = ftok(curdir, ascii_a + random()%26);
+	if (ipc_key == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "ftok");
 
-	if (msgctl(queue_id, IPC_RMID, NULL) == -1) {
-		tst_resm(TINFO, "WARNING: message queue deletion failed.");
-		tst_resm(TINFO, "This could lead to IPC resource problems.");
-		tst_resm(TINFO, "id = %d", queue_id);
-	}
-}
-
-/*
- * init_buf() - initialize the message buffer with some text and a type.
- */
-void
-init_buf(MSGBUF *m_buf, int type, int size)
-{
-	int i;
-	int ascii_a = (int)'a';		/* the ascii value for 'a' */
-
-	/* this fills the message with a repeating alphabet string */
-	for (i=0; i<size; i++) {
-		m_buf->mtext[i] = ascii_a + (i % 26);
-	}
-
-	/* terminate the message */
-	m_buf->mtext[i] = '\0';
-
-	/* if the type isn't valid, set it to 1 */
-	if (type < 1) {
-		m_buf->mtype = 1;
-	} else {
-		m_buf->mtype = type;
-	}
-}
-
-/*
- * rm_sema() - removes a semaphore.
- */
-void
-rm_sema(int sem_id)
-{
-	union semun arr;
-
-	if (sem_id == -1) {		/* no semaphore to remove */
-		return;
-	}
-
-	if (semctl(sem_id, 0, IPC_RMID, arr) == -1) {
-		tst_resm(TINFO, "WARNING: semaphore deletion failed.");
-		tst_resm(TINFO, "This could lead to IPC resource problems.");
-		tst_resm(TINFO, "id = %d", sem_id);
-	}
-}
-
-/*
- * check_root() - make sure the process ID is root
- */
-void
-check_root()
-{
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, cleanup, "test must be run as root");
-	}
+	return ipc_key;
 }
 
 /*
  * getuserid() - return the integer value for the "user" id
  */
-int
-getuserid(char *user)
+int getuserid(char *user)
 {
 	struct passwd *ent;
 
-	/* allocate some space for the passwd struct */
-	if ((ent = (struct passwd *)malloc(sizeof(struct passwd))) == NULL) {
-	     tst_brkm(TBROK, cleanup, "couldn't allocate space for passwd"
-		      " structure");
-        }
+	ent = (struct passwd *)malloc(sizeof(struct passwd));
+	if (ent == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "malloc ent");
 
-	/* get the uid value for the user */
-	if ((ent = getpwnam(user)) == NULL) {
-		tst_brkm(TBROK, cleanup, "Couldn't get password entry for %s",
-			 user);
-	}
+	ent = getpwnam(user);
+	if (ent == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "getpwnam");
 
-	return(ent->pw_uid);
+	return ent->pw_uid;
 }
 
 /*
  * rm_shm() - removes a shared memory segment.
  */
-void
-rm_shm(int shm_id)
+void rm_shm(int shm_id)
 {
-	if (shm_id == -1) {		/* no segment to remove */
+	if (shm_id == -1)
 		return;
-	}
 
 	/*
 	 * check for # of attaches ?
 	 */
-
 	if (shmctl(shm_id, IPC_RMID, NULL) == -1) {
 		tst_resm(TINFO, "WARNING: shared memory deletion failed.");
 		tst_resm(TINFO, "This could lead to IPC resource problems.");

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



