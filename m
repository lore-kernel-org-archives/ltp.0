Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OWoYH-00014w-EQ
	for ltp-list@lists.sourceforge.net; Thu, 08 Jul 2010 10:41:57 +0000
Date: Thu, 8 Jul 2010 12:55:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100708105524.GA11545@saboteur.suse.cz>
References: <20100426212128.GA28261@saboteur.suse.cz>
	<i2t364299f41004261917vf9e34d44y3cbde0a2eada4e75@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <i2t364299f41004261917vf9e34d44y3cbde0a2eada4e75@mail.gmail.com>
Subject: Re: [LTP] [PATCH] add types for functions in fs-bench
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > Attached patch adds types for functions in sources for fs-bench just because
> > when function doesn't have return type it defaults to int and this causes
> > problems (for example when doing return from such function without value).
> >
> > Signed-off-by: Cyril Hrubis chrubis@suse.cz
> >
> >
> > Side note:
> >
> > The code quality for fs-bench is very poor, there is no documentation and the
> > scripts are broken (mostly wrongly hardcoded paths). IMHO these tests are not
> > worth fixing and candidate for removal.
> 
>     Please provide a build log.

Okay apparently I've missed some "unused variable" and "implicit
function declaration" warnings.  Attached patch fixes all compilation
issues (has previous two merged) but still at least the test scripts are
broken.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--C7zPtVaVf+AK4Oqc
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fs-bench_cleanup.patch"

diff --git a/testcases/kernel/fs/fs-bench/boxmuler.c b/testcases/kernel/fs/fs-bench/boxmuler.c
index 89ee941..0609335 100644
--- a/testcases/kernel/fs/fs-bench/boxmuler.c
+++ b/testcases/kernel/fs/fs-bench/boxmuler.c
@@ -1,5 +1,8 @@
 #include <math.h>
+#include <stdlib.h>
+
 #define M_2PI (M_PI*2)
