Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WYW9d-0003ng-3i
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 07:45:41 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WYW9b-0007vP-4F
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 07:45:41 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3B7jW9B032634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 07:45:33 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3B7jVpk005413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 07:45:32 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s3B7jSpX011046
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 07:45:31 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 11 Apr 2014 11:45:19 +0400
Message-Id: <1397202319-31759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] lib, tools, pan: old-style function definition fixes
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
Cc: vasily.isaenko@oracle.com

No functional changes. No "cleanup". Just fixes for
"old-style function definition" compile warnings.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 lib/datapid.c      |   13 ++-----------
 lib/file_lock.c    |   12 ++----------
 lib/forker.c       |   14 ++++++--------
 lib/parse_opts.c   |    2 +-
 lib/pattern.c      |   14 ++------------
 lib/random_range.c |   48 +++++++++++-------------------------------------
 lib/search_path.c  |    9 ++++-----
 lib/tlibio.c       |   41 +++++++++++++++++------------------------
 lib/write_log.c    |   30 ++++++++----------------------
 pan/reporter.c     |   12 ++++--------
 pan/scan.l         |   10 ++++------
 pan/symbol.c       |    2 +-
 pan/tag_report.c   |   21 ++++++---------------
 pan/zoolib.c       |    2 +-
 tools/rand_lines.c |   32 ++++++++++++--------------------
 15 files changed, 81 insertions(+), 181 deletions(-)

diff --git a/lib/datapid.c b/lib/datapid.c
index 23164d3..dad1a12 100644
--- a/lib/datapid.c
+++ b/lib/datapid.c
@@ -81,11 +81,7 @@ static char Errmsg[80];
  * thus, offset 16 is the start of  the second full word
  * Thus, offset 8 is in middle of word 1
  ***********************************************************************/
