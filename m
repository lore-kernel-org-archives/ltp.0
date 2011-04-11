Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q9Lv9-0000k0-Ds
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 18:33:07 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q9Lv8-0004r7-Ad
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 18:33:07 +0000
Received: from cf--amer001e--3.americas.sgi.com
	(cf--amer001e--3.americas.sgi.com [137.38.100.5])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 0D3B88F8040
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 11:33:00 -0700 (PDT)
From: Alex Elder <aelder@sgi.com>
Date: Mon, 11 Apr 2011 13:32:00 -0500
Message-ID: <1302546720.2580.29.camel@doink>
Mime-Version: 1.0
Subject: [LTP] [PATCH 3/3, v2] ltp: fix warnings in "fsstress.c"
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

Fix remaining warnings in "testcases/kernel/fs/fsstress/fsstress.c".
Three of them are due to mismatches between fprintf() conversion
specifications and the variables being formatted.  Fix these by
casting the variables to the right type.

Two others are due to the use of a __uint64_t local variable to
represent a value of type __u64 (which evidently can be defined
differently in some environments).  Fix these by using the exact
matching type in the cases that produce the warning messages.

Updated to address the concern raised by Garrett Cooper about the
use of types that are not identical to what's used in the XFS
ioctl() interface in the kernel.  Also added memset() calls so we're
sure no garbage resides in data structures passed between user space
and the kernel.

Signed-off-by: Alex Elder <aelder@sgi.com>

---
 ltp/fsstress.c |   83
+++++++++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 34 deletions(-)

Index: b/ltp/fsstress.c
===================================================================
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -419,6 +419,7 @@ int main(int argc, char **argv)
                }
 #ifndef NO_XFS
                if (!no_xfs) {
+               memset(&geom, 0, sizeof geom);
                i = ioctl(fd, XFS_IOC_FSGEOMETRY, &geom);
                if (i >= 0 && geom.rtblocks)
                        rtpct = MIN(MAX(geom.rtblocks * 100 /
@@ -447,6 +448,7 @@ int main(int argc, char **argv)
                                errtag += (random() % (XFS_ERRTAG_MAX -
errtag));
                        }
                        printf("Injecting failure on tag #%d\n",
errtag);
+                       memset(&err_inj, 0, sizeof err_inj);
                        err_inj.errtag = errtag;
                        err_inj.fd = fd;
                        srval = ioctl(fd, XFS_IOC_ERROR_INJECTION,
&err_inj);
@@ -476,6 +478,7 @@ int main(int argc, char **argv)
                }
 #ifndef NO_XFS
                if (errtag != 0) {
+                       memset(&err_inj, 0, sizeof err_inj);
                        err_inj.errtag = 0;
                        err_inj.fd = fd;
                        if ((srval = ioctl(fd, XFS_IOC_ERROR_CLEARALL,
&err_inj)) != 0) {
@@ -1396,9 +1399,9 @@ allocsp_f(int opno, long r)
        int             e;
        pathname_t      f;
        int             fd;
-       struct flock64  fl;
-       __int64_t       lr;
-       off64_t         off;
+       struct xfs_flock64 fl;
+       __s64           lr;
+       __s64           off;
        struct stat64   stb;
        int             v;
 
@@ -1427,9 +1430,10 @@ allocsp_f(int opno, long r)
                close(fd);
                return;
        }
-       lr = ((__int64_t)random() << 32) + random();
-       off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024),
MAXFSIZE));
+       lr = ((__s64) random() << 32) + random();
+       off = lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
        off %= maxfsize;
+       memset(&fl, 0, sizeof fl);
        fl.l_whence = SEEK_SET;
        fl.l_start = off;
        fl.l_len = 0;