+
 int box_muler(int min, int max)
 {
   double u1,u2,z;
diff --git a/testcases/kernel/fs/fs-bench/create-files.c b/testcases/kernel/fs/fs-bench/create-files.c
index 88ea202..ec54bb8 100644
--- a/testcases/kernel/fs/fs-bench/create-files.c
+++ b/testcases/kernel/fs/fs-bench/create-files.c
@@ -15,11 +15,14 @@
 char wbuf[MAXFSIZE];
 static int filecount=0;
 
+void makedir(char *dir1);
+void changedir(char *dir);
+void create_file(char *filename);
 
 extern int box_muler(int, int);
 
 int startc=0;
-main(int ac,char *av[])
+int main(int ac,char *av[])
 {
   int i=0;
   int j=0;
@@ -71,18 +74,21 @@ main(int ac,char *av[])
 end:
   fprintf(stderr,"\nTotal create files: %d\n",filecount);
   printf("Done\n");
+  return 0;
 }
 
 int showchar[]={124,47,45,92,124,47,45,92};
-static int mkdir_counter=0;
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
@@ -90,7 +96,7 @@ changedir(char *dir) {
 }
 
 
-create_file(char *filename)
+void create_file(char *filename)
 {
   int fd;
   int randomsize;
diff --git a/testcases/kernel/fs/fs-bench/random-access-del-create.c b/testcases/kernel/fs/fs-bench/random-access-del-create.c
index 3322d92..fdfc71f 100644
--- a/testcases/kernel/fs/fs-bench/random-access-del-create.c
+++ b/testcases/kernel/fs/fs-bench/random-access-del-create.c
@@ -20,12 +20,14 @@ int openlog[2]={0,0};
 extern int box_muler(int, int);
 extern void create_or_delete(char *);
 
+int delete_file(char *filename);
+int create_file(char *filename);
+
 int cfilecount=0;
 int dfilecount=0;
 int errorcount=0;
 
-int
-main(int ac, char **av)
+int main(int ac, char **av)
 {
   int r;
   char fname[1024];
@@ -73,7 +75,6 @@ static int disk_space_pool=0;
 void create_or_delete(char *fname)
 {
   int r;
-  int fsize;
 
   r = (random() & 1);
   if ( r && disk_space_pool > POOLDISKSPACE) {
@@ -92,7 +93,7 @@ void create_or_delete(char *fname)
   }
 }
 
-create_file(char *filename)
+int create_file(char *filename)
 {
   int fd;
   int randomsize;
@@ -112,12 +113,14 @@ create_file(char *filename)
   cfilecount++;
   disk_space_pool -= randomsize;
   close(fd);
+
+  return 0;
 }
 
 #include <sys/stat.h>
 #include <unistd.h>
 
-delete_file(char *filename)
+int delete_file(char *filename)
 {
   struct stat buf;
   int st;
@@ -132,4 +135,6 @@ delete_file(char *filename)
     return(-1);
   }
   dfilecount++;
+
+  return 0;
 }
diff --git a/testcases/kernel/fs/fs-bench/random-access.c b/testcases/kernel/fs/fs-bench/random-access.c
index e2f8536..f5eb6a2 100644
--- a/testcases/kernel/fs/fs-bench/random-access.c
+++ b/testcases/kernel/fs/fs-bench/random-access.c
@@ -15,10 +15,12 @@ int openlog[2]={0,0};
 
 #define MAXNUM 0x100000
 
+void open_read_close(char *fname);
+
 int nullfd;
-main(int ac, char **av)
+
+int main(int ac, char **av)
 {
-  int fd;
   int r;
   char fname[1024];
   time_t t;
@@ -62,7 +64,7 @@ main(int ac, char **av)
 }
 
 #define BUFS 8192
-open_read_close(char *fname)
+void open_read_close(char *fname)
 {
   int fd;
   char buf[BUFS];
diff --git a/testcases/kernel/fs/fs-bench/random-del-create.c b/testcases/kernel/fs/fs-bench/random-del-create.c
index a1fc8b8..70ddf32 100644
--- a/testcases/kernel/fs/fs-bench/random-del-create.c
+++ b/testcases/kernel/fs/fs-bench/random-del-create.c
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
@@ -111,12 +111,13 @@ create_file(char *filename)
   cfilecount++;
   disk_space_pool -= randomsize;
   close(fd);
+  return 0;
 }
 
 #include <sys/stat.h>
 #include <unistd.h>
 
-delete_file(char *filename)
+int delete_file(char *filename)
 {
   struct stat buf;
   int st;
@@ -131,4 +132,5 @@ delete_file(char *filename)
     return(-1);
   }
   dfilecount++;
+  return 0;
 }

--C7zPtVaVf+AK4Oqc
Content-Type: text/x-log; charset=us-ascii
Content-Disposition: attachment; filename="orig_comp.log"

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../../include -I../../../../include  -c -o create-files.o create-files.c
create-files.c:23: warning: return type defaults to 'int'
create-files.c: In function 'main':
create-files.c:48: warning: implicit declaration of function 'makedir'
create-files.c:49: warning: implicit declaration of function 'changedir'
create-files.c:60: warning: implicit declaration of function 'create_file'
create-files.c: At top level:
create-files.c:79: warning: return type defaults to 'int'
create-files.c:85: warning: return type defaults to 'int'
create-files.c:94: warning: return type defaults to 'int'
create-files.c: In function 'create_file':
create-files.c:112: warning: control reaches end of non-void function
create-files.c: In function 'changedir':
create-files.c:90: warning: control reaches end of non-void function
create-files.c: In function 'makedir':
create-files.c:84: warning: control reaches end of non-void function
create-files.c: In function 'main':
create-files.c:74: warning: control reaches end of non-void function
create-files.c: At top level:
create-files.c:77: warning: 'mkdir_counter' defined but not used
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../../include -I../../../../include  -c -o boxmuler.o boxmuler.c
boxmuler.c: In function 'box_muler':
boxmuler.c:16: warning: implicit declaration of function 'random'
gcc   -L../../../../lib  create-files.o boxmuler.o   -lm -o create-files
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../../include -I../../../../include   -L../../../../lib  random-access.c   -lm -o random-access
random-access.c:20: warning: return type defaults to 'int'
random-access.c: In function 'main':
random-access.c:57: warning: implicit declaration of function 'open_read_close'
random-access.c:21: warning: unused variable 'fd'
random-access.c: At top level:
random-access.c:66: warning: return type defaults to 'int'
random-access.c: In function 'open_read_close':
random-access.c:74: warning: 'return' with no value, in function returning non-void
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../../include -I../../../../include  -c -o random-access-del-create.o random-access-del-create.c
random-access-del-create.c: In function 'create_or_delete':
random-access-del-create.c:81: warning: implicit declaration of function 'create_file'
random-access-del-create.c:84: warning: implicit declaration of function 'delete_file'
random-access-del-create.c:76: warning: unused variable 'fsize'
random-access-del-create.c: At top level:
random-access-del-create.c:96: warning: return type defaults to 'int'
random-access-del-create.c:121: warning: return type defaults to 'int'
random-access-del-create.c: In function 'delete_file':
random-access-del-create.c:135: warning: control reaches end of non-void function
random-access-del-create.c: In function 'create_file':
random-access-del-create.c:115: warning: control reaches end of non-void function
gcc   -L../../../../lib  random-access-del-create.o boxmuler.o   -lm -o random-access-del-create

--C7zPtVaVf+AK4Oqc
Content-Type: text/x-log; charset=us-ascii
Content-Disposition: attachment; filename="new_comp.log"

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../../include -I../../../../include  -c -o create-files.o create-files.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../../include -I../../../../include  -c -o boxmuler.o boxmuler.c
gcc   -L../../../../lib  create-files.o boxmuler.o   -lm -o create-files
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../../include -I../../../../include   -L../../../../lib  random-access.c   -lm -o random-access
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../../include -I../../../../include  -c -o random-access-del-create.o random-access-del-create.c
gcc   -L../../../../lib  random-access-del-create.o boxmuler.o   -lm -o random-access-del-create

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--C7zPtVaVf+AK4Oqc--