-int datapidgen(pid, buffer, bsize, offset)
-int pid;
-char *buffer;
-int bsize;
-int offset;
+int datapidgen(int pid, char *buffer, int bsize, int offset)
 {
 #if CRAY
 
@@ -182,12 +178,7 @@ int offset;
  *
  *
  ***********************************************************************/
-int datapidchk(pid, buffer, bsize, offset, errmsg)
-int pid;
-char *buffer;
-int bsize;
-int offset;
-char **errmsg;
+int datapidchk(int pid, char *buffer, int bsize, int offset, char **errmsg)
 {
 #if CRAY
 
diff --git a/lib/file_lock.c b/lib/file_lock.c
index 52c8947..0d86f2c 100644
--- a/lib/file_lock.c
+++ b/lib/file_lock.c
@@ -58,10 +58,7 @@ static char errmsg[256];
  * Test interface to the fcntl system call.
  * It will loop if the LOCK_NB flags is NOT set.
  ***********************************************************************/
-int file_lock(fd, flags, errormsg)
-int fd;
-int flags;
-char **errormsg;
+int file_lock(int fd, int flags, char **errormsg)
 {
 	register int cmd, ret;
 	struct flock flocks;
@@ -133,12 +130,7 @@ char **errormsg;
  * Test interface to the fcntl system call.
  * It will loop if the LOCK_NB flags is NOT set.
  ***********************************************************************/
-int record_lock(fd, flags, start, len, errormsg)
-int fd;
-int flags;
-int start;
-int len;
-char **errormsg;
+int record_lock(int fd, int flags, int start, int len, char **errormsg)
 {
 	register int cmd, ret;
 	struct flock flocks;
diff --git a/lib/forker.c b/lib/forker.c
index 5e6ac48..0f82815 100644
--- a/lib/forker.c
+++ b/lib/forker.c
@@ -127,8 +127,7 @@ int Forker_npids = 0;		/* number of entries in Forker_pids */
  *   0 : if fork did not fail
  *  !0 : if fork failed, the return value will be the errno.
  ***********************************************************************/
-int background(prefix)
-char *prefix;
+int background(char *prefix)
 {
 	switch (fork()) {
 	case -1:
@@ -153,12 +152,11 @@ char *prefix;
  * Forker will fork ncopies-1 copies of self.
  *
  ***********************************************************************/
-int forker(ncopies, mode, prefix)
-int ncopies;
-int mode;			/* 0 - all childern of parent, 1 - only 1 direct child */
-char *prefix;			/* if ! NULL, an message will be printed to stderr */
-		/* if fork fails.  The prefix (program name) will */
-		/* preceed the message */
+int forker(int ncopies,
+	int mode,	/* 0 - all children of parent, 1 - only 1 direct child */
+	char *prefix)	/* if ! NULL, an message will be printed to stderr */
+			/* if fork fails. The prefix (program name) will */
+			/* preceed the message */
 {
 	int cnt;
 	int pid;
diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index 3e99bdb..759fd3f 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -632,7 +632,7 @@ void STD_opts_help(void)
 /*
  * routine to goto when we get the SIGUSR1 for STD_PAUSE
  */
-void STD_go()
+void STD_go(int sig)
 {
 	return;
 }
diff --git a/lib/pattern.c b/lib/pattern.c
index 5863965..7f46aef 100644
--- a/lib/pattern.c
+++ b/lib/pattern.c
@@ -37,12 +37,7 @@
  * with/against a known pattern.
  */
 
-int pattern_check(buf, buflen, pat, patlen, patshift)
-char *buf;
-int buflen;
-char *pat;
-int patlen;
-int patshift;
+int pattern_check(char *buf, int buflen, char *pat, int patlen, int patshift)
 {
 	int nb, ncmp, nleft;
 	char *cp;
@@ -103,12 +98,7 @@ int patshift;
 	return 0;
 }
 
-int pattern_fill(buf, buflen, pat, patlen, patshift)
-char *buf;
-int buflen;
-char *pat;
-int patlen;
-int patshift;
+int pattern_fill(char *buf, int buflen, char *pat, int patlen, int patshift)
 {
 	int trans, ncopied, nleft;
 	char *cp;
diff --git a/lib/random_range.c b/lib/random_range.c
index cd2096c..1d88dd2 100644
--- a/lib/random_range.c
+++ b/lib/random_range.c
@@ -98,14 +98,8 @@ struct range {
 static int str_to_int();
 static long long divider(long long, long long, long long, long long);
 
-int parse_ranges(str, defmin, defmax, defmult, parse_func, rangeptr, errptr)
-char *str;
-int defmin;
-int defmax;
-int defmult;
-int (*parse_func) ();
-char **rangeptr;
-char **errptr;
+int parse_ranges(char *str, int defmin, int defmax, int defmult,
+		int (*parse_func)(), char **rangeptr, char **errptr)
 {
 	int ncommas;
 	char *tmpstr, *cp, *tok, *n1str, *n2str, *multstr;
@@ -224,9 +218,7 @@ char **errptr;
  * The default integer-parsing function
  */
 
-static int str_to_int(str, ip)
-char *str;
-int *ip;
+static int str_to_int(char *str, int *ip)
 {
 	char c;
 
@@ -243,23 +235,17 @@ int *ip;
  * and that r is a valid range within that buffer.
  */
 
-int range_min(rbuf, r)
-char *rbuf;
-int r;
+int range_min(char *rbuf, int r)
 {
 	return ((struct range *)rbuf)[r].min;
 }
 
-int range_max(rbuf, r)
-char *rbuf;
-int r;
+int range_max(char *rbuf, int r)
 {
 	return ((struct range *)rbuf)[r].max;
 }
 
-int range_mult(rbuf, r)
-char *rbuf;
-int r;
+int range_mult(char *rbuf, int r)
 {
 	return ((struct range *)rbuf)[r].mult;
 }
@@ -289,11 +275,7 @@ int r;
  *          setting the seed.
  *****************************************************************************/
 
-long random_range(min, max, mult, errp)
-int min;
-int max;
-int mult;
-char **errp;
+long random_range(int min, int max, int mult, char **errp)
 {
 	int r, nmults, orig_min, orig_max, orig_mult, tmp;
 	extern long lrand48();
@@ -380,11 +362,7 @@ char **errp;
 /*
  * Just like random_range, but all values are longs.
  */
-long random_rangel(min, max, mult, errp)
-long min;
-long max;
-long mult;
-char **errp;
+long random_rangel(long min, long max, long mult, char **errp)
 {
 	long r, nmults, orig_min, orig_max, orig_mult, tmp;
 	extern long lrand48();
@@ -470,11 +448,8 @@ char **errp;
 /*
  *  Attempts to be just like random_range, but everything is long long (64 bit)
  */
-long long random_rangell(min, max, mult, errp)
-long long min;
-long long max;
-long long mult;
-char **errp;
+long long random_rangell(long long min, long long max,
+			long long mult, char **errp)
 {
 	long long r, nmults, orig_min, orig_max, orig_mult, tmp;
 	long long randnum;
@@ -634,8 +609,7 @@ divider(long long min, long long max, long long cnt, long long rand)
  * be used in random_range().
  *****************************************************************************/
 
-void random_range_seed(s)
-long s;
+void random_range_seed(long s)
 {
 	extern void srand48();
 
diff --git a/lib/search_path.c b/lib/search_path.c
index a5ebfad..5c516c9 100644
--- a/lib/search_path.c
+++ b/lib/search_path.c
@@ -124,11 +124,10 @@ char **argv;
 
 /*
  */
-int search_path(cmd, res_path, access_mode, fullpath)
-char *cmd;			/* The requested filename */
-char *res_path;			/* The resulting path or error mesg */
-int access_mode;		/* the mode used by access(2) */
-int fullpath;			/* if set, cwd will be prepended to all non-full paths */
+int search_path(char *cmd,	/* the requested filename */
+		char *res_path,	/* the resulting path or error msg*/
+		int access_mode,	/* the mode used by access(2) */
+		int fullpath)	/* if set, cwd wil be prepended to all non-full paths */
 {
 	char *cp;		/* used to scan PATH for directories */
 	int ret;		/* return value from access */
diff --git a/lib/tlibio.c b/lib/tlibio.c
index 9104a72..6b6103f 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -216,13 +216,8 @@ static int Debug_level = 0;
  * (maule, 11/16/95)
  ***********************************************************************/
 
-int stride_bounds(offset, stride, nstrides, bytes_per_stride, min, max)
-int offset;
-int stride;
-int nstrides;
-int bytes_per_stride;
-int *min;
-int *max;
+int stride_bounds(int offset, int stride, int nstrides, int bytes_per_stride,
+		int *min, int *max)
 {
 	int nbytes, min_byte, max_byte;
 
@@ -268,7 +263,7 @@ int *max;
 /***********************************************************************
  * This function will allow someone to set the debug level.
  ***********************************************************************/
-int lio_set_debug(level)
+int lio_set_debug(int level)
 {
 	int old;
 
@@ -539,14 +534,13 @@ static void wait4sync_io(int fd, int read)
  *
  * (rrl 04/96)
  ***********************************************************************/
-int lio_write_buffer(fd, method, buffer, size, sig, errmsg, wrd)
-int fd;				/* open file descriptor */
-int method;			/* contains io type and wait method bitmask */
-char *buffer;			/* pointer to buffer */
-int size;			/* the size of the io */
-int sig;			/* signal to use if async io */
-char **errmsg;			/* char pointer that will be updated to point to err message */
-long wrd;			/* to allow future features, use zero for now */
+int lio_write_buffer(int fd,		/* open file descriptor */
+		int method,	/* contains io type and wait method bitmask */
+		char *buffer,	/* pointer to buffer */
+		int size,	/* the size of the io */
+		int sig,	/* signal to use if async io */
+		char **errmsg,	/* char pointer that will be updated to point to err message */
+		long wrd)	/* to allow future features, use zero for now */
 {
 	int ret = 0;		/* syscall return or used to get random method */
 	char *io_type;		/* Holds string of type of io */
@@ -1110,14 +1104,13 @@ long wrd;			/* to allow future features, use zero for now */
  *
  * (rrl 04/96)
  ***********************************************************************/
-int lio_read_buffer(fd, method, buffer, size, sig, errmsg, wrd)
-int fd;				/* open file descriptor */
-int method;			/* contains io type and wait method bitmask */
-char *buffer;			/* pointer to buffer */
-int size;			/* the size of the io */
-int sig;			/* signal to use if async io */
-char **errmsg;			/* char pointer that will be updated to point to err message */
-long wrd;			/* to allow future features, use zero for now */
+int lio_read_buffer(int fd,	/* open file descriptor */
+		int method,	/* contains io type and wait method bitmask*/
+		char *buffer,	/* pointer to buffer */
+		int size,	/* the size of the io */
+		int sig,	/* signal to use if async io */
+		char **errmsg,	/* char pointer that will be updated to point to err message */
+		long wrd)	/* to allow future features, use zero for now */
 {
 	int ret = 0;		/* syscall return or used to get random method */
 	char *io_type;		/* Holds string of type of io */
diff --git a/lib/write_log.c b/lib/write_log.c
index 1731dc3..6fc6258 100644
--- a/lib/write_log.c
+++ b/lib/write_log.c
@@ -110,10 +110,7 @@ static int wlog_rec_unpack();
  * umask.
  */
 
-int wlog_open(wfile, trunc, mode)
-struct wlog_file *wfile;
-int trunc;
-int mode;
+int wlog_open(struct wlog_file *wfile, int trunc, int mode)
 {
 	int omask, oflags;
 
@@ -159,8 +156,7 @@ int mode;
  * with the wlog_open() call.
  */
 
-int wlog_close(wfile)
-struct wlog_file *wfile;
+int wlog_close(struct wlog_file *wfile)
 {
 	close(wfile->w_afd);
 	close(wfile->w_rfd);
@@ -193,10 +189,8 @@ struct wlog_file *wfile;
  * place before the record is written.
  */
 
-int wlog_record_write(wfile, wrec, offset)
-struct wlog_file *wfile;
-struct wlog_rec *wrec;
-long offset;
+int wlog_record_write(struct wlog_file *wfile, struct wlog_rec *wrec,
+			long offset)
 {
 	int reclen;
 	char wbuf[WLOG_REC_MAX_SIZE + 2];
@@ -264,11 +258,8 @@ long offset;
  * will be passed a single parameter - a wlog_rec structure .
  */
 
-int wlog_scan_backward(wfile, nrecs, func, data)
-struct wlog_file *wfile;
-int nrecs;
-int (*func) ();
-long data;
+int wlog_scan_backward(struct wlog_file *wfile, int nrecs,
+			int (*func)(), long data)
 {
 	int fd, leftover, nbytes, offset, recnum, reclen, rval;
 	char buf[BSIZE * 32], *bufend, *cp, *bufstart;
@@ -410,10 +401,7 @@ long data;
  * these routines must be reflected in the other.
  */
 
-static int wlog_rec_pack(wrec, buf, flag)
-struct wlog_rec *wrec;
-char *buf;
-int flag;
+static int wlog_rec_pack(struct wlog_rec *wrec, char *buf, int flag)
 {
 	char *file, *host, *pattern;
 	struct wlog_rec_disk *wrecd;
@@ -460,9 +448,7 @@ int flag;
 	}
 }
 
-static int wlog_rec_unpack(wrec, buf)
-struct wlog_rec *wrec;
-char *buf;
+static int wlog_rec_unpack(struct wlog_rec *wrec, char *buf)
 {
 	char *file, *host, *pattern;
 	struct wlog_rec_disk *wrecd;
diff --git a/pan/reporter.c b/pan/reporter.c
index d1dee3a..7b4a1e0 100644
--- a/pan/reporter.c
+++ b/pan/reporter.c
@@ -79,8 +79,7 @@ static int (*test_end_func) (SYM, SYM, SYM) = scanner_test_end;
  *  (4) go thru all tags and report each as described at the beginning of
  *      this file
  */
-static int scanner_reporter(tags)
-SYM tags;
+static int scanner_reporter(SYM tags)
 {
 	DBT Key, Data;
 	SYM Tag, Keys;
@@ -179,8 +178,7 @@ SYM tags;
  * under another key tree with almost zero brainwork because a SYM
  * is what the DATA area points to.
  */
-static int scanner_test_end(alltags, ctag, keys)
-SYM alltags, ctag, keys;
+static int scanner_test_end(SYM alltags, SYM ctag, SYM keys)
 {
 	static int notag = 0;	/* counter for records with no tag (error) */
 	char tagname[KEYSIZE];	/* used when creating name (see above) */
@@ -233,14 +231,12 @@ SYM alltags, ctag, keys;
 	return 0;
 }
 
-static int iscanner_reporter(tags)
-SYM tags;
+static int iscanner_reporter(SYM tags)
 {
 	return 0;
 }
 
-static int iscanner_test_end(alltags, ctag, keys)
-SYM alltags, ctag, keys;
+static int iscanner_test_end(SYM alltags, SYM ctag, SYM keys)
 {
 	if (alltags == NULL || keys == NULL || ctag == NULL)
 		return -1;	/* for really messed up test output */
diff --git a/pan/scan.l b/pan/scan.l
index aa5a1c6..fdc33f3 100644
--- a/pan/scan.l
+++ b/pan/scan.l
@@ -285,7 +285,7 @@ S	[ \t]+
  * BEGIN the CUTS state.
  */
 int
-begin_cuts()
+begin_cuts(void)
 {
     BEGIN CUTS;
     return 0;
@@ -295,8 +295,7 @@ begin_cuts()
  * Calls lex repeatedly until all input is seen.
  */
 int
-scanner(tags)
-    SYM tags;
+scanner(SYM tags)
 {
     alltags = tags;		/* move into global scope for lex actions */
 
@@ -313,8 +312,7 @@ scanner(tags)
  *  toss all the output.
  */
 static int
-test_output(tag, keys)
-    SYM tag, keys;
+test_output(SYM tag, SYM keys)
 {
     char *at;
 
@@ -433,7 +431,7 @@ lex_files(char **names)
  *  return "-1" and lex will end.
  */
 int
-yywrap()
+yywrap(void)
 {
     extern FILE *yyin;
     extern int yylineno;	/* Line number from Lex */
diff --git a/pan/symbol.c b/pan/symbol.c
index ab056bc..d7b90af 100644
--- a/pan/symbol.c
+++ b/pan/symbol.c
@@ -82,7 +82,7 @@ static char *sym_error = NULL;
  * mknode(...) allocates a new symbol table entry
  */
 
-SYM newsym()
+SYM newsym(void)
 {
 	SYM h;
 
diff --git a/pan/tag_report.c b/pan/tag_report.c
index 61caabd..eb8fb3d 100644
--- a/pan/tag_report.c
+++ b/pan/tag_report.c
@@ -52,10 +52,7 @@ static char *worst_case(char *, char *);
  *  This is the central results reporting function.  All standard report
  *  format results are printed thru test_result.
  */
-int test_result(tag, tcid, tc, result, tags)
-char *tag, *tcid, *tc;
-char *result;
-SYM tags;
+int test_result(char *tag, char *tcid, char *tc, char *result, SYM tags)
 {
 	char *expert, expkey[KEYSIZE];
 	register char *c;
@@ -109,9 +106,7 @@ SYM tags;
  *	report an error if they don't match.
  */
 
-int cuts_report(tags, keys, at, tag)
-SYM tags, keys;
-char *at, *tag;
+int cuts_report(SYM tags, SYM keys, char *at, char *tag)
 {
 	DBT Key, Data;
 
@@ -227,8 +222,7 @@ char *at, *tag;
  *  (4) go thru all tags and report each as described at the beginning of
  *      this file
  */
-int tag_report(alltags, ctag, keys)
-SYM alltags, ctag, keys;
+int tag_report(SYM alltags, SYM ctag, SYM keys)
 {
 
 	extern int extended;
@@ -380,8 +374,7 @@ SYM alltags, ctag, keys;
  *  Print a header made up of the RTS keywords
  *  In "extended" mode, print the header to stderr.
  */
-int print_header(tags)
-SYM tags;
+int print_header(SYM tags)
 {
 	DBT Key, Data;
 	char key_get[255];
@@ -422,8 +415,7 @@ SYM tags;
  * This is passed s SYM for the current tag and the initiation keys.
  * The text seen by lex is in yytext (global).
  */
-int cuts_testcase(tag, keys)
-SYM tag, keys;
+int cuts_testcase(SYM tag, SYM keys)
 {
 	char *cuts_info[6];
 	char key[KEYSIZE];
@@ -462,8 +454,7 @@ SYM tag, keys;
 /*
  * Determine a "worst case" status from two given statuses.
  */
-static char *worst_case(t1, t2)
-char *t1, *t2;
+static char *worst_case(char *t1, char *t2)
 {
 	/* NULL-terminated table, ordered from worst-case to best-case */
 	static char *worst[] = {
diff --git a/pan/zoolib.c b/pan/zoolib.c
index 568ffff..afdc706 100644
--- a/pan/zoolib.c
+++ b/pan/zoolib.c
@@ -71,7 +71,7 @@ static int zoo_unlock(zoo_t z);
 char *cat_args(int argc, char **argv);
 
 /* zoo_getname(): create a filename to use for the zoo */
-char *zoo_getname()
+char *zoo_getname(void)
 {
 	char buf[1024];
 	char *zoo;
diff --git a/tools/rand_lines.c b/tools/rand_lines.c
index fdf3f79..9d86ed7 100644
--- a/tools/rand_lines.c
+++ b/tools/rand_lines.c
@@ -117,7 +117,7 @@ struct offset_t {
 };
 
 void usage(FILE * stream);
-void help();
+void help(void);
 int rnd_file(FILE * infile, int numlines, long seed);
 int get_numlines(FILE * infile);
 int rnd_insert(struct offset_t offsets[], long offset, int size);
@@ -134,9 +134,7 @@ char *Progname = NULL;
 /***********************************************************************
  *  MAIN
  ***********************************************************************/
-int main(argc, argv)
-int argc;
-char **argv;
+int main(int argc, char *argv[])
 {
 	FILE *infile;
 	int c;
@@ -230,7 +228,7 @@ void usage(FILE * stream)
 /***********************************************************************
  * Print help message to stdout.
  ***********************************************************************/
-void help()
+void help(void)
 {
 	usage(stdout);
 	printf("This tool will print lines in random order (max line len %d).\n\
@@ -246,8 +244,7 @@ void help()
  * counts the number of lines in already open file.
  * Note: File must be seekable (not stdin or a pipe).
  ***********************************************************************/
-int get_numlines(infile)
-FILE *infile;
+int get_numlines(FILE *infile)
 {
 	char line[MAX_LN_SZ];	/* max size of a line */
 	int cnt = 0;
@@ -270,12 +267,11 @@ FILE *infile;
  * It will then print each line in the array stored order.
  *
  ***********************************************************************/
-int rnd_file(infile, numlines, seed)
-FILE *infile;
-int numlines;			/* can be more or less than num lines in file */
+int rnd_file(FILE *infile,
+	int numlines,	/* can be more or less than num lines in file */
 			/* most opt randomized when num lines in files */
 			/* or just a bit bigger */
-long seed;
+	long seed)
 {
 
 	char line[MAX_LN_SZ];	/* max size of a line */
@@ -359,10 +355,7 @@ long seed;
  * open array element.
  *
  ***********************************************************************/
-int rnd_insert(offsets, offset, size)
-struct offset_t offsets[];
-long offset;
-int size;
+int rnd_insert(struct offset_t offsets[], long offset, int size)
 {
 	int rand_num;
 	int quick = 0;
@@ -414,14 +407,13 @@ int size;
  * file (i.e stdin).
  *
  ***********************************************************************/
-int rnd_stdin(infile, space, numlines, seed)
-FILE *infile;
-int space;			/* amount of space to use to read file into memory, */
+int rnd_stdin(FILE *infile,
+	int space,	/* amount of space to use to read file into memory, */
 			/* randomized and print.  randomize in chunks */
-int numlines;			/* can be more or less than num lines in file */
+	int numlines,	/* can be more or less than num lines in file */
 			/* most opt randomized when num lines in files */
 			/* or just a bit bigger */
-long seed;
+	long seed)
 {
 
 	char line[MAX_LN_SZ];	/* max size of a line */
-- 
1.7.1


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
