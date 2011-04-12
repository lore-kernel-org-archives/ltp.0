Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q9eEY-0006ZB-VK
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 14:06:22 +0000
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q9eEX-0007zm-So
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 14:06:22 +0000
From: Alex Elder <aelder@sgi.com>
Date: Tue, 12 Apr 2011 09:06:04 -0500
Message-Id: <cb4b455094351bcefd98c7095f3639dd14498bca.1302617105.git.aelder@sgi.com>
In-Reply-To: <1302617166-10309-1-git-send-email-aelder@sgi.com>
References: <1302617166-10309-1-git-send-email-aelder@sgi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------true"
Subject: [LTP] [PATCH 1/3] ltp: fix warnings in "growfiles.c"
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

This is a multi-part message in MIME format.
--------------true
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: quoted-printable


In "testcases/kernel/fs/doio/growfiles.c" there are a number of
variables of type off_t which are formatted using a "%ld" conversion
specification.  When I build on an i386 system I get warnings,
because evidently off_t is not defined as a long in this
environment.

Updated to address Garrett Cooper's concerns that variables named
"tmp" are used for a number of purposes in this file.  In one case
I renamed the variable "off_tmp" (its type is off_t) (but did not
change corresponding printed text).  The other cases the "tmp"
variable was more appropriately type int.  Also adjusted some
whitespace, as requested.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/fs/doio/growfiles.c |  117 ++++++++++++++++++++--------=
-----
 1 files changed, 71 insertions(+), 46 deletions(-)


--------------true
Content-Type: text/x-patch; name="0001-ltp-fix-warnings-in-growfiles.c.patch"
Content-Disposition: attachment;
	filename="0001-ltp-fix-warnings-in-growfiles.c.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/d=
oio/growfiles.c
index 2bb21bd..2a31d30 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -372,7 +372,7 @@ int stop =3D 0;			/* loop stopper if set */
 unsigned long curr_size =3D 0;			/* BUG:14136 (keep track of file size) =
*/
 const unsigned long ext2_limit =3D 2147483647;	/* BUG:14136 (2GB ext2 fi=
lesize limit) */
=20
-off_t tmp;
+int tmp;
 char chr;
 int ret;
 int pre_alloc_space =3D 0;
@@ -1141,10 +1141,10 @@ no whole file checking will be performed!\n", Pro=
gname, TagName, getpid());
 	     * get different intervals.
 	     */
 	    tmp=3Dunlink_inter;
-	    unlink_inter=3Drandom_range(tmp, unlink_inter_ran, 1, NULL);
+	    unlink_inter =3D (int)random_range(tmp, unlink_inter_ran, 1, NULL);
=20
 	    if (Debug > 2)
-		printf("%s: %d DEBUG3 Unlink interval is %d (random %ld - %d)\n",
+		printf("%s: %d DEBUG3 Unlink interval is %d (random %d - %d)\n",
 		    Progname, Pid, unlink_inter, tmp, unlink_inter_ran);
 	}
