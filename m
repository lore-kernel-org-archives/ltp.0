Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q9eEY-0006Z2-Pi
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 14:06:22 +0000
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q9eEX-0007zl-O8
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 14:06:22 +0000
From: Alex Elder <aelder@sgi.com>
Date: Tue, 12 Apr 2011 09:06:06 -0500
Message-Id: <4b2cc7d81eb2b9665e9b6f0f19f1ef31f1fab84d.1302617105.git.aelder@sgi.com>
In-Reply-To: <1302617166-10309-1-git-send-email-aelder@sgi.com>
References: <1302617166-10309-1-git-send-email-aelder@sgi.com>
In-Reply-To: <cb4b455094351bcefd98c7095f3639dd14498bca.1302617105.git.aelder@sgi.com>
References: <cb4b455094351bcefd98c7095f3639dd14498bca.1302617105.git.aelder@sgi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------true"
Subject: [LTP] [PATCH 3/3] ltp: fix warnings in "fsstress.c"
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
and the kernel.  Also updated some whitespace, as requested.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |   81 ++++++++++++++++++-------=
------
 1 files changed, 48 insertions(+), 33 deletions(-)


--------------true
Content-Type: text/x-patch; name="0003-ltp-fix-warnings-in-fsstress.c.patch"
Content-Disposition: attachment;
	filename="0003-ltp-fix-warnings-in-fsstress.c.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/f=
s/fsstress/fsstress.c
index 9b93bca..9987484 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -419,6 +419,7 @@ int main(int argc, char **argv)
 		}
 #ifndef NO_XFS
 		if (!no_xfs) {
+		memset(&geom, 0, sizeof(geom));
 		i =3D ioctl(fd, XFS_IOC_FSGEOMETRY, &geom);
 		if (i >=3D 0 && geom.rtblocks)
 			rtpct =3D MIN(MAX(geom.rtblocks * 100 /
@@ -447,6 +448,7 @@ int main(int argc, char **argv)
 				errtag +=3D (random() % (XFS_ERRTAG_MAX - errtag));
 			}
 			printf("Injecting failure on tag #%d\n", errtag);
+			memset(&err_inj, 0, sizeof(err_inj));
 			err_inj.errtag =3D errtag;
 			err_inj.fd =3D fd;
 			srval =3D ioctl(fd, XFS_IOC_ERROR_INJECTION, &err_inj);
@@ -476,6 +478,7 @@ int main(int argc, char **argv)
 		}
 #ifndef NO_XFS
 		if (errtag !=3D 0) {
+			memset(&err_inj, 0, sizeof(err_inj));
 			err_inj.errtag =3D 0;
 			err_inj.fd =3D fd;
 			if ((srval =3D ioctl(fd, XFS_IOC_ERROR_CLEARALL, &err_inj)) !=3D 0) {
@@ -1396,9 +1399,9 @@ allocsp_f(int opno, long r)
 	int		e;
 	pathname_t	f;
 	int		fd;
-	struct flock64	fl;
-	__int64_t	lr;
-	off64_t		off;
+	struct xfs_flock64 fl;
+	__s64		lr;
+	__s64		off;
 	struct stat64	stb;
 	int		v;
=20
@@ -1427,9 +1430,10 @@ allocsp_f(int opno, long r)
 		close(fd);
 		return;
 	}
-	lr =3D ((__int64_t)random() << 32) + random();
-	off =3D (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
+	lr =3D ((__s64)random() << 32) + random();
+	off =3D lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
 	off %=3D maxfsize;
+	memset(&fl, 0, sizeof(fl));
 	fl.l_whence =3D SEEK_SET;
 	fl.l_start =3D off;
 	fl.l_len =3D 0;
@@ -1547,10 +1551,10 @@ attr_set_f(int opno, long r)
 void
 bulkstat_f(int opno, long r)
 {
-	int		count;
+	__s32		count;
 	int		fd;
-	__uint64_t	last;
-	int		nent;
+	__u64		last;
+	__s32		nent;
 	xfs_bstat_t	*t;
 	__int64_t	total;
 	xfs_fsop_bulkreq_t bsr;
@@ -1561,6 +1565,7 @@ bulkstat_f(int opno, long r)
 	fd =3D open(".", O_RDONLY);
 	total =3D 0;
=20
+	memset(&bsr, 0, sizeof(bsr));
 	bsr.lastip=3D&last;
 	bsr.icount=3Dnent;
 	bsr.ubuffer=3Dt;
@@ -1571,7 +1576,7 @@ bulkstat_f(int opno, long r)
 	free(t);
 	if (verbose)
 		printf("%d/%d: bulkstat nent %d total %lld\n",
-			procid, opno, nent, (long long)total);
+			procid, opno, (int)nent, (long long)total);
 	close(fd);
 }
=20
@@ -1582,7 +1587,7 @@ bulkstat1_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	int		good;
-	__uint64_t	ino;
+	__u64		ino;
 	struct stat64	s;
 	xfs_bstat_t	t;
 	int		v;
@@ -1617,6 +1622,7 @@ bulkstat1_f(int opno, long r)
 	}
 	fd =3D open(".", O_RDONLY);
=20
+	memset(&bsr, 0, sizeof(bsr));
 	bsr.lastip=3D&ino;
 	bsr.icount=3D1;
 	bsr.ubuffer=3D&t;
@@ -1625,7 +1631,8 @@ bulkstat1_f(int opno, long r)
 	e =3D ioctl(fd, XFS_IOC_FSBULKSTAT_SINGLE, &bsr) < 0 ? errno : 0;
 	if (v)
 		printf("%d/%d: bulkstat1 %s ino %lld %d\n",
-			procid, opno, good?"real":"random", (int64_t)ino, e);
+			procid, opno, good ? "real" : "random",
+			(long long)ino, e);
 	close(fd);
 }
