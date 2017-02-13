From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 15:43:04 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/3] lib: Move rmobj() to tst_tmpdir.c
In-Reply-To: <20170213144304.3806-1-chrubis@suse.cz>
References: <20170213144304.3806-1-chrubis@suse.cz>
Message-ID: <20170213144304.3806-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/man3/rmobj.3    |  59 ---------------
 include/old/rmobj.h |  12 ---
 lib/rmobj.c         | 211 ----------------------------------------------------
 lib/tst_tmpdir.c    | 113 +++++++++++++++++++++++++++-
 4 files changed, 112 insertions(+), 283 deletions(-)
 delete mode 100644 doc/man3/rmobj.3
 delete mode 100644 include/old/rmobj.h
 delete mode 100644 lib/rmobj.c

diff --git a/doc/man3/rmobj.3 b/doc/man3/rmobj.3
deleted file mode 100644
index 520e333..0000000
--- a/doc/man3/rmobj.3
+++ /dev/null
@@ -1,59 +0,0 @@
-.\"
-.\" $Id: rmobj.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\"
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\"
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\"
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\"
-.\" http://www.sgi.com
-.\"
-.\" For further information regarding this notice, see:
-.\"
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH RMOBJ 3 07/25/2000 "Linux Test Project"
-.SH NAME
-\fBrmobj\fR \- Remove a file, or a directory and all its subdirectories
-.SH SYNOPSIS
-\fBint rmobj(\fIobject\fB, \fIerrmsg\fB);
-.br
-   char *\fIobject\fB;
-.br
-   char **\fIerrmsg\fB;\fR
-.br
-.SH DESCRIPTION
-The \fBrmobj\fR function will remove the specified object.  If the
-specified object is a directory, it will recursively remove the
-directory and everything underneath it.  \fBrmobj\fR assumes that it
-has the necessary privilege to remove whatever was specified.  If
-\fBrmobj\fR encounters any problems, and \fIerrmsg\fR is not NULL,
-\fIerrmsg\fR is set to point to a string explaining the error.
-.SH RETURN VALUE
-If \fBrmobj\fR encounters any problems, it will set \fIerrmsg\fR (if
-it was not NULL) and return -1.  Otherwise it will return 0.
-.SH SEE ALSO
-.\"\fBsects(1)\fR
-.\".br
-\fBrmdir(2)\fR
-.br
-\fBunlink(2)\fR
diff --git a/include/old/rmobj.h b/include/old/rmobj.h
deleted file mode 100644
index 4808ca2..0000000
--- a/include/old/rmobj.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _RMOBJ_H_
-#define _RMOBJ_H_
-
-/*
- * rmobj() - Remove the specified object.  If the specified object is a
- *           directory, recursively remove everything inside of it.  If
- *           there are any problems, set errmsg (if it is not NULL) and
- *           return -1.  Otherwise return 0.
- */
-int rmobj( char *object , char **errmesg );
-
-#endif
diff --git a/lib/rmobj.c b/lib/rmobj.c
deleted file mode 100644
index a9de59c..0000000
--- a/lib/rmobj.c
+++ /dev/null
@@ -1,211 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- */
-
-/* $Id: rmobj.c,v 1.5 2009/07/20 10:59:32 vapier Exp $ */
-
-/**********************************************************
- *
- *    OS Testing - Silicon Graphics, Inc.
- *
- *    FUNCTION NAME     : rmobj()
- *
- *    FUNCTION TITLE    : Remove an object
- *
- *    SYNOPSIS:
- *      int rmobj(char *obj, char **errmsg)
- *
- *    AUTHOR            : Kent Rogers
- *
- *    INITIAL RELEASE   : UNICOS 7.0
- *
- *    USER DESCRIPTION
- *      This routine will remove the specified object.  If the specified
- *      object is a directory, it will recursively remove the directory
- *      and everything underneath it.  It assumes that it has privilege
- *      to remove everything that it tries to remove.  If rmobj() encounters
- *      any problems, and errmsg is not NULL, errmsg is set to point to a
- *      string explaining the error.
- *
- *    DETAILED DESCRIPTION
- *      Allocate space for the directory and its contents
- *      Open the directory to get access to what is in it
- *      Loop through the objects in the directory:
- *        If the object is not "." or "..":
- *          Determine the file type by calling lstat()
- *          If the object is not a directory:
- *            Remove the object with unlink()
- *         Else:
- *            Call rmobj(object) to remove the object's contents
- *            Determine the link count on object by calling lstat()
- *            If the link count >= 3:
- *              Remove the directory with unlink()
- *            Else
- *               Remove the directory with rmdir()
- *      Close the directory and free the pointers
- *
- *    RETURN VALUE
- *      If there are any problems, rmobj() will set errmsg (if it was not
- *      NULL) and return -1.  Otherwise it will return 0.
- *
- ************************************************************/
-#define _GNU_SOURCE
-#include <errno.h>		/* for errno */
-#include <stdio.h>		/* for NULL */
-#include <stdlib.h>		/* for malloc() */
-#include <string.h>		/* for string function */
-#include <limits.h>		/* for PATH_MAX */
-#include <sys/types.h>		/* for opendir(), readdir(), closedir(), stat() */
-#include <sys/stat.h>		/* for [l]stat() */
-#include <fcntl.h>
-#include <dirent.h>		/* for opendir(), readdir(), closedir() */
-#include <unistd.h>		/* for rmdir(), unlink() */
-#include "rmobj.h"
-
-#define SYSERR strerror(errno)
-
-int rmobj(char *obj, char **errmsg)
-{
-	int ret_val = 0;	/* return value from this routine */
-	DIR *dir;		/* pointer to a directory */
-	struct dirent *dir_ent;	/* pointer to directory entries */
-	char dirobj[PATH_MAX];	/* object inside directory to modify */
-	struct stat statbuf;	/* used to hold stat information */
-	static char err_msg[1024];	/* error message */
-	int fd;
-
-	/* Determine the file type */
-
-	fd = open(obj, O_DIRECTORY | O_NOFOLLOW);
-	if (fd != -1) {
-		close(fd);
-		/* object is a directory */
-
-		/* Do NOT perform the request if the directory is "/" */
-		if (!strcmp(obj, "/")) {
-			if (errmsg != NULL) {
-				sprintf(err_msg, "Cannot remove /");
-				*errmsg = err_msg;
-			}
-			return -1;
-		}
-
-		/* Open the directory to get access to what is in it */
-		if ((dir = opendir(obj)) == NULL) {
-			if (rmdir(obj) != 0) {
-				if (errmsg != NULL) {
-					sprintf(err_msg,
-						"rmdir(%s) failed; errno=%d: %s",
-						obj, errno, SYSERR);
-					*errmsg = err_msg;
-				}
-				return -1;
-			} else {
-				return 0;
-			}
-		}
-
-		/* Loop through the entries in the directory, removing each one */
-		for (dir_ent = (struct dirent *)readdir(dir);
-		     dir_ent != NULL; dir_ent = (struct dirent *)readdir(dir)) {
-
-			/* Don't remove "." or ".." */
-			if (!strcmp(dir_ent->d_name, ".")
-			    || !strcmp(dir_ent->d_name, ".."))
-				continue;
-
-			/* Recursively call this routine to remove the current entry */
-			sprintf(dirobj, "%s/%s", obj, dir_ent->d_name);
-			if (rmobj(dirobj, errmsg) != 0)
-				ret_val = -1;
-		}
-
-		/* Close the directory */
-		closedir(dir);
-
-		/* If there were problems removing an entry, don't attempt to
-		   remove the directory itself */
-		if (ret_val == -1)
-			return -1;
-
-		/* Get the link count, now that all the entries have been removed */
-		if (lstat(obj, &statbuf) < 0) {
-			if (errmsg != NULL) {
-				sprintf(err_msg,
-					"lstat(%s) failed; errno=%d: %s", obj,
-					errno, SYSERR);
-				*errmsg = err_msg;
-			}
-			return -1;
-		}
-
-		/* Remove the directory itself */
-		if (statbuf.st_nlink >= 3) {
-			/* The directory is linked; unlink() must be used */
-			if (unlink(obj) < 0) {
-				if (errmsg != NULL) {
-					sprintf(err_msg,
-						"unlink(%s) failed; errno=%d: %s",
-						obj, errno, SYSERR);
-					*errmsg = err_msg;
-				}
-				return -1;
-			}
-		} else {
-			/* The directory is not linked; remove() can be used */
-			if (remove(obj) < 0) {
-				if (errmsg != NULL) {
-					sprintf(err_msg,
-						"remove(%s) failed; errno=%d: %s",
-						obj, errno, SYSERR);
-					*errmsg = err_msg;
-				}
-				return -1;
-			}
-		}
-	} else {
-		/* object is not a directory; just use unlink() */
-		if (unlink(obj) < 0) {
-			if (errmsg != NULL) {
-				sprintf(err_msg,
-					"unlink(%s) failed; errno=%d: %s", obj,
-					errno, SYSERR);
-				*errmsg = err_msg;
-			}
-			return -1;
-		}
-	}			/* if obj is a directory */
-
-	/*
-	 * Everything must have went ok.
-	 */
-	return 0;
-}				/* rmobj() */
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 5474634..71ca3b9 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -67,9 +67,10 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <dirent.h>
+#include <fcntl.h>
 
 #include "test.h"
