Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q5mPR-0003GA-G1
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:37 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q5mPQ-0005Ax-Fr
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:37 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  1 Apr 2011 17:01:24 -0500
Message-Id: <fd62b40430e6b1c99c8c1495fbc2d17ce2f959b0.1301695094.git.aelder@sgi.com>
In-Reply-To: <1301695288-24912-1-git-send-email-aelder@sgi.com>
References: <1301695288-24912-1-git-send-email-aelder@sgi.com>
In-Reply-To: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
References: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
Subject: [LTP] [PATCH 2/6] ltp: move type definitions up in "doio.c"
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

The definitions of some types are spread around in the file
"testcases/kernel/fs/doio/doio.c".  Group them near the top of the
file.  This is in preparation for the next change, which adds
full-fledged C prototypes for all functions in the file.

All changes in this patch are simple "bulk moves" of blocks of
code from one place in the file to another.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/fs/doio/doio.c |  220 +++++++++++++++++++-------------------
 1 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/testcases/kernel/fs/doio/doio.c b/testcases/kernel/fs/doio/doio.c
index a2c50aa..65b76da 100644
--- a/testcases/kernel/fs/doio/doio.c
+++ b/testcases/kernel/fs/doio/doio.c
@@ -87,6 +87,115 @@
 #include "random_range.h"
 #include "string_to_tokens.h"
 
+#define	NMEMALLOC	32
+#define	MEM_DATA	1	/* data space 				*/
+#define	MEM_SHMEM	2	/* System V shared memory 		*/
+#define	MEM_T3ESHMEM	3	/* T3E Shared Memory 			*/
+#define	MEM_MMAP	4	/* mmap(2) 				*/
+
+#define	MEMF_PRIVATE	0001
+#define	MEMF_AUTORESRV	0002
+#define	MEMF_LOCAL	0004
+#define	MEMF_SHARED	0010
+
+#define	MEMF_FIXADDR	0100
+#define	MEMF_ADDR	0200
+#define	MEMF_AUTOGROW	0400
+#define	MEMF_FILE	01000	/* regular file -- unlink on close	*/
+#define	MEMF_MPIN	010000	/* use mpin(2) to lock pages in memory */
+
+struct memalloc {
+	int	memtype;
+	int	flags;
+	int	nblks;
+	char	*name;
+	void	*space;		/* memory address of allocated space */
+	int	fd;		/* FD open for mmaping */
+	int	size;
+}	Memalloc[NMEMALLOC];
+
+/*
+ * Structure for maintaining open file test descriptors.  Used by
+ * alloc_fd().
+ */
+
+struct fd_cache {
+	char    c_file[MAX_FNAME_LENGTH+1];
+	int	c_oflags;
+	int	c_fd;
+	long    c_rtc;
+#ifdef sgi
+	int	c_memalign;	/* from F_DIOINFO */
+	int	c_miniosz;
+	int	c_maxiosz;
+#endif
+#ifndef CRAY
+	void	*c_memaddr;	/* mmapped address */
+	int	c_memlen;	/* length of above region */
+#endif
+};
+
+/*
+ * Name-To-Value map
+ * Used to map cmdline arguments to values
+ */
+struct smap {
+	char    *string;
+	int	value;
+};
+
+struct aio_info {
+	int			busy;
+	int			id;
+	int			fd;
+	int			strategy;
+	volatile int		done;
+#ifdef CRAY
+	struct iosw		iosw;
+#endif
+#ifdef sgi
+	aiocb_t			aiocb;
+	int			aio_ret;	/* from aio_return */
+	int			aio_errno;	/* from aio_error */
+#endif
+	int			sig;
+	int			signalled;
+	struct sigaction	osa;
+};
+
+/* ---------------------------------------------------------------------------
+ *
+ * A new paradigm of doing the r/w system call where there is a "stub"
+ * function that builds the info for the system call, then does the system
+ * call; this is called by code that is common to all system calls and does
+ * the syscall return checking, async I/O wait, iosw check, etc.
+ *
+ * Flags:
+ *	WRITE, ASYNC, SSD/SDS,
+ *	FILE_LOCK, WRITE_LOG, VERIFY_DATA,
+ */
+
+struct	status {
+	int	rval;		/* syscall return */
+	int	err;		/* errno */
+	int	*aioid;		/* list of async I/O structures */
+};
+
+struct syscall_info {
+	char		*sy_name;
+	int		sy_type;
+	struct status	*(*sy_syscall)();
+	int		(*sy_buffer)();
+	char		*(*sy_format)();
+	int		sy_flags;
+	int		sy_bits;
+};
+
+#define	SY_WRITE		00001
+#define	SY_ASYNC		00010
+#define	SY_IOSW			00020
+#define	SY_SDS			00100
+
 #ifndef O_SSD
 #define O_SSD 0	    	/* so code compiles on a CRAY2 */
 #endif
@@ -173,33 +282,6 @@ int	havesigint = 0;
 
 #define SKIP_REQ	-2	/* skip I/O request */
 
