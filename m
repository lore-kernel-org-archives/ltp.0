From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 16:16:06 +0100
Subject: [LTP] [COMMITTED] [PATCH] tools: Get rid of rand_lines
Message-ID: <20170213151606.9836-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All uses were replaced with sort -R

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh     |  14 +-
 testcases/kernel/fs/scsi/ltpscsi/ltpfsscsi.sh |   2 +-
 testscripts/ltp-aiodio.sh                     |  12 +-
 testscripts/ltp-scsi_debug.sh                 |   2 +-
 testscripts/ltpfslvm.sh                       |   4 +-
 testscripts/ltpfsnolvm.sh                     |   4 +-
 testscripts/ltpstress.sh                      |   6 +-
 tools/.gitignore                              |   1 -
 tools/rand_lines.c                            | 543 --------------------------
 9 files changed, 22 insertions(+), 566 deletions(-)
 delete mode 100644 tools/rand_lines.c

diff --git a/testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh b/testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh
index 0338724..ed3d8e2 100755
--- a/testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh
+++ b/testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh
@@ -83,7 +83,7 @@ mount -v /dev/$part1 /test/growfiles/ext2
 
 
 echo "************ Running tests "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltpfs.part1 > ${TMPBASE}/ltpfs.part1
+sort -R ${LTPROOT}/runtest/ltpfs.part1 -o ${TMPBASE}/ltpfs.part1
 
 ${LTPROOT}/pan/pan -e -S -a ltpfspart1 -n ltpfspart1 -l lvmlogfile -f ${TMPBASE}/ltpfs.part1 &
 
@@ -95,7 +95,7 @@ mkfs.xfs -f   /dev/$part1
 mount -v /dev/$part1 /test/growfiles/xfs
 
 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltpfs.part2 > ${TMPBASE}/ltpfs.part2
+sort -R ${LTPROOT}/runtest/ltpfs.part2 -o ${TMPBASE}/ltpfs.part2
 
 ${LTPROOT}/pan/pan -e -S -a ltpfspart2 -n ltpfspart2 -l lvmlogfile -f ${TMPBASE}/ltpfs.part2 &
 
@@ -105,7 +105,7 @@ mkfs -V -t msdos    /dev/$part1
 umount -v /dev/$part1
 mount -v /dev/$part1 /test/growfiles/msdos
 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltpfs.part3 > ${TMPBASE}/ltpfs.part3
+sort -R ${LTPROOT}/runtest/ltpfs.part3 -o ${TMPBASE}/ltpfs.part3
 
 ${LTPROOT}/pan/pan -e -S -a ltpfspart3 -n ltpfspart3 -l lvmlogfile -f ${TMPBASE}/ltpfs.part3 &
 
@@ -115,7 +115,7 @@ umount -v /dev/$part1
 mkreiserfs          /dev/$part1 <yesenter.txt
 mount -v /dev/$part1 /test/growfiles/reiser
 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltpfs.part4 > ${TMPBASE}/ltpfs.part4
+sort -R ${LTPROOT}/runtest/ltpfs.part4 -o ${TMPBASE}/ltpfs.part4
 
 ${LTPROOT}/pan/pan -e -S -a ltpfspart4 -n ltpfspart4 -l lvmlogfile -f ${TMPBASE}/ltpfs.part4 &
 
@@ -125,7 +125,7 @@ umount -v /dev/$part1
 mkfs -V -t minix    /dev/$part1
 mount -v /dev/$part1 /test/growfiles/minix
 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltpfs.part5 > ${TMPBASE}/ltpfs.part5
+sort -R ${LTPROOT}/runtest/ltpfs.part5 -o ${TMPBASE}/ltpfs.part5
 
 ${LTPROOT}/pan/pan -e -S -a ltpfspart5 -n ltpfspart5 -l lvmlogfile -f ${TMPBASE}/ltpfs.part5 &
 
@@ -135,7 +135,7 @@ umount -v /dev/$part1
 mkfs -V -t ext3     /dev/$part1
 mount -v /dev/$part1 /test/growfiles/ext3
 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltpfs.part6 > ${TMPBASE}/ltpfs.part6