-#include "rmobj.h"
 #include "ltp_priv.h"
 #include "lapi/futex.h"
 
@@ -115,6 +116,116 @@ const char *tst_get_startwd(void)
 	return test_start_work_dir;
 }
 
+static int rmobj(char *obj, char **errmsg)
+{
+	int ret_val = 0;
+	DIR *dir;
+	struct dirent *dir_ent;
+	char dirobj[PATH_MAX];
+	struct stat statbuf;
+	static char err_msg[1024];
+	int fd;
+
+	fd = open(obj, O_DIRECTORY | O_NOFOLLOW);
+	if (fd != -1) {
+		close(fd);
+
+		/* Do NOT perform the request if the directory is "/" */
+		if (!strcmp(obj, "/")) {
+			if (errmsg != NULL) {
+				sprintf(err_msg, "Cannot remove /");
+				*errmsg = err_msg;
+			}
+			return -1;
+		}
+
+		/* Open the directory to get access to what is in it */
+		if ((dir = opendir(obj)) == NULL) {
+			if (rmdir(obj) != 0) {
+				if (errmsg != NULL) {
+					sprintf(err_msg,
+						"rmdir(%s) failed; errno=%d: %s",
+						obj, errno, tst_strerrno(errno));
+					*errmsg = err_msg;
+				}
+				return -1;
+			} else {
+				return 0;
+			}
+		}
+
+		/* Loop through the entries in the directory, removing each one */
+		for (dir_ent = (struct dirent *)readdir(dir);
+		     dir_ent != NULL; dir_ent = (struct dirent *)readdir(dir)) {
+
+			/* Don't remove "." or ".." */
+			if (!strcmp(dir_ent->d_name, ".")
+			    || !strcmp(dir_ent->d_name, ".."))
+				continue;
+
+			/* Recursively call this routine to remove the current entry */
+			sprintf(dirobj, "%s/%s", obj, dir_ent->d_name);
+			if (rmobj(dirobj, errmsg) != 0)
+				ret_val = -1;
+		}
+
+		closedir(dir);
+
+		/* If there were problems removing an entry, don't attempt to
+		   remove the directory itself */
+		if (ret_val == -1)
+			return -1;
+
+		/* Get the link count, now that all the entries have been removed */
+		if (lstat(obj, &statbuf) < 0) {
+			if (errmsg != NULL) {
+				sprintf(err_msg,
+					"lstat(%s) failed; errno=%d: %s", obj,
+					errno, tst_strerrno(errno));
+				*errmsg = err_msg;
+			}
+			return -1;
+		}
+
+		/* Remove the directory itself */
+		if (statbuf.st_nlink >= 3) {
+			/* The directory is linked; unlink() must be used */
+			if (unlink(obj) < 0) {
+				if (errmsg != NULL) {
+					sprintf(err_msg,
+						"unlink(%s) failed; errno=%d: %s",
+						obj, errno, tst_strerrno(errno));
+					*errmsg = err_msg;
+				}
+				return -1;
+			}
+		} else {
+			/* The directory is not linked; remove() can be used */
+			if (remove(obj) < 0) {
+				if (errmsg != NULL) {
+					sprintf(err_msg,
+						"remove(%s) failed; errno=%d: %s",
+						obj, errno, tst_strerrno(errno));
+					*errmsg = err_msg;
+				}
+				return -1;
+			}
+		}
+	} else {
+		if (unlink(obj) < 0) {
+			if (errmsg != NULL) {
+				sprintf(err_msg,
+					"unlink(%s) failed; errno=%d: %s", obj,
+					errno, tst_strerrno(errno));
+				*errmsg = err_msg;
+			}
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 void tst_tmpdir(void)
 {
 	char template[PATH_MAX];
-- 
2.10.2