-#define	NMEMALLOC	32
-#define	MEM_DATA	1	/* data space 				*/
-#define	MEM_SHMEM	2	/* System V shared memory 		*/
-#define	MEM_T3ESHMEM	3	/* T3E Shared Memory 			*/
-#define	MEM_MMAP	4	/* mmap(2) 				*/
-
-#define	MEMF_PRIVATE	0001
-#define	MEMF_AUTORESRV	0002
-#define	MEMF_LOCAL	0004
-#define	MEMF_SHARED	0010
-
-#define	MEMF_FIXADDR	0100
-#define	MEMF_ADDR	0200
-#define	MEMF_AUTOGROW	0400
-#define	MEMF_FILE	01000	/* regular file -- unlink on close	*/
-#define MEMF_MPIN	010000	/* use mpin(2) to lock pages in memory */
-
-struct memalloc {
-	int	memtype;
-	int	flags;
-	int	nblks;
-	char	*name;
-	void	*space;		/* memory address of allocated space */
-	int	fd;		/* FD open for mmaping */
-	int	size;
-}	Memalloc[NMEMALLOC];
-
 /*
  * Global file descriptors
  */
@@ -207,27 +289,6 @@ struct memalloc {
 int 	Wfd_Append; 	    /* for appending to the write-log	    */
 int 	Wfd_Random; 	    /* for overlaying write-log entries	    */
 
-/*
- * Structure for maintaining open file test descriptors.  Used by
- * alloc_fd().
- */
-
-struct fd_cache {
-	char    c_file[MAX_FNAME_LENGTH+1];
-	int	c_oflags;
-	int	c_fd;
-	long    c_rtc;
-#ifdef sgi
-	int	c_memalign;	/* from F_DIOINFO */
-	int	c_miniosz;
-	int	c_maxiosz;
-#endif
-#ifndef CRAY
-	void	*c_memaddr;	/* mmapped address */
-	int	c_memlen;	/* length of above region */
-#endif
-};
-
 #define FD_ALLOC_INCR	32      /* allocate this many fd_map structs	*/
 				/* at a time */
 
@@ -297,15 +358,6 @@ struct	fd_cache *alloc_fdcache(char *, int);
 
 #define U_ALL	    	(U_CORRUPTION | U_IOSW | U_RVAL)
 
-/*
- * Name-To-Value map
- * Used to map cmdline arguments to values
- */
-struct smap {
-	char    *string;
-	int	value;
-};
-
 struct smap Upanic_Args[] = {
 	{ "corruption",	U_CORRUPTION	},
 	{ "iosw",	U_IOSW		},
@@ -314,25 +366,6 @@ struct smap Upanic_Args[] = {
 	{ NULL,         0               }
 };
 
-struct aio_info {
-	int			busy;
-	int			id;
-	int			fd;
-	int			strategy;
-	volatile int		done;
-#ifdef CRAY
-	struct iosw		iosw;
-#endif
-#ifdef sgi
-	aiocb_t			aiocb;
-	int			aio_ret;	/* from aio_return */
-	int			aio_errno;	/* from aio_error */
-#endif
-	int			sig;
-	int			signalled;
-	struct sigaction	osa;
-};
-
 struct aio_info	Aio_Info[MAX_AIO];
 
 struct aio_info	*aio_slot();
@@ -2220,39 +2253,6 @@ struct io_req	*req;
 
 #endif /* _CRAY1 */
 
-/* ---------------------------------------------------------------------------
- *
- * A new paradigm of doing the r/w system call where there is a "stub"
- * function that builds the info for the system call, then does the system
- * call; this is called by code that is common to all system calls and does
- * the syscall return checking, async I/O wait, iosw check, etc.
- *
- * Flags:
- *	WRITE, ASYNC, SSD/SDS,
- *	FILE_LOCK, WRITE_LOG, VERIFY_DATA,
- */
-
-struct	status {
-	int	rval;		/* syscall return */
-	int	err;		/* errno */
-	int	*aioid;		/* list of async I/O structures */
-};
-
-struct syscall_info {
-	char		*sy_name;
-	int		sy_type;
-	struct status	*(*sy_syscall)();
-	int		(*sy_buffer)();
-	char		*(*sy_format)();
-	int		sy_flags;
-	int		sy_bits;
-};
-
-#define	SY_WRITE		00001
-#define	SY_ASYNC		00010
-#define	SY_IOSW			00020
-#define	SY_SDS			00100
-
 char *
 fmt_ioreq(struct io_req *ioreq, struct syscall_info *sy, int fd)
 {
@@ -5435,4 +5435,4 @@ FILE	*stream;
 	fprintf(stream, "\t                     of io_req structures (see doio.h).  Currently\n");
 	fprintf(stream, "\t                     only the iogen program generates the proper\n");
 	fprintf(stream, "\t                     format\n");
-}
\ No newline at end of file
+}
-- 
1.7.4


------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