=20
@@ -1853,7 +1853,7 @@ growfile(int fd, char *file, int grow_incr, char *b=
uf,
    off_t fsize;		/* current size of file */
    int size_grew;	/* size the file grew */
    struct stat stbuf;
-   off_t tmp =3D 0;
+   off_t off_tmp =3D 0;
=20
         /*
          * Do a stat on the open file.
@@ -1909,8 +1909,8 @@ growfile(int fd, char *file, int grow_incr, char *b=
uf,
 	if (Mode & MODE_GROW_BY_LSEEK) {
                 Woffset=3Dfsize;
 		if (Debug > 2) {
-		    printf("%s: %d DEBUG3 %s/%d: Current size of file is %ld\n", Progn=
ame,
-			Pid, __FILE__, __LINE__, Woffset);
+		    printf("%s: %d DEBUG3 %s/%d: Current size of file is %ld\n",
+			    Progname, Pid, __FILE__, __LINE__, (long)Woffset);
 		    printf("%s: %d DEBUG3 %s/%d: lseeking to %d byte with SEEK_END\n",=
 Progname,
 			Pid, __FILE__, __LINE__, grow_incr-1);
 		}
@@ -2006,14 +2006,17 @@ growfile(int fd, char *file, int grow_incr, char =
*buf,
                    }
=20
 		   if ((Woffset=3Dlseek(fd, noffset, SEEK_SET)) =3D=3D -1) {
-                        fprintf(stderr, "%s%s: %d %s/%d: lseek(%d, %ld, =
SEEK_SET) l2 failed: %s\n",
-                                Progname, TagName, Pid, __FILE__, __LINE=
__, fd, noffset, strerror(errno));
+                        fprintf(stderr, "%s%s: %d %s/%d: lseek(%d, %ld, =
"
+				"SEEK_SET) l2 failed: %s\n",
+                                Progname, TagName, Pid, __FILE__, __LINE=
__,
+				fd, (long)noffset, strerror(errno));
                         return -1;
 		   }
                    else if (Debug > 2)
-                        printf("%s: %d DEBUG3 %s/%d: lseeked to random o=
ffset %ld (fsz:%d)\n",
-                            Progname, Pid, __FILE__, __LINE__, Woffset,
-			    (int)stbuf.st_size);
+                        printf("%s: %d DEBUG3 %s/%d: lseeked to "
+				"random offset %ld (fsz:%d)\n",
+                            Progname, Pid, __FILE__, __LINE__,
+			    (long)Woffset, (int)stbuf.st_size);
=20
                 }
=20
@@ -2027,8 +2030,9 @@ growfile(int fd, char *file, int grow_incr, char *b=
uf,
 			return -1;
 		    }
                     else if (Debug > 2)
-                        printf("%s: %d DEBUG3 %s/%d: lseeked to end of f=
ile, offset %ld\n",
-                            Progname, Pid, __FILE__, __LINE__, Woffset);
+                        printf("%s: %d DEBUG3 %s/%d: lseeked to "
+				"end of file, offset %ld\n",
+                            Progname, Pid, __FILE__, __LINE__, (long)Wof=
fset);
 		}
=20
 		if (Pattern =3D=3D PATTERN_OFFSET)
@@ -2061,7 +2065,7 @@ growfile(int fd, char *file, int grow_incr, char *b=
uf,
 /*****
 		ret=3Dwrite(fd, buf, grow_incr);
=20
-		tmp=3Dtell(fd);
+		off_tmp =3D tell(fd);
=20
 		lkfile(fd, LOCK_UN, LKLVL0);
=20
@@ -2083,10 +2087,10 @@ growfile(int fd, char *file, int grow_incr, char =
*buf,
 			/* If it is a fifo then just pretend the file
 			 * offset is where we think it should be.
 			 */
-			tmp =3D Woffset + grow_incr;
+			off_tmp =3D Woffset + grow_incr;
 		}
 		else{
-			if ((tmp=3Dlseek(fd,0,SEEK_CUR)) < 0) { /* get offset after the write=
 */
+			if ((off_tmp =3D lseek(fd,0,SEEK_CUR)) < 0) { /* get offset after the=
 write */
 				fprintf(stderr, "%s%s: %s/%d: tell(2) failed: %d  %s\n",
 					Progname, TagName, __FILE__, __LINE__, errno, strerror(errno) );
 				return -1;
@@ -2100,18 +2104,18 @@ growfile(int fd, char *file, int grow_incr, char =
*buf,
 			 * tell() told us.  Fudge it here.
 			 */
 			if ((io_type & LIO_IO_ASYNC_TYPES) || (io_type & LIO_RANDOM)) {
-				if (tmp !=3D Woffset + grow_incr) {
+				if (off_tmp !=3D Woffset + grow_incr) {
 					if (Debug > 5) {
 						printf("%s: %d DEBUG6 %s/%d: posix fudge, forcing tmp (%"PRId64") =
to match Woffset+grow_incr (%"PRId64")\n",
-						       Progname, Pid, __FILE__, __LINE__, (int64_t)tmp, (int64_t)W=
offset+grow_incr);
+						       Progname, Pid, __FILE__, __LINE__, (int64_t)off_tmp, (int64=
_t)Woffset+grow_incr);
 					}
-					tmp =3D Woffset + grow_incr;
+					off_tmp =3D Woffset + grow_incr;
 				}
 			}
 #endif /* sgi __linux__ */
 #endif
 		}
-		*curr_size_ptr=3Dtmp;	/* BUG:14136 */
+		*curr_size_ptr =3D off_tmp;	/* BUG:14136 */
=20
 		lkfile(fd, LOCK_UN, LKLVL0);
=20
@@ -2129,7 +2133,7 @@ growfile(int fd, char *file, int grow_incr, char *b=
uf,
 		 * Check for a condition where the file was truncated just before
 		 * the write.
 		 */
-		if (tmp !=3D Woffset + grow_incr) {
+		if (off_tmp !=3D Woffset + grow_incr) {
 		    /*
 		     * The offset after the write was not as expected.
 		     * This could be caused by the following:
@@ -2140,16 +2144,24 @@ growfile(int fd, char *file, int grow_incr, char =
*buf,
 		     * The pattern written to the file will be considered corrupted.
 		     */
 		    if (Debug > 0 && lockfile) {
-		        printf("%s%s: %d DEBUG1 %s/%d: offset after write(%ld) not as =
exp(%ld+%d=3D%ld)\n",
-			    Progname, TagName, Pid, __FILE__, __LINE__, tmp, Woffset, grow_in=
cr, Woffset+grow_incr);
-			printf("%s%s: %d DEBUG1 %s/%d: %d Assuming file changed by another pr=
ocess, resetting offset:%ld (expect pattern mismatch)\n",
-				Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt, tmp-grow_incr)=
;
+		        printf("%s%s: %d DEBUG1 %s/%d: offset after "
+				"write(%ld) not as exp(%ld+%d=3D%ld)\n",
+			    Progname, TagName, Pid, __FILE__, __LINE__,
+			    (long)off_tmp, (long)Woffset, grow_incr,
+			    (long)(Woffset + grow_incr));
+			printf("%s%s: %d DEBUG1 %s/%d: %d Assuming file "
+				"changed by another process, resetting "
+				"offset:%ld (expect pattern mismatch)\n",
+				Progname, TagName, Pid, __FILE__, __LINE__,
+				Iter_cnt, (long)(off_tmp - grow_incr));
 		    }
 		    if (Debug > 4) {
-			printf("%s: %d DEBUG5 %s/%d: about to chop Woffset.  tmp=3D%ld, grow_=
incr=3D%d, Woffset was %ld\n",
-			       Progname, Pid, __FILE__, __LINE__, tmp, grow_incr, Woffset);
+			printf("%s: %d DEBUG5 %s/%d: about to chop Woffset.  "
+				"tmp=3D%ld, grow_incr=3D%d, Woffset was %ld\n",
+			       Progname, Pid, __FILE__, __LINE__,
+			       (long)off_tmp, grow_incr, (long)Woffset);
 		    }
-		    Woffset=3Dtmp-grow_incr;
+		    Woffset =3D off_tmp - grow_incr;
 		    if (Woffset < 0)
 			Woffset =3D 0;
 		}
@@ -2169,11 +2181,15 @@ growfile(int fd, char *file, int grow_incr, char =
*buf,
 	     }
=20
 	     else if (size_grew > 0)
-		printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld), grew file by =
%d bytes\n",
-                        Progname, Pid, __FILE__, __LINE__, Iter_cnt, Gro=
w_incr, Woffset, size_grew);
+		printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld), "
+			"grew file by %d bytes\n",
+                        Progname, Pid, __FILE__, __LINE__, Iter_cnt,
+			Grow_incr, (long)Woffset, size_grew);
 	     else
-		printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld), did not grow =
file\n",
-                        Progname, Pid, __FILE__, __LINE__, Iter_cnt, Gro=
w_incr, Woffset);
+		printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld), "
+			"did not grow file\n",
+                        Progname, Pid, __FILE__, __LINE__, Iter_cnt,
+			Grow_incr, (long)Woffset);
 	}
