Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q9LuA-0000gi-MB
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 18:32:06 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q9Lu9-00038r-DZ
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 18:32:06 +0000
Received: from cf--amer001e--3.americas.sgi.com
	(cf--amer001e--3.americas.sgi.com [137.38.100.5])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 054958F804C
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 11:32:00 -0700 (PDT)
From: Alex Elder <aelder@sgi.com>
Date: Mon, 11 Apr 2011 13:31:42 -0500
Message-ID: <1302546702.2580.26.camel@doink>
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/3, v2] ltp: fix warnings in "growfiles.c"
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
To: ltp-list@lists.sourceforge.net

In "testcases/kernel/fs/doio/growfiles.c" there are a number of
variables of type off_t which are formatted using a "%ld" conversion
specification.  When I build on an i386 system I get warnings,
because evidently off_t is not defined as a long in this
environment.

Updated to address Garrett Cooper's concerns that variables named
"tmp" are used for a number of purposes in this file.  In one case I
renamed the variable "off_tmp" (its type is off_t) (but did not
change corresponding printed text).  The other cases the "tmp"
variable was more appropriately type int.

Signed-off-by: Alex Elder <aelder@sgi.com>

---
 ltp/growfiles.c |  117
+++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 46 deletions(-)

Index: b/ltp/growfiles.c
===================================================================
--- a/ltp/growfiles.c
+++ b/ltp/growfiles.c
@@ -372,7 +372,7 @@ int stop = 0;                       /* loop stopper
if set *
 unsigned long curr_size = 0;                   /* BUG:14136 (keep track
of file size) */
 const unsigned long ext2_limit = 2147483647;   /* BUG:14136 (2GB ext2
filesize limit) */
 
-off_t tmp;
+int tmp;
 char chr;
 int ret;
 int pre_alloc_space = 0;
@@ -1141,10 +1141,10 @@ no whole file checking will be performed
             * get different intervals.
             */
            tmp=unlink_inter;
-           unlink_inter=random_range(tmp, unlink_inter_ran, 1, NULL);
+           unlink_inter = (int) random_range(tmp, unlink_inter_ran, 1,
NULL);
 
            if (Debug > 2)
-               printf("%s: %d DEBUG3 Unlink interval is %d (random %ld
- %d)\n",
+               printf("%s: %d DEBUG3 Unlink interval is %d (random %d -
%d)\n",
                    Progname, Pid, unlink_inter, tmp, unlink_inter_ran);
        }
 
