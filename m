Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q5mPR-0001xq-W4
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:37 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q5mPQ-0004L1-P5
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:37 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  1 Apr 2011 17:01:25 -0500
Message-Id: <be4a4189d3c632186a2c7e4cd2d1aaba604af96a.1301695094.git.aelder@sgi.com>
In-Reply-To: <1301695288-24912-1-git-send-email-aelder@sgi.com>
References: <1301695288-24912-1-git-send-email-aelder@sgi.com>
In-Reply-To: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
References: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
Subject: [LTP] [PATCH 3/6] ltp: use C function prototypes in "doio.c"
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

Many functions in "doio.c" are defined using old-style C
declarations.  Convert all functions so they follow standard C,
and include standard prototypes for each.

Every function (except main()) now has a standard C prototype, and
all prototypes are grouped in the same section of the file.  The
prototypes--as well as the function definitions themselves--now
follow a consistent formatting style.

One more change was made, to some signal handler functions.
Previously, a few of them were defined without an integer argument,
and so did not comply with the definition of a sighandler_t function
(defined in signal(2)).  These have been fixed to conform.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/fs/doio/doio.c |  448 +++++++++++++++++++--------------------
 1 files changed, 216 insertions(+), 232 deletions(-)

diff --git a/testcases/kernel/fs/doio/doio.c b/testcases/kernel/fs/doio/doio.c
index 65b76da..b22b590 100644
--- a/testcases/kernel/fs/doio/doio.c
+++ b/testcases/kernel/fs/doio/doio.c
@@ -86,6 +86,7 @@
 #include "write_log.h"
 #include "random_range.h"
 #include "string_to_tokens.h"
+#include "pattern.h"
 
 #define	NMEMALLOC	32
 #define	MEM_DATA	1	/* data space 				*/
@@ -311,42 +312,158 @@ int	Pattern_Length;
  * Signal handlers, and related globals
  */
 
-void	sigint_handler();	/* Catch SIGINT in parent doio, propagate
-				 * to children, does not die. */
+char		*syserrno(int err);
+void		doio(void);
+void		doio_delay(void);
+char		*format_oflags(int oflags);
+char		*format_strat(int strategy);
+char		*format_rw(struct io_req *ioreq, int fd, void *buffer,
+			int signo, char *pattern, void *iosw);
+#ifdef CRAY
+char		*format_sds(struct io_req *ioreq, void *buffer, int sds
+			char *pattern);
+#endif /* CRAY */
+
+int		do_read(struct io_req *req);
+int		do_write(struct io_req *req);
+int		lock_file_region(char *fname, int fd, int type, int start,
+			int nbytes);
 
-void	die_handler();		/* Bad sig in child doios, exit 1. */
-void	cleanup_handler();	/* Normal kill, exit 0. */
+#ifdef CRAY
+char		*format_listio(struct io_req *ioreq, int lcmd,
+			struct listreq *list, int nent, int fd, char *pattern);
+#endif /* CRAY */
+
+int		do_listio(struct io_req *req);
+
+#if defined(_CRAY1) || defined(CRAY)
+int		do_ssdio(struct io_req *req);
+#endif /* defined(_CRAY1) || defined(CRAY) */
+
+char		*fmt_ioreq(struct io_req *ioreq, struct syscall_info *sy,
+			int fd);
+
+#ifdef CRAY
+struct status	*sy_listio(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr);
+int		listio_mem(struct io_req *req, int offset, int fmstride,
+			int *min, int *max);
+char		*fmt_listio(struct io_req *req, struct syscall_info *sy,
+			int fd, char *addr);
+#endif /* CRAY */
+
+#ifdef sgi
+struct status	*sy_pread(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr);
+struct status	*sy_pwrite(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr);
+char		*fmt_pread(struct io_req *req, struct syscall_info *sy,
+			int fd, char *addr);
+#endif	/* sgi */
 
 #ifndef CRAY
