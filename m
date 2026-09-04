Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBBFC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:57:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86D403E570A
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:56:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EFE83E5716
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:56:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 54BA31000F7A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:56:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 085F622B32;
 Fri,  4 Sep 2026 08:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788512173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qU3MUyPlFi7aOouyR+AtmcpuOdyQgUXoy6uQ8jHVsYc=;
 b=AreBEzHjsYhP+Htp5i0yVWDJej8/BQ6N6gB3V5MwbKnk7DElR/nmGjtiJtPeY+0cr4E/F7
 iq9+ky8t3crSZRM1N375bB94dOmOfuBQnxHPEmscIn13R7XSeMOXCWSH0TBIJXImA6dSKy
 LI9F9BlcJfau6Ma/FNhf99BVeZI3ta4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788512173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qU3MUyPlFi7aOouyR+AtmcpuOdyQgUXoy6uQ8jHVsYc=;
 b=jzfh37Tp30ghk/J+v9MZ5ZRUv9Z9iJ0Q9MKuOktv2sVDZVfHzaF6QY6ME4C0DYs1hOcAXb
 lCxRPPp5okjOEZCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788512169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qU3MUyPlFi7aOouyR+AtmcpuOdyQgUXoy6uQ8jHVsYc=;
 b=xu7JC3luYpstgP7aAG8KnyGBSkJV5jTYFG/88H1nx4EEsncOSIEO1MEJ/yfn4zl/Bzz6MI
 Fg7mWvkkwKdZjSdGxJhRyusPByjQu3Z+JhuaF4//RpNMn9enJD1Cu5HiPiariTBGBo8JVR
 CQ2JRYIY/AYfy6aode6HN+kCpQN1xTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788512169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qU3MUyPlFi7aOouyR+AtmcpuOdyQgUXoy6uQ8jHVsYc=;
 b=+AqaP4JdK7C/zSzK58CYbwhr8QzXuJN44I4JetMqETfAJKMQgkjLNe2AxkMmLwpd3J+MOH
 GRvWrMm0Vu/93VBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 376CC13869;
 Fri,  4 Sep 2026 08:56:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eKswC6iHmmqraAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 04 Sep 2026 08:56:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  4 Sep 2026 10:55:54 +0200
Message-ID: <20260904085555.1202288-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904085555.1202288-1-pvorel@suse.cz>
References: <20260904085555.1202288-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.994];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[12]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:mid,suse.cz:email,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] Remove testscripts/ltp-aiodio.sh
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Tim Bird <tim.bird@sony.com>, Steffen Jaeckel <sjaeckel@suse.de>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Script was using ltp-pan (already removed), kirk should now be used.

Update also testcases/kernel/io/ltp-aiodio/README, while at it remove
also note about the old gcc 3 requirement.

Remove also now unused testscripts/yesenter.txt.

Fixes: 5e5fd4a1ae ("pan: Remove")
Reported-by: Steffen Jaeckel <sjaeckel@suse.de>
Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>
Acked-by: Avinesh Kumar <avinesh.kumar@suse.com>
Acked-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Remove ltp-aiodio.sh from doc, also gcc 3.

 testcases/kernel/io/ltp-aiodio/README |   8 -
 testscripts/ltp-aiodio.sh             | 327 --------------------------
 testscripts/yesenter.txt              |   2 -
 3 files changed, 337 deletions(-)
 delete mode 100755 testscripts/ltp-aiodio.sh
 delete mode 100644 testscripts/yesenter.txt

diff --git a/testcases/kernel/io/ltp-aiodio/README b/testcases/kernel/io/ltp-aiodio/README
index ae31db7999..338950438a 100644
--- a/testcases/kernel/io/ltp-aiodio/README
+++ b/testcases/kernel/io/ltp-aiodio/README
@@ -1,13 +1,5 @@
-
 TESTS to check consistency between O_DIRECT reads/writes and buffered
 reads/writes and truncate.
 
-These tests should be run from the aiodio directory and MUST use a kernel
-compiled with GCC 3.3.X. Older versions of the compiler will fail and seg fault.
-
 The large file passed should be at least 25M to properly stress AIO & DIO. A
 suggestion would be a tarred version of the gcc package.