@@ -1853,7 +1853,7 @@ growfile(int fd, char *file, int grow_in
    off_t fsize;                /* current size of file */
    int size_grew;      /* size the file grew */
    struct stat stbuf;
-   off_t tmp = 0;
+   off_t off_tmp = 0;
 
         /*
          * Do a stat on the open file.
@@ -1909,8 +1909,8 @@ growfile(int fd, char *file, int grow_in
        if (Mode & MODE_GROW_BY_LSEEK) {
                 Woffset=fsize;
                if (Debug > 2) {
-                   printf("%s: %d DEBUG3 %s/%d: Current size of file is
%ld\n", Progname,
-                       Pid, __FILE__, __LINE__, Woffset);
+                   printf("%s: %d DEBUG3 %s/%d: Current size of file is
%ld\n",
+                           Progname, Pid, __FILE__, __LINE__, (long)
Woffset);
                    printf("%s: %d DEBUG3 %s/%d: lseeking to %d byte
with SEEK_END\n", Progname,
                        Pid, __FILE__, __LINE__, grow_incr-1);
                }
@@ -2006,14 +2006,17 @@ growfile(int fd, char *file, int grow_in
                    }
 
                   if ((Woffset=lseek(fd, noffset, SEEK_SET)) == -1) {
-                        fprintf(stderr, "%s%s: %d %s/%d: lseek(%d, %ld,
SEEK_SET) l2 failed: %s\n",
-                                Progname, TagName, Pid, __FILE__,
__LINE__, fd, noffset, strerror(errno));
+                        fprintf(stderr, "%s%s: %d %s/%d: lseek(%d, %ld,
"
+                               "SEEK_SET) l2 failed: %s\n",
+                                Progname, TagName, Pid, __FILE__,
__LINE__,
+                               fd, (long) noffset, strerror(errno));
                         return -1;
                   }
                    else if (Debug > 2)
-                        printf("%s: %d DEBUG3 %s/%d: lseeked to random
offset %ld (fsz:%d)\n",
-                            Progname, Pid, __FILE__, __LINE__, Woffset,
-                           (int)stbuf.st_size);
+                        printf("%s: %d DEBUG3 %s/%d: lseeked to "
+                               "random offset %ld (fsz:%d)\n",
+                            Progname, Pid, __FILE__, __LINE__,
+                           (long) Woffset, (int)stbuf.st_size);
 
                 }
 
@@ -2027,8 +2030,9 @@ growfile(int fd, char *file, int grow_in
                        return -1;
                    }
                     else if (Debug > 2)
-                        printf("%s: %d DEBUG3 %s/%d: lseeked to end of
file, offset %ld\n",
-                            Progname, Pid, __FILE__, __LINE__,
Woffset);
+                        printf("%s: %d DEBUG3 %s/%d: lseeked to "
+                               "end of file, offset %ld\n",
+                            Progname, Pid, __FILE__, __LINE__, (long)
Woffset);
                }
 
                if (Pattern == PATTERN_OFFSET)
@@ -2061,7 +2065,7 @@ growfile(int fd, char *file, int grow_in
 /*****
                ret=write(fd, buf, grow_incr);
 
-               tmp=tell(fd);
+               off_tmp = tell(fd);
 
                lkfile(fd, LOCK_UN, LKLVL0);
 
@@ -2083,10 +2087,10 @@ growfile(int fd, char *file, int grow_in
                        /* If it is a fifo then just pretend the file
                         * offset is where we think it should be.
                         */
-                       tmp = Woffset + grow_incr;
+                       off_tmp = Woffset + grow_incr;
                }
                else{
-                       if ((tmp=lseek(fd,0,SEEK_CUR)) < 0) { /* get
offset after the write */
+                       if ((off_tmp = lseek(fd,0,SEEK_CUR)) < 0) { /*
get offset after the write */
                                fprintf(stderr, "%s%s: %s/%d: tell(2)
failed: %d  %s\n",
                                        Progname, TagName, __FILE__,
__LINE__, errno, strerror(errno) );
                                return -1;
@@ -2100,18 +2104,18 @@ growfile(int fd, char *file, int grow_in
                         * tell() told us.  Fudge it here.
                         */
                        if ((io_type & LIO_IO_ASYNC_TYPES) || (io_type &
LIO_RANDOM)) {
-                               if (tmp != Woffset + grow_incr) {
+                               if (off_tmp != Woffset + grow_incr) {
                                        if (Debug > 5) {
                                                printf("%s: %d DEBUG6 %
s/%d: posix fudge, forcing tmp (%"PRId64") to match Woffset+grow_incr
(%"PRId64")\n",
-                                                      Progname, Pid,
__FILE__, __LINE__, (int64_t)tmp, (int64_t)Woffset+grow_incr);
+                                                      Progname, Pid,
__FILE__, __LINE__, (int64_t)off_tmp, (int64_t)Woffset+grow_incr);
                                        }
-                                       tmp = Woffset + grow_incr;
+                                       off_tmp = Woffset + grow_incr;
                                }
                        }
 #endif /* sgi __linux__ */
 #endif
                }
-               *curr_size_ptr=tmp;     /* BUG:14136 */
+               *curr_size_ptr = off_tmp;       /* BUG:14136 */
 
                lkfile(fd, LOCK_UN, LKLVL0);
 
@@ -2129,7 +2133,7 @@ growfile(int fd, char *file, int grow_in
                 * Check for a condition where the file was truncated
just before
                 * the write.
                 */
-               if (tmp != Woffset + grow_incr) {
+               if (off_tmp != Woffset + grow_incr) {
                    /*
                     * The offset after the write was not as expected.
                     * This could be caused by the following:
@@ -2140,16 +2144,24 @@ growfile(int fd, char *file, int grow_in
                     * The pattern written to the file will be
considered corrupted.
                     */
                    if (Debug > 0 && lockfile) {
-                       printf("%s%s: %d DEBUG1 %s/%d: offset after
write(%ld) not as exp(%ld+%d=%ld)\n",
-                           Progname, TagName, Pid, __FILE__, __LINE__,
tmp, Woffset, grow_incr, Woffset+grow_incr);
-                       printf("%s%s: %d DEBUG1 %s/%d: %d Assuming file
changed by another process, resetting offset:%ld (expect pattern
mismatch)\n",
-                               Progname, TagName, Pid, __FILE__,
__LINE__, Iter_cnt, tmp-grow_incr);
+                       printf("%s%s: %d DEBUG1 %s/%d: offset after "
+                               "write(%ld) not as exp(%ld+%d=%ld)\n",
+                           Progname, TagName, Pid, __FILE__, __LINE__,
+                           (long) off_tmp, (long) Woffset, grow_incr,
+                           (long) (Woffset + grow_incr));
+                       printf("%s%s: %d DEBUG1 %s/%d: %d Assuming file
"
+                               "changed by another process, resetting "
+                               "offset:%ld (expect pattern
mismatch)\n",
+                               Progname, TagName, Pid, __FILE__,
__LINE__,
+                               Iter_cnt, (long) (off_tmp - grow_incr));
                    }
                    if (Debug > 4) {
-                       printf("%s: %d DEBUG5 %s/%d: about to chop
Woffset.  tmp=%ld, grow_incr=%d, Woffset was %ld\n",
-                              Progname, Pid, __FILE__, __LINE__, tmp,
grow_incr, Woffset);
+                       printf("%s: %d DEBUG5 %s/%d: about to chop
Woffset.  "
+                               "tmp=%ld, grow_incr=%d, Woffset was %ld
\n",
+                              Progname, Pid, __FILE__, __LINE__,
+                              (long) off_tmp, grow_incr, (long)
Woffset);
                    }
-                   Woffset=tmp-grow_incr;
+                   Woffset = off_tmp - grow_incr;
                    if (Woffset < 0)
                        Woffset = 0;
                }
@@ -2169,11 +2181,15 @@ growfile(int fd, char *file, int grow_in
             }
 
             else if (size_grew > 0)
-               printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld),
grew file by %d bytes\n",
-                        Progname, Pid, __FILE__, __LINE__, Iter_cnt,
Grow_incr, Woffset, size_grew);
+               printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld),
"
+                       "grew file by %d bytes\n",
+                        Progname, Pid, __FILE__, __LINE__, Iter_cnt,
+                       Grow_incr, (long) Woffset, size_grew);
             else