@@ -1547,10 +1551,10 @@ attr_set_f(int opno, long r)
 void
 bulkstat_f(int opno, long r)
 {
-       int             count;
+       __s32           count;
        int             fd;
-       __uint64_t      last;
-       int             nent;
+       __u64           last;
+       __s32           nent;
        xfs_bstat_t     *t;
        __int64_t       total;
        xfs_fsop_bulkreq_t bsr;
@@ -1561,6 +1565,7 @@ bulkstat_f(int opno, long r)
        fd = open(".", O_RDONLY);
        total = 0;
 
+       memset(&bsr, 0, sizeof bsr);
        bsr.lastip=&last;
        bsr.icount=nent;
        bsr.ubuffer=t;
@@ -1571,7 +1576,7 @@ bulkstat_f(int opno, long r)
        free(t);
        if (verbose)
                printf("%d/%d: bulkstat nent %d total %lld\n",
-                       procid, opno, nent, (long long)total);
+                       procid, opno, (int) nent, (long long) total);
        close(fd);
 }
 
@@ -1582,7 +1587,7 @@ bulkstat1_f(int opno, long r)
        pathname_t      f;
        int             fd;
        int             good;
-       __uint64_t      ino;
+       __u64           ino;
        struct stat64   s;
        xfs_bstat_t     t;
        int             v;
@@ -1617,6 +1622,7 @@ bulkstat1_f(int opno, long r)
        }
        fd = open(".", O_RDONLY);
 
+       memset(&bsr, 0, sizeof bsr);
        bsr.lastip=&ino;
        bsr.icount=1;
        bsr.ubuffer=&t;
@@ -1625,7 +1631,8 @@ bulkstat1_f(int opno, long r)
        e = ioctl(fd, XFS_IOC_FSBULKSTAT_SINGLE, &bsr) < 0 ? errno : 0;
        if (v)
                printf("%d/%d: bulkstat1 %s ino %lld %d\n",
-                       procid, opno, good?"real":"random",
(int64_t)ino, e);
+                       procid, opno, good ? "real" : "random",
+                       (long long) ino, e);
        close(fd);
 }
 
@@ -1698,6 +1705,7 @@ creat_f(int opno, long r)
        if (fd >= 0) {
 #ifndef NO_XFS
                struct fsxattr  a;
+               memset(&a, 0, sizeof a);
                if (extsize && ioctl(fd, XFS_IOC_FSGETXATTR, &a) >= 0) {
                        a.fsx_xflags |= XFS_XFLAG_REALTIME;
                        a.fsx_extsize =
@@ -1799,6 +1807,7 @@ dread_f(int opno, long r)
                return;
        }
 
+       memset(&diob, 0, sizeof diob);
        if (no_xfs) {
                diob.d_miniosz = stb.st_blksize;
                diob.d_maxiosz = stb.st_blksize * 256;  /* good number ?
*/
@@ -1889,6 +1898,7 @@ dwrite_f(int opno, long r)
                close(fd);
                return;
        }
+       memset(&diob, 0, sizeof diob);
        if (no_xfs) {
                diob.d_miniosz = stb.st_blksize;
                diob.d_maxiosz = stb.st_blksize * 256;  /* good number ?
*/
@@ -1976,9 +1986,9 @@ freesp_f(int opno, long r)
        int             e;
        pathname_t      f;
        int             fd;
-       struct flock64  fl;
-       __int64_t       lr;
-       off64_t         off;
+       struct xfs_flock64 fl;
+       __s64           lr;
+       __s64           off;
        struct stat64   stb;
        int             v;
 
@@ -2007,16 +2017,17 @@ freesp_f(int opno, long r)
                close(fd);
                return;
        }
-       lr = ((__int64_t)random() << 32) + random();
-       off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024),
MAXFSIZE));
+       lr = ((__s64) random() << 32) + random();
+       off = lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
        off %= maxfsize;
