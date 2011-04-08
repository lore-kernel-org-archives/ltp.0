Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q8IOD-0008D5-TA
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 20:34:45 +0000
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q8IOC-0002t5-T4
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 20:34:45 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  8 Apr 2011 15:34:33 -0500
Message-Id: <d639d5426d92155704bca0ab640ccf1257283b1f.1302294850.git.aelder@sgi.com>
In-Reply-To: <1302294875-6898-1-git-send-email-aelder@sgi.com>
References: <1302294875-6898-1-git-send-email-aelder@sgi.com>
In-Reply-To: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
References: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
Subject: [LTP] [PATCH 2/4] ltp: kill warnings related to formatting off_t in
	"growfiles.c"
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

In "testcases/kernel/fs/doio/growfiles.c" there are a number of
variables of type off_t which are formatted using a "%ld" conversion
specification.  When I build on an i386 system I get warnings,
because evidently off_t is not defined as a long in this
environment.

Since off_t is a 32-bit signed type, it should be safe to just
explicitly cast the off_t arguments to (long) in these cases.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/fs/doio/growfiles.c |   93 +++++++++++++++++++++------------
 1 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index 2bb21bd..ad7128f 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -1145,7 +1145,7 @@ no whole file checking will be performed!\n", Progname, TagName, getpid());
 
 	    if (Debug > 2)
 		printf("%s: %d DEBUG3 Unlink interval is %d (random %ld - %d)\n",
-		    Progname, Pid, unlink_inter, tmp, unlink_inter_ran);
+		    Progname, Pid, unlink_inter, (long) tmp, unlink_inter_ran);
 	}
 
 	/*
@@ -1909,8 +1909,8 @@ growfile(int fd, char *file, int grow_incr, char *buf,
 	if (Mode & MODE_GROW_BY_LSEEK) {
                 Woffset=fsize;
 		if (Debug > 2) {
-		    printf("%s: %d DEBUG3 %s/%d: Current size of file is %ld\n", Progname,
-			Pid, __FILE__, __LINE__, Woffset);
+		    printf("%s: %d DEBUG3 %s/%d: Current size of file is %ld\n",
+			    Progname, Pid, __FILE__, __LINE__, (long) Woffset);
 		    printf("%s: %d DEBUG3 %s/%d: lseeking to %d byte with SEEK_END\n", Progname,
 			Pid, __FILE__, __LINE__, grow_incr-1);
 		}
@@ -2006,14 +2006,17 @@ growfile(int fd, char *file, int grow_incr, char *buf,
                    }
 
 		   if ((Woffset=lseek(fd, noffset, SEEK_SET)) == -1) {
-                        fprintf(stderr, "%s%s: %d %s/%d: lseek(%d, %ld, SEEK_SET) l2 failed: %s\n",
-                                Progname, TagName, Pid, __FILE__, __LINE__, fd, noffset, strerror(errno));
+                        fprintf(stderr, "%s%s: %d %s/%d: lseek(%d, %ld, "
+				"SEEK_SET) l2 failed: %s\n",
+                                Progname, TagName, Pid, __FILE__, __LINE__,
+				fd, (long) noffset, strerror(errno));
                         return -1;
 		   }
                    else if (Debug > 2)
-                        printf("%s: %d DEBUG3 %s/%d: lseeked to random offset %ld (fsz:%d)\n",
-                            Progname, Pid, __FILE__, __LINE__, Woffset,
-			    (int)stbuf.st_size);
+                        printf("%s: %d DEBUG3 %s/%d: lseeked to "
+				"random offset %ld (fsz:%d)\n",
+                            Progname, Pid, __FILE__, __LINE__,
+			    (long) Woffset, (int)stbuf.st_size);
 
                 }
 
@@ -2027,8 +2030,9 @@ growfile(int fd, char *file, int grow_incr, char *buf,
 			return -1;
 		    }
                     else if (Debug > 2)
-                        printf("%s: %d DEBUG3 %s/%d: lseeked to end of file, offset %ld\n",
-                            Progname, Pid, __FILE__, __LINE__, Woffset);
+                        printf("%s: %d DEBUG3 %s/%d: lseeked to "
+				"end of file, offset %ld\n",
+                            Progname, Pid, __FILE__, __LINE__, (long) Woffset);
 		}
 
 		if (Pattern == PATTERN_OFFSET)
@@ -2140,14 +2144,22 @@ growfile(int fd, char *file, int grow_incr, char *buf,
 		     * The pattern written to the file will be considered corrupted.
 		     */
 		    if (Debug > 0 && lockfile) {
-		        printf("%s%s: %d DEBUG1 %s/%d: offset after write(%ld) not as exp(%ld+%d=%ld)\n",
-			    Progname, TagName, Pid, __FILE__, __LINE__, tmp, Woffset, grow_incr, Woffset+grow_incr);
-			printf("%s%s: %d DEBUG1 %s/%d: %d Assuming file changed by another process, resetting offset:%ld (expect pattern mismatch)\n",
-				Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt, tmp-grow_incr);
+		        printf("%s%s: %d DEBUG1 %s/%d: offset after "
+				"write(%ld) not as exp(%ld+%d=%ld)\n",
+			    Progname, TagName, Pid, __FILE__, __LINE__,
+			    (long) tmp, (long) Woffset, grow_incr,
+			    (long) (Woffset + grow_incr));
+			printf("%s%s: %d DEBUG1 %s/%d: %d Assuming file "
+				"changed by another process, resetting "
+				"offset:%ld (expect pattern mismatch)\n",
+				Progname, TagName, Pid, __FILE__, __LINE__,
+				Iter_cnt, (long) (tmp - grow_incr));
 		    }
 		    if (Debug > 4) {
-			printf("%s: %d DEBUG5 %s/%d: about to chop Woffset.  tmp=%ld, grow_incr=%d, Woffset was %ld\n",
-			       Progname, Pid, __FILE__, __LINE__, tmp, grow_incr, Woffset);
+			printf("%s: %d DEBUG5 %s/%d: about to chop Woffset.  "
+				"tmp=%ld, grow_incr=%d, Woffset was %ld\n",
+			       Progname, Pid, __FILE__, __LINE__,
+			       (long) tmp, grow_incr, (long) Woffset);
 		    }
 		    Woffset=tmp-grow_incr;
 		    if (Woffset < 0)
