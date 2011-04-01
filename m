Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q5mPR-0003GF-VP
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:37 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q5mPR-0004L5-7Y
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:37 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  1 Apr 2011 17:01:27 -0500
Message-Id: <e15d7ac6c8634d565bc66fe8b9a0d8ab795eea04.1301695094.git.aelder@sgi.com>
In-Reply-To: <1301695288-24912-1-git-send-email-aelder@sgi.com>
References: <1301695288-24912-1-git-send-email-aelder@sgi.com>
In-Reply-To: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
References: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
Subject: [LTP] [PATCH 5/6] ltp: use C function prototypes in "iogen.c"
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

Many functions in "iogen.c" are defined using old-style C
declarations.  Convert all functions so they follow standard C,
and include standard prototypes for each.

Every function (except main()) now has a standard C prototype, and
all prototypes are grouped in the same section of the file.  The
prototypes--as well as the function definitions themselves--now
follow a consistent formatting style.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/fs/doio/iogen.c |   61 +++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/testcases/kernel/fs/doio/iogen.c b/testcases/kernel/fs/doio/iogen.c
index 4f46099..167edbd 100644
--- a/testcases/kernel/fs/doio/iogen.c
+++ b/testcases/kernel/fs/doio/iogen.c
@@ -113,6 +113,18 @@ struct strmap {
 	int	m_flags;
 };
 
+void		startup_info(FILE *stream, int seed);
+int		init_output(void);
+int		form_iorequest(struct io_req *req);
+int		get_file_info(struct file_info *rec);
+int		create_file(char *path, int nbytes);
+int		str_to_value(struct strmap *map, char *str);
+struct strmap	*str_lookup(struct strmap *map, char *str);
+char		*value_to_string(struct strmap *map, int val);
+int		parse_cmdline(int argc, char **argv, char *opts);
+int		help(FILE *stream);
+int		usage(FILE *stream);
+
 /*
  * Declare cmdline option flags/variables initialized in parse_cmdline()
  */
@@ -165,8 +177,6 @@ int	Fileio = 0;		/* flag indicating that a file		    */
 int	Naio_Strat_Types = 0;	/* # async io completion types		    */
 struct	strmap *Aio_Strat_List[128]; /* Async io completion types	    */
 
-void	startup_info();
-
 /*
  * Map async io completion modes (-a args) names to values.  Macros are
  * defined in doio.h.
@@ -366,16 +376,8 @@ char	Byte_Patterns[26] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
 			      'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
 			      'Y', 'Z' };
 
-int form_iorequest(struct io_req *);
-int init_output();
-int parse_cmdline(int argc, char **argv, char *opts);
-int help(FILE *stream);
-int usage(FILE *stream);
-
 int
-main(argc, argv)
-int 	argc;
-char	**argv;
+main(int argc, char **argv)
 {
     int	    	    rseed, outfd, infinite;
     time_t  	    start_time;
@@ -533,7 +535,7 @@ startup_info(FILE *stream, int seed)
  * error code if this cannot be done.
  */
 int
-init_output()
+init_output(void)
 {
     int	 outfd;
     struct stat	    sbuf;
@@ -579,8 +581,7 @@ init_output()
  */
 
 int
-form_iorequest(req)
-struct io_req   *req;
+form_iorequest(struct io_req *req)
 {
     int	    	    	mult, offset=0, length=0, slength;
     int	    	    	minlength, maxlength, laststart, lastend;
@@ -926,8 +927,7 @@ struct io_req   *req;
  */
 
 int
-get_file_info(rec)
-struct file_info    *rec;
+get_file_info(struct file_info *rec)
 {
     struct stat			sbuf;
 #ifdef CRAY
@@ -1047,9 +1047,7 @@ struct file_info    *rec;
  */
 
 int
-create_file(path, nbytes)
-char	*path;
-int 	nbytes;
+create_file(char *path, int nbytes)
 {
     int	    	fd, rval;
     char    	c;
@@ -1298,9 +1296,7 @@ int 	nbytes;
  */
 
 int
-str_to_value(map, str)
-struct strmap	*map;
-char	    	*str;
+str_to_value(struct strmap *map, char *str)
 {
     struct strmap   *mp;
 
@@ -1317,9 +1313,7 @@ char	    	*str;
  */
 
 struct strmap *
-str_lookup(map, str)
-struct strmap	*map;
-char	    	*str;
+str_lookup(struct strmap *map, char *str)
 {
     struct strmap   *mp;
 
@@ -1336,9 +1330,7 @@ char	    	*str;
  */
 
 char *
-value_to_string(map, val)
-struct strmap   *map;
-int		val;
+value_to_string(struct strmap *map, int val)
 {
     struct strmap  *mp;
 
@@ -1355,10 +1347,7 @@ int		val;
  */
 
 int
-parse_cmdline(argc, argv, opts)
-int 	argc;
-char	**argv;
-char	*opts;
+parse_cmdline(int argc, char **argv, char *opts)
 {
     int	    	    	o, len, nb, format_error;
     struct strmap	*flgs, *sc;
@@ -1870,8 +1859,7 @@ char	*opts;
 }
 
 int
-help(stream)
-FILE	*stream;
+help(FILE *stream)
 {
     usage(stream);
     fprintf(stream, "\n");
@@ -1981,9 +1969,8 @@ FILE	*stream;
  */
 
 int
-usage(stream)
-FILE	*stream;
+usage(FILE *stream)
 {
     fprintf(stream, "usage%s:  iogen [-hoq] [-a aio_type,...] [-f flag[,flag...]] [-i iterations] [-p outpipe] [-m offset-mode] [-s syscall[,syscall...]] [-t mintrans] [-T maxtrans] [ -O file-create-flags ] [[len:]file ...]\n", TagName);
   return 0;
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
