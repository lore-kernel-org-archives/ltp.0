Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q6idh-0002xY-0J
	for ltp-list@lists.sourceforge.net; Mon, 04 Apr 2011 12:12:13 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q6idd-0001BR-9g
	for ltp-list@lists.sourceforge.net; Mon, 04 Apr 2011 12:12:12 +0000
Received: from cf--amer001e--3.americas.sgi.com
	(cf--amer001e--3.americas.sgi.com [137.38.100.5])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 1523B8F8074
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 Apr 2011 05:12:04 -0700 (PDT)
From: Alex Elder <aelder@sgi.com>
Date: Mon, 04 Apr 2011 07:08:35 -0500
Message-ID: <1301918915.3282.27.camel@doink>
Mime-Version: 1.0
Subject: [LTP] [PATCH 4/6] ltp: use C function prototypes in "growfiles.c"
Reply-To: aelder@sgi.com
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Many functions in "growfiles.c" are defined using old-style C
declarations.  Convert all functions so they follow standard C,
and include standard prototypes for each.

Every function (except main()) now has a standard C prototype, and
all prototypes are grouped in the same section of the file.  The
prototypes--as well as the function definitions themselves--now
follow a consistent formatting style.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/fs/doio/growfiles.c |  121 ++++++++++++++-------------------
 1 files changed, 51 insertions(+), 70 deletions(-)

diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index f85d47e..2bb21bd 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -85,6 +85,9 @@
 #include "dataascii.h"
 #include "random_range.h"
 #include "databin.h"
+#include "open_flags.h"
+#include "forker.h"
+#include "file_lock.h"
 
 #ifdef CRAY
 #include <sys/panic.h>
@@ -93,6 +96,31 @@
 
 #include "test.h"
 
+int		set_sig(void);
+void		sig_handler(int sig);
+static void	notify_others(void);
+int		handle_error(void);
+int		cleanup(void);
+void		usage(void);
+void		help(void);
+void		prt_examples(FILE *stream);
+int		growfile(int fd, char *file, int grow_incr, char *buf,
+			unsigned long *curr_size_ptr);
+int		shrinkfile(int fd, char *filename, int trunc_incr,
+			int trunc_inter, int just_trunc);
+int		check_write(int fd, int cf_inter, char *filename, int mode);
+int		check_file(int fd, int cf_inter, char *filename,
+			int no_file_check);
+int		file_size(int fd);
+int		lkfile(int fd, int operation, int lklevel);
+
+#ifndef linux
+int		pre_alloc(int fd, long size);
+#endif /* !linux */
+
+extern int	datapidgen(int, char *, int, int);
+extern int	datapidchk(int, char *, int, int, char **);
+
 /* LTP status reporting */
 char *TCID="growfiles";		/* Default test program identifier.    */
 int TST_TOTAL=1;    		/* Total number of test cases. */
@@ -109,35 +137,6 @@ myexit (int x)
   tst_exit();
 }
 
-extern char *openflags2symbols();
-
-extern int parse_open_flags();
-extern int background();
-extern int forker();
-extern int datapidgen();
-extern void databingen();
-extern int datapidchk();
-extern int databinchk();
-extern int file_lock();
-
-int file_size();
-int check_write();
-int shrinkfile();
-int check_file();
-int growfile();
-int cleanup();
-int handle_error();
-int lkfile();
-void usage();
-void help();
-void prt_examples();
-int set_sig();
-void sig_handler();
-static void notify_others();
-#ifndef linux
-int pre_alloc();
-#endif
-
 #define NEWIO	1	/* Use the tlibio.c functions */
 
 #ifndef NEWIO
