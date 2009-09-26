Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <avagin@gmail.com>) id 1Mrg28-0000Sg-3q
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 22:46:28 +0000
Received: from mail-fx0-f221.google.com ([209.85.220.221])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mrg1y-0006Pr-IO
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 22:46:28 +0000
Received: by fxm21 with SMTP id 21so2814794fxm.33
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 Sep 2009 15:46:12 -0700 (PDT)
From: Andrew Vagin <avagin@gmail.com>
Date: Sun, 27 Sep 2009 02:45:59 +0400
Message-Id: <1254005162-27353-2-git-send-email-avagin@gmail.com>
In-Reply-To: <1254005162-27353-1-git-send-email-avagin@gmail.com>
References: <1254005162-27353-1-git-send-email-avagin@gmail.com>
Subject: [LTP] [PATCH 2/5] fsstress: use tabs instead of spaces for
	indentation
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net


Signed-off-by: Andrew Vagin <avagin@gmail.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |  144 +++++++++++++++---------------
 1 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index b313b62..5ada3d8 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -294,7 +294,7 @@ int main(int argc, char **argv)
 #ifndef NO_XFS
 	ptrdiff_t	srval;
 #endif
-        int             nousage=0;
+	int		nousage=0;
 #ifndef NO_XFS
 	xfs_error_injection_t	err_inj;
 #endif
@@ -361,7 +361,7 @@ int main(int argc, char **argv)
 		case 'S':
 			show_ops(0, NULL);
 			printf("\n");
-                        nousage=1;
+			nousage=1;
 			break;
 		case '?':
 			fprintf(stderr, "%s - invalid parameters\n",
@@ -375,8 +375,8 @@ int main(int argc, char **argv)
 			break;
 		}
 	}
-        while ( (loopcntr <= loops) || (loops == 0) )
-        {
+	while ( (loopcntr <= loops) || (loops == 0) )
+	{
 		if (no_xfs && errtag) {
 			fprintf(stderr, "error injection only works on XFS\n");
 			exit(1);
@@ -390,11 +390,11 @@ int main(int argc, char **argv)
 			}
 		}
 
-       	 	if (!dirname) {
-       	     	/* no directory specified */
-    	        	if (!nousage) usage();
-           	 exit(1);
-        	}
+		if (!dirname) {
+			/* no directory specified */
+			if (!nousage) usage();
+			exit(1);
+		}
 
 		(void)mkdir(dirname, 0777);
 		if (chdir(dirname) < 0) {
@@ -485,12 +485,12 @@ int main(int argc, char **argv)
 			close(fd);
 		}
 #endif
-	if (cleanup == 0)
-	{
-	  sprintf(cmd,"rm -rf %s/*",dirname);
-	  system(cmd);
-	}
-        loopcntr++;
+		if (cleanup == 0)
+		{
+			sprintf(cmd,"rm -rf %s/*",dirname);
+			system(cmd);
+		}
+		loopcntr++;
 	}
 	return 0;
 }
@@ -864,7 +864,7 @@ get_fname(int which, long r, pathname_t *name, flist_t **flpp, fent_t **fepp,
 	fprintf(stderr, "fsstress: get_fname failure\n");
 	abort();
 #endif
-        return -1;
+	return -1;
 	/* NOTREACHED */
 }
 