@@ -2169,11 +2181,15 @@ growfile(int fd, char *file, int grow_incr, char *buf,
 	     }
 
 	     else if (size_grew > 0)
-		printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld), grew file by %d bytes\n",
-                        Progname, Pid, __FILE__, __LINE__, Iter_cnt, Grow_incr, Woffset, size_grew);
+		printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld), "
+			"grew file by %d bytes\n",
+                        Progname, Pid, __FILE__, __LINE__, Iter_cnt,
+			Grow_incr, (long) Woffset, size_grew);
 	     else
-		printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld), did not grow file\n",
-                        Progname, Pid, __FILE__, __LINE__, Iter_cnt, Grow_incr, Woffset);
+		printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld), "
+			"did not grow file\n",
+                        Progname, Pid, __FILE__, __LINE__, Iter_cnt,
+			Grow_incr, (long) Woffset);
 	}
 
     	bytes_consumed += size_grew;
@@ -2333,8 +2349,9 @@ check_write(int fd, int cf_inter, char *filename, int mode)
 
     if (Grow_incr <= 0) {
         if (Debug > 3)
-	    printf("%s: %d DEBUG4 %s/%d: No write validation,  Grow_incr = %d, offset = %ld\n",
-	        Progname, Pid, __FILE__, __LINE__, Grow_incr, Woffset);
+	    printf("%s: %d DEBUG4 %s/%d: No write validation,  "
+		    "Grow_incr = %d, offset = %ld\n",
+	        Progname, Pid, __FILE__, __LINE__, Grow_incr, (long) Woffset);
       return 0;	/* no check */
     }
 
@@ -2354,8 +2371,10 @@ check_write(int fd, int cf_inter, char *filename, int mode)
 	 * The contents of our last write is totally gone, no check.
 	 */
 	if (Debug > 1)
