From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 15:07:25 +0100
Subject: [LTP] [COMMITTED] [PATCH] lib: Move some code to
	testcases/kernel/fs/doio/
Message-ID: <20170213140725.5704-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Quite a number of code in lib/ directory was used only by one of the
three doio testcases. Hence it does not make much sense to keep it in
lib/.

So this commit moves the files + corresponding header files into the
doio directory and also deletes corresponding manual pages (+ few pages
for nonexisting functions as well).

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .gitignore                                         |   1 -
 doc/man3/bytes_by_prefix.3                         | 101 --------
 doc/man3/forker.3                                  | 151 -----------
 doc/man3/get_attrib.3                              | 136 ----------
 doc/man3/parse_open_flags.3                        | 137 ----------
 doc/man3/pattern.3                                 |  90 -------
 doc/man3/string_to_tokens.3                        |  71 ------
 doc/man3/tst_set_error.3                           | 150 -----------
 doc/man3/write_log.3                               | 244 ------------------
 lib/tests/bytes_by_prefix_test.c                   | 282 ---------------------
 testcases/kernel/fs/doio/Makefile                  |  11 +-
 .../kernel/fs/doio}/bytes_by_prefix.c              |   0
 {lib => testcases/kernel/fs/doio}/dataascii.c      |   0
 {lib => testcases/kernel/fs/doio}/databin.c        |   0
 {lib => testcases/kernel/fs/doio}/datapid.c        |   0
 {lib => testcases/kernel/fs/doio}/file_lock.c      |   0
 {lib => testcases/kernel/fs/doio}/forker.c         |   0
 .../kernel/fs/doio/include}/bytes_by_prefix.h      |   0
 .../kernel/fs/doio/include}/dataascii.h            |   0
 .../kernel/fs/doio/include}/databin.h              |   0
 .../kernel/fs/doio/include}/file_lock.h            |   0
 .../kernel/fs/doio/include}/forker.h               |   0
 .../kernel/fs/doio/include}/open_flags.h           |   0
 .../kernel/fs/doio/include}/pattern.h              |   0
 .../kernel/fs/doio/include}/string_to_tokens.h     |   0
 .../kernel/fs/doio/include}/write_log.h            |   0
 {lib => testcases/kernel/fs/doio}/open_flags.c     |   0
 {lib => testcases/kernel/fs/doio}/pattern.c        |   0
 .../kernel/fs/doio}/string_to_tokens.c             |   0
 {lib => testcases/kernel/fs/doio}/write_log.c      |   0
 30 files changed, 10 insertions(+), 1364 deletions(-)
 delete mode 100644 doc/man3/bytes_by_prefix.3
 delete mode 100644 doc/man3/forker.3
 delete mode 100644 doc/man3/get_attrib.3
 delete mode 100644 doc/man3/parse_open_flags.3
 delete mode 100644 doc/man3/pattern.3
 delete mode 100644 doc/man3/string_to_tokens.3
 delete mode 100644 doc/man3/tst_set_error.3
 delete mode 100644 doc/man3/write_log.3
 delete mode 100644 lib/tests/bytes_by_prefix_test.c
 rename {lib => testcases/kernel/fs/doio}/bytes_by_prefix.c (100%)
 rename {lib => testcases/kernel/fs/doio}/dataascii.c (100%)
 rename {lib => testcases/kernel/fs/doio}/databin.c (100%)
 rename {lib => testcases/kernel/fs/doio}/datapid.c (100%)
 rename {lib => testcases/kernel/fs/doio}/file_lock.c (100%)
 rename {lib => testcases/kernel/fs/doio}/forker.c (100%)
 rename {include/old => testcases/kernel/fs/doio/include}/bytes_by_prefix.h (100%)
 rename {include/old => testcases/kernel/fs/doio/include}/dataascii.h (100%)
 rename {include/old => testcases/kernel/fs/doio/include}/databin.h (100%)
 rename {include/old => testcases/kernel/fs/doio/include}/file_lock.h (100%)
 rename {include/old => testcases/kernel/fs/doio/include}/forker.h (100%)
 rename {include/old => testcases/kernel/fs/doio/include}/open_flags.h (100%)
 rename {include/old => testcases/kernel/fs/doio/include}/pattern.h (100%)
 rename {include/old => testcases/kernel/fs/doio/include}/string_to_tokens.h (100%)
 rename {include/old => testcases/kernel/fs/doio/include}/write_log.h (100%)
 rename {lib => testcases/kernel/fs/doio}/open_flags.c (100%)
 rename {lib => testcases/kernel/fs/doio}/pattern.c (100%)
 rename {lib => testcases/kernel/fs/doio}/string_to_tokens.c (100%)
 rename {lib => testcases/kernel/fs/doio}/write_log.c (100%)

diff --git a/.gitignore b/.gitignore
index 1b4ac3e..cbaea66 100644
--- a/.gitignore
+++ b/.gitignore
@@ -55,7 +55,6 @@ patches/
 logfile.*
 
 /utils/benchmark/ebizzy-0.3/ebizzy
-/lib/tests/bytes_by_prefix_test
 /lib/tests/tst_tmpdir_test
 /lib/tests/tst_checkpoint
 /lib/tests/tst_checkpoint_wait_timeout