@@ -1222,33 +1222,33 @@ show_ops(int flag, char *lead_str)
 {
 	opdesc_t	*p;
 
-        if (flag<0) {
-                /* print in list form */
-                int             x = WIDTH;
+	if (flag<0) {
+		/* print in list form */
+		int x = WIDTH;
 
-	        for (p = ops; p < ops_end; p++) {
+		for (p = ops; p < ops_end; p++) {
 			if (lead_str != NULL && x+strlen(p->name)>=WIDTH-5)
 				x=printf("%s%s", (p==ops)?"":"\n", lead_str);
-                        x+=printf("%s ", p->name);
-                }
-                printf("\n");
-        } else {
-	        int		f;
-	        for (f = 0, p = ops; p < ops_end; p++)
-		        f += p->freq;
-
-	        if (f == 0)
-		        flag = 1;
-
-	        for (p = ops; p < ops_end; p++) {
-		        if (flag != 0 || p->freq > 0) {
-			        if (lead_str != NULL)
-				        printf("%s", lead_str);
-			        printf("%20s %d/%d %s\n",
-			        p->name, p->freq, f,
-			        (p->iswrite == 0) ? " " : "write op");
-		        }
-                }
+			x+=printf("%s ", p->name);
+		}
+		printf("\n");
+	} else {
+		int f;
+		for (f = 0, p = ops; p < ops_end; p++)
+			f += p->freq;
+
+		if (f == 0)
+			flag = 1;
+
+		for (p = ops; p < ops_end; p++) {
+			if (flag != 0 || p->freq > 0) {
+				if (lead_str != NULL)
+					printf("%s", lead_str);
+				printf("%20s %d/%d %s\n",
+				p->name, p->freq, f,
+				(p->iswrite == 0) ? " " : "write op");
+			}
+		}
 	}
 }
 
@@ -1278,10 +1278,10 @@ symlink_path(const char *name1, pathname_t *name)
 	pathname_t	newname;
 	int		rval;
 
-        if (!strcmp(name1, name->path)) {
-            printf("yikes! %s %s\n", name1, name->path);
-            return 0;
-        }
+	if (!strcmp(name1, name->path)) {
+		printf("yikes! %s %s\n", name1, name->path);
+		return 0;
+	}
 
 	rval = symlink(name1, name->path);
 	if (rval >= 0 || errno != ENAMETOOLONG)
@@ -1546,7 +1546,7 @@ bulkstat_f(int opno, long r)
 	int		nent;
 	xfs_bstat_t	*t;
 	__int64_t	total;
-        xfs_fsop_bulkreq_t bsr;
+	xfs_fsop_bulkreq_t bsr;
 
 	last = 0;
 	nent = (r % 999) + 2;
@@ -1554,10 +1554,10 @@ bulkstat_f(int opno, long r)
 	fd = open(".", O_RDONLY);
 	total = 0;
 
-        bsr.lastip=&last;
-        bsr.icount=nent;
-        bsr.ubuffer=t;
-        bsr.ocount=&count;
+	bsr.lastip=&last;
+	bsr.icount=nent;
+	bsr.ubuffer=t;
+	bsr.ocount=&count;
 
 	while (ioctl(fd, XFS_IOC_FSBULKSTAT, &bsr) == 0 && count > 0)
 		total += count;
@@ -1579,12 +1579,12 @@ bulkstat1_f(int opno, long r)
 	struct stat64	s;
 	xfs_bstat_t	t;
 	int		v;
-        xfs_fsop_bulkreq_t bsr;
+	xfs_fsop_bulkreq_t bsr;
 
 
 	good = random() & 1;
 	if (good) {
-               /* use an inode we know exists */
+		/* use an inode we know exists */
 		init_pathname(&f);
 		if (!get_fname(FT_ANYm, r, &f, NULL, NULL, &v))
 			append_pathname(&f, ".");
@@ -1592,34 +1592,34 @@ bulkstat1_f(int opno, long r)
 		check_cwd();
 		free_pathname(&f);
 	} else {
-                /*
-                 * pick a random inode
-                 *
-                 * note this can generate kernel warning messages
-                 * since bulkstat_one will read the disk block that
-                 * would contain a given inode even if that disk
-                 * block doesn't contain inodes.
-                 *
-                 * this is detected later, but not until after the
-                 * warning is displayed.
-                 *
-                 * "XFS: device 0x825- bad inode magic/vsn daddr 0x0 #0"
-                 *
-                 */
+		/*
+		 * pick a random inode
+		 *
+		 * note this can generate kernel warning messages
+		 * since bulkstat_one will read the disk block that
+		 * would contain a given inode even if that disk
+		 * block doesn't contain inodes.
+		 *
+		 * this is detected later, but not until after the
+		 * warning is displayed.
+		 *
+		 * "XFS: device 0x825- bad inode magic/vsn daddr 0x0 #0"
+		 *
+		 */
 		ino = (ino64_t)r;
 		v = verbose;
 	}
 	fd = open(".", O_RDONLY);
 
-        bsr.lastip=&ino;
-        bsr.icount=1;
-        bsr.ubuffer=&t;
-        bsr.ocount=NULL;
+	bsr.lastip=&ino;
+	bsr.icount=1;
+	bsr.ubuffer=&t;
+	bsr.ocount=NULL;
 
 	e = ioctl(fd, XFS_IOC_FSBULKSTAT_SINGLE, &bsr) < 0 ? errno : 0;
 	if (v)
 		printf("%d/%d: bulkstat1 %s ino %lld %d\n",
-                    procid, opno, good?"real":"random", (int64_t)ino, e);
+			procid, opno, good?"real":"random", (int64_t)ino, e);
 	close(fd);
 }
 
@@ -1702,7 +1702,7 @@ creat_f(int opno, long r)
 
 		}
 #endif
-		 		 add_to_flist(type, id, parid);
+		add_to_flist(type, id, parid);
 		close(fd);
 	}
 	if (v)
@@ -1798,7 +1798,7 @@ dread_f(int opno, long r)
 		diob.d_mem = stb.st_blksize;
 	}
 #ifndef NO_XFS
-	   else 	if (ioctl(fd, XFS_IOC_DIOINFO, &diob) < 0) {
+	else if (ioctl(fd, XFS_IOC_DIOINFO, &diob) < 0) {
 		if (v)
 			printf(
 			"%d/%d: dread - ioctl(fd, XFS_IOC_DIOINFO) %s failed %d\n",
-- 
1.6.2.5


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