-	    printf("%s%s: %d DEBUG2 %s/%d: %d File size (%d) smaller than where last wrote (%ld)- no write validation\n",
-		Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt, fsize, Woffset);
+	    printf("%s%s: %d DEBUG2 %s/%d: %d File size (%d) smaller than "
+		    "where last wrote (%ld)- no write validation\n",
+		Progname, TagName, Pid, __FILE__, __LINE__,
+		Iter_cnt, fsize, (long) Woffset);
         lkfile(fd, LOCK_UN, LKLVL0);
       return 0;	/* no validation, but not an error */
 
@@ -2371,25 +2390,29 @@ check_write(int fd, int cf_inter, char *filename, int mode)
 
 	if (Debug > 1)  {
 
-	    printf("%s%s: %d DEBUG2 %s/%d: %d fsz:%d, lost(%d)of wrt(off:%ld, sz:%d), adj=%d\n",
-	    Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt, fsize, tmp-Grow_incr, Woffset, tmp, Grow_incr);
+	    printf("%s%s: %d DEBUG2 %s/%d: %d fsz:%d, lost(%d)of "
+		    "wrt(off:%ld, sz:%d), adj=%d\n", Progname,
+		    TagName, Pid, __FILE__, __LINE__, Iter_cnt, fsize,
+		    tmp - Grow_incr, (long) Woffset, tmp, Grow_incr);
 	}
 
     }
 
     if (Debug > 2)
-        printf("%s: %d DEBUG3 %s/%d: about to do write validation, offset = %ld, size = %d\n",
-	    Progname, Pid, __FILE__, __LINE__, Woffset, Grow_incr);
+        printf("%s: %d DEBUG3 %s/%d: about to do write validation, "
+		"offset = %ld, size = %d\n",
+	    Progname, Pid, __FILE__, __LINE__, (long) Woffset, Grow_incr);
 
     if (! (mode & MODE_FIFO)) {
 
         if (lseek(fd, Woffset, 0) == -1) {
             fprintf(stderr, "%s%s: %d %s/%d: lseek(fd, %ld, 0) failed: %s\n",
-	        Progname, TagName, Pid, __FILE__, __LINE__, Woffset, strerror(errno));
+	        Progname, TagName, Pid, __FILE__, __LINE__,
+		(long) Woffset, strerror(errno));
         }
         if (Debug > 3)
 	    printf("%s: %d DEBUG4 %s/%d: lseeked to offset:%ld\n",
-	        Progname, Pid, __FILE__, __LINE__, Woffset);
+	        Progname, Pid, __FILE__, __LINE__, (long) Woffset);
     }
 
     /*
@@ -2476,9 +2499,10 @@ check_write(int fd, int cf_inter, char *filename, int mode)
 		Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt, errmsg, filename);
 
 	if (Debug > 0)
-	    printf("%s%s: %d DEBUG1 %s/%d: **fd:%d, lk:%d, offset:%ld, sz:%d open flags:%#o %s\n",
+	    printf("%s%s: %d DEBUG1 %s/%d: **fd:%d, lk:%d, "
+		    "offset:%ld, sz:%d open flags:%#o %s\n",
 		Progname, TagName, Pid, __FILE__, __LINE__, fd, lockfile,
-		Woffset, Grow_incr, Fileinfo.openflags,
+		(long) Woffset, Grow_incr, Fileinfo.openflags,
 		openflags2symbols(Fileinfo.openflags, ",", 0));
 
 	fflush(stderr);
@@ -2486,8 +2510,9 @@ check_write(int fd, int cf_inter, char *filename, int mode)
     }
 
     if (Debug > 6)
-        printf("%s: %d DEBUG7 %s/%d: No corruption detected on write validation , offset = %ld, size = %d\n",
-            Progname, Pid, __FILE__, __LINE__, Woffset, Grow_incr);
+        printf("%s: %d DEBUG7 %s/%d: No corruption detected on "
+		"write validation , offset = %ld, size = %d\n",
+            Progname, Pid, __FILE__, __LINE__, (long) Woffset, Grow_incr);
 
   return 0;	/* all is well */
 }
-- 
1.7.4


------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