diff --git a/doc/man3/bytes_by_prefix.3 b/doc/man3/bytes_by_prefix.3
deleted file mode 100644
index 882245d..0000000
--- a/doc/man3/bytes_by_prefix.3
+++ /dev/null
@@ -1,101 +0,0 @@
-.\"
-.\" $Id: bytes_by_prefix.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
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
-.TH BYTES_BY_PREFIX 3 07/25/2000 "Linux Test Project"
-.SH NAME
-bytes_by_prefix \- convert a string to a int byte count
-lbytes_by_prefix \- convert a string to a long byte count
-llbytes_by_prefix \- convert a string to a long long byte count
-.SH SYNOPSIS
-int bytes_by_prefix(char *\fIstr\fR);
-.br
-long lbytes_by_prefix(char *\fIstr\fR);
-.br
-long long llbytes_by_prefix(char *\fIstr\fR);
-.SH DESCRIPTION
-\fBbytes_by_prefix()\fR, \fBlbytes_by_prefix()\fR, and \fBllbytes_by_prefix()\fR converts
-\fIstr\fR to an integer, long, or long long  byte count.  \fIstr\fR is an
-floating point number optionally followed by a single character multiplier.
-Currently the following multipliers are supported:
-.sp
-.nf
-    Char  Meaning       Multiplier
-    ----  ---------     --------------------------------
-    b     Blocks        BSIZE or UBSIZE
-    k     Kilobytes     2^10 (1024)
-    K     Kilowords     2^10 (1024) * sizeof(long)
-    m     Megabytes     2^20 (1048576)
-    M     Megawords     2^20 (1048576) * sizeof(long)
-    g     Gigabytes     2^30 (1073741824)
-    G     Gigawords     2^30 (1073741824) * sizeof(long)
-.fi
-.sp
-\fIstr\fR is interpreted as floating point number (base 10).
-When using \fBllbytes_by_prefix()\fR, the uppercase suffix will result
-in multiplying by the size of a (long long) or 8.
-.SH RETURNS
--1 if the integer portion of \fIstr\fR is invalid, if an unsupported
-multiplier is supplied, or if \fIstr\fR has extra leading or trailing
-characters.  If \fIstr\fR contains a negative number, the return
-value will be negative.
-.SH EXAMPLES
-\fBbytes_by_prefix("1000")\fR
-.br
-.RS 8
-Returns 1000
-.RE
-.br
-\fBbytes_by_prefix("5b")\fR
-.br
-.RS 8
-Returns 5 * BSIZE.
-.RE
-\fBbytes_by_prefix("1.5m")\fR
-.br
-.RS 8
-Returns 1.5 * 1048576 or 1572864
-.RE
-
-.SH LIMITATIONS
-
-\fBbytes_by_prefix()\fR and \fBlbytes_by_prefix()\fR when compiled as
-a 32 bit IRIX binary can only return a max number of 2g (2147483647).
-However, \fBlbytes_by_prefix()\fR is not limited by the 2g limit when
-compiled as 64 bit binary, where \fBbytes_by_prefix()\fR still is limited.
-
-Note that the size of long will vary depending how if compiled as
-a 32 or 64 bit binary.  The size of a long long is always 8.
-
-Also note that on a traditional CRAY system, a block is 4096 bytes, where
-on most IRIX systems a block is 1024 bytes.
-
diff --git a/doc/man3/forker.3 b/doc/man3/forker.3
deleted file mode 100644
index 435d730..0000000
--- a/doc/man3/forker.3
+++ /dev/null
@@ -1,151 +0,0 @@
-.\"
-.\" $Id: forker.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
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
-.TH FORKER 3 07/25/2000 "Linux Test Project"
-.SH NAME
-forker \- fork desired number of copies of the current process
-.br
-background \- fork a process and return control to caller
-
-.SH SYNOPSIS
-int
-.br
-\fBbackground\fR(\fIprefix\fR)
-.br
-char *\fIprefix\fR;
-
-int
-.br
-\fBforker\fR(\fIncopies, mode, prefix\fR)
-.br
-int \fIncopies\fR;
-.br
-int \fImode\fR;
-.br
-char *\fIprefix\fR;
-
-extern int \fBForker_pids\fR[];
-.br
-extern int \fBForker_npids\fR;
-
-.SH DESCRIPTION
-The \fBbackground\fR function will do a fork of the current process.
-The parent process will then exit, thus orphaning the
-child process.  Doing this will not nice the child process
-like executing a cmd in the background using "&" from the shell.
-If the fork fails and prefix is not NULL, a error message is printed
-to stderr and the process will exit with a value of errno.
-
-The \fBforker\fR function will fork \fIncopies\fR minus one copies
-of the current process.  There are two modes in how the forks
-will be done.  Mode 0 (default) will have all new processes
-be children of the parent process.    Using Mode 1,
-the parent process will have one child and that child will
-fork the next process, if necessary, and on and on.
-The \fBforker\fR function will return the number of successful
-forks.  This value will be different for the parent and each child.
-Using mode 0, the parent will get the total number of successful
-forks.  Using mode 1, the newest child will get the total number
-of forks.  The parent will get a return value of 1.
-
-The \fBforker \fRfunction also updates the global variables
-\fIForker_pids[\fR] and Forker_npids.  The \fIForker_pids\fR array will
-be updated to contain the pid of each new process.  The
-\fIForker_npids\fR variable contains the number of entries
-in \fIForker_pids.\fR  Note, not all processes will have
-access to all pids via \fIForker_pids.\fR  If using mode 0, only the
-parent process will have all information.  If using mode 1,
-only the last child process will have all information.
-
-If the \fIprefix\fR parameter is not NULL and the fork system call fails,
-a error message will be printed to stderr.  The error message
-will be preceded with \fIprefix\fR string.  If \fIprefix\fR is NULL,
-no error message is printed.
-
-.SH EXAMPLES
-
-.nf
-.in +3
-/*
- * The following is a unit test main for the background and forker
- * functions.
- */
-
-#include <stdio.h>
-
-main(argc, argv)
-int argc;
-char **argv;
-{
-    int ncopies=1;
-    int mode=0;
-    int ret;
-
-    if ( argc == 1 ) {
-        printf("Usage: %s ncopies [mode]\n", argv[0]);
-        exit(1);
-    }
-
-    if ( sscanf(argv[1], "%i", &ncopies) != 1 ) {
-        printf("%s: ncopies argument must be integer\n", argv[0]);
-        exit(1);
-    }
-
-    if ( argc == 3 )
-        if ( sscanf(argv[2], "%i", &mode) != 1 ) {
-        printf("%s: mode argument must be integer\n", argv[0]);
-        exit(1);
-    }
-
-    printf("Starting Pid = %d\n", getpid());
-    ret=background(argv[0]);
-    printf("After background() ret:%d, pid = %d\n", ret, getpid());
-
-    ret=forker(ncopies, mode, argv[0]);
-
-    printf("forker(%d, %d, %s) ret:%d, pid = %d, sleeping 30 seconds.\n",
-        ncopies, mode, argv[0], ret, getpid());
-    sleep(30);
-    exit(0);
-}
-.in -3
-.fi
-
-.SH "SEE ALSO"
-fork(2).
-
-.SH BUGS
-The child pids are stored in the fixed array, \fIForker_pids\fR.
-The array only has space for 4098 pids.  Only the first
-4098 pids will be stored in the array.
-
diff --git a/doc/man3/get_attrib.3 b/doc/man3/get_attrib.3
deleted file mode 100644
index 179d972..0000000
--- a/doc/man3/get_attrib.3
+++ /dev/null
@@ -1,136 +0,0 @@
-.\"
-.\" $Id: get_attrib.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
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
-.TH GET_ATTRIB 3 07/25/2000 "Linux Test Project"
-.SH NAME
-\fBget_attrib\fR \- Returns needed attributes to execute a command successfully on any system.
-.SH SYNOPSIS
-.sp
-\fB#include "get_attrib.h"\fR
-.sp
-\fBchar *get_attrib (char *\fIcommand_name\fB, char *\fIpermits\fB, char *\fIactive_categories\fB, char *\fIauthorized_categories\fB, long \fIflag\fR);\fR
-.SH DESCRIPTION
-The \fBget_attributes\fR routine is designed to determine the system type
-currently running and return the needed \fBruncmd(1)\fR string to run the
-command specified successfully on any 7.0 and above systems.  On systems
-with TFM configured 'ON' some commands need special attributes that can't
-be determined easily, this routine then uses an internal table to return the
-needed attributes to run the command.  On other system types the needed
-attributes are easily determined without use of this table.
-.PP
-The \fBget_attrib\fR arguments are as follows:
-.TP 10
-\fIcommand_name\fR
-Pointer to the command the attributes are to be returned about.
-.TP
-\fIpermits\fR
-Pointer to either an octal or name string of permits to be
-added to string returned.
-.TP
-\fIactive_category\fR
-Pointer to either an octal or name string of active categories to be
-added to string returned.
-.TP
-\fIauthorized_categories\fR
-Pointer to either an octal or name string of categories to be
-added to string returned.
-.TP
-\fIflag\fR
-Long set to any combination of values defined in get_attrib.h.  These values
-are used to specify that the string returned should be for the specified
-system type.
-.sp
-	\fBGA_BOTH_OFF   \fR	PRIV_SU and PRIV_TFM off.
-.sp
-	\fBGA_SU_ON      \fR	PRIV_SU on.
-.sp
-	\fBGA_TFM_ON     \fR	PRIV_TFM on.
-.sp
-	\fBGA_BOTH_ON    \fR	PRIV_SU and PRIV_TFM on.
-.sp
-	\fBGA_CURRENT_SYS\fR	Current system type.
-.sp
-.PP
-.SH "EXAMPLE"
-.P
-The following example shows how \fBget_attrib\fR can be used to determine
-the needed attributes to run a command successfully:
-.P
-.nf
-#include <stdio.h>
-#include "get_attrib.h"
-
-main()
-{
- char cmd[256];
- char *string;
-
- if ((string =
-      get_attrib("mount",NULL,NULL,NULL,GA_CURRENT_SYS)) == (char *)NULL) {
-    printf("get_attrib() failed\en");
-    exit(1);
- } else {
-    sprintf(cmd, "runcmd %s mount /dev/dsk/qtest3 /qtest3", string);
-    printf("Command = %s\en",cmd);
- }
-
-
- if ((string =
-      get_attrib("mount", NULL, NULL, NULL, GA_BOTH_OFF))==(char *)NULL) {
-    printf("get_attrib() failed\en");
-    exit(1);
- } else {
-    sprintf(cmd, "runcmd %s mount /dev/dsk/qtest3 /qtest3", string);
-    printf("Command = %s\en",cmd);
- }
-}
-.ni
-
-On an MLS system with PRIV_SU ON the first sprintf would return,
-\fBruncmd -u root mount /dev/dsk/qtest3 /qtest3\fR.
-
-On the same system the second sprintf would return, \fBruncmd -J secadm -j
-secadm  mount /dev/dsk/qtest3 /qtest3\fR  Which is as if PRIV_TFM and PRIV_SU
-were OFF.
-.PP
-.SH "RETURN VALUE"
-If \fBget_attrib()\fR completes successfully, a pointer to a string
-containing the options of the runcmd string is returned; otherwise NULL is
-returned.
-.SH ERRORS
-If \fBget_attrib()\fR has problems, an error message will be put in GA_Err_Msg
-and NULL will be returned.
-.SH "SEE ALSO"
-\fBget_attrib\fR(1)
-.P
-\fBruncmd\fR(1)
diff --git a/doc/man3/parse_open_flags.3 b/doc/man3/parse_open_flags.3
deleted file mode 100644
index 6451e2b..0000000
--- a/doc/man3/parse_open_flags.3
+++ /dev/null
@@ -1,137 +0,0 @@
-.\"
-.\" $Id: parse_open_flags.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
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
-.TH PARSE_OPEN_FLAGS 3 07/25/2000 "Linux Test Project"
-.SH NAME
-parse_open_flags \- converts open flag symbols into bitmask
-.br
-openflags2symbols \- converts open flag bitmask into symbols
-
-.SH SYNOPSIS
-int
-.br
-\fBparse_open_flags\fR(\fIsymbols, badname\fR)
-.br
-char *\fIsymbols\fR;
-.br
-char **\fIbadname\fR;
-
-char *
-.br
-\fBopenflags2symbols\fR(\fIopenflags, sep, mode\fR)
-.br
-int \fIopenflags\fR;
-.br
-char *\fIsep\fR;
-.br
-int \fImode\fR;
-
-.SH DESCRIPTION
-The \fBparse_open_flags\fR function can be used to convert
-a list of comma separated \fBopen\fR(2) flag symbols (i.e. O_TRUNC)
-into the bitmask that can be used by open(2).
-If a symbol is unknown and \fIbadname\fR is not NULL, \fIbadname\fR
-will updated to point that symbol in \fIsymbols\fR.
-\fBParse_open_flags\fR will return -1 on this error.
-Otherwise \fBparse_open_flags\fR will return the open flag bitmask.
-If \fBparse_open_flags\fR returns, \fIstring\fR will left unchanged.
-
-The \fBopenflags2symbols\fR function attempts to convert open flag
-bits into human readable  symbols (i.e. O_TRUNC).  If there
-are more than one symbol, the \fBsep\fR string will be placed as
-a separator between symbols.  Commonly used separators would
-be a comma "," or pipe "|".  If \fImode\fR is one and not all
-\fIopenflags\fR bits can be converted to symbols, the \fBUNKNOWN\fR
-symbol will be added to return string.
-Openflags2symbols will return the identified symbols.
-If no symbols are recognized the return value will be a empty
-string or the \fBUNKNOWN\fR symbol.
-
-If the \fBO_WRONLY\fR and \fBO_RDWR\fR bits are not set, \fBopenflags2symbols\fR
-assumes that \fBO_RDONLY\fR symbol is wanted.
-
-.SH "SEE ALSO"
-open(2),
-/usr/include/fcntl.h.
-
-.SH EXAMPLES
-.nf
-.in +3
-/*
- * The following code provides a UNIT test main for
- * parse_open_flags and openflags2symbols functions.
- */
-#include <stdio.h>
-
-main(argc, argv)
-int argc;
-char **argv;
-{
-    int bits;
-    int ret;
-    char *err;
-
-    if (argc == 1 ) {
-        printf("Usage: %s openflagsbits\n\t%s symbols\n", argv[0], argv[0]);
-        exit(1);
-    }
-
-    if ( sscanf(argv[1], "%i", &bits) == 1 ) {
-        printf("openflags2symbols(%#o, \",\", 1) returned %s\n",
-            bits, openflags2symbols(bits, ",", 1));
-
-    } else {
-        ret=parse_open_flags(argv[1], &err);
-        if ( ret == -1 )
-            printf("parse_open_flags(%s, &err) returned -1, err = %s\n",
-                argv[0], err);
-        else
-            printf("parse_open_flags(%s, &err) returned %#o\n", argv[0], ret);
-    }
-
-    exit(0);
-}
-
-.in -3
-.fi
-
-.SH LIMITATIONS
-Currently (06/96) all known symbols are coded into \fBopenflags2symbols\fR.
-If new open flags are added this function code will have to updated
-to know about them or they will not be recognized.
-
-The static space where \fBopenflags2symbols\fR stores open flag
-symbols with callers separators is limited to 512 characters.
-This should be large enough for most open flags symbols as long as the
-separator is kept short.
-
diff --git a/doc/man3/pattern.3 b/doc/man3/pattern.3
deleted file mode 100644
index 538a357..0000000
--- a/doc/man3/pattern.3
+++ /dev/null
@@ -1,90 +0,0 @@
-.\"
-.\" $Id: pattern.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
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
-.TH PATTERN 3 07/25/2000 "Linux Test Project"
-.SH NAME
-pattern_fill \- Fill a buffer with copies of a pattern
-.br
-pattern_check \- Validate a buffer against copies of a pattern
-.SH SYNOPSIS
-\fBpattern_fill\fP(char *\fIbuf\fP, int \fIbuflen\fP, char *\fIpat\fP, int \fIpatlen\fP, int \fIpatshift\fP)
-.br
-\fBpattern_check\fP(char *\fIbuf\fP, int \fIbuflen\fP, char *\fIpat\fP, int \fIpatlen\fP, int \fIpatshift\fP)
-.SH DESCRIPTION
-\fBpattern_fill()\fP fills a buffer of length \fIbuflen\fP with repeated
-occurrences of a pattern whose length is \fIpatlen\fP.
-If \fIbuflen\fP is not a multiple of \fIpatlen\fP, a partial pattern will
-be written in the last part of the buffer.  This implies that a buffer which is
-shorter than the pattern length will receive only a partial pattern.
-
-\fBpattern_check()\fP verifies that \fIbuf\fP contains repeated occurrences
-of the indicated pattern.
-
-The \fIpatshift\fP argument to \fBpattern_fill()\fP and \fBpattern_shift()\fP
-specify that \fIpat\fP should be rotated (\fIpatshift\fP % \fIpatlen\fP) bytes
-to the left before filling or comparing the buffer.  Since the pattern is
-rotated by (\fIpatshift\fP % \fIpatlen\fP), \fIpatshift\fP may be greater than
-\fIpathlen\fP.
-.SH EXAMPLES
-\fBpattern_fill(buf, sizeof(buf), "abcde", 5, 0)\fR
-.br
-.RS 8
-
-fill buf with repeated occurrences of "abcde"
-
-.RE
-.br
-\fBpattern_check(buf, sizeof(buf), "abcde", 5, 0)\fR
-.br
-.RS 8
-
-verify that buf consists of repeated occurrences of "abcde"
-
-.RE
-.br
-\fBpattern_fill(buf, sizeof(buf), "abcde", 5, 3)\fR
-.br
-.RS 8
-
-fill buf with repeated occurrences of "deabc"
-
-.RE
-
-.SH DIAGNOSTICS
-\fBpattern_fill()\fP always returns 0 - no validation of arguments is done.
-.br
-\fBpattern_check()\fP returns -1 if the buffer does not contain repeated
-occurrences of the indicated pattern (rotated \fIpatshift\fB bytes) or 0
-otherwise.
-.SH BUGS
-None known.
diff --git a/doc/man3/string_to_tokens.3 b/doc/man3/string_to_tokens.3
deleted file mode 100644
index d4b233c..0000000
--- a/doc/man3/string_to_tokens.3
+++ /dev/null
@@ -1,71 +0,0 @@
-.\"
-.\" $Id: string_to_tokens.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
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
-.TH STRING_TO_TOKEN 3 07/25/2000 "Linux Test Project"
-.SH NAME
-string_to_tokens \- Break a string into its tokens
-.SH SYNOPSIS
-.nf
-\fB
-int string_to_tokens(arg_string, arg_array, array_size, separator)
-char *arg_string;
-char *arg_array[];
-int array_size;
-char *separator;
-\fR
-.fi
-
-.SH DESCRIPTION
-This function parses the string \fIarg_string\fR, placing pointers to
-the \fIseparator\fR separated tokens into the elements of \fIarg_array\fR.
-The array is terminated with a null pointer.
-\fIarg_array\fR must contains at least \fIarray_size\fR elements.
-Only the first \fIarray_size\fR minus one tokens will be placed into
-\fIarg_array\fR.  If there are more than \fIarray_size\fR-1 tokens, the rest are
-ignored by this routine.
-.RE
-
-.SH "SEE ALSO"
-strtok(3).
-
-.SH DIAGNOSTICS
-This function returns the number of \fIseparator\fR separated tokens that
-were found in \fIarg_string\fR.
-If \fIarg_array\fR or \fIseparator\fR is NULL or \fIarray_size\fR is less than 2,
--1 is returned.
-
-.SH BUGS
-This function uses \fBstrtok()\fR to parse \fIarg_string\fR, and thus
-physically alters \fIarg_string\fR by placing null characters where the
-separators originally were.
-
diff --git a/doc/man3/tst_set_error.3 b/doc/man3/tst_set_error.3
deleted file mode 100644
index 44f6f26..0000000
--- a/doc/man3/tst_set_error.3
+++ /dev/null
@@ -1,150 +0,0 @@
-.\"
-.\" $Id: tst_set_error.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
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
-.TH TST_SET_ERROR 3 07/25/2000 "Linux Test Project"
-.SH NAME
-tst_set_error \- Sets global tst_error values
-.br
-tst_clear_error \- clears global tst_error values
-.SH SYNOPSIS
-.nf
-\fB
-#include "test.h"
-
-void
-tst_set_error(file, line, func, fmt...)
-char *file;
-int line;
-char *func;
-char *fmt;     /* printf format */
-
-void
-tst_clear_error()
-\fR
-.fi
-
-.SH DESCRIPTION
-These two functions provide a simple interface to allow
-a programmer set and clear the global variables in
-\fBtst_error\fR defined in \fItest_error.c\fR.
-
-The purpose of these global variables to provide space
-for error messages passing.  Functions within our library
-can use this space and these routines to a pass error messages and
-some debug data to the caller.
-
-\fBtst_error\fR is a global variable, which is really a structure
-of five elements.   The structure is defined \fItest.h\fR and looks
-like:
-
-.nf
-    int  te_line;
-				/* line where last error was reported. */
-				/* Use "__LINE__" and let compiler do */
-				/* the rest */
-    int  te_level;
-				/* If set, will prevent current stored */
-				/* error to not be overwritten */
-    char te_func[TST_ERR_FUNC_SIZE+1];
-				/* name of function of last error */
-				/* Name of function or NULL */
-    char te_file[TST_ERR_FILE_SIZE+1];
-				/* module of last error.  Use */
-				/* "__FILE__" and let compiler do the */
-				/* rest */
-    char te_mesg[TST_ERR_MESG_SIZE+1];
-				/* string of last error */
-.fi
-
-Any new or existing function will be able to call \fBtst_set_error()\fR
-to save error information.  Any caller of a function that uses
-this data, can access the data fields directly and print any of
-error data in desired format.
-
-Do not append newline to the end \fBte_mesg\fR string, it is the
-responsibility of the user of these mesg to print the trailing newline.
-This does not say that for long error messages, that there can not be
-newlines in the message.
-
-\fBtst_set_error()\fR will not overwrite these global variables if
-\fBtst_error.te_level\fR is not zero.
-
-\fBtst_clear_error()\fR will make all strings zero length and set all integers to zero.
-
-These global variables should not be used as the
-method for determining if there is an error.  The functions that use
-\fBtst_set_error\fR, should provide another way to indicating that an error
-has occurred.  These variables should be used reporting the error message.
-Although, if you use \fBtst_clear_error()\fR prior to calling any functions
-and \fBtst_error.te_mesg\fR[0] != '\0', you know someone reported an error or
-at least used the space.
-
-.RE
-
-.SH "Examples"
-
-To clear/initialize a programmer can use the tst_clear_error()
-function or access the variables directly.
-
-.nf
-#include "test.h"
-	....
-	tst_clear_error();
-.fi
-
-To report an error, use tst_set_error() function:
-
-.nf
-#include "test.h"
-	....
-	tst_set_error(__LINE__, __FILE__, "funcname",
-		"Malloc(%d) failed, errno:%d", size, errno);
-.fi
-
-To access the error information an issue an error message:
-
-.nf
-#include "test.h"
- 	....
-	fprintf(stderr, "%s: funcname failed: %s\n", Prog, tst_error.te_mesg);
-
-.fi
-
-.SH DIAGNOSTICS
-Both functions are void, thus not return value.
-
-.SH BUGS
-There is no space overwrite preventions on the \fBtst_error.te_mesg\fR field.
-If \fIfmt\fR parameter of \fBtst_set_error\fR expands to a string
-larger than the space in \fBtst_error.te_mesg\fR, you will start overwriting
-memory.  This field contains 1024 bytes, which is fairly big error message.
diff --git a/doc/man3/write_log.3 b/doc/man3/write_log.3
deleted file mode 100644
index df65b91..0000000
--- a/doc/man3/write_log.3
+++ /dev/null
@@ -1,244 +0,0 @@
-.\"
-.\" $Id: write_log.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
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
-.TH WRITE_LOG 3 07/25/2000 "Linux Test Project"
-.SH NAME
-write_log \- a set of routines for logging writes to a history file
-.SH SYNOPSIS
-.nf
-\fB#include "write_log.h"\fP
-
-\fBint wlog_open(struct wlog_file *\fIwfile\fB, int \fItrunc\fB, int \fImode\fB);\fR
-\fBint wlog_close(struct wlog_file *\fIwfile\fB);\fR
-\fBint wlog_record_write(struct wlog_file *\fIwfile\fB, struct wlog_rec *\fIwrec\fB, long \fIoffset\fB);\fR
-\fBint wlog_scan_backward(struct wlog_file *\fIwfile\fB, int \fInrecs\fB, int (*func)(struct wlog_rec *\fIrec\fB), long \fIdata\fB);\fR
-
-\fBchar *Wlog_Error_String;\fR
-.fi
-.SH DESCRIPTION
-
-The write_log package is a set of routines for creating a history file
-of write operations done to a set of files.
-
-It is assumed that the actual pattern written to the file will be
-repeated occurrences of a string whose length is no greater than
-WLOG_MAX_PATTERN.  See the pattern(3) man
-page for routines to conveniently generate buffers of this kind.
-
-wlog_open() initializes the history file contained in wfile->w_file, and
-fills in the wfile structure.  If trunc is non-zero, and existing history
-file by the same name will be truncated.  If no history file exists, it
-will be created with the specified mode.
-
-wlog_close() releases any resources associated with the given wfile.  Use
-of wfile after this point is undefined until it is initialized again with
-wlog_open().
-
-wlog_record_write() is the main routine for putting a wlog_rec into the
-history file.  The caller is responsible for supplying a fully initialized
-wlog_rec structure.  If offset is < 0, the record will be appended to the
-end of the history file.  If offset is >= 0, the record will be written
-at the indicated offset.  This, along with the w_done field in the wlog_rec
-structure, provide a mechanism for 'pre-logging' a write, doing the write
-operation, and then overlaying the original record with the w_done flag
-set to 1.  This is useful for async writes which may not complete in a
-timely manner.  It is also useful for seeing which write operations were
-pending at the time of a system crash - the ones whose w_done flag is 0 have
-not yet been verified as complete.
-The return value from wlog_record_write() is the offset
-in the history file at which the record was written.
-
-wlog_scan_backward() can be used to conveniently scan a write history file.
-The routine scans the file in reverse order (ie. first record written is
-scanned last).  For every record found, the user supplied function is called
-with 2 parameters:  the read record, and an arbitrary word passed in by the
-user.  This word may be interpreted however the user desires.  If nrecs is
-greater than 0, up to nrecs will be scanned.  The user supplied function should
-return 1 of the following:  WLOG_STOP_SCAN, or WLOG_CONTINUE_SCAN.
-WLOG_STOP_SCAN provides a way for the user supplied function to prematurely
-abort the scanning process.  WLOG_CONTINUE_SCAN instructs wlog_scan_backward()
-to continue scanning the next record.
-
-In order for the history file to be effective, some basic rules must
-be followed by the programs using the history mechanism:
-
-.in +.5i
-.ll -.5i
-The area of the data file being written must be locked from
-before the write operation, until after the wlog_record_write()
-is complete.  This is necessary to 'synchronize' simultaneous
-writes to the same area of a file.  Note that the entire file
-does not need to be locked, only the portion being written to.
-If the calling program can guarantee that there will never be more
-than 1 process writing to the same area of a file at the same time,
-locking is not necessary.  (Note:  UNICOS Shared File Systems do not support
-record locking.  The whole file is silently locked.)
-
-Pathnames in the history file (w_path field) should be full
-pathnames if possible.  This allows validation tools to be
-able to find the test files without having to take working
-directory considerations into account.
-.ll +.5i
-.in -.5i
-
-.nf
-\fC
-.ta .25i +.5i +1i
-/*
- * write log file data type.  wlog_open() initializes this structure
- * which is then passed around to the various wlog_xxx routines.
- */
-
-struct wlog_file {
-	int	w_afd;	/* append fd */
-	int	w_rfd;	/* random-access fd */
-	char	w_file[1024];	/* name of the write_log */
-};
-\fR
-.DT
-.fi
-
-.nf
-\fC
-.ta .25i +.5i +2.0i
-/*
- * User view of a history file record.  Note that this is not
- * necessarily how the data is formatted on disk (significant
- * compression occurs), so don't expect to od(1) the history file and
- * see things formatted this way.  See the file write_log.h for comments
- * on how the data is actually written to disk.
- */
-
-struct wlog_rec {
-	int	w_pid;	/* pid doing the write */
-	int	w_offset;	/* file offset */
-	int	w_nbytes;	/* # bytes written */
-	int	w_oflags;	/* low-order open() flags */
-	int	w_done;	/* 1 if io confirmed done */
-	int	w_async;	/* 1 if async write (writea) */
-
-	char	w_host[WLOG_MAX_HOST+1];	/* host doing write */
-	int	w_hostlen;	/* host name length */
-	char	w_path[WLOG_MAX_PATH+1];	/* file written to */
-	int	w_pathlen;	/* file name length */
-	char	w_pattern[WLOG_MAX_PATTERN+1];	/* pattern written */
-	int	w_patternlen;	/* pattern length */
-};
-\fR
-.DT
-.fi
-
-Note:  The history files can become very large very quickly if a lot of
-processes are logging writes.  This is especially apt to happen if long
-pathnames or patterns are used.  This is because the w_host, w_path, and
-w_pattern fields are variable length fields when stored on disk.  Thus, use
-short pathnames and patterns to minimize the size of the history file.  If
-any of the w_path, w_pattern, or w_host fields are not important to you, set
-the respective length field to 0 in the wlog_rec structure.
-
-.SH EXAMPLES
-This is a simple example of how to initialize a history file, and
-record a write to it.
-
-.nf
-#include "write_log.h"
-
-main()
-{
-	struct wlog_rec wrec;
-	struct wlog_file wfile;
-
-	...
-	strcpy(wfile.w_file, hisfile);
-	if (wlog_open(&wfile, 1, 0666) < 0) {
-		fprintf("wlog_open failed\n");
-		exit(2);
-	}
-
-	...
-
-	wrec.w_pid = getpid();
-	wrec.w_offset = write_offset;
-	wrec.w_nbytes = nbytes;
-	wrec.w_oflags = open_flags;
-	wrec.w_done = 0;
-	wrec.w_async = 0;
-	wrec.w_host = 0;             /* don't care about host */
-
-	wrec.w_pathlen = sprintf(wrec.w_path, "%s", path);
-	wrec.w_patternlen = sprintf(wrec.w_pattern, "%s", pattern);
-
-	pattern_fill(buf, nbytes, pattern, strlen(pattern), 0);
-
-	... lock fd here ...
-
-	log_offset = wlog_record_write(&wfile, &wrec, -1);
-	write(fd, buf, nbytes);
-	wrec.w_done = 1;
-	wlog_record_write(&wfile, &wrec, log_offset);
-
-	... unlock fd here ...
-
-	...
-
-	/*
-	 * Scan the logfile printing records for the file in 'path'.
-	 */
-
-	wlog_scan_backward(&wfile, 0, print_log_record, (long)path);
-}
-
-int
-print_log_record(record, data)
-struct wlog_rec	*record;
-long		data;
-{
-	char	*path;
-
-	path = (char *)data;
-	if (strcmp(record->w_path, path) == 0) {
-		printf("write() of %d bytes to %s at offset %d by pid %d\n",
-			record->w_nbytes, record->path, record->w_offset, record->w_pid);
-	}
-
-	return WLOG_CONTINUE_SCAN;
-}
-
-.fi
-.SH "SEE ALSO"
-pattern(3).
-.SH DIAGNOSTICS
-All routines return a value < 0 on failure, and >= 0 on success.  Error
-messages can be accessed through Wlog_Error_String.
-.SH BUGS
-None known.
diff --git a/lib/tests/bytes_by_prefix_test.c b/lib/tests/bytes_by_prefix_test.c
deleted file mode 100644
index 4e65bbd..0000000
--- a/lib/tests/bytes_by_prefix_test.c
+++ /dev/null
@@ -1,282 +0,0 @@
-/*
- * Copyright (C) 2012 Marios Makris <marios.makris@gmail.com>
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
- */
-
-/*
- * Test program for the bytes_by_prefix program in /lib
- *
- * This program tests a few predefined values against the expected predefined
- * results, upon sucesfull completion, it prints the message:
- * "Tests sucesfully completed!" else it prints that there were an error
- * and the value as well as the type on which it failed (int, long, long long)
- * at the time of the error in order for someone to be able to trace
- * it back as well as the total number of errors encountered along with the
- * message: "Some test(s): (number of tests) failed please review!"
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-
-#include "bytes_by_prefix.h"
-
-struct test_vals {
-	char *val;
-	long long res;
-};
-
-/*
- * Array with generic values suitable for all operations.
- */
-struct test_vals test[] = {
-	{"1", 1},
-	{"5", 5},
-	{"10", 10},
-	{"552558", 552558},
-	{"0", 0},
-	{"1b", 512},
-	{"5b", 2560},
-	{"0b", 0},
-	{"1k", 1024},
-	{"5k", 5120},
-	{"552558k", 565819392},
-	{"0k", 0},
-	{"1m", 1048576},
-	{"5m", 5242880},
-	{"0m", 0},
-	{"1g", 1073741824},
-	{"0g", 0},
-	/*
-	 * Negative Test Values
-	 */
-	{"a", -1},
-	{"k", -1},
-	{"m", -1},
-	{"g", -1},
-	{"K", -1},
-	{"M", -1},
-	{"G", -1},
-	{"5km", -1},
-	{"1a", -1},
-	{"1mabc", -1},
-	{"a1", -1},
-	{"k1", -1},
-	{"1 k", -1},
-	{"1k g", -1},
-	{"-5", -1},
-	{"-5b", -1},
-	{"-2k", -1},
-	{"-2m", -1},
-	{"-2g", -1},
-	{"-2K", -1},
-	{"-2M", -1},
-	{"-2G", -1}
-};
-
-/*
- * Specific values for int operations
- */
-struct test_vals test_i[] = {
-/*
- * In case of 64b system as the results of capital multipliers are multiplied
- * by the sizeof(long) or sizeof(long long) respectively.
- * Check "/lib/bytes_by_prefix.c" file for more information.
- */
-#if __SIZEOF_LONG__ == 8
-	{"5K", 40960},
-	{"0K", 0},
-	{"5M", 41943040}
-/*
- * In case of 32b system as the results of capital multipliers are multiplied
- * by the sizeof(long) or sizeof(long long) respectively.
- * Check "/lib/bytes_by_prefix.c" file for more information.
- */
-#else
-	{"5K", 20480},
-	{"0K", 0},
-	{"5M", 20971520}
-#endif
-};
-
-/*
- * Specific values for long operations
- */
-struct test_vals test_l[] = {
-/*
- * In case of 64b system as the results of capital multipliers are multiplied
- * by the sizeof(long) or sizeof(long long) respectively.
- * Check "/lib/bytes_by_prefix.c" file for more information.
- */
-#if __SIZEOF_LONG__ == 8
-	{"552558m", 579399057408},
-	{"5g", 5368709120},
-	{"5K", 40960},
-	{"5M", 41943040},
-	{"1G", 8589934592}
-/*
- * In case of 32b system as the results of capital multipliers are multiplied
- * by the sizeof(long) or sizeof(long long) respectively.
- * Check "/lib/bytes_by_prefix.c" file for more information.
- */
-#else
-	{"552558m", -1},
-	{"5g", -1},
-	{"5K", 20480},
-	{"5M", 20971520},
-	{"1G", -1}
-#endif
-};
-
-/*
- * Specific values for long long operations
- */
-struct test_vals test_ll[] = {
-	{"552558m", 579399057408LL},
-	{"5g", 5368709120LL},
-	{"5K", 40960},
-	{"552558K", 4526555136LL},
-	{"5M", 41943040},
-	{"552558M", 4635192459264LL},
-	{"5G", 42949672960LL},
-	{"552558G", 4746437078286336LL}
-};
-
-static int test_values(void)
-{
-	/*
-	 * 1st position of the array denotes the valid int operations
-	 * 2nd position of the array denotes the valid long operations
-	 * 3rd position of the array denotes the valid long long operations
-	 */
-	int valid_count[3];
-	int tests_number[3];	/* int / long / long long */
-	int i;
-	int error_count = 0;
-	int elements;		/* Number of elements inside the test array. */
-
-	elements = sizeof(test) / sizeof(struct test_vals);
-	/*
-	 * Initializing counters.
-	 */
-	for (i = 0; i < 3; i++) {
-		valid_count[i] = 0;
-		tests_number[i] = elements;
-	}
-
-	/*
-	 * The "generic" test loop. If the result of the function equals the
-	 * expected predifined result, then increase the valid counter
-	 */
-	for (i = 0; i < elements; i++) {
-		if (bytes_by_prefix(test[i].val) == test[i].res) {
-			valid_count[0]++;
-		} else {
-			printf("Test value:%s failed on int.\n", test[i].val);
-			error_count++;
-		}
-
-		if (lbytes_by_prefix(test[i].val) == test[i].res) {
-			valid_count[1]++;
-		} else {
-			printf("Test value:%s failed on long.\n", test[i].val);
-			error_count++;
-		}
-
-		if (llbytes_by_prefix(test[i].val) == test[i].res) {
-			valid_count[2]++;
-		} else {
-			printf("Test value:%s failed on long long.\n",
-			       test[i].val);
-			error_count++;
-		}
-	}
-
-	elements = sizeof(test_i) / sizeof(struct test_vals);
-	tests_number[0] += elements;
-
-	/*
-	 * Int specific test loop
-	 */
-	for (i = 0; i < elements; i++) {
-		if (bytes_by_prefix(test_i[i].val) == test_i[i].res) {
-			valid_count[0]++;
-		} else {
-			printf("Test value:%s failed on int.\n", test_i[i].val);
-			error_count++;
-		}
-	}
-
-	elements = sizeof(test_l) / sizeof(struct test_vals);
-	tests_number[1] += elements;
-
-	/*
-	 * Long specific test loop
-	 */
-	for (i = 0; i < elements; i++) {
-		if (lbytes_by_prefix(test_l[i].val) == test_l[i].res) {
-			valid_count[1]++;
-		} else {
-			printf("Test value:%s failed on long.\n",
-			       test_l[i].val);
-			error_count++;
-		}
-	}
-
-	elements = sizeof(test_ll) / sizeof(struct test_vals);
-	tests_number[2] += elements;
-
-	/*
-	 * Long long specific test loop
-	 */
-	for (i = 0; i < elements; i++) {
-		if (llbytes_by_prefix(test_ll[i].val) == test_ll[i].res) {
-			valid_count[2]++;
-		} else {
-			printf("Test value:%s failed on long long.\n",
-			       test_ll[i].val);
-			error_count++;
-		}
-	}
-
-	fprintf(stdout, "Succesfull int tests:%d/%d\n", valid_count[0],
-		tests_number[0]);
-	fprintf(stdout, "Succesfull long tests:%d/%d\n", valid_count[1],
-		tests_number[1]);
-	fprintf(stdout, "Succesfull long long tests:%d/%d\n", valid_count[2],
-		tests_number[2]);
-
-	return error_count;
-}
-
-int main(void)
-{
-	int errors = test_values();
-
-	if (errors > 0) {
-		fprintf(stderr, "\nSome test(s):(%d) failed please review!\n",
-			errors);
-		exit(1);
-	} else {
-		fprintf(stdout, "Tests succesfully completed!\n");
-	}
-
-	return 0;
-}
diff --git a/testcases/kernel/fs/doio/Makefile b/testcases/kernel/fs/doio/Makefile
index 7e56089..253e804 100644
--- a/testcases/kernel/fs/doio/Makefile
+++ b/testcases/kernel/fs/doio/Makefile
@@ -24,9 +24,18 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CFLAGS			+= -D_LARGEFILE64_SOURCE -Wall
+CFLAGS			+= -D_LARGEFILE64_SOURCE -Wall \
+			   -I$(abs_top_srcdir)/testcases/kernel/fs/doio/include/
 LDLIBS			+= -lrt -lpthread
 
