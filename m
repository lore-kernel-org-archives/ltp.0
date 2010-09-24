Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1OzBgi-0001qn-W8
	for ltp-list@lists.sourceforge.net; Fri, 24 Sep 2010 17:03:56 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OzBgh-0005BH-Mj
	for ltp-list@lists.sourceforge.net; Fri, 24 Sep 2010 17:03:56 +0000
Date: Fri, 24 Sep 2010 13:03:49 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <587303608.585691285347829006.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <622595573.585371285347722630.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_28797_1932476348.1285347829005"
Subject: Re: [LTP] buffered I/O causes testcases/network/nfs/nfsstress
 failure
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

------=_Part_28797_1932476348.1285347829005
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:

> On Tue, Sep 7, 2010 at 8:13 AM, Caspar Zhang <czhang@redhat.com>
> wrote:
> >
> > ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
> >
> >> On Tue, Sep 7, 2010 at 5:18 AM, Caspar Zhang <czhang@redhat.com>
> >> wrote:
> >> > Hi all,
> >> > =C2=A0When I run testcases/network/nfs/nfsstress/ test, I found
> sometimes
> >> the
> >> > test failed due to buffered I/O, in detail, for example, there
> are
> >> the following
> >> > lines in make_tree.c :
> >> >
> >> > 544 =C2=A0 =C2=A0 numchar[0] =3D sprintf(prog_buf,
> >> > 545 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "main()\=
n{\n\t printf(\"hello
> world\");\n}\n");
> >> >
> >> > sometimes the generated .c file will be:
> >> > ^@ain() // <- strange ASCII char '^@' appears instead of 'm'
> >> > {
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("hello world");
> >> > }
> >> >
> >> > And running with this .c file will cause error.
> >> >
> >> > That is to say, string 'prog_buf' gets a mistake during sprintf.
> And
> >> there're
> >> > somewhere else using buffered I/O in this test as well. Do we
> have
> >> an
> >> > unbuffered solution to this test?
> >>
> >> That seems a bit odd. Is the NFS mount/server TCP or UDP?
> >
> > Hi Garrett, it's UDP.
>=20
>     Ok. Something else that might be good to note is whether or not
> it's v2, v3, or v4 on the client and server side.
>     Could you please try with TCP and see whether or not the issue
> persists? I'm just curious if it's a potentially real issue with NFS
> code in the kernel, random networking infrastructure issues, etc.
> Thanks,

Hi Garrett, sorry for late reply. I tried all combinations of TCP/UDP=20
and v2/v3/v4 but the error still existed. I wrote a workaround patch
and re-tested with the combinations above, the issue seemed to be solved.

This patch have 2 fixes:

a) extend malloc length from 1024 to 2048. If we keep both default dir num
and file num as 100, the string length of dirname/filename length will be=
=20
easily > 1024 bytes. This will cause string buffer overflow and the main.c=
=20
may be filled with such wrong chars: '19123.97/19123.98/19123.99/19123.99.0=
.cmain()...'

b) add tmpdirname var in some sprintf sentences. According the man page of
sprintf:

NOTES
       Some programs imprudently rely on code such as the following
           sprintf(buf, "%s some further text", buf);
       to append text to buf.  However, the standards explicitly note
 that the results are undefined if source  and  destination buffers =20
 overlap  when  calling  sprintf(),  snprintf(), vsprintf(), and=20
 vsnprintf().  Depending on the version of gcc(1) used, and the=20
 compiler options employed, calls such as the above will not produce=20
 the expected results.

Signed-off-by: Caspar Zhang <czhang@redhat.com>

Thanks,
Caspar

