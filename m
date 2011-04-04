Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q6idg-0002xx-WE
	for ltp-list@lists.sourceforge.net; Mon, 04 Apr 2011 12:12:13 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q6idd-0001BS-9g
	for ltp-list@lists.sourceforge.net; Mon, 04 Apr 2011 12:12:12 +0000
Received: from cf--amer001e--3.americas.sgi.com
	(cf--amer001e--3.americas.sgi.com [137.38.100.5])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 1D3B68F8078
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 Apr 2011 05:12:04 -0700 (PDT)
From: Alex Elder <aelder@sgi.com>
Date: Mon, 04 Apr 2011 07:08:37 -0500
Message-ID: <1301918917.3282.28.camel@doink>
Mime-Version: 1.0
Subject: [LTP] [PATCH 5/6] ltp: use C function prototypes in "iogen.c"
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