+MAKE_TARGETS		:= growfiles doio iogen
 INSTALL_TARGETS		:= rwtest
 
+
+$(MAKE_TARGETS): dataascii.o databin.o file_lock.o forker.o open_flags.o \
+		 datapid.o write_log.o pattern.o string_to_tokens.o \
+		 bytes_by_prefix.o
+
+%.o: $(abs_top_srcdir)/testcases/kernel/fs/doio/%.c
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/lib/bytes_by_prefix.c b/testcases/kernel/fs/doio/bytes_by_prefix.c
similarity index 100%
rename from lib/bytes_by_prefix.c
rename to testcases/kernel/fs/doio/bytes_by_prefix.c
diff --git a/lib/dataascii.c b/testcases/kernel/fs/doio/dataascii.c
similarity index 100%
rename from lib/dataascii.c
rename to testcases/kernel/fs/doio/dataascii.c
diff --git a/lib/databin.c b/testcases/kernel/fs/doio/databin.c
similarity index 100%
rename from lib/databin.c
rename to testcases/kernel/fs/doio/databin.c
diff --git a/lib/datapid.c b/testcases/kernel/fs/doio/datapid.c
similarity index 100%
rename from lib/datapid.c
rename to testcases/kernel/fs/doio/datapid.c
diff --git a/lib/file_lock.c b/testcases/kernel/fs/doio/file_lock.c
similarity index 100%
rename from lib/file_lock.c
rename to testcases/kernel/fs/doio/file_lock.c
diff --git a/lib/forker.c b/testcases/kernel/fs/doio/forker.c
similarity index 100%
rename from lib/forker.c
rename to testcases/kernel/fs/doio/forker.c
diff --git a/include/old/bytes_by_prefix.h b/testcases/kernel/fs/doio/include/bytes_by_prefix.h
similarity index 100%
rename from include/old/bytes_by_prefix.h
rename to testcases/kernel/fs/doio/include/bytes_by_prefix.h
diff --git a/include/old/dataascii.h b/testcases/kernel/fs/doio/include/dataascii.h
similarity index 100%
rename from include/old/dataascii.h
rename to testcases/kernel/fs/doio/include/dataascii.h
diff --git a/include/old/databin.h b/testcases/kernel/fs/doio/include/databin.h
similarity index 100%
rename from include/old/databin.h
rename to testcases/kernel/fs/doio/include/databin.h
diff --git a/include/old/file_lock.h b/testcases/kernel/fs/doio/include/file_lock.h
similarity index 100%
rename from include/old/file_lock.h
rename to testcases/kernel/fs/doio/include/file_lock.h
diff --git a/include/old/forker.h b/testcases/kernel/fs/doio/include/forker.h
similarity index 100%
rename from include/old/forker.h
rename to testcases/kernel/fs/doio/include/forker.h
diff --git a/include/old/open_flags.h b/testcases/kernel/fs/doio/include/open_flags.h
similarity index 100%
rename from include/old/open_flags.h
rename to testcases/kernel/fs/doio/include/open_flags.h
diff --git a/include/old/pattern.h b/testcases/kernel/fs/doio/include/pattern.h
similarity index 100%
rename from include/old/pattern.h
rename to testcases/kernel/fs/doio/include/pattern.h
diff --git a/include/old/string_to_tokens.h b/testcases/kernel/fs/doio/include/string_to_tokens.h
similarity index 100%
rename from include/old/string_to_tokens.h
rename to testcases/kernel/fs/doio/include/string_to_tokens.h
diff --git a/include/old/write_log.h b/testcases/kernel/fs/doio/include/write_log.h
similarity index 100%
rename from include/old/write_log.h
rename to testcases/kernel/fs/doio/include/write_log.h
diff --git a/lib/open_flags.c b/testcases/kernel/fs/doio/open_flags.c
similarity index 100%
rename from lib/open_flags.c
rename to testcases/kernel/fs/doio/open_flags.c
diff --git a/lib/pattern.c b/testcases/kernel/fs/doio/pattern.c
similarity index 100%
rename from lib/pattern.c
rename to testcases/kernel/fs/doio/pattern.c
diff --git a/lib/string_to_tokens.c b/testcases/kernel/fs/doio/string_to_tokens.c
similarity index 100%
rename from lib/string_to_tokens.c
rename to testcases/kernel/fs/doio/string_to_tokens.c
diff --git a/lib/write_log.c b/testcases/kernel/fs/doio/write_log.c
similarity index 100%
rename from lib/write_log.c
rename to testcases/kernel/fs/doio/write_log.c
-- 
2.10.2