-void	sigbus_handler();	/* Handle sigbus--check active_mmap_rw to
-				   decide if this should be a normal exit. */
-#endif
+struct status	*sy_readv(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr);
+struct status	*sy_writev(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr);
+struct status	*sy_rwv(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr, int rw);
+char		*fmt_readv(struct io_req *req, struct syscall_info *sy,
+			int fd, char *addr);
+#endif /* !CRAY */
 
-void	cb_handler();		/* Posix aio callback handler. */
-void	noop_handler();		/* Delayop alarm, does nothing. */
-char	*hms();
-char	*format_rw();
-char	*format_sds();
-char	*format_listio();
-char	*check_file();
-int	doio_fprintf(FILE *stream, char *format, ...);
-void	doio_upanic();
-void	doio();
-void	help();
-void	doio_delay();
-int     alloc_fd( char *, int );
-int     alloc_mem( int );
-int     do_read( struct io_req * );
-int     do_write( struct io_req * );
-int     do_rw( struct io_req * );
-int     do_sync( struct io_req * );
-int     usage( FILE * );
-int     aio_unregister( int );
-int	pattern_check(char *buf, int buflen, char *pat, int patlen, int patshift);
-int	pattern_fill(char *buf, int buflen, char *pat, int patlen, int patshift);
-int     parse_cmdline( int, char **, char * );
-int     lock_file_region( char *, int, int, int, int );
-struct	fd_cache *alloc_fdcache(char *, int);
+#ifdef sgi
+struct status	*sy_aread(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr);
+struct status	*sy_awrite(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr)
+struct status	*sy_arw(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr, int rw);
+char		*fmt_aread(struct io_req *req, struct syscall_info *sy,
+			int fd, char *addr);
+#endif /* sgi */
+
+#ifndef CRAY
+struct status	*sy_mmread(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr);
+struct status	*sy_mmwrite(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr);
+struct status	*sy_mmrw(struct io_req *req, struct syscall_info *sysc,
+			int fd, char *addr, int rw);
+char		*fmt_mmrw(struct io_req *req, struct syscall_info *sy, int fd,
+			char *addr);
+#endif /* !CRAY */
+
+int		do_rw(struct io_req *req);
+
+#ifdef sgi
+int		do_fcntl(struct io_req *req);
+#endif /* sgi */
+
+#ifndef CRAY
+int		do_sync(struct io_req *req);
+#endif /* !CRAY */
+
+int		doio_pat_fill(char *addr, int mem_needed, char *Pattern,
+			int Pattern_Length, int shift);
+char		*doio_pat_check(char *buf, int offset, int length,
+			char *pattern, int pattern_length, int patshift);
+char		*check_file(char *file, int offset, int length, char *pattern,
+			int pattern_length, int patshift, int fsa);
+int		doio_fprintf(FILE *stream, char *format, ...);
+int		alloc_mem(int nbytes);
+
+#if defined(_CRAY1) || defined(CRAY)
+int		alloc_sds(int nbytes);
+#endif /* defined(_CRAY1) || defined(CRAY) */
+
+int		alloc_fd(char *file, int oflags);
+struct fd_cache	*alloc_fdcache(char *file, int oflags);
+
+#ifdef sgi
+void		signal_info(int sig, siginfo_t *info, void *v);
+void		cleanup_handler(int sig, siginfo_t *info, void *v);
+void		die_handler(int sig, siginfo_t *info, void *v);
+void		sigbus_handler(int sig, siginfo_t *info, void *v);
+#else	/* !sgi */
+void		cleanup_handler(int sig);
+void		die_handler(int sig);
+
+#ifndef CRAY
+void		sigbus_handler(int sig);
+#endif /* !CRAY */
+#endif /* sgi */
+
+void		noop_handler(int sig);
+void		sigint_handler(int sig);
+void		aio_handler(int sig);
+void		dump_aio(void);
+
+#ifdef sgi
+void		cb_handler(sigval_t val);
+#endif /* sgi */
+
+struct aio_info	*aio_slot(int aio_id);
+int		aio_register(int fd, int strategy, int sig);
+int		aio_unregister(int aio_id);
+
+#ifndef __linux__
+int		aio_wait(int aio_id);
+#endif /* !__linux__ */
+
+char		*hms(time_t t);
+int		aio_done(struct aio_info *ainfo);
+void		doio_upanic(int mask);
+int		parse_cmdline(int argc, char **argv, char *opts);
+
+#ifndef CRAY
+void		parse_memalloc(char *arg);
+void		dump_memalloc(void);
+#endif /* !CRAY */
+
+void		parse_delay(char *arg);
+int		usage(FILE *stream);
+void		help(FILE *stream);
 
 /*
  * Upanic conditions, and a map from symbolics to values
@@ -368,9 +485,6 @@ struct smap Upanic_Args[] = {
 
 struct aio_info	Aio_Info[MAX_AIO];
 
-struct aio_info	*aio_slot();
-int     aio_done( struct aio_info * );
-
 /* -C data-fill/check type */
 #define	C_DEFAULT	1
 struct smap checkmap[] = {
@@ -410,9 +524,7 @@ syserrno(int err)
 ******/
 
 int
-main(argc, argv)
-int 	argc;
-char	**argv;
+main(int argc, char **argv)
 {
 	int	    	    	i, pid, stat, ex_stat;
 #ifdef CRAY
@@ -644,7 +756,7 @@ char	**argv;
  */
 
 void
-doio()
+doio(void)
 {
 	int	    	    	rval, i, infd, nbytes;
 	char			*cp;
@@ -973,7 +1085,7 @@ doio()
 }  /* doio */
 
 void
-doio_delay()
+doio_delay(void)
 {
 	struct timeval tv_delay;
 	struct sigaction sa_al, sa_old;
@@ -1151,18 +1263,8 @@ format_strat(int strategy)
 }
 
 char *
-format_rw(
-	struct	io_req	*ioreq,
-	int		fd,
-	void		*buffer,
-	int		signo,
-	char		*pattern,
-#ifdef CRAY
-	struct	iosw	*iosw
-#else
-	void		*iosw
-#endif
-	)
+format_rw(struct io_req *ioreq, int fd, void *buffer, int signo, char *pattern,
+	void *iosw)
 {
 	static char		*errbuf=NULL;
 	char			*aio_strat, *cp;
@@ -1231,12 +1333,7 @@ format_rw(
 
 #ifdef CRAY
 char *
-format_sds(
-	struct	io_req	*ioreq,
-	void		*buffer,
-	int		sds,
-	char		*pattern
-	)
+format_sds(struct io_req *ioreq, void *buffer, int sds, char *pattern)
 {
 	int			i;
 	static char		*errbuf=NULL;
@@ -1271,8 +1368,7 @@ format_sds(
  */
 
 int
-do_read(req)
-struct io_req	*req;
+do_read(struct io_req *req)
 {
 	int	    	    	fd, offset, nbytes, oflags, rval;
 	char    	    	*addr, *file;
@@ -1462,8 +1558,7 @@ struct io_req	*req;
  */
 
 int
-do_write(req)
-struct io_req	*req;
+do_write(struct io_req *req)
 {
 	static int		pid = -1;
 	int	    	    	fd, nbytes, oflags, signo;
@@ -1817,12 +1912,7 @@ struct io_req	*req;
  */
 
 int
-lock_file_region(fname, fd, type, start, nbytes)
-char	*fname;
-int	fd;
-int	type;
-int	start;
-int	nbytes;
+lock_file_region(char *fname, int fd, int type, int start, int nbytes)
 {
 	struct flock	flk;
 
@@ -1849,14 +1939,8 @@ int	nbytes;
 
 #ifdef CRAY
 char *
-format_listio(
-	struct	io_req	*ioreq,
-	int		lcmd,
-	struct listreq	*list,
-	int		nent,
-	int		fd,
-	char		*pattern
-	)
+format_listio(struct io_req *ioreq, int lcmd, struct listreq *list,
+	int nent, int fd, char *pattern)
 {
 	static	char		*errbuf=NULL;
 	struct	listio_req	*liop = &ioreq->r_data.listio;
@@ -1912,8 +1996,7 @@ format_listio(
 #endif /* CRAY */
 
 int
-do_listio(req)
-struct io_req	*req;
+do_listio(struct io_req *req)
 {
 #ifdef CRAY
 	struct listio_req	*lio;
@@ -2167,8 +2250,7 @@ struct io_req	*req;
 #ifdef _CRAY1
 
 int
-do_ssdio(req)
-struct io_req	*req;
+do_ssdio(struct io_req *req)
 {
 	int	    nbytes, nb;
 	char    errbuf[BSIZE];
@@ -2240,8 +2322,7 @@ struct io_req	*req;
 #ifdef CRAY
 
 int
-do_ssdio(req)
-struct io_req	*req;
+do_ssdio(struct io_req *req)
 {
 	doio_fprintf(stderr,
 		     "Internal Error - do_ssdio() called on a non-cray1 system\n");
@@ -2249,7 +2330,7 @@ struct io_req	*req;
 	exit(E_INTERNAL);
 }
 
-#endif
+#endif /* CRAY */
 
 #endif /* _CRAY1 */
 
@@ -2350,11 +2431,7 @@ fmt_ioreq(struct io_req *ioreq, struct syscall_info *sy, int fd)
  */
 #ifdef CRAY
 struct status *
-sy_listio(req, sysc, fd, addr)
-struct io_req	*req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
+sy_listio(struct io_req *req, struct syscall_info *sysc, int fd, char *addr)
 {
 	int		offset, nbytes, nstrides, nents, aio_strat;
 	int		aio_id, signo, o, i, lc;
@@ -2435,8 +2512,7 @@ char *addr;
  * This assumes filestride & memstride = 0.
  */
 int
-listio_mem(struct io_req *req, int offset, int fmstride,
-	   int *min, int *max)
+listio_mem(struct io_req *req, int offset, int fmstride, int *min, int *max)
 {
 	int	i, size;
 
@@ -2477,11 +2553,7 @@ fmt_listio(struct io_req *req, struct syscall_info *sy, int fd, char *addr)
 
 #ifdef sgi
 struct status *
-sy_pread(req, sysc, fd, addr)
-struct io_req	*req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
+sy_pread(struct io_req *req, struct syscall_info *sysc, int fd, char *addr)
 {
 	int rc;
 	struct status	*status;
@@ -2503,11 +2575,7 @@ char *addr;
 }
 
 struct status *
-sy_pwrite(req, sysc, fd, addr)
-struct io_req	*req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
+sy_pwrite(struct io_req *req, struct syscall_info *sysc, int fd, char *addr)
 {
 	int rc;
 	struct status	*status;
@@ -2552,34 +2620,22 @@ fmt_pread(struct io_req *req, struct syscall_info *sy, int fd, char *addr)
 
 #ifndef CRAY
 struct status *
-sy_readv(req, sysc, fd, addr)
-struct io_req	*req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
+sy_readv(struct io_req	*req, struct syscall_info *sysc, int fd, char *addr)
 {
 	struct status *sy_rwv();
 	return sy_rwv(req, sysc, fd, addr, 0);
 }
 
 struct status *
-sy_writev(req, sysc, fd, addr)
-struct io_req	*req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
+sy_writev(struct io_req *req, struct syscall_info *sysc, int fd, char *addr)
 {
 	struct status *sy_rwv();
 	return sy_rwv(req, sysc, fd, addr, 1);
 }
 
 struct status *
-sy_rwv(req, sysc, fd, addr, rw)
-struct io_req	*req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
-int rw;
+sy_rwv(struct io_req *req, struct syscall_info *sysc, int fd, char *addr,
+	int rw)
 {
 	int rc;
 	struct status	*status;
@@ -2628,22 +2684,14 @@ fmt_readv(struct io_req *req, struct syscall_info *sy, int fd, char *addr)
 
 #ifdef sgi
 struct status *
-sy_aread(req, sysc, fd, addr)
-struct io_req *req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
+sy_aread(struct io_req *req, struct syscall_info *sysc, int fd, char *addr)
 {
 	struct status *sy_arw();
 	return sy_arw(req, sysc, fd, addr, 0);
 }
 
 struct status *
-sy_awrite(req, sysc, fd, addr)
-struct io_req *req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
+sy_awrite(struct io_req *req, struct syscall_info *sysc, int fd, char *addr)
 {
 	struct status *sy_arw();
 	return sy_arw(req, sysc, fd, addr, 1);
@@ -2655,12 +2703,8 @@ char *addr;
  */
 
 struct status *
-sy_arw(req, sysc, fd, addr, rw)
-struct io_req *req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
-int rw;
+sy_arw(struct io_req *req, struct syscall_info *sysc, int fd, char *addr,
+	int rw)
 {
 	/* POSIX 1003.1b-1993 Async read */
 	struct status		*status;
@@ -2736,34 +2780,22 @@ fmt_aread(struct io_req *req, struct syscall_info *sy, int fd, char *addr)
 #ifndef CRAY
 
 struct status *
-sy_mmread(req, sysc, fd, addr)
-struct io_req *req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
+sy_mmread(struct io_req *req, struct syscall_info *sysc, int fd, char *addr)
 {
 	struct status *sy_mmrw();
 	return sy_mmrw(req, sysc, fd, addr, 0);
 }
 
 struct status *
-sy_mmwrite(req, sysc, fd, addr)
-struct io_req *req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
+sy_mmwrite(struct io_req *req, struct syscall_info *sysc, int fd, char *addr)
 {
 	struct status *sy_mmrw();
 	return sy_mmrw(req, sysc, fd, addr, 1);
 }
 
 struct status *
-sy_mmrw(req, sysc, fd, addr, rw)
-struct io_req *req;
-struct syscall_info *sysc;
-int fd;
-char *addr;
-int rw;
+sy_mmrw(struct io_req *req, struct syscall_info *sysc, int fd, char *addr,
+	int rw)
 {
 	/*
 	 * mmap read/write
@@ -2958,8 +2990,7 @@ struct syscall_info syscalls[] = {
 };
 
 int
-do_rw(req)
-	struct io_req	*req;
+do_rw(struct io_req *req)
 {
 	static int		pid = -1;
 	int	    		fd, offset, nbytes, nstrides, nents, oflags;
@@ -3382,8 +3413,7 @@ do_rw(req)
  */
 #ifdef sgi
 int
-do_fcntl(req)
-	struct io_req	*req;
+do_fcntl(struct io_req *req)
 {
 	int	    		fd, oflags, offset, nbytes;
 	int			rval, op;
@@ -3474,15 +3504,14 @@ do_fcntl(req)
 
 	return (rval == -1) ? -1 : 0;
 }
-#endif
+#endif /* sgi */
 
 /*
  *  fsync(2) and fdatasync(2)
  */
 #ifndef CRAY
 int
-do_sync(req)
-	struct io_req	*req;
+do_sync(struct io_req *req)
 {
 	int	    		fd, oflags;
 	int			rval;
@@ -3516,23 +3545,18 @@ do_sync(req)
 	}
 	return (rval == -1) ? -1 : 0;
 }
-#endif
+#endif /* !CRAY */
 
 int
 doio_pat_fill(char *addr, int mem_needed, char *Pattern, int Pattern_Length,
-	      int shift)
+	int shift)
 {
 	return pattern_fill(addr, mem_needed, Pattern, Pattern_Length, 0);
 }
 
 char *
-doio_pat_check(buf, offset, length, pattern, pattern_length, patshift)
-char	*buf;
-int	offset;
-int 	length;
-char	*pattern;
-int	pattern_length;
-int	patshift;
+doio_pat_check(char *buf, int offset, int length, char *pattern,
+	int pattern_length, int patshift)
 {
 	static char	errbuf[4096];
 	int		nb, i, pattern_index;
@@ -3610,14 +3634,8 @@ int	patshift;
  */
 
 char *
-check_file(file, offset, length, pattern, pattern_length, patshift, fsa)
-char 	*file;
-int 	offset;
-int 	length;
-char	*pattern;
-int	pattern_length;
-int	patshift;
-int	fsa;
+check_file(char *file, int offset, int length, char *pattern,
+	int pattern_length, int patshift, int fsa)
 {
 	static char	errbuf[4096];
 	int	    	fd, nb, flags;
@@ -3742,8 +3760,7 @@ doio_fprintf(FILE *stream, char *format, ...)
  */
 #ifndef CRAY
 int
-alloc_mem(nbytes)
-int nbytes;
+alloc_mem(int nbytes)
 {
 	char    	*cp;
 	void		*addr;
@@ -4002,12 +4019,9 @@ int nbytes;
 	mturn++;
 	return 0;
 }
-#endif /* !CRAY */
-
-#ifdef CRAY
+#else /* CRAY */
 int
-alloc_mem(nbytes)
-int nbytes;
+alloc_mem(int nbytes)
 {
 	char    *cp;
 	int	ip;
@@ -4083,8 +4097,7 @@ int nbytes;
 #ifdef _CRAY1
 
 int
-alloc_sds(nbytes)
-int nbytes;
+alloc_sds(int nbytes)
 {
 	int nblks;
 
@@ -4107,8 +4120,7 @@ int nbytes;
 #ifdef CRAY
 
 int
-alloc_sds(nbytes)
-int	nbytes;
+alloc_sds(int nbytes)
 {
 	doio_fprintf(stderr,
 		     "Internal Error - alloc_sds() called on a CRAY2 system\n");
@@ -4133,9 +4145,7 @@ int	nbytes;
  */
 
 int
-alloc_fd(file, oflags)
-char	*file;
-int	oflags;
+alloc_fd(char *file, int oflags)
 {
 	struct fd_cache *fdc;
 	struct fd_cache *alloc_fdcache(char *file, int oflags);
@@ -4148,9 +4158,7 @@ int	oflags;
 }
 
 struct fd_cache *
-alloc_fdcache(file, oflags)
-char	*file;
-int	oflags;
+alloc_fdcache(char *file, int oflags)
 {
 	int			fd;
 	struct fd_cache		*free_slot, *oldest_slot, *cp;
@@ -4369,9 +4377,7 @@ signal_info(int sig, siginfo_t *info, void *v)
 		doio_fprintf(stderr, "signal_info: sig %d\n", sig);
 	}
 }
-#endif
 
-#ifdef sgi
 void
 cleanup_handler(int sig, siginfo_t *info, void *v)
 {
@@ -4419,7 +4425,7 @@ sigbus_handler(int sig, siginfo_t *info, void *v)
 #else
 
 void
-cleanup_handler()
+cleanup_handler(int sig)
 {
 	havesigint=1; /* in case there's a followup signal */
 	alloc_mem(-1);
@@ -4427,8 +4433,7 @@ cleanup_handler()
 }
 
 void
-die_handler(sig)
-int sig;
+die_handler(int sig)
 {
 	doio_fprintf(stderr, "terminating on signal %d\n", sig);
 	alloc_mem(-1);
@@ -4437,8 +4442,7 @@ int sig;
 
 #ifndef CRAY
 void
-sigbus_handler(sig)
-int sig;
+sigbus_handler(int sig)
 {
 	/* See sigbus_handler() in the 'ifdef sgi' case for details.  Here,
 	   we don't have the siginfo stuff so the guess is weaker but we'll
@@ -4446,7 +4450,7 @@ int sig;
 	*/
 
 	if (active_mmap_rw && havesigint)
-		cleanup_handler();
+		cleanup_handler(sig);
 	else
 		die_handler(sig);
 }
@@ -4454,8 +4458,7 @@ int sig;
 #endif /* sgi */
 
 void
-noop_handler(sig)
-int sig;
+noop_handler(int sig)
 {
 	return;
 }
@@ -4467,7 +4470,7 @@ int sig;
  */
 
 void
-sigint_handler()
+sigint_handler(int sig)
 {
 	int	i;
 
@@ -4485,8 +4488,7 @@ sigint_handler()
  */
 
 void
-aio_handler(sig)
-int	sig;
+aio_handler(int sig)
 {
 	unsigned int	i;
 	struct aio_info	*aiop;
@@ -4508,7 +4510,7 @@ int	sig;
  * dump info on all open aio slots
  */
 void
-dump_aio()
+dump_aio(void)
 {
 	unsigned int	i, count;
 
@@ -4536,8 +4538,7 @@ dump_aio()
  * Aio_Info[] index.
  */
 void
-cb_handler(val)
-sigval_t val;
+cb_handler(sigval_t val)
 {
 	struct aio_info	*aiop;
 
@@ -4557,8 +4558,7 @@ sigval_t val;
 #endif
 
 struct aio_info *
-aio_slot(aio_id)
-int	aio_id;
+aio_slot(int aio_id)
 {
 	unsigned int	i;
 	static int	id = 1;
@@ -4594,13 +4594,9 @@ int	aio_id;
 }
 
 int
-aio_register(fd, strategy, sig)
-int		fd;
-int		strategy;
-int		sig;
+aio_register(int fd, int strategy, int sig)
 {
 	struct aio_info		*aiop;
-	void			aio_handler();
 	struct sigaction	sa;
 
 	aiop = aio_slot(-1);
@@ -4630,8 +4626,7 @@ int		sig;
 }
 
 int
-aio_unregister(aio_id)
-int	aio_id;
+aio_unregister(int aio_id)
 {
 	struct aio_info	*aiop;
 
@@ -4647,8 +4642,7 @@ int	aio_id;
 
 #ifndef __linux__
 int
-aio_wait(aio_id)
-int	aio_id;
+aio_wait(int aio_id)
 {
 #ifdef RECALL_SIZEOF
 	long		mask[RECALL_SIZEOF];
@@ -4771,8 +4765,7 @@ int	aio_id;
  */
 
 char *
-hms(t)
-time_t	t;
+hms(time_t t)
 {
 	static char	ascii_time[9];
 	struct tm	*ltime;
@@ -4826,8 +4819,7 @@ aio_done(struct aio_info *ainfo)
  */
 
 void
-doio_upanic(mask)
-int	mask;
+doio_upanic(int mask)
 {
 	if (U_opt == 0 || (mask & Upanic_Conditions) == 0) {
 		return;
@@ -4854,10 +4846,7 @@ int	mask;
  */
 
 int
-parse_cmdline(argc, argv, opts)
-int 	argc;
-char	**argv;
-char	*opts;
+parse_cmdline(int argc, char **argv, char *opts)
 {
 	int	    	c;
 	char    	cc, *cp=NULL, *tok=NULL;
@@ -4867,9 +4856,6 @@ char	*opts;
 	struct smap	*s;
 	char		*memargs[NMEMALLOC];
 	int		nmemargs, ma;
-	void		parse_memalloc(char *arg);
-	void		parse_delay(char *arg);
-	void		dump_memalloc();
 
 	if (*argv[0] == '-') {
 		argv[0]++;
@@ -5241,7 +5227,7 @@ parse_memalloc(char *arg)
 }
 
 void
-dump_memalloc()
+dump_memalloc(void)
 {
 	int	ma;
 	char	*mt;
@@ -5314,8 +5300,7 @@ parse_delay(char *arg)
  */
 
 int
-usage(stream)
-FILE	*stream;
+usage(FILE *stream)
 {
 	/*
 	 * Only do this if we are on vpe 0, to avoid seeing it from every
@@ -5331,8 +5316,7 @@ FILE	*stream;
 }
 
 void
-help(stream)
-FILE	*stream;
+help(FILE *stream)
 {
 	/*
 	 * Only the app running on vpe 0 gets to issue help - this prevents
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