=20
@@ -1698,6 +1705,7 @@ creat_f(int opno, long r)
 	if (fd >=3D 0) {
 #ifndef NO_XFS
 		struct fsxattr	a;
+		memset(&a, 0, sizeof(a));
 		if (extsize && ioctl(fd, XFS_IOC_FSGETXATTR, &a) >=3D 0) {
 			a.fsx_xflags |=3D XFS_XFLAG_REALTIME;
 			a.fsx_extsize =3D
@@ -1799,6 +1807,7 @@ dread_f(int opno, long r)
 		return;
 	}
=20
+	memset(&diob, 0, sizeof(diob));
 	if (no_xfs) {
 		diob.d_miniosz =3D stb.st_blksize;
 		diob.d_maxiosz =3D stb.st_blksize * 256;  /* good number ? */
@@ -1889,6 +1898,7 @@ dwrite_f(int opno, long r)
 		close(fd);
 		return;
 	}
+	memset(&diob, 0, sizeof(diob));
 	if (no_xfs) {
 		diob.d_miniosz =3D stb.st_blksize;
 		diob.d_maxiosz =3D stb.st_blksize * 256;  /* good number ? */
@@ -1976,9 +1986,9 @@ freesp_f(int opno, long r)
 	int		e;
 	pathname_t	f;
 	int		fd;
-	struct flock64	fl;
-	__int64_t	lr;
-	off64_t		off;
+	struct xfs_flock64 fl;
+	__s64		lr;
+	__s64		off;
 	struct stat64	stb;
 	int		v;
=20
@@ -2007,9 +2017,10 @@ freesp_f(int opno, long r)
 		close(fd);
 		return;
 	}
-	lr =3D ((__int64_t)random() << 32) + random();
-	off =3D (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
+	lr =3D ((__s64)random() << 32) + random();
+	off =3D lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
 	off %=3D maxfsize;
+	memset(&fl, 0, sizeof(fl));
 	fl.l_whence =3D SEEK_SET;
 	fl.l_start =3D off;
 	fl.l_len =3D 0;
@@ -2349,9 +2360,9 @@ resvsp_f(int opno, long r)
 	int		e;
 	pathname_t	f;
 	int		fd;
-	struct flock64	fl;
-	__int64_t	lr;
-	off64_t		off;
+	struct xfs_flock64 fl;
+	__s64		lr;
+	__s64		off;
 	struct stat64	stb;
 	int		v;
=20
@@ -2380,16 +2391,18 @@ resvsp_f(int opno, long r)
 		close(fd);
 		return;
 	}
-	lr =3D ((__int64_t)random() << 32) + random();
-	off =3D (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
+	lr =3D ((__s64)random() << 32) + random();
+	off =3D lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
 	off %=3D maxfsize;
+	memset(&fl, 0, sizeof(fl));
 	fl.l_whence =3D SEEK_SET;
 	fl.l_start =3D off;
-	fl.l_len =3D (off64_t)(random() % (1024 * 1024));
+	fl.l_len =3D (__s64)(random() % (1024 * 1024));
 	e =3D ioctl(fd, XFS_IOC_RESVSP64, &fl) < 0 ? errno : 0;
 	if (v)
-		printf("%d/%d: ioctl(XFS_IOC_RESVSP64) %s %lld %ld %d\n",
-			procid, opno, f.path, (long long)off, fl.l_len, e);
+		printf("%d/%d: ioctl(XFS_IOC_RESVSP64) %s %lld %lld %d\n",
+			procid, opno, f.path, (long long)off,
+			(long long)fl.l_len, e);
 	free_pathname(&f);
 	close(fd);
 }
@@ -2524,7 +2537,7 @@ truncate_f(int opno, long r)
 		return;
 	}
 	lr =3D ((__int64_t)random() << 32) + random();
-	off =3D (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
+	off =3D lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
 	off %=3D maxfsize;
 	e =3D truncate64_path(&f, off) < 0 ? errno : 0;
 	check_cwd();
@@ -2566,9 +2579,9 @@ unresvsp_f(int opno, long r)
 	int		e;
 	pathname_t	f;
 	int		fd;
-	struct flock64	fl;
-	__int64_t	lr;
-	off64_t		off;
+	struct xfs_flock64 fl;
+	__s64		lr;
+	__s64		off;
 	struct stat64	stb;
 	int		v;
=20
@@ -2597,16 +2610,18 @@ unresvsp_f(int opno, long r)
 		close(fd);
 		return;
 	}
-	lr =3D ((__int64_t)random() << 32) + random();
-	off =3D (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
+	lr =3D ((__s64)random() << 32) + random();
+	off =3D lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE);
 	off %=3D maxfsize;
+	memset(&fl, 0, sizeof(fl));
 	fl.l_whence =3D SEEK_SET;
 	fl.l_start =3D off;
-	fl.l_len =3D (off64_t)(random() % (1 << 20));
+	fl.l_len =3D (__s64)(random() % (1 << 20));
 	e =3D ioctl(fd, XFS_IOC_UNRESVSP64, &fl) < 0 ? errno : 0;
 	if (v)
-		printf("%d/%d: ioctl(XFS_IOC_UNRESVSP64) %s %lld %ld %d\n",
-			procid, opno, f.path, (long long)off, fl.l_len, e);
+		printf("%d/%d: ioctl(XFS_IOC_UNRESVSP64) %s %lld %lld %d\n",
+			procid, opno, f.path, (long long)off,
+			(long long)fl.l_len, e);
 	free_pathname(&f);
 	close(fd);
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