+sort -R ${LTPROOT}/runtest/ltpfs.part6 -o ${TMPBASE}/ltpfs.part6
 
 ${LTPROOT}/pan/pan -e -S -a ltpfspart6 -n ltpfspart6 -l lvmlogfile -f ${TMPBASE}/ltpfs.part6 &
 
@@ -145,7 +145,7 @@ umount -v /dev/$part1
 mkfs -V -t jfs /dev/$part1  <yesenter.txt
 mount -v -t jfs    /dev/$part1           /test/growfiles/jfs
 
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltpfs.part7 > ${TMPBASE}/ltpfs.part7
+sort -R ${LTPROOT}/runtest/ltpfs.part7 -o ${TMPBASE}/ltpfs.part7
 
 ${LTPROOT}/pan/pan -e -S -a ltpfspart7 -n ltpfspart7 -l lvmlogfile -f ${TMPBASE}/ltpfs.part7 &
 
diff --git a/testcases/kernel/fs/scsi/ltpscsi/ltpfsscsi.sh b/testcases/kernel/fs/scsi/ltpscsi/ltpfsscsi.sh
index a26d6f6..29648d9 100755
--- a/testcases/kernel/fs/scsi/ltpscsi/ltpfsscsi.sh
+++ b/testcases/kernel/fs/scsi/ltpscsi/ltpfsscsi.sh
@@ -96,7 +96,7 @@ modprobe scsi_debug max_luns=2 num_tgts=7 add_host=10
 cd ${LTPROOT}
 
 echo "************ Running tests "
