From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 23 Nov 2016 15:18:28 +0800
Subject: [LTP] [PATCH 1/4] ipc/lib: add header files for new API
Message-ID: <1479885511-7414-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

1) add tst_ipcmsg.h for new API
2) add tst_ipcsem.h for new API
3=EF=BC=89add tst_ipcshm.h for new API
4) fix libipc.c for new API

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/lib/libipc.c     |  6 +--
 testcases/kernel/syscalls/ipc/lib/tst_ipcmsg.h | 61 ++++++++++++++++++++++=
++++
 testcases/kernel/syscalls/ipc/lib/tst_ipcsem.h | 52 ++++++++++++++++++++++
 testcases/kernel/syscalls/ipc/lib/tst_ipcshm.h | 47 ++++++++++++++++++++
 4 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/lib/tst_ipcmsg.h
 create mode 100644 testcases/kernel/syscalls/ipc/lib/tst_ipcsem.h
 create mode 100644 testcases/kernel/syscalls/ipc/lib/tst_ipcshm.h

diff --git a/testcases/kernel/syscalls/ipc/lib/libipc.c b/testcases/kernel/=
syscalls/ipc/lib/libipc.c
index 4de7faa..856bfdb 100644
--- a/testcases/kernel/syscalls/ipc/lib/libipc.c
+++ b/testcases/kernel/syscalls/ipc/lib/libipc.c
@@ -58,7 +58,7 @@ key_t getipckey(void)
 	static int count =3D 0;
=20
 	if (NULL =3D=3D (curdir =3D getcwd(curdir, size))) {
-		tst_brkm(TBROK, cleanup, "Can't get current directory "
+		tst_brkm(TBROK, NULL, "Can't get current directory "
 			 "in getipckey()");
 	}
=20
@@ -72,7 +72,7 @@ key_t getipckey(void)
 	count++;
=20
 	if ((ipc_key =3D ftok(curdir, proj_id)) =3D=3D -1) {
-		tst_brkm(TBROK, cleanup, "Can't get msgkey from ftok()");
+		tst_brkm(TBROK, NULL, "Can't get msgkey from ftok()");
 	}
=20
 	return (ipc_key);
@@ -145,7 +145,7 @@ int getuserid(char *user)
=20
 	/* get the uid value for the user */
 	if ((ent =3D getpwnam(user)) =3D=3D NULL) {
-		tst_brkm(TBROK, cleanup, "Couldn't get password entry for %s",
+		tst_brkm(TBROK, NULL, "Couldn't get password entry for %s",
 			 user);
 	}
=20
diff --git a/testcases/kernel/syscalls/ipc/lib/tst_ipcmsg.h b/testcases/ker=
nel/syscalls/ipc/lib/tst_ipcmsg.h
new file mode 100644
index 0000000..ec80e31
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/lib/tst_ipcmsg.h
@@ -0,0 +1,61 @@
+/*
+ * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+/*
+ * ipcmsg.h - common definitions for the IPC message tests.
+ */
+
+#ifndef __IPCMSG_H
+#define __IPCMSG_H	1
+
+#include <errno.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/types.h>
+
+#define MSG_RD  0400            /* read permission for the queue */
+#define MSG_WR  0200            /* write permission for the queue */
+#define MSG_RW	(MSG_RD | MSG_WR)
+
+#define MSGSIZE	1024		/* a resonable size for a message */
+#define MSGTYPE 1		/* a type ID for a message */
+
+#define NR_MSGQUEUES	16	/* MSGMNI as defined in linux/msg.h */
+
+#define min(a, b)	(((a) < (b)) ? @ : (b))
+
+typedef struct mbuf {		/* a generic message structure */
+	long mtype;
+	char mtext[MSGSIZE + 1];  /* add 1 here so the message can be 1024   */
+} MSGBUF;			  /* characters long with a '\0' termination */
+
+#ifdef LIBIPC
+key_t msgkey;                   /* the ftok() generated message key */
+#else
+extern key_t msgkey;                   /* the ftok() generated message key=
 */
+#endif
+
+void init_buf(MSGBUF *m_buf, int type, int size);
+void rm_queue(int queue_id);
+
+key_t getipckey(void);
+int getuserid(char *user);
+
+int get_max_msgqueues(void);
+int get_used_msgqueues(void);
+
+#endif /* ipcmsg.h */
diff --git a/testcases/kernel/syscalls/ipc/lib/tst_ipcsem.h b/testcases/ker=
nel/syscalls/ipc/lib/tst_ipcsem.h
new file mode 100644
index 0000000..d9be9ab
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/lib/tst_ipcsem.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+/*
+ * ipcsem.h - common definitions for the IPC semaphore tests
+ */
+
+#ifndef __IPCSEM_H
+#define __IPCSEM_H
+
+#include <errno.h>
+#include <sys/ipc.h>
+#include <sys/sem.h>
+
+#include "lapi/semun.h"
+
+#define SEM_RD	0400
+#define SEM_ALT	0200
+#define SEM_RA	(SEM_RD | SEM_ALT)
+
+/*
+ * a reasonable value for the number of
+ * "primitive semaphores" per ID
+ */
+#define PSEMS	10
+
+#ifdef LIBIPC
+key_t semkey;			/* an IPC key generated by ftok() */
+#else
+extern key_t semkey;		/* an IPC key generated by ftok() */
+#endif
+
+void rm_sema(int sem_id);
+
+int getipckey(void);
+int getuserid(char *user);
+
+#endif /* ipcsem.h */
diff --git a/testcases/kernel/syscalls/ipc/lib/tst_ipcshm.h b/testcases/ker=
nel/syscalls/ipc/lib/tst_ipcshm.h
new file mode 100644
index 0000000..c5876d4
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/lib/tst_ipcshm.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+/*
+ * ipcshm.h - common definitions for the IPC shared memory tests
+ */
+
+#ifndef __IPCSHM_H
+#define __IPCSHM_H
+
+#include <errno.h>
+#include <wait.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+
+#define SHM_RD	0400
+#define SHM_WR	0200
+#define SHM_RW	(SHM_RD | SHM_WR)
+
+#define SHM_SIZE	2048	/* a resonable size for a memory segment */
+#define INT_SIZE	4	/* instead of sizeof(int) */
+
+#define MODE_MASK	0x01FF	/* to get the lower nine permission bits */
+				/* from shmid_ds.ipc_perm.mode		 */
+
+key_t shmkey;			/* an IPC key generated by ftok() */
+
+void rm_shm(int shm_id);
+
+int getipckey(void);
+int getuserid(char *user);
+
+#endif /* ipcshm.h */
--=20
1.8.3.1