+       memset(&fl, 0, sizeof fl);
        fl.l_whence = SEEK_SET;
        fl.l_start = off;
        fl.l_len = 0;
        e = ioctl(fd, XFS_IOC_FREESP64, &fl) < 0 ? errno : 0;
        if (v)
                printf("%d/%d: ioctl(XFS_IOC_FREESP64) %s %lld 0 %d\n",
-                       procid, opno, f.path, (long long)off, e);
+                       procid, opno, f.path, (long long) off, e);
        free_pathname(&f);
        close(fd);
 }
@@ -2349,9 +2360,9 @@ resvsp_f(int opno, long r)
        int             e;
        pathname_t      f;
        int             fd;
-       struct flock64  fl;
-       __int64_t       lr;
-       off64_t         off;
+       struct xfs_flock64 fl;
+       __s64           lr;
+       __s64           off;
        struct stat64   stb;
        int             v;
 
@@ -2380,16 +2391,18 @@ resvsp_f(int opno, long r)
                close(fd);
                return;
        }
-       lr = ((__int64_t)random() << 32) + random();
-       off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024),
MAXFSIZE));
+       lr = ((__s64) random() << 32) + random();
+       off = lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
        off %= maxfsize;
+       memset(&fl, 0, sizeof fl);
        fl.l_whence = SEEK_SET;
        fl.l_start = off;
-       fl.l_len = (off64_t)(random() % (1024 * 1024));
+       fl.l_len = (__s64) (random() % (1024 * 1024));
        e = ioctl(fd, XFS_IOC_RESVSP64, &fl) < 0 ? errno : 0;
        if (v)
-               printf("%d/%d: ioctl(XFS_IOC_RESVSP64) %s %lld %ld %d
\n",
-                       procid, opno, f.path, (long long)off, fl.l_len,
e);
+               printf("%d/%d: ioctl(XFS_IOC_RESVSP64) %s %lld %lld %d
\n",
+                       procid, opno, f.path, (long long) off,
+                       (long long) fl.l_len, e);
        free_pathname(&f);
        close(fd);
 }
@@ -2524,7 +2537,7 @@ truncate_f(int opno, long r)
                return;
        }
        lr = ((__int64_t)random() << 32) + random();
-       off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024),
MAXFSIZE));
+       off = lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
        off %= maxfsize;
        e = truncate64_path(&f, off) < 0 ? errno : 0;
        check_cwd();
@@ -2566,9 +2579,9 @@ unresvsp_f(int opno, long r)
        int             e;
        pathname_t      f;
        int             fd;
-       struct flock64  fl;
-       __int64_t       lr;
-       off64_t         off;
+       struct xfs_flock64 fl;
+       __s64           lr;
+       __s64           off;
        struct stat64   stb;
        int             v;
 
@@ -2597,16 +2610,18 @@ unresvsp_f(int opno, long r)
                close(fd);
                return;
        }
-       lr = ((__int64_t)random() << 32) + random();
-       off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024),
MAXFSIZE));
+       lr = ((__s64) random() << 32) + random();
+       off = lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
        off %= maxfsize;
+       memset(&fl, 0, sizeof fl);
        fl.l_whence = SEEK_SET;
        fl.l_start = off;
-       fl.l_len = (off64_t)(random() % (1 << 20));
+       fl.l_len = (__s64) (random() % (1 << 20));
        e = ioctl(fd, XFS_IOC_UNRESVSP64, &fl) < 0 ? errno : 0;
        if (v)
-               printf("%d/%d: ioctl(XFS_IOC_UNRESVSP64) %s %lld %ld %d
\n",
-                       procid, opno, f.path, (long long)off, fl.l_len,
e);
+               printf("%d/%d: ioctl(XFS_IOC_UNRESVSP64) %s %lld %lld %d
\n",
+                       procid, opno, f.path, (long long) off,
+                       (long long) fl.l_len, e);
        free_pathname(&f);
        close(fd);
 }


------------------------------------------------------------------------------
Forrester Wave Report
Recovery time is now measured in hours and minutes not days.
key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