=20
     	bytes_consumed +=3D size_grew;
@@ -2333,8 +2349,9 @@ check_write(int fd, int cf_inter, char *filename, i=
nt mode)
=20
     if (Grow_incr <=3D 0) {
         if (Debug > 3)
-	    printf("%s: %d DEBUG4 %s/%d: No write validation,  Grow_incr =3D %d=
, offset =3D %ld\n",
-	        Progname, Pid, __FILE__, __LINE__, Grow_incr, Woffset);
+	    printf("%s: %d DEBUG4 %s/%d: No write validation,  "
+		    "Grow_incr =3D %d, offset =3D %ld\n",
+	        Progname, Pid, __FILE__, __LINE__, Grow_incr, (long)Woffset);
       return 0;	/* no check */
     }
=20
@@ -2354,8 +2371,10 @@ check_write(int fd, int cf_inter, char *filename, =
int mode)
 	 * The contents of our last write is totally gone, no check.
 	 */
 	if (Debug > 1)
-	    printf("%s%s: %d DEBUG2 %s/%d: %d File size (%d) smaller than where=
 last wrote (%ld)- no write validation\n",
-		Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt, fsize, Woffset);
+	    printf("%s%s: %d DEBUG2 %s/%d: %d File size (%d) smaller than "
+		    "where last wrote (%ld)- no write validation\n",
+		Progname, TagName, Pid, __FILE__, __LINE__,
+		Iter_cnt, fsize, (long)Woffset);
         lkfile(fd, LOCK_UN, LKLVL0);
       return 0;	/* no validation, but not an error */