--=20
Quality Assurance Associate (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch

TEL: +86-10-62608150
WEB: http://www.redhat.com/

------=_Part_28797_1932476348.1285347829005
Content-Type: text/x-patch; name=network-nfsstress-buffered-io-string.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=network-nfsstress-buffered-io-string.patch

--- a/testcases/network/nfs/nfsstress/make_tree.c	2010-04-01 14:23:11.000000000 +0800
+++ b/testcases/network/nfs/nfsstress/make_tree.c	2010-09-25 00:43:37.470000001 +0800
@@ -266,13 +266,13 @@
     char	*dirname;	/* location where compile is initated         */
     char	*command;	/* make or make clean command.                */
 
-    if ((dirname = malloc(sizeof(char) * 1024)) == NULL) /* just paranoid */
+    if ((dirname = malloc(sizeof(char) * 2048)) == NULL) /* just paranoid */
     {
         perror("init_compile(): dirname malloc()");
         return 1;
     }
 
-    if ((command = malloc(1024)) == NULL) 		/* just paranoid */
+    if ((command = malloc(sizeof(char) * 1024)) == NULL) /* just paranoid */
     {
         perror("init_compile(): dirname malloc()");
         return 1;
@@ -364,23 +364,29 @@
     int		dircnt;		        /* index into directory tree          */
     int		sindex = numsdir;       /* num subdirectory tree to remove    */
     char	*dirname;		/* name of the directory to chdir()   */
+    char	*tmpdirname;		/* temp name for directory, for swap  */
     char	*filename;		/* name of the cfile to remove        */
     char	*subdir;		/* name of the sub dir to remove      */
 
-    if ((dirname = malloc(sizeof(char) * 1024)) == NULL) /* just paranoid */
+    if ((dirname = malloc(sizeof(char) * 2048)) == NULL) /* just paranoid */
     {
         perror("crte_mk_rm(): dirname malloc()");
 	return 1;
     }
     
+    if ((tmpdirname = malloc(sizeof(char) * 2048)) == NULL) /* just paranoid */
+    {
+        perror("crte_mk_rm(): tmpdirname malloc()");
+	return 1;
+    }
 
-    if ((filename = malloc(sizeof(char) * 1024)) == NULL) /* just paranoid */
+    if ((filename = malloc(sizeof(char) * 2048)) == NULL) /* just paranoid */
     {
         perror("crte_mk_rm(): filename malloc()");
 	return 1;
     }
 
-    if ((subdir = malloc(sizeof(char) * 1024)) == NULL) /* just paranoid */
+    if ((subdir = malloc(sizeof(char) * 2048)) == NULL) /* just paranoid */
     {
         perror("crte_mk_rm(): subdir malloc()");
 	return 1;
@@ -391,9 +397,16 @@
     {
         /* get the name of the last directory created. */
         for (dircnt = 0; dircnt < sindex; dircnt++)
-            (dircnt == 0) ? 
-	       sprintf(dirname, "%s/%s.%ld", base_dir, hname, gettid()) :
-               sprintf(dirname, "%s/%ld.%d", dirname, gettid(), dircnt);
+        {
+            if (dircnt == 0)
+                sprintf(dirname, "%s/%s.%ld", base_dir, hname, gettid());
+            else
+            {
+                 sprintf(tmpdirname, "%s/%ld.%d", dirname, gettid(), dircnt);
+                 sprintf(dirname, "%s", tmpdirname);
+            }
+            sync;
+        }
 
         dprt("pid[%d]: cd'ing to last created dir: %s\n", gettid(), dirname);
 
@@ -410,6 +423,7 @@
             {
                 dprt("pid[%d]: failed removing file: %s\n", gettid(), filename);
                 perror("rm_file_dir(): unlink()");
+                free(tmpdirname);
                 free(dirname);
                 free(filename);
                 free(subdir);
@@ -423,6 +437,7 @@
         if (unlink(filename))
         {
             perror("rm_file_dir() cound not remove makefile unlink()");
+            free(tmpdirname);
             free(dirname);
             free(filename);
             free(subdir);
@@ -442,6 +457,7 @@
             if (rmdir(subdir) == -1)
             {
                 perror("rm_file_dir() rmdir()");
+                free(tmpdirname);
                 free(dirname);
                 free(filename);
                 free(subdir);
@@ -451,6 +467,7 @@
         }
     }
 
+    free(tmpdirname);
     free(dirname);
     free(filename);
     free(subdir);
@@ -484,6 +501,7 @@
     int		filecnt;	/* index to the number of ".c" files created  */
     int		numchar[2];	/* number of characters written to buffer     */
     char 	*dirname;	/* name of the directory/idirectory tree      */
+    char 	*tmpdirname;	/* name of a temporary directory, for swaping */
     char	*cfilename;     /* name of the ".c" file created	      */
     char	*mkfilename;	/* name of the makefile - which is "makefile" */
     char	*hostname;	/* hostname of the client machine             */
@@ -494,19 +512,25 @@
                              (long *)args; 
     volatile int exit_val = 0;  /* exit value of the pthreads		      */
 
-    if ((dirname = malloc(sizeof(char) * 1024)) == NULL) /* just paranoid */
+    if ((dirname = malloc(sizeof(char) * 2048)) == NULL) /* just paranoid */
     {
         perror("crte_mk_rm(): dirname malloc()");
 	PTHREAD_EXIT(-1);
     }
 
-    if ((cfilename = malloc(sizeof(char) * 1024)) == NULL)
+    if ((tmpdirname = malloc(sizeof(char) * 2048)) == NULL)
+    {
+        perror("crte_mk_rm(): tmpdirname malloc()");
+	PTHREAD_EXIT(-1);
+    }
+
+    if ((cfilename = malloc(sizeof(char) * 2048)) == NULL)
     {
         perror("crte_mk_rm(): cfilename malloc()");
 	PTHREAD_EXIT(-1);
     }
 
-    if ((mkfilename = malloc(sizeof(char) * 1024)) == NULL)
+    if ((mkfilename = malloc(sizeof(char) * 2048)) == NULL)
     {
         perror("crte_mk_rm(): mkfilename malloc()");
 	PTHREAD_EXIT(-1);
@@ -547,9 +571,14 @@
     for (dircnt = 0; dircnt < (int)locargptr[0]; dircnt++)
     {
         /* First create the base directory, then create the subdirectories   */
-        (dircnt == 0) ?
-	    sprintf(dirname, "%s.%ld", hostname, gettid()):
-            sprintf(dirname, "%s/%ld.%d", dirname, gettid(), dircnt);
+        if (dircnt == 0)
+            sprintf(dirname, "%s.%ld", hostname, gettid());
+        else
+        {
+            sprintf(tmpdirname, "%s/%ld.%d", dirname, gettid(), dircnt);
+            sprintf(dirname, "%s", tmpdirname);
+        }
+        sync();
           
         dprt("pid[%d] creating directory: %s\n", gettid(), dirname); 
         if (mkdir(dirname, 0777) == -1)
@@ -563,9 +592,14 @@
     usleep(10);
     for (dircnt = 0; dircnt < (int)locargptr[0]; dircnt++)
     {
-        (dircnt == 0) ?
-	    sprintf(dirname, "%s/%s.%ld", pwd, hostname, gettid()):
-            sprintf(dirname, "%s/%ld.%d", dirname, gettid(), dircnt);
+        if (dircnt == 0)
+            sprintf(dirname, "%s/%s.%ld", pwd, hostname, gettid());
+        else
+        {
+            sprintf(tmpdirname, "%s/%ld.%d", dirname, gettid(), dircnt);
+            sprintf(dirname, "%s", tmpdirname);
+        }
+        sync();
         if ((make_buf = malloc(sizeof(char) * 4096)) == NULL)
         {
             perror("crte_mk_rm(): make_buf malloc()");
@@ -641,9 +675,14 @@
 
     for (dircnt = 0; dircnt < (int)locargptr[0]; dircnt++)
     {
-        (dircnt == 0) ?
-	    sprintf(dirname, "%s/%s.%ld", pwd, hostname, gettid()):
-            sprintf(dirname, "%s/%ld.%d", dirname, gettid(), dircnt);
+        if (dircnt == 0)
+            sprintf(dirname, "%s/%s.%ld", pwd, hostname, gettid());
+        else
+        {
+            sprintf(tmpdirname, "%s/%ld.%d", dirname, gettid(), dircnt);
+            sprintf(dirname, "%s", tmpdirname);
+        }
+        sync();
         /* In each directory create N ".c" files and a makefile. */
         for (filecnt = 0; filecnt < (int)locargptr[1]; filecnt++)
         {

------=_Part_28797_1932476348.1285347829005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
------=_Part_28797_1932476348.1285347829005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_28797_1932476348.1285347829005--