-${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/scsi.part1 > ${TMPBASE}/scsi.part1
+sort -R ${LTPROOT}/runtest/scsi.part1 -o ${TMPBASE}/scsi.part1
 
 ${LTPROOT}/pan/pan -e -S -a scsipart1 -n scsipart1 -l scsilogfile -f ${TMPBASE}/scsi.part1 &
 
diff --git a/testscripts/ltp-aiodio.sh b/testscripts/ltp-aiodio.sh
index 2bd5dbf..06ea534 100755
--- a/testscripts/ltp-aiodio.sh
+++ b/testscripts/ltp-aiodio.sh
@@ -229,7 +229,7 @@ dd if=$file1 of=$TMP/aiodio/junkfile bs=8192 conv=block,sync
 date
 echo "************ Running aio-stress tests "
 echo "current working dir = ${PWD}"
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part1 > ${TMPBASE}/ltp-aio-stress.part1
+sort -R ${LTPROOT}/runtest/ltp-aio-stress.part1 -o ${TMPBASE}/ltp-aio-stress.part1
 
 ${LTPROOT}/bin/ltp-pan -e -S -a ltpaiostresspart1 -n ltp-aiostresspart1 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part1 &
 
@@ -241,7 +241,7 @@ echo ""
 
 if [ "$runExtendedStress" -eq 1 ];then
 echo "************ Running EXTENDED aio-stress tests "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part2 > ${TMPBASE}/ltp-aio-stress.part2
+sort -R ${LTPROOT}/runtest/ltp-aio-stress.part2 -o ${TMPBASE}/ltp-aio-stress.part2
 
 ${LTPROOT}/bin/ltp-pan -e -S -a ltpaiostresspart2 -n ltp-aiostresspart2 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part2 &
 
@@ -256,7 +256,7 @@ dd if=$file1 of=$TMP/aiodio/ff2      bs=1024 conv=block,sync
 dd if=$file1 of=$TMP/aiodio/ff3      bs=512  conv=block,sync
 
 echo "************ Running aiocp tests "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part1 > ${TMPBASE}/ltp-aiodio.part1
+sort -R ${LTPROOT}/runtest/ltp-aiodio.part1 -o ${TMPBASE}/ltp-aiodio.part1
 
 ${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart1 -n ltp-aiodiopart1 -l ltpaiodio1.logfile -o ltpaiodio1.outfile -p -f ${TMPBASE}/ltp-aiodio.part1 &
 
@@ -266,7 +266,7 @@ echo "************ End Running aiocp tests "
 echo ""
 
 echo "************ Running aiodio_sparse tests "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part2 > ${TMPBASE}/ltp-aiodio.part2
+sort -R ${LTPROOT}/runtest/ltp-aiodio.part2 -o ${TMPBASE}/ltp-aiodio.part2
 
 ${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart2 -n ltp-aiodiopart2 -l ltpaiodio2.logfile -o ltpaiodio2.outfile -p -f ${TMPBASE}/ltp-aiodio.part2 &
 
@@ -278,7 +278,7 @@ echo ""
 
 if [ "$runExtendedStress" -eq 1 ];then
 echo "************ Running fsx-linux tests "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part3 > ${TMPBASE}/ltp-aiodio.part3
+sort -R ${LTPROOT}/runtest/ltp-aiodio.part3 -o ${TMPBASE}/ltp-aiodio.part3
 
 ${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart3 -n ltp-aiodiopart3 -l ltpaiodio3.logfile -o ltpaiodio3.outfile -p -f ${TMPBASE}/ltp-aiodio.part3 &
 
@@ -297,7 +297,7 @@ dd if=$file1 of=$TMP/aiodio/file5      bs=4096 conv=block,sync
 
 
 echo "************ Running dio_sparse & miscellaneous tests "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part4 > ${TMPBASE}/ltp-aiodio.part4
+sort -R ${LTPROOT}/runtest/ltp-aiodio.part4 -o ${TMPBASE}/ltp-aiodio.part4
 ${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart4 -n ltp-aiodiopart4 -l ltpaiodio4.logfile -o ltpaiodio4.outfile -p -f ${TMPBASE}/ltp-aiodio.part4 &
 
 wait $!
diff --git a/testscripts/ltp-scsi_debug.sh b/testscripts/ltp-scsi_debug.sh
index fc3cec3..3785300 100755
--- a/testscripts/ltp-scsi_debug.sh
+++ b/testscripts/ltp-scsi_debug.sh
@@ -204,7 +204,7 @@ mount /dev/$part4 /test/growfiles/msdos
 
 echo "----- Running tests ----- "
 echo "The test may take about 2 hours to finish..."
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/scsi_debug.part1 > ${TMPBASE}/scsi_debug
+sort -R ${LTPROOT}/runtest/scsi_debug.part1 -o ${TMPBASE}/scsi_debug
 
 ${LTPROOT}/bin/ltp-pan -e -S -a scsi_debug -n scsi_debug -l ${TMPBASE}/fs-scsi_debug.log -o ${TMPBASE}/fs-scsi_debug.out -f ${TMPBASE}/scsi_debug
 
diff --git a/testscripts/ltpfslvm.sh b/testscripts/ltpfslvm.sh
index 0712322..a90d065 100755
--- a/testscripts/ltpfslvm.sh
+++ b/testscripts/ltpfslvm.sh
@@ -156,7 +156,7 @@ mount -v /dev/ltp_test_vg2/ltp_test_lv4 /test/growfiles/minix
 mount -v /dev/ram                       /test/growfiles/ramdisk
 
 echo "************ Running tests "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/lvm.part1 > ${TMPBASE}/lvm.part1
+sort -R ${LTPROOT}/runtest/lvm.part1 -o ${TMPBASE}/lvm.part1
 
 ${LTPROOT}/bin/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
 
@@ -188,7 +188,7 @@ mount -v -t ext3   /dev/$part4         /test/growfiles/ext3
 mount -v -t jfs    /dev/hdc1           /test/growfiles/jfs
 
 echo "************ Running EXT3 & JFS tests...  "
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/lvm.part2 > ${TMPBASE}/lvm.part2
+sort -R ${LTPROOT}/runtest/lvm.part2 -o ${TMPBASE}/lvm.part2
 
 ${LTPROOT}/bin/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
 
diff --git a/testscripts/ltpfsnolvm.sh b/testscripts/ltpfsnolvm.sh
index 81904ac..26dac01 100755
--- a/testscripts/ltpfsnolvm.sh
+++ b/testscripts/ltpfsnolvm.sh
@@ -116,7 +116,7 @@ mount -v /dev/$part4                    /test/growfiles/minix
 mount -v /dev/ram                       /test/growfiles/ramdisk
 
 echo "************ Running tests "
-${LTPROOT}/../bin/rand_lines -g ${LTPROOT}/../runtest/lvm.part1 > ${TMPBASE}/lvm.part1
+sort -R ${LTPROOT}/../runtest/lvm.part1 -o ${TMPBASE}/lvm.part1
 
 ${LTPROOT}/../bin/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
 
@@ -138,7 +138,7 @@ mount -v -t ext3   /dev/$part4         /test/growfiles/ext3
 mount -v -t jfs    /dev/$part1         /test/growfiles/jfs
 
 echo "************ Running EXT3 & JFS tests...  "
-${LTPROOT}/../bin/rand_lines -g ${LTPROOT}/../runtest/lvm.part2 > ${TMPBASE}/lvm.part2
+sort -R ${LTPROOT}/../runtest/lvm.part2 -o ${TMPBASE}/lvm.part2
 
 ${LTPROOT}/../bin/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
 
diff --git a/testscripts/ltpstress.sh b/testscripts/ltpstress.sh
index 651d3da..a487db5 100755
--- a/testscripts/ltpstress.sh
+++ b/testscripts/ltpstress.sh
@@ -274,9 +274,9 @@ fi
 if [ $NO_NETWORK -eq 0 ];then
  netpipe.sh >/dev/null 2>/dev/null &
 fi
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/stress.part1 > ${TMP}/stress.part1
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/stress.part2 > ${TMP}/stress.part2
-${LTPROOT}/bin/rand_lines -g ${LTPROOT}/runtest/stress.part3 > ${TMP}/stress.part3
+sort -R ${LTPROOT}/runtest/stress.part1 -o ${TMP}/stress.part1
+sort -R ${LTPROOT}/runtest/stress.part2 -o ${TMP}/stress.part2
+sort -R ${LTPROOT}/runtest/stress.part3 -o ${TMP}/stress.part3
 
 sleep 2
 
diff --git a/tools/.gitignore b/tools/.gitignore
index 0fe20a1..68fed60 100644
--- a/tools/.gitignore
+++ b/tools/.gitignore
@@ -1,2 +1 @@
 /gethost
-/rand_lines
diff --git a/tools/rand_lines.c b/tools/rand_lines.c
deleted file mode 100644
index 9d86ed7..0000000
--- a/tools/rand_lines.c
+++ /dev/null
@@ -1,543 +0,0 @@
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
- *
- */
-/* $Id: rand_lines.c,v 1.5 2002/09/16 15:02:57 nstraz Exp $ */
-/**************************************************************
- *
- *    OS Testing - Silicon Graphics, Inc.
- *
- *    TOOL IDENTIFIER   : rand_lines
- *
- *    DESCRIPTION       : prints lines from a file in random order
- *
- *    SYNOPSIS:
- *      rand_line [-hg][-S seed][-l numlines] [files...]
- *
- *    AUTHOR            : Richard Logan
- *
- *    CO-PILOT(s)       :
- *
- *    DATE STARTED      : 05/94
- *
- *    INPUT SPECIFICATIONS
- *     This tool will print lines of a file in random order.
- *     The max line length is 4096.
- *     The options supported are:
- *       -h     This option prints an help message then exits.
- *
- *       -g     This option specifies to count the number of lines
- *		in the file before randomizing.  This option overrides
- *		-l option.  Using this option, will give you the best
- *		randomization, but it requires processing
- *		the file an additional time.
- *
- *       -l numlines : This option specifies to randomize file in
- *		numlines chucks.  The default size is 4096.
- *
- *       -S seed     : sets randomization seed to seed.
- *		The default is time(0).  If seed is zero, time(0) is used.
- *
- *	 file   A readable, seekable filename.  The cmd allows the user
- *	 	to specify multiple files, but each file is dealt with
- *		separately.
- *
- *    DESIGN DESCRIPTION
- *	This tool uses a simple algorithm where the file is read.
- *	The offset to the each line is randomly placed into an
- *	array.  The array is then processed sequentially.  The infile's
- *	line who's offset in the array element is thus reread then printed.
- *	This output will thus be infile's lines in random order.
- *
- *    SPECIAL REQUIREMENTS
- *	None.
- *
- *    UPDATE HISTORY
- *      This should contain the description, author, and date of any
- *      "interesting" modifications (i.e. info should helpful in
- *      maintaining/enhancing this tool).
- *      username     description
- *      ----------------------------------------------------------------
- *	rrl 	    Creatation of program
- *	rrl  06/02  Fixed bug and some cleanup. Changed default chunk
- *	            and line size to 4096 characters.
- *
- *    BUGS/LIMITATIONS
- *	This program can not deal with non-seekable file like
- *	stdin or a pipe.  If more than one file is specified,
- *	each file is randomized one at a time.  The max line
- *	length is 4096 characters.
- *
- **************************************************************/
-
-#include <err.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <unistd.h>
-
-#include "random_range.h"
-
-/*
- * Structure used to hold file line offset.
- */
-struct offset_t {
-	long used;
-	long offset;
-};
-
-void usage(FILE * stream);
-void help(void);
-int rnd_file(FILE * infile, int numlines, long seed);
-int get_numlines(FILE * infile);
-int rnd_insert(struct offset_t offsets[], long offset, int size);
-
-#define DEF_SIZE	4096	/* default chunk size */
-#define MAX_LN_SZ	4096	/* max line size */
-
-#ifndef SEEK_SET
-#define SEEK_SET	0
-#endif
-
-char *Progname = NULL;
-
-/***********************************************************************
- *  MAIN
- ***********************************************************************/
-int main(int argc, char *argv[])
-{
-	FILE *infile;
-	int c;
-	long seed = -1;		/* use time as seed */
-	int lsize = DEF_SIZE;	/* num lines to randomize */
-	int getfilelines = 0;	/* if set, count lines first */
-
-	if ((Progname = strrchr(argv[0], '/')) == NULL)
-		Progname = argv[0];
-	else
-		Progname++;
-
-	while ((c = getopt(argc, argv, "hgS:l:")) != EOF) {
-		switch (c) {
-		case 'h':
-			help();
-			exit(0);
-			break;
-		case 'S':	/* seed */
-			if (sscanf(optarg, "%li", &seed) != 1) {
-				fprintf(stderr,
-					"%s: --S option argument is invalid\n",
-					Progname);
-				exit(1);
-			}
-			break;
-
-		case 'l':	/* number of lines */
-			if (sscanf(optarg, "%i", &lsize) != 1) {
-				fprintf(stderr,
-					"%s: --s option argument is invalid\n",
-					Progname);
-				exit(1);
-			}
-			break;
-
-		case 'g':
-			getfilelines++;
-			break;
-
-		case '?':
-			usage(stderr);
-			exit(1);
-			break;
-		}
-	}
-
-	if (optind + 1 != argc) {
-		fprintf(stderr, "%s: Missing argument.\n", Progname);
-		usage(stderr);
-		exit(1);
-	}
-
-	if (seed == -1) {
-		seed = time(0);
-	}
-
-	if (strcmp(argv[argc - 1], "-") == 0) {
-		infile = stdin;
-		fprintf(stderr, "%s: Can not support stdin processing.\n",
-			Progname);
-		exit(2);
-	} else {
-
-		if ((infile = fopen(argv[argc - 1], "r")) == NULL) {
-			fprintf(stderr, "%s: Unable to open file %s: %s\n",
-				Progname, argv[argc - 1], strerror(errno));
-			exit(1);
-		}
-
-		if (getfilelines) {
-			lsize = get_numlines(infile);
-		}
-
-		rnd_file(infile, lsize, seed);
-	}
-
-	exit(0);
-}
-
-/***********************************************************************
- * Print usage message to stream.
- ***********************************************************************/
-void usage(FILE * stream)
-{
-	fprintf(stream,
-		"Usage %s [-hg][-S seed][-l numlines] [files...]\n", Progname);
-
-}
-
-/***********************************************************************
- * Print help message to stdout.
- ***********************************************************************/
-void help(void)
-{
-	usage(stdout);
-	printf("This tool will print lines in random order (max line len %d).\n\
-  -h          : print this help and exit\n\
-  -g          : count the number of lines in the file before randomizing\n\
-	        This option overrides -l option.\n\
-  -l numlines : randoms lines in numlines chuncks (def %d)\n\
-  -S seed     : sets seed to seed (def time(0))\n", MAX_LN_SZ, DEF_SIZE);
-
-}
-
-/***********************************************************************
- * counts the number of lines in already open file.
- * Note: File must be seekable (not stdin or a pipe).
- ***********************************************************************/
-int get_numlines(FILE *infile)
-{
-	char line[MAX_LN_SZ];	/* max size of a line */
-	int cnt = 0;
-
-	while (fgets(line, MAX_LN_SZ, infile) != NULL) {
-		cnt++;
-	}
-
-	/* rewind the file */
-	fseek(infile, 0, SEEK_SET);
-
-	return cnt;
-}
-
-/***********************************************************************
- *
- *  infile must be a fseekable file.  Thus, it can not be stdin.
- * It will read each line in the file, randomly saving the offset
- * of each line in a array of struct offset_t.
- * It will then print each line in the array stored order.
- *
- ***********************************************************************/
-int rnd_file(FILE *infile,
-	int numlines,	/* can be more or less than num lines in file */
-			/* most opt randomized when num lines in files */
-			/* or just a bit bigger */
-	long seed)
-{
-
-	char line[MAX_LN_SZ];	/* max size of a line */
-	int cnt;
-	long coffset;		/* current line offset */
-
-	struct offset_t *offsets;
-	int memsize;
-
-	if (numlines <= 0) {	/*use default */
-		numlines = DEF_SIZE;
-	}
-
-	/*
-	 * Malloc space for numlines copies the offset_t structure.
-	 * This is where the randomization takes place.
-	 */
-	memsize = sizeof(struct offset_t) * numlines;
-
-	if ((offsets = (struct offset_t *)malloc(memsize)) == NULL) {
-		fprintf(stderr, "Unable to malloc(%d): errno:%d\n", memsize,
-			errno);
-		return -1;
-	}
-
-	random_range_seed(seed);
-
-	coffset = 0;
-
-	while (!feof(infile)) {
-
-		fseek(infile, coffset, SEEK_SET);
-		coffset = ftell(infile);
-		memset(offsets, 0, memsize);
-		cnt = 0;
-
-		/*
-		 * read the file in and place offset of each line randomly
-		 * into offsets array.  Only numlines line can be randomized
-		 *@a time.
-		 */
-		while (cnt < numlines && fgets(line, MAX_LN_SZ, infile) != NULL) {
-
-			if (rnd_insert(offsets, coffset, numlines) < 0) {
-				fprintf(stderr,
-					"%s:%d rnd_insert() returned -1 (fatal error)!\n",
-					__FILE__, __LINE__);
-				abort();
-			}
-			cnt++;
-
-			coffset = ftell(infile);
-		}
-
-		if (cnt == 0) {
-			continue;
-		}
-
-		/*
-		 * print out lines based on offset.
-		 */
-		for (cnt = 0; cnt < numlines; cnt++) {
-
-			if (offsets[cnt].used) {
-				fseek(infile, offsets[cnt].offset, SEEK_SET);
-				if (fgets(line, MAX_LN_SZ, infile) == NULL)
-					err(1, "fgets");
-				fputs(line, stdout);
-			}
-		}
-
-	}			/* end of file */
-
-	return 0;
-}
-
-/***********************************************************************
- * This function randomly inserts offset information into
- * the offsets array.  The array has a size of size.
- * It will attempt 75 random array indexes before finding the first
- * open array element.
- *
- ***********************************************************************/
-int rnd_insert(struct offset_t offsets[], long offset, int size)
-{
-	int rand_num;
-	int quick = 0;
-	int ind;
-
-	/*
-	 * Loop looking for random unused index.
-	 * It will only be attempted 75 times.
-	 */
-	while (quick < 75) {
-
-		rand_num = random_range(0, size - 1, 1, NULL);
-
-		if (!offsets[rand_num].used) {
-			offsets[rand_num].offset = offset;
-			offsets[rand_num].used++;
-			return rand_num;
-		}
-		quick++;
-	}
-
-	/*
-	 * an randomly choosen index was not found, find
-	 * first open index and use it.
-	 */
-	for (ind = 0; ind < size && offsets[ind].used != 0; ind++) ;	/* do nothing */
-
-	if (ind >= size) {
-		/*
-		 * If called with an array where all offsets are used,
-		 * we won't be able to find an open array location.
-		 * Thus, return -1 indicating the error.
-		 * This should never happen if called correctly.
-		 */
-		return -1;
-	}
-
-	offsets[ind].offset = offset;
-	offsets[ind].used++;
-	return ind;
-
-}
-
-/***********************************************************************
- *
- * CODE NOT TESTED AT ALL - it must be tested before it is used.
- *
- * This function was written to allow rand_lines to work on non-seekable
- * file (i.e stdin).
- *
- ***********************************************************************/
-int rnd_stdin(FILE *infile,
-	int space,	/* amount of space to use to read file into memory, */
-			/* randomized and print.  randomize in chunks */
-	int numlines,	/* can be more or less than num lines in file */
-			/* most opt randomized when num lines in files */
-			/* or just a bit bigger */
-	long seed)
-{
-
-	char line[MAX_LN_SZ];	/* max size of a line */
-	int cnt;		/* offset printer counter */
-	long loffset;		/* last line address */
-	char *buffer;		/* malloc space for file reads */
-	char *rdbuff;		/* where to start read */
-	long stopaddr;		/* end of read space (address) */
-	int rdsz;		/* amount read */
-	int sztord;
-	char *chr;		/* buffer processing pointer */
-	char *ptr;		/* printing processing pointer */
-	char *lptr;		/* printing processing pointer */
-	int loopcntl = 1;	/* main loop control flag */
-	struct offset_t *offsets;	/* pointer to offset space */
-	int memsize;		/* amount of offset space to malloc */
-	int newbuffer = 1;	/* need new buffer */
-
-	if (numlines <= 0) {	/*use default */
-		numlines = DEF_SIZE;
-	}
-
-	/*
-	 * Malloc space for file contents
-	 */
-	if ((buffer = (char *)malloc(space)) == NULL) {
-		fprintf(stderr, "Unable to malloc(%d): errno:%d\n", space,
-			errno);
-		return -1;
-	}
-
-	/*
-	 * Malloc space for numlines copies the offset_t structure.
-	 * This is where the randomization takes place.
-	 */
-	memsize = sizeof(struct offset_t) * numlines;
-
-	if ((offsets = (struct offset_t *)malloc(memsize)) == NULL) {
-		fprintf(stderr, "Unable to malloc(%d): errno:%d\n", memsize,
-			errno);
-		return -1;
-	}
-
-	random_range_seed(seed);
-	rdbuff = buffer;	/* read into start of buffer */
-	sztord = space;		/* amount of space left in buffer */
-
-	/*
-	 *  Loop until read doesn't read anything
-	 *  If last line does not end in newline, it is not printed
-	 */
-	while (loopcntl) {
-		/*
-		 *  read in file up to space size
-		 *  only works if used as filter.
-		 *  The code will randomize one reads worth@a time.
-		 *  If typing in lines, read will read only one line - no randomizing.
-		 */
-
-		chr = buffer;
-		if ((rdsz = fread((void *)rdbuff, sztord, 1, infile)) == 0) {
-			fprintf(stderr,
-				"input file is empty, done randomizing\n");
-			loopcntl = 0;
-			return 0;
-		}
-
-		stopaddr = ((long)buffer + rdsz);
-
-		loffset = (long)buffer;
-
-		while (!newbuffer) {
-
-			while ((long)chr < stopaddr && *chr != '\n')
-				chr++;
-
-			chr++;
-
-			if ((long)chr >= stopaddr) {
-
-				fprintf(stderr, "end of read in buffer\n");
-
-				/*
-				 * print out lines based on offset.
-				 */
-				for (cnt = 0; cnt < numlines; cnt++) {
-
-					if (offsets[cnt].used) {
-						ptr =
-						    (char *)offsets[cnt].offset;
-						/*
-						 * copy buffer characters into line for printing
-						 */
-						lptr = line;
-						while (*ptr != '\n')
-							*lptr++ = *ptr++;
-
-						printf("%s\n", line);
-					}
-				}
-
-				/*
-				 * move start of partically read line to beginning of buffer
-				 * and adjust rdbuff to end of partically read line
-				 */
-				memcpy((void *)loffset, buffer,
-				       (stopaddr - loffset));
-				rdbuff = buffer + (stopaddr - loffset);
-				sztord = space - (stopaddr - loffset);
-
-				newbuffer++;
-			}
-
-			if (rnd_insert(offsets, loffset, numlines) < 0) {
-				fprintf(stderr,
-					"%s:%d rnd_insert() returned -1 (fatal error)!\n",
-					__FILE__, __LINE__);
-				abort();
-			}
-
-			loffset = (long)chr;
-		}
-	}
-
-	return 0;
-
-}
-- 
2.10.2

