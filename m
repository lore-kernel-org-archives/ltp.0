Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O6Vcn-00063x-O5
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 21:13:53 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 88CFC867E2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Apr 2010 23:13:46 +0200 (CEST)
Date: Mon, 26 Apr 2010 23:21:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100426212128.GA28261@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
Subject: [LTP] [PATCH] add types for functions in fs-bench
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
To: ltp-list@lists.sourceforge.net


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Attached patch adds types for functions in sources for fs-bench just because
when function doesn't have return type it defaults to int and this causes
problems (for example when doing return from such function without value).

Signed-off-by: Cyril Hrubis chrubis@suse.cz


Side note:

The code quality for fs-bench is very poor, there is no documentation and the
scripts are broken (mostly wrongly hardcoded paths). IMHO these tests are not
worth fixing and candidate for removal.

-- 
Cyril Hrubis
chrubis@suse.cz

--u3/rZRmxL6MmkK24
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="clean_up_fs-bench.patch"

Index: ltp-full-20100228/testcases/kernel/fs/fs-bench/create-files.c
===================================================================
--- ltp-full-20100228.orig/testcases/kernel/fs/fs-bench/create-files.c
+++ ltp-full-20100228/testcases/kernel/fs/fs-bench/create-files.c
@@ -19,7 +19,7 @@ static int filecount=0;
 extern int box_muler(int, int);
 
 int startc=0;
-main(int ac,char *av[])
+int main(int ac,char *av[])
 {
   int i=0;
   int j=0;
@@ -75,14 +75,17 @@ end:
 
 int showchar[]={124,47,45,92,124,47,45,92};
 static int mkdir_counter=0;
-makedir(char *dir1)
+
+void makedir(char *dir1)
 {
   if (mkdir(dir1, S_IRWXU) < 0) {
     perror(dir1);
     exit(1);
   }
 }
-changedir(char *dir) {
+
+void changedir(char *dir)
+{
   if ( chdir(dir) < 0 ) {
     perror(dir);
     exit(1);
@@ -90,7 +93,7 @@ changedir(char *dir) {
 }
 
 
-create_file(char *filename)
+void create_file(char *filename)
 {
   int fd;
   int randomsize;
Index: ltp-full-20100228/testcases/kernel/fs/fs-bench/random-access-del-create.c
===================================================================
--- ltp-full-20100228.orig/testcases/kernel/fs/fs-bench/random-access-del-create.c
+++ ltp-full-20100228/testcases/kernel/fs/fs-bench/random-access-del-create.c
@@ -24,8 +24,7 @@ int cfilecount=0;
 int dfilecount=0;
 int errorcount=0;
 
-int
-main(int ac, char **av)
+int main(int ac, char **av)
 {
   int r;
   char fname[1024];
@@ -92,7 +91,7 @@ void create_or_delete(char *fname)
   }
 }
 
-create_file(char *filename)
+int create_file(char *filename)
 {
   int fd;
   int randomsize;
@@ -117,7 +116,7 @@ create_file(char *filename)
 #include <sys/stat.h>
 #include <unistd.h>
 
-delete_file(char *filename)
+int delete_file(char *filename)
 {
   struct stat buf;
   int st;
Index: ltp-full-20100228/testcases/kernel/fs/fs-bench/random-access.c
===================================================================
--- ltp-full-20100228.orig/testcases/kernel/fs/fs-bench/random-access.c
+++ ltp-full-20100228/testcases/kernel/fs/fs-bench/random-access.c
@@ -16,7 +16,7 @@ int openlog[2]={0,0};
 #define MAXNUM 0x100000
 
 int nullfd;
-main(int ac, char **av)
+int main(int ac, char **av)
 {
   int fd;
   int r;
@@ -62,7 +62,7 @@ main(int ac, char **av)
 }
 
 #define BUFS 8192
-open_read_close(char *fname)
+void open_read_close(char *fname)
 {
   int fd;
   char buf[BUFS];
Index: ltp-full-20100228/testcases/kernel/fs/fs-bench/random-del-create.c
===================================================================
--- ltp-full-20100228.orig/testcases/kernel/fs/fs-bench/random-del-create.c
+++ ltp-full-20100228/testcases/kernel/fs/fs-bench/random-del-create.c
@@ -24,7 +24,7 @@ int cfilecount=0;
 int dfilecount=0;
 int errorcount=0;
 
-main(int ac, char **av)
+int main(int ac, char **av)
 {
   int r;
   char fname[1024];
@@ -91,7 +91,7 @@ void create_or_delete(char *fname)
   }
 }
 
-create_file(char *filename)
+int create_file(char *filename)
 {
   int fd;
   int randomsize;
@@ -116,7 +116,7 @@ create_file(char *filename)
 #include <sys/stat.h>
 #include <unistd.h>
 
-delete_file(char *filename)
+int delete_file(char *filename)
 {
   struct stat buf;
   int st;

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--u3/rZRmxL6MmkK24--