-               printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld),
did not grow file\n",
-                        Progname, Pid, __FILE__, __LINE__, Iter_cnt,
Grow_incr, Woffset);
+               printf("%s: %d DEBUG2 %s/%d: %d wrote %d bytes(off:%ld),
"
+                       "did not grow file\n",
+                        Progname, Pid, __FILE__, __LINE__, Iter_cnt,
+                       Grow_incr, (long) Woffset);
        }
 
        bytes_consumed += size_grew;
@@ -2333,8 +2349,9 @@ check_write(int fd, int cf_inter, char *
 
     if (Grow_incr <= 0) {
         if (Debug > 3)
-           printf("%s: %d DEBUG4 %s/%d: No write validation,  Grow_incr
= %d, offset = %ld\n",
-               Progname, Pid, __FILE__, __LINE__, Grow_incr, Woffset);
+           printf("%s: %d DEBUG4 %s/%d: No write validation,  "
+                   "Grow_incr = %d, offset = %ld\n",
+               Progname, Pid, __FILE__, __LINE__, Grow_incr, (long)
Woffset);
       return 0;        /* no check */
     }
 
@@ -2354,8 +2371,10 @@ check_write(int fd, int cf_inter, char *
         * The contents of our last write is totally gone, no check.
         */
        if (Debug > 1)
-           printf("%s%s: %d DEBUG2 %s/%d: %d File size (%d) smaller
than where last wrote (%ld)- no write validation\n",
-               Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt,
fsize, Woffset);
+           printf("%s%s: %d DEBUG2 %s/%d: %d File size (%d) smaller
than "
+                   "where last wrote (%ld)- no write validation\n",
+               Progname, TagName, Pid, __FILE__, __LINE__,
+               Iter_cnt, fsize, (long) Woffset);
         lkfile(fd, LOCK_UN, LKLVL0);
       return 0;        /* no validation, but not an error */
 
@@ -2371,25 +2390,29 @@ check_write(int fd, int cf_inter, char *
 
        if (Debug > 1)  {
 
-           printf("%s%s: %d DEBUG2 %s/%d: %d fsz:%d, lost(%d)of
wrt(off:%ld, sz:%d), adj=%d\n",
-           Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt, fsize,
tmp-Grow_incr, Woffset, tmp, Grow_incr);
+           printf("%s%s: %d DEBUG2 %s/%d: %d fsz:%d, lost(%d)of "
+                   "wrt(off:%ld, sz:%d), adj=%d\n", Progname,
+                   TagName, Pid, __FILE__, __LINE__, Iter_cnt, fsize,
+                   tmp - Grow_incr, (long) Woffset, tmp, Grow_incr);
        }
 
     }
 
     if (Debug > 2)
-        printf("%s: %d DEBUG3 %s/%d: about to do write validation,
offset = %ld, size = %d\n",
-           Progname, Pid, __FILE__, __LINE__, Woffset, Grow_incr);
+        printf("%s: %d DEBUG3 %s/%d: about to do write validation, "
+               "offset = %ld, size = %d\n",
+           Progname, Pid, __FILE__, __LINE__, (long) Woffset,
Grow_incr);
 
     if (! (mode & MODE_FIFO)) {
 
         if (lseek(fd, Woffset, 0) == -1) {
             fprintf(stderr, "%s%s: %d %s/%d: lseek(fd, %ld, 0) failed:
%s\n",
-               Progname, TagName, Pid, __FILE__, __LINE__, Woffset,
strerror(errno));
+               Progname, TagName, Pid, __FILE__, __LINE__,
+               (long) Woffset, strerror(errno));
         }
         if (Debug > 3)
            printf("%s: %d DEBUG4 %s/%d: lseeked to offset:%ld\n",
-               Progname, Pid, __FILE__, __LINE__, Woffset);
+               Progname, Pid, __FILE__, __LINE__, (long) Woffset);
     }
 
     /*
@@ -2476,9 +2499,10 @@ check_write(int fd, int cf_inter, char *
                Progname, TagName, Pid, __FILE__, __LINE__, Iter_cnt,
errmsg, filename);
 
        if (Debug > 0)
-           printf("%s%s: %d DEBUG1 %s/%d: **fd:%d, lk:%d, offset:%ld,
sz:%d open flags:%#o %s\n",
+           printf("%s%s: %d DEBUG1 %s/%d: **fd:%d, lk:%d, "
+                   "offset:%ld, sz:%d open flags:%#o %s\n",
                Progname, TagName, Pid, __FILE__, __LINE__, fd,
lockfile,
-               Woffset, Grow_incr, Fileinfo.openflags,
+               (long) Woffset, Grow_incr, Fileinfo.openflags,
                openflags2symbols(Fileinfo.openflags, ",", 0));
 
        fflush(stderr);
@@ -2486,8 +2510,9 @@ check_write(int fd, int cf_inter, char *
     }
 
     if (Debug > 6)
-        printf("%s: %d DEBUG7 %s/%d: No corruption detected on write
validation , offset = %ld, size = %d\n",
-            Progname, Pid, __FILE__, __LINE__, Woffset, Grow_incr);
+        printf("%s: %d DEBUG7 %s/%d: No corruption detected on "
+               "write validation , offset = %ld, size = %d\n",
+            Progname, Pid, __FILE__, __LINE__, (long) Woffset,
Grow_incr);
 
   return 0;    /* all is well */
 }


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