@@ -345,9 +344,7 @@ int Open_flags[] = {
  * MAIN
  ***********************************************************************/
 int
-main(argc, argv)
-int argc;
-char **argv;
+main(int argc, char **argv)
 {
 extern char *optarg;            /* used by getopt */
 extern int optind;
@@ -372,8 +369,8 @@ int num;
 int fd;				/* file descriptor */
 int stop = 0;			/* loop stopper if set */
 
-long unsigned curr_size = 0;			/* BUG:14136 (keep track of file size) */
-const long unsigned ext2_limit = 2147483647;	/* BUG:14136 (2GB ext2 filesize limit) */
+unsigned long curr_size = 0;			/* BUG:14136 (keep track of file size) */
+const unsigned long ext2_limit = 2147483647;	/* BUG:14136 (2GB ext2 filesize limit) */
 
 off_t tmp;
 char chr;
@@ -1359,7 +1356,7 @@ no whole file checking will be performed!\n", Progname, TagName, getpid());
 		if (Debug > 3) {
 		    printf("%s: %d DEBUG3 %s/%d: %d Open filename = %s, open flags = %#o %s\n",
 			Progname, Pid, __FILE__, __LINE__, Iter_cnt, filename, ret,
-		        openflags2symbols(ret, ",", NULL));
+		        openflags2symbols(ret, ",", 0));
 		} else if (Debug > 2) {
 		    printf("%s: %d DEBUG3 %s/%d: %d filename = %s, open flags = %#o\n",
 			Progname, Pid, __FILE__, __LINE__, Iter_cnt, filename, ret);
@@ -1534,9 +1531,9 @@ no whole file checking will be performed!\n", Progname, TagName, getpid());
  *
  ***********************************************************************/
 int
-set_sig()
+set_sig(void)
 {
-   int sig;
+	int sig;
 
         /*
          * now loop through all signals and set the handlers
@@ -1578,8 +1575,7 @@ set_sig()
  *
  ***********************************************************************/
 void
-sig_handler(sig)
-int sig;
+sig_handler(int sig)
 {
     int exit_stat = 2;
 
@@ -1617,7 +1613,7 @@ int sig;
  *
  ***********************************************************************/
 static void
-notify_others()
+notify_others(void)
 {
     static int send_signals = 0;
     int ind;
@@ -1651,7 +1647,7 @@ notify_others()
  * and exit is Maxerrs were encountered.
  ***********************************************************************/
 int
-handle_error()
+handle_error(void)
 {
     Errors++;
 
@@ -1683,9 +1679,9 @@ handle_error()
  *
  ***********************************************************************/
 int
-cleanup()
+cleanup(void)
 {
-    int ind;
+	int ind;
 
 	if (remove_files) {
 	    if (Debug > 2)
@@ -1705,7 +1701,7 @@ cleanup()
  *
  ***********************************************************************/
 void
-usage()
+usage(void)
 {
 	fprintf(stderr,
 	"Usage: %s%s [-bhEluy][[-g grow_incr][-i num][-t trunc_incr][-T trunc_inter]\n",
@@ -1725,7 +1721,7 @@ usage()
  *
  ***********************************************************************/
 void
-help()
+help(void)
 {
 	usage();
 
@@ -1846,13 +1842,9 @@ prt_examples(FILE *stream)
  * Woffset will be set to the offset before the write.
  * Grow_incr will be set to the size of the write or lseek write.
  ***********************************************************************/
-int
-growfile(fd, file, grow_incr, buf, curr_size_ptr)	/* BUG:14136 */
-int fd;
-char *file;
-int grow_incr;
-char *buf;
-long *curr_size_ptr;	/* BUG:14136 */
+int	/* BUG:14136 */
+growfile(int fd, char *file, int grow_incr, char *buf,
+	unsigned long *curr_size_ptr)
 {
    off_t noffset;
    int ret;
@@ -2198,12 +2190,8 @@ long *curr_size_ptr;	/* BUG:14136 */
  *
  ***********************************************************************/
 int
-shrinkfile(fd, filename, trunc_incr, trunc_inter, just_trunc)
-int fd;
-char *filename;
-int trunc_incr;
-int trunc_inter;	/* interval */
-int just_trunc;		/* lseek has already been done for you */
+shrinkfile(int fd, char *filename, int trunc_incr, int trunc_inter,
+	int just_trunc)
 {
     static int shrink_cnt = 0;
     int cur_offset;
@@ -2325,11 +2313,7 @@ int just_trunc;		/* lseek has already been done for you */
  *
  ***********************************************************************/
 int
-check_write(fd, cf_inter, filename, mode)
-int fd;
-int cf_inter;   /* check file interval */
-char *filename; /* needed for error messages */
-int mode;       /* write mode */
+check_write(int fd, int cf_inter, char *filename, int mode)
 {
     int fsize;
     static int cf_count = 0;
@@ -2494,7 +2478,8 @@ int mode;       /* write mode */
 	if (Debug > 0)
 	    printf("%s%s: %d DEBUG1 %s/%d: **fd:%d, lk:%d, offset:%ld, sz:%d open flags:%#o %s\n",
 		Progname, TagName, Pid, __FILE__, __LINE__, fd, lockfile,
-		Woffset, Grow_incr, Fileinfo.openflags, openflags2symbols(Fileinfo.openflags, ",", NULL));
+		Woffset, Grow_incr, Fileinfo.openflags,
+		openflags2symbols(Fileinfo.openflags, ",", 0));
 
 	fflush(stderr);
 	return 1;
@@ -2511,11 +2496,7 @@ int mode;       /* write mode */
  *
  ***********************************************************************/
 int
-check_file(fd, cf_inter, filename, no_file_check)
-int fd;
-int cf_inter;	/* check file interval */
-char *filename;	/* needed for error messages */
-int no_file_check;	/* if set, do not do file content check */
+check_file(int fd, int cf_inter, char *filename, int no_file_check)
 {
     int fsize;
     static int cf_count = 0;
@@ -2842,4 +2823,4 @@ pre_alloc(int fd, long size)
 
 	return 0;
 }
-#endif
\ No newline at end of file
+#endif
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