-
-Run the ltp-aiodio.sh file to execute all the tests. The tests can also be run
-individually, just execute the program and the excepted params will be output.
-No scripts were created to run the test standalone.
diff --git a/testscripts/ltp-aiodio.sh b/testscripts/ltp-aiodio.sh
deleted file mode 100755
index 06ea534e37..0000000000
--- a/testscripts/ltp-aiodio.sh
+++ /dev/null
@@ -1,327 +0,0 @@
-#!/bin/bash
-# This script should be run after installing the libaio RPM or libraries
-# A valid large file should be passed to the test.
-# These tests will only run correctly if the kernel and libaio has been compiled
-# with at least a 3.3.X GCC. Older versions of the compiler will seg fault.
-#
-# 02/08/04 mridge@us.ibm.com
-#
-# 04/12/06 a Forth scenerio file has been added ltp-aiodio.part4
-#
-
-cd `dirname $0`
-export LTPROOT=${PWD}
-echo $LTPROOT | grep testscripts > /dev/null 2>&1
-if [ $? -eq 0 ]; then
- cd ..
- export LTPROOT=${PWD}
-fi
-export PATH=$LTPROOT/testcases/bin:$PATH
-export TMP=${TMP:=/tmp}
-
-run0=0
-runTest=0
-nextTest=0
-runExtendedStress=0
-
-export TMPBASE="/tmp"
-usage()
-{
-	cat <<-END >&2
-	usage: ${0##*/} [ -f large_filename -b partition] [-o optional partition] [-e 1] [-t 1] [-j 1] [-x 1] or [-a 1]
-
-	defaults:
-	file1=$file1
-	part1=$part1
-        ext2=0
-        ext3=0
-        jfs=0
-        xfs=0
-      example: ${0##*/} -f MyLargeFile -b /dev/hdc1 [-o /dev/hdc2] [-a 1] or
-[-e 1] [-x 1] [-j 1] [-t 1]
-        -o = optional partition allows some of the tests to utilize multiple filesystems to further stress AIO/DIO
-        -e = test ex2 filesystem.
-        -t = test ext3 filesystem
-        -j = test JFS filesystem
-        -x = test XFS filesystem
-                    or
-        -a = test all supported filesystems, this will override any other filesystem flags passed.
-
-        - a 1 turns on the test for the above supported filesystem, just omit passing the flag to skip that filesystem.
-
-        - A Large file should be passed to fully stress the test. You must pass at least one filesystem to test, you can pass any combination
-          but there is not a default filesystem. ReiserFS does not support AIO so these tests will not support ReiserFS.
-
-        - WARNING !! The partition you pass will be overwritten. This is a destructive test so only pass a partition where data can be destroyed.
-
-
-
-	END
-exit
-}
-
-while getopts :a:b:e:f:t:o:x:j: arg
-do      case $arg in
-		f)	file1=$OPTARG;;
-		b)	part1=$OPTARG;;
-		o)	part2=$OPTARG;;
-		e)	ext2=$OPTARG;;
-		t)	ext3=$OPTARG;;
-		x)	xfs=$OPTARG;;
-		j)	jfs=$OPTARG;;
-		a)	allfs=$OPTARG;;
-
-                \?)     echo "************** Help Info: ********************"
-                        usage;;
-        esac
-done
-
-if [ ! -n "$file1"  ]; then
-  echo "Missing the large file. You must pass a large filename for testing"
-  usage;
-  exit
-fi
-
-if [ ! -n "$part1"  ]; then
-  echo "Missing the partition. You must pass a partition for testing"
-  usage;
-  exit
-fi
-
-if [ -n "$allfs"  ]; then
-  echo "testing ALL supported filesystems"
-  ext2="1"
-  ext3="1"
-  jfs="1"
-  xfs="1"
-  echo "test run = $run0"
-fi
-
-if [ -n "$ext2"  ]; then
-  echo "** testing ext2 **"
-  run0=$(($run0+1))
-fi
-
-if [ -n "$ext3"  ]; then
-  echo "** testing ext3 **"
-  run0=$(($run0+1))
-fi
-
-if [ -n "$xfs"  ]; then
-  echo "** testing xfs **"
-  run0=$(($run0+1))
-fi
-
-if [ -n "$jfs"  ]; then
-  echo "** testing jfs **"
-  run0=$(($run0+1))
-fi
-
-if [ -n "$part2" -a "$run0" -gt 1  ]; then
-  echo "** Running extended stress testing **"
-  runExtendedStress=1
-elif [ -n "$part2" -a "$run0" -eq 1 ]; then
-  echo " ** You must pass at least 2 filesystems to run an extended AIO stress test **"
-  usage;
-fi
-
-if [ "$run0" -eq 0 ]; then
-  echo "No filesystems passed to test"
-  echo "Please pass at least one supported filesystem or the -a 1 flag to run all "
-  usage;
-fi
-
-mkdir $TMP  > /dev/null 2>&1
-mkdir $TMP/aiodio > /dev/null  2>&1
-mkdir $TMP/aiodio2 > /dev/null  2>&1
-
-while [ "$runTest" -lt "$run0" ]
-do
-
-echo "runTest=$runTest run0=$run0 nextTest=$nextTest"
-
-if [ -n "$ext2" -a $nextTest -eq 0 ]; then
-  echo "***************************"
-  echo "* Testing ext2 filesystem *"
-  echo "***************************"
-  mkfs -t ext2 $part1
-  mount -t ext2 $part1 $TMP/aiodio
-  if [ "$runExtendedStress" -eq 1 -a -n "$ext3" ]; then
-    mkfs -t ext3 $part2
-    mount -t ext3 $part2 $TMP/aiodio2
-  elif [ "$runExtendedStress" -eq 1 -a -n "$jfs" ]; then
-    mkfs.jfs  $part2 <testscripts/yesenter.txt
-    mount -t jfs $part2 $TMP/aiodio2
-  elif [ "$runExtendedStress" -eq 1 -a -n "$xfs" ]; then
-    mkfs.xfs -f $part2
-    mount -t xfs $part2 $TMP/aiodio2
-  fi
-elif [ $nextTest -eq 0 ]; then
-  nextTest=$(($nextTest+1))
-fi
-
-if [ -n "$ext3" -a $nextTest -eq 1 ]; then
-  echo "***************************"
-  echo "* Testing ext3 filesystem *"
-  echo "***************************"
-  mkfs -t ext3 $part1
-  mount -t ext3 $part1 $TMP/aiodio
-  if [ "$runExtendedStress" -eq 1 -a -n "$jfs" ]; then
-    mkfs.jfs  $part2 <testscripts/yesenter.txt
-    mount -t jfs $part2 $TMP/aiodio2
-  elif [ "$runExtendedStress" -eq 1 -a -n "$xfs" ]; then
-    mkfs.xfs -f $part2
-    mount -t xfs $part2 $TMP/aiodio2
-  elif [ "$runExtendedStress" -eq 1 -a -n "$ext2" ]; then
-    mkfs -t ext2 $part2
-    mount -t ext2 $part2 $TMP/aiodio2
-  fi
-elif [ $nextTest -eq 1 ]; then
-  nextTest=$(($nextTest+1))
-fi
-
-if [ -n "$jfs" -a $nextTest -eq 2 ]; then
-  echo "**************************"
-  echo "* Testing jfs filesystem *"
-  echo "**************************"
-  mkfs.jfs  $part1 <testscripts/yesenter.txt
-  mount -t jfs $part1 $TMP/aiodio
-  if [ "$runExtendedStress" -eq 1 -a -n "$ext3" ]; then
-    mkfs -t ext3  $part2
-    mount -t ext3 $part2 $TMP/aiodio2
-  elif [ "$runExtendedStress" -eq 1 -a -n "$xfs" ]; then
-    mkfs.xfs -f $part2
-    mount -t xfs $part2 $TMP/aiodio2
-  elif [ "$runExtendedStress" -eq 1 -a -n "$ext2" ]; then
-    mkfs -t ext2 $part2
-    mount -t ext2 $part2 $TMP/aiodio2
-  fi
-elif [ $nextTest -eq 2 ]; then
-  nextTest=$(($nextTest+1))
-fi
-
-if [ -n "$xfs" -a $nextTest -eq 3 ]; then
-  echo "**************************"
-  echo "* Testing xfs filesystem *"
-  echo "**************************"
-  mkfs.xfs -f $part1
-  mount -t xfs $part1 $TMP/aiodio
-  if [ "$runExtendedStress" -eq 1 -a -n "$ext2" ]; then
-    mkfs -t ext2 $part2
-    mount -t ext2 $part2 $TMP/aiodio2
-  elif [ "$runExtendedStress" -eq 1 -a -n "$ext3" ]; then
-    mkfs -t ext3  $part2
-    mount -t ext3 $part2 $TMP/aiodio2
-  elif [ "$runExtendedStress" -eq 1 -a -n "$jfs" ]; then
-    mkfs.jfs  $part2 <testscripts/yesenter.txt
-    mount -t jfs $part2 $TMP/aiodio2
-  fi
-elif [ $nextTest -eq 3 ]; then
-  nextTest=$(($nextTest+1))
-fi
-
-nextTest=$(($nextTest+1))
-runTest=$(($runTest+1))
-
-mkdir $TMP/aiodio/junkdir
-dd if=$file1 of=$TMP/aiodio/junkfile bs=8192 conv=block,sync
-
-date
-echo "************ Running aio-stress tests "
-echo "current working dir = ${PWD}"
-sort -R ${LTPROOT}/runtest/ltp-aio-stress.part1 -o ${TMPBASE}/ltp-aio-stress.part1
-
-${LTPROOT}/bin/ltp-pan -e -S -a ltpaiostresspart1 -n ltp-aiostresspart1 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part1 &
-
-wait $!
-
-sync
-echo "************ End Running aio-stress tests "
-echo ""
-
-if [ "$runExtendedStress" -eq 1 ];then
-echo "************ Running EXTENDED aio-stress tests "
-sort -R ${LTPROOT}/runtest/ltp-aio-stress.part2 -o ${TMPBASE}/ltp-aio-stress.part2
-
-${LTPROOT}/bin/ltp-pan -e -S -a ltpaiostresspart2 -n ltp-aiostresspart2 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part2 &
-
-wait $!
-sync
-fi
-
-dd if=$file1 of=$TMP/aiodio/junkfile bs=8192 conv=block,sync
-dd if=$file1 of=$TMP/aiodio/fff      bs=4096 conv=block,sync
-dd if=$file1 of=$TMP/aiodio/ff1      bs=2048 conv=block,sync
-dd if=$file1 of=$TMP/aiodio/ff2      bs=1024 conv=block,sync
-dd if=$file1 of=$TMP/aiodio/ff3      bs=512  conv=block,sync
-
-echo "************ Running aiocp tests "
-sort -R ${LTPROOT}/runtest/ltp-aiodio.part1 -o ${TMPBASE}/ltp-aiodio.part1
-
-${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart1 -n ltp-aiodiopart1 -l ltpaiodio1.logfile -o ltpaiodio1.outfile -p -f ${TMPBASE}/ltp-aiodio.part1 &
-
-wait $!
-sync
-echo "************ End Running aiocp tests "
-echo ""
-
-echo "************ Running aiodio_sparse tests "
-sort -R ${LTPROOT}/runtest/ltp-aiodio.part2 -o ${TMPBASE}/ltp-aiodio.part2
-
-${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart2 -n ltp-aiodiopart2 -l ltpaiodio2.logfile -o ltpaiodio2.outfile -p -f ${TMPBASE}/ltp-aiodio.part2 &
-
-wait $!
-sync
-echo "************ End Running aiodio_sparse tests "
-echo ""
-
-
-if [ "$runExtendedStress" -eq 1 ];then
-echo "************ Running fsx-linux tests "
-sort -R ${LTPROOT}/runtest/ltp-aiodio.part3 -o ${TMPBASE}/ltp-aiodio.part3
-
-${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart3 -n ltp-aiodiopart3 -l ltpaiodio3.logfile -o ltpaiodio3.outfile -p -f ${TMPBASE}/ltp-aiodio.part3 &
-
-
-
-wait $!
-sync
-fi
-
-dd if=$file1 of=$TMP/aiodio/file2      bs=2048 conv=block,sync
-dd if=$file1 of=$TMP/aiodio/file3      bs=1024 conv=block,sync
-dd if=$file1 of=$TMP/aiodio/file4      bs=512  conv=block,sync
-dd if=$file1 of=$TMP/aiodio/file5      bs=4096 conv=block,sync
-
-
-
-
-echo "************ Running dio_sparse & miscellaneous tests "
-sort -R ${LTPROOT}/runtest/ltp-aiodio.part4 -o ${TMPBASE}/ltp-aiodio.part4
-${LTPROOT}/bin/ltp-pan -e -S -a ltpaiodiopart4 -n ltp-aiodiopart4 -l ltpaiodio4.logfile -o ltpaiodio4.outfile -p -f ${TMPBASE}/ltp-aiodio.part4 &
-
-wait $!
-sync
-echo "************ End Running dio_sparse & miscellaneous tests "
-echo ""
-
-echo "************ Cleaning/Umounting"
-
-rm -f $TMP/aiodio/fff
-rm -f $TMP/aiodio/ff1
-rm -f $TMP/aiodio/ff2
-rm -f $TMP/aiodio/ff3
-rm -f $TMP/aiodio/junkfile*
-rm -f $TMP/aiodio/file*
-rm -rf $TMP/aiodio/junkdir
-
-umount $part1
-
-if [ "$runExtendedStress" -eq 1 ]; then
-      umount $part2
-fi
-
-
-done
-date
-echo "AIO/DIO test complete "
diff --git a/testscripts/yesenter.txt b/testscripts/yesenter.txt
deleted file mode 100644
index 842f4ffd57..0000000000
--- a/testscripts/yesenter.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-y
-
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