=20
@@ -2371,25 +2390,29 @@ check_write(int fd, int cf_inter, char *filename,=
 int mode)
=20
 	if (Debug > 1)  {
=20
-	    printf("%s%s: %d DEBUG2 %s/%d: %d fsz:%d, lost(%d)of wrt(off:%ld, s=
z:%d), adj=3D%d\n",
-	    Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt, fsize, tmp-Gr=
ow_incr, Woffset, tmp, Grow_incr);
+	    printf("%s%s: %d DEBUG2 %s/%d: %d fsz:%d, lost(%d)of "
+		    "wrt(off:%ld, sz:%d), adj=3D%d\n", Progname,
+		    TagName, Pid, __FILE__, __LINE__, Iter_cnt, fsize,
+		    tmp - Grow_incr, (long)Woffset, tmp, Grow_incr);
 	}
=20
     }
=20
     if (Debug > 2)
-        printf("%s: %d DEBUG3 %s/%d: about to do write validation, offse=
t =3D %ld, size =3D %d\n",
-	    Progname, Pid, __FILE__, __LINE__, Woffset, Grow_incr);
+        printf("%s: %d DEBUG3 %s/%d: about to do write validation, "
+		"offset =3D %ld, size =3D %d\n",
+	    Progname, Pid, __FILE__, __LINE__, (long)Woffset, Grow_incr);
=20
     if (! (mode & MODE_FIFO)) {
=20
         if (lseek(fd, Woffset, 0) =3D=3D -1) {
             fprintf(stderr, "%s%s: %d %s/%d: lseek(fd, %ld, 0) failed: %=
s\n",
-	        Progname, TagName, Pid, __FILE__, __LINE__, Woffset, strerror(e=
rrno));
+	        Progname, TagName, Pid, __FILE__, __LINE__,
+		(long)Woffset, strerror(errno));
         }
         if (Debug > 3)
 	    printf("%s: %d DEBUG4 %s/%d: lseeked to offset:%ld\n",
-	        Progname, Pid, __FILE__, __LINE__, Woffset);
+	        Progname, Pid, __FILE__, __LINE__, (long)Woffset);
     }
=20
     /*
@@ -2476,9 +2499,10 @@ check_write(int fd, int cf_inter, char *filename, =
int mode)
 		Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt, errmsg, filename=
);
=20
 	if (Debug > 0)
-	    printf("%s%s: %d DEBUG1 %s/%d: **fd:%d, lk:%d, offset:%ld, sz:%d op=
en flags:%#o %s\n",
+	    printf("%s%s: %d DEBUG1 %s/%d: **fd:%d, lk:%d, "
+		    "offset:%ld, sz:%d open flags:%#o %s\n",
 		Progname, TagName, Pid, __FILE__, __LINE__, fd, lockfile,
-		Woffset, Grow_incr, Fileinfo.openflags,
+		(long)Woffset, Grow_incr, Fileinfo.openflags,
 		openflags2symbols(Fileinfo.openflags, ",", 0));
=20
 	fflush(stderr);
@@ -2486,8 +2510,9 @@ check_write(int fd, int cf_inter, char *filename, i=
nt mode)
     }
=20
     if (Debug > 6)
-        printf("%s: %d DEBUG7 %s/%d: No corruption detected on write val=
idation , offset =3D %ld, size =3D %d\n",
-            Progname, Pid, __FILE__, __LINE__, Woffset, Grow_incr);
+        printf("%s: %d DEBUG7 %s/%d: No corruption detected on "
+		"write validation , offset =3D %ld, size =3D %d\n",
+            Progname, Pid, __FILE__, __LINE__, (long)Woffset, Grow_incr)=
;
=20
   return 0;	/* all is well */
 }

--------------true
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
--------------true
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------true--



